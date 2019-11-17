//
//  Astronuat.swift
//  Moonshot
//
//  Created by dominator on 14/11/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import SwiftUI

struct AstronuatView: View {
    let astronuat: Astronaut
    let missions: [Mission]
    init(astronuat: Astronaut) {
        self.astronuat = astronuat
        let allMissions: [Mission] = Bundle.main.loadFile("missions.json")
        print(allMissions)
        self.missions = allMissions.filter({
            $0.crew.contains(where: {$0.name == astronuat.id})
        })
    }
    var body: some View {
        GeometryReader{ geometry in
            ScrollView{
                VStack{
                    Image(self.astronuat.id)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: geometry.size.width)
                    Text(self.astronuat.description)
                        .padding()
                    .layoutPriority(1)
                }
                ForEach(self.missions){ mission in
                    NavigationLink(destination: MissionView(mission: mission)) {
                        HStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 50, height: 50)
                                .clipShape(Circle())
                                .shadow(radius: 5)
                            VStack(alignment: .leading){
                                Text(mission.displayName)
                                    .font(.headline)
                                 Text("Launch date: ") + Text(mission.launchDate != nil ? "\(DateFormatter.localizedString(from: mission.launchDate!, dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none))" : "N/A")
                                
                            }
                            Spacer()
                        }.padding()
                    }.buttonStyle(PlainButtonStyle())
                }
            }
            .navigationBarTitle(Text(self.astronuat.name), displayMode: .inline)
        }
    }
}

struct Astronuat_Previews: PreviewProvider {
    static let astronuats: [Astronaut] = Bundle.main.loadFile("astronauts.json")
    static var previews: some View {
        NavigationView{
            AstronuatView(astronuat: astronuats[2])
        }
    }
}
/*
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
 }
 */
