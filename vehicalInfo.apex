/* @RestResource is used to tell the apex that this class is exposing/consuming the Salesforce API.
    urlMapping - URL of the API that will be used to hit the APEX REST
*/
@RestResource(urlMapping='/v1/registrations/*')
global class vehicalInfo {
//getrequest 
@HttpGet
global static void getvehicalInfo(){
     RestRequest req = RestContext.request;
     RestResponse res = RestContext.response;
     res.addHeader('Content-Type','application/json');
     List<String>  registrations= new List<String>();
     String regserlize;
     List<registration__c> vehicalinfo =[select id,plater_number__c, expired__c, expiry_date__c, 
                                         type__c,make__c, model__c, colour__c, vin__c, tare_weight__c, gross_mass__c, name__c,code__c  from registration__c ]; 
   
     vehicalInfoPayload regload= new vehicalInfoPayload(); //Instance of wrapper class 
     vehicalInfoPayload.cls_registrations regestrationsInfo = new vehicalInfoPayload.cls_registrations(); //Instance of registration info
   
     for(registration__c vehCollections: vehicalinfo){ //Loop thru the query and assigne the value to respective wrapper class values
      vehicalInfoPayload.cls_regoexpire regoexpiredetail = new  vehicalInfoPayload.cls_regoexpire();  
      vehicalInfoPayload.cls_vehicle vehicaldetail = new  vehicalInfoPayload.cls_vehicle();
      vehicalInfoPayload.cls_insurer insurancedetail = new  vehicalInfoPayload.cls_insurer();  
      
      
      regoexpiredetail.expired=vehCollections.expired__c; 
      regoexpiredetail.expiry_date=String.valueof(vehCollections.expiry_date__c);

      vehicaldetail.type=vehCollections.type__c;
      vehicaldetail.make=vehCollections.make__c;
      vehicaldetail.model=vehCollections.model__c;
      vehicaldetail.colour=vehCollections.colour__c;  
      vehicaldetail.vin=vehCollections.vin__c;
      vehicaldetail.tare_weight=String.valueof(vehCollections.tare_weight__c);  
      vehicaldetail.gross_mass=String.valueof(vehCollections.gross_mass__c);
        
      
      insurancedetail.name=vehCollections.name__c;
      insurancedetail.code=String.valueof(vehCollections.code__c); 
      
      regestrationsInfo.plate_number=vehCollections.plater_number__c; 
      regestrationsInfo.registration=regoexpiredetail;
      regestrationsInfo.vehicle=vehicaldetail;
      regestrationsInfo.insurer=insurancedetail;  
      regload.registrations=regestrationsInfo;
      regserlize =JSON.serializePretty(regload);    
      registrations.add(regserlize); // Looping thru all the registration vehincal into an List array
         
     }
     regserlize=String.join(registrations,',');  //Converting List array to string to response in JSON 
     res.responseBody= blob.valueOf(regserlize);
    } 
 }
