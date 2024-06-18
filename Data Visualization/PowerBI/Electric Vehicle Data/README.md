This project, or visualization dashboard primarily focuses on electric vehicles. Basic information of electric vehicles would be discovered to understand the market of electric vehicles in the USA.

In this project, we draw attention to creating our dashboard with existing columns and measures (calculated fields) from existing columns.

Some calculated fields that have been created: 

- Total Vehicle = Sum of DOL Vehicle ID

This measure is created to capture the market size in electric vehicles. Note that vehicles whose model was released before 2010 were removed as people seem to prefer the latest versions (personal perspective).

- Avg Range = CONCATENATE(ROUND(AVERAGE(Electric_Vehicle_Population_Dat[Electric Range]),2), "Km")

The purpose of this measure is to create a combined words of a number followed by a measurement unit. For example, the average of electric range is 67.83; if we follow a traditional solution (select column `Electric Range`, change sum to average), only 67.83 is visualized.

As `Electric Range` is a continuous variable, it is ambiguos for audiences without mentioning its measurement unit. As a result, a calculation was performed to concatenate the average value with the string 'Km' to effectively ensure data transparency.

- Count of BEV/ PHEV = Count of BEV/ PHEV in Total Vehicle
- % of BEV/ PHEV = Count of BEV/ PHEV divided by Total Vehicle.

A brief explanation would be discussed in the video. For any enquiry, please email to havinhnguyen24@gmail.com.

Thank you for viewing my portfolio! 

[Click Here for Google Drive Link to Dashboard Explanation](https://drive.google.com/file/d/1Et7P9RH6br_nlX9-tRSgitmZwZlgknfa/view?usp=sharing)
