//
//  MissionView.swift
//  Moonshot
//
//  Created by dominator on 12/11/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let mission: Mission
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut] = Bundle.main.loadFile("astronauts.json")) {
        self.mission = mission
        
        var matches = [CrewMember]()
        
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
    
    var body: some View {
        GeometryReader{ geo in
            ScrollView{
                VStack(alignment: .center){
                    Image(self.mission.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geo.size.width * 0.7)
                    Text("Launch date: ") + Text(self.mission.launchDate != nil ? "\(DateFormatter.localizedString(from: self.mission.launchDate!, dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none))" : "N/A")
                    Text(self.mission.description)
                        .padding()
                    ForEach(self.astronauts, id: \.role){ astronaut in
                        NavigationLink(destination: AstronuatView(astronuat: astronaut.astronaut)){
                            HStack{
                                Image(astronaut.astronaut.id)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                                VStack(alignment: .leading){
                                    Text(astronaut.astronaut.name)
                                        .font(.headline)
                                    Text(astronaut.role)
                                    
                                }
                                Spacer()
                            }                       .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.loadFile("missions.json")
    static let autronuats: [Astronaut] = Bundle.main.loadFile("astronauts.json")
    static var previews: some View {
        NavigationView{
            MissionView(mission: missions[0], astronauts: autronuats)
        }
    }
}
