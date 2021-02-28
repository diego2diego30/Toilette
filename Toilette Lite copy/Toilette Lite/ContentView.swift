//
//  ContentView.swift
//  Toilette Lite
//
//  Created by Diego Ortuondo on 2/27/21.
//

import SwiftUI
import MapKit

var width = UIScreen.main.bounds.width
var height = UIScreen.main.bounds.height

struct NavView: View {
    var body: some View {
            VStack {
                TabView {
                    NearbyView()
                        .tabItem {
                            Image(systemName: "map")
                            Text("Nearby")
                        }
                    Search()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                    Text("3")
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        }
                }
                
            }
    }
}

struct Search: View {
    let bathrooms = ["Stroller Hikes Bathroom", "Fast Hikes Bathroom", "Lame Hikes Bathroom", "Stupid Hikes Bathroom"]
    @State private var searchText : String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $searchText, placeholder: "Search Bathrooms")
                List {
                    ForEach(self.bathrooms.filter {
                        self.searchText.isEmpty ? true : $0.lowercased().contains(self.searchText.lowercased())
                    }, id: \.self) { bathroom in
                        Text(bathroom)
                    }
                }.navigationBarTitle(Text("Bathrooms"))
            }
        }
    }
}

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        
        @Binding var text: String
        
        init(text: Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text)
    }
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        searchBar.autocapitalizationType = .none
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}

struct FirstReview: View {
    var body: some View {
        NavigationView {
            VStack{
                Text("Stroller Hikes Bathroom")
                    .font(.system(size:30, weight:. bold))
                Image("Bathroom")
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 400.0, height: 200.0)
                VStack(alignment: .leading){
                    Text("• Located in Wilderness Hiking Area")
                        .frame(alignment: .leading)
                    Text("• Cleanliness: 4 Toilet Rolls")
                    Text("• Gender-Neutral ✓")
                    Text("• Great size for large families ✓")
                    Group{
                        Text("• Extra Ammentities: ")
                        Text("• Toilet Paper \n• Soap \n• Paper towels")
                            .padding(.leading, 20)
                        
                    }
                    VStack {
                        Text("Reviews:")
                            .font(.headline)
                        Text("It was pretty clean except for some wet paper towels on the ground. - Anonymous")
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 20)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        Text("In addition, there were not toilet seat covers, so you had to use multiple paper towels if you wanted to cover the surface. - Anonymous")
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 20)
                            .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    }
                    
                }
            }.frame(width: width, height: height, alignment: .top)
        }
    }
}


struct NearbyView: View {
    
    @State private var FirstReviewPageIsActive: Bool = false
    @State private var SecondReviewIsActive: Bool = false
    @State private var ThirdReviewIsActive: Bool = false
    @State private var ProfilePageIsActive: Bool = false
    @State private var SearchPageIsActive: Bool = false
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.75773, longitude: -73.985708), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    
    var body: some View {
        NavigationView {
            VStack {
                Map(coordinateRegion: $region).frame(height: 360, alignment: .top)
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundColor(Color(#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)))
                        .shadow(radius: 5)
                    
                    
                    VStack {
                        
                        Text("Bathrooms Near You")
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .padding(.top, 25.0)
                            .frame(width: 360, height: 20, alignment: .leading)
                        
                        ScrollView(.horizontal) {
                            HStack {
                                NavigationLink("", destination: FirstReview(), isActive: $FirstReviewPageIsActive)
                                Button(action: {
                                    FirstReviewPageIsActive = true
                                }) { Image("Bathroom")
                                    .padding(.top)
                                    .frame(width: 180.0, height: 190.0)
                                    .mask(RoundedRectangle(cornerRadius: 6))
                                    
                                }
                                Button(action: {
                                    FirstReviewPageIsActive = true
                                }) { Image("Bathroom")
                                    .padding(.top)
                                    .frame(width: 180.0, height: 190.0)
                                    .mask(RoundedRectangle(cornerRadius: 6))
                                    
                                }
                                Button(action: {
                                    FirstReviewPageIsActive = true
                                }) { Image("Bathroom")
                                    .padding(.top)
                                    .frame(width: 180.0, height: 190.0)
                                    .mask(RoundedRectangle(cornerRadius: 6))
                                    .border(Color.white, width: 2)
                                    
                                }
                                

                                
                            }
                            .padding([.leading, .bottom, .trailing])
                        }
                        
                        
                    }
                }.frame(width: width - 30, alignment: .top)
                .padding(10)
                
            }.navigationBarTitle("Nearby", displayMode: .large)
            .navigationBarItems(trailing:
                                    HStack {
                                        Button(action: {
                                            print("Info button tapped!")
                                        }) {
                                            Image(systemName: "person.crop.circle").resizable()
                                                .frame(width: 33.0, height: 33.0)
                                            
                                        }
                                    }
            )
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavView()
        }
    }
}
