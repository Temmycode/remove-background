//
//  Repository.swift
//  Remove Background
//
//  Created by Temiloluwa Akisanya on 18/03/2024.
//

import AppKit
import Observation

@Observable class Repository {
    var isLoading = false
    var removedBackgroundImage: NSImage? = nil

    func removeBackground(paramName: String, fileName: String, image: NSImage) {
        self.isLoading = true
        let url = URL(string: "http://127.0.0.1:8000/remove-background")
        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        let imagePngData: Data = nsPngData(image: image)!
        print("The data was not null")
        let session = URLSession.shared

        // Set the URLRequest to POST and to the specified URL
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"

        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(imagePngData)
        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Send a POST request to the URL, with the data we created earlier
        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
            DispatchQueue.main.async {
                if error == nil {
                    if let responseData = responseData {
                        self.removedBackgroundImage = NSImage(data: responseData)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.isLoading = false
                        }
                    } else {
                        self.isLoading = false
                    }
                } else {
                    self.isLoading = false
                }
            }
        }).resume()
    }
    
    func nsPngData(image: NSImage) -> Data? {
        if let tiffData = image.tiffRepresentation {
            // Convert TIFF data to NSBitmapImageRep
            if let bitmap = NSBitmapImageRep(data: tiffData) {
                // Convert NSBitmapImageRep to PNG data
                if let pngData = bitmap.representation(using: .png, properties: [:]) {
                    // Now you have the PNG data, you can use it as needed
                    return pngData
                } else {
                    print("Failed to convert TIFF to PNG data")
                    return nil;
                }
            } else {
                print("Failed to create NSBitmapImageRep from TIFF data")
                return nil;
            }
        } else {
            print("Failed to get TIFF representation of image")
            return nil;
        }
    }
}

enum RemBgError: Error {
    case invalidURL
    case unknownError
}
