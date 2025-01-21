//+------------------------------------------------------------------+
//|                                                     Messages.mqh |
//|                                                       E&JCapital |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "E&JCapital"
#property link      "https://www.mql5.com"
#property strict
//+------------------------------------------------------------------+
//| defines                                                          |
//+------------------------------------------------------------------+
// #define MacrosHello   "Hello, world!"
// #define MacrosYear    2010
//+------------------------------------------------------------------+
//| DLL imports                                                      |
//+------------------------------------------------------------------+
// #import "user32.dll"
//   int      SendMessageA(int hWnd,int Msg,int wParam,int lParam);
// #import "my_expert.dll"
//   int      ExpertRecalculate(int wParam,int lParam);
// #import
//+------------------------------------------------------------------+
//| EX5 imports                                                      |
//+------------------------------------------------------------------+
// #import "stdlib.ex5"
//   string ErrorDescription(int error_code);
// #import
//+------------------------------------------------------------------+
class Messages {


private:
   string            this_address;
   double            account;
   string            tags;
   string            header;
   string            str;
   char              data[],result[];
   string            result_headers;
   string            trade_mode;


   enum emoji {

      PROFIT,
      LOSS,
      NEUTRAL

   };

   void              statusUpdates() {
      double currentBalance = AccountBalance();
      //double currentBalance = -120000.0;
      double diff;
      //If balance are the same
      if(currentBalance == account) {
         str += "No trades for the day.\n";
      } else if(currentBalance > account) {
         diff = currentBalance - account;
         str += "Today's financial report reveals that the automated system has yielded profitable returns.\n";
         str += "Today's Profit: $" + FormatCurrency(diff);
      } else {
         diff = currentBalance - account;
         str += "Analysis indicate a downturn in profitability.\n";
         str += "Today's difference: $" + FormatCurrency(diff);
      }
      //Add current account balance to body
      str += "\nAccount Balance: $" + FormatCurrency(AccountBalance());
      //Update new balance
      account = AccountBalance();
   }

   void              currentUpdates() {
      //double currentBalance = AccountBalance();
      double currentBalance = 1000.0;
      double diff;
      if(currentBalance == account) {
         str += "No trades for the day.\n";
      } else if(currentBalance > account) {
         diff = currentBalance - account;
         header += "Attach: https://raw.githubusercontent.com/jblanco360/mt4-NTFY/refs/heads/master/pictures/positive.png \n";
         str += "Today's financial report reveals that the automated system has yielded profitable returns.\n";
         str += "Today's Profit: $" + FormatCurrency(diff);
      } else {
         diff = currentBalance - account;
         str += "Analysis indicate a downturn in profitability.\n";
         str += "Today's difference: $" + FormatCurrency(diff);
      }
      str += "Current Account Status:\n";
   }

   void              sendMessage() {
      int    res;     // To receive the operation execution result
      // ArrayInitialize(data, 0);
      ArrayInitialize(result, 0);
      result_headers = "";
      ArrayResize(data,ArraySize(data)-1);
      ArrayResize(data,StringToCharArray(str,data,0,WHOLE_ARRAY,CP_UTF8)-1);
      res = WebRequest("POST",this_address,header,5000,data,result,result_headers);
      //ArrayResize(data,StringToCharArray(str,data,0,WHOLE_ARRAY,CP_UTF8)-1);
   }

   // Function to format a double value as currency with commas
   string            FormatCurrency(double value) {
      string result = DoubleToString(value, 2);  // Convert to string with 2 decimal places
      int len = StringLen(result);
      string formattedResult = "";
      int count = 0;
      string period;
      // Loop through the string in reverse
      for(int i = len - 1; i >= 0; i--) {
         char ch = StringGetChar(result, i);
         formattedResult = CharToStr(ch) + formattedResult;
         count++;
         // Add comma every 3 digits before the decimal point
         period = StringGetChar(result, i - 1);
         if(count > 3 && count % 3 == 0 && i !=0) {
            formattedResult = "," + formattedResult;
         }
      }
      return formattedResult;
   }



public:
   void              Messages(string address) {
      this_address = address;
      account =  AccountBalance();
   }

   void              init(string mode) {
      int    res;     // To receive the operation execution result
      trade_mode = mode;
      tags = "Tags: ledger\n";
      header = "Title: E & J Notification Services Initialized\n";
      str = "Current account size: $" + DoubleToStr(account,2);
      header = header + tags;
      StringToCharArray(str, data, 0, WHOLE_ARRAY, CP_UTF8);
      res = WebRequest("POST",this_address,header,5000,data,result,result_headers);
      ArrayInitialize(data, 0);
      ArrayInitialize(result, 0);
      //ArrayResize(data,StringToCharArray("",data,0,WHOLE_ARRAY,CP_UTF8)-1);
   }

   void              dailyUpdate() {
      tags = "Tags: sunrise_over_mountains\n";
      header = "Title: Good Morning E & J Capital (" + trade_mode + ")\n";
      header += tags;
      str = "Your daily updates are as follows: \n";
      statusUpdates();
      sendMessage();
   }

   void              currentBalanceStatus() {
      tags = "Tags: sunrise_over_mountains\n";
      header = "Title: Good Morning E & J Capital (" + trade_mode + ")\n";
      header += tags;
      str = "Your daily updates are as follows: \n";
      currentUpdates();
      sendMessage();
   }

   void              nightlyUpdate() {
      tags = "Tags: night_with_stars\n";
      header = "Title: Good Evening E & J Capital\n";
      header += tags;
      str = "Your daily updates are as follows: \n";
      statusUpdates();
      sendMessage();
   }

   void              orderDelete(double spread) {
      tags = "Tags: man_office_worker\n";
      header = "Title: Order Management\n";
      header += tags;
      str = "Order Deleted per spread of " + DoubleToString(spread,0) +"\n";
      sendMessage();
   }



};
//+------------------------------------------------------------------+
