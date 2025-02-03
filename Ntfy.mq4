//+------------------------------------------------------------------+
//|                                                         Ntfy.mq4 |
//|                                                       E&JCapital |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
#include "Messages.mqh";

//input string NTFY_TOPIC = "https://ntfy.sh/EandJDebug";
input string NTFY_TOPIC = "https://ntfy.sh/DragonForceFx";

Messages ntfy(NTFY_TOPIC);

//Time Units
int min = 0;

int number_of_trades = 0;


//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int OnInit() {
//---
//---
   ntfy.init("Live");
   return(INIT_SUCCEEDED);
}


//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
//---
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int getTradeCount() {
   int count = 0;
   if(OrdersTotal() == 0) {
      return 0;
   } else {
      for(int i = 0; i < OrdersTotal(); i++) {
         if(OrderSelect(i,SELECT_BY_POS)) {
            if(OrderType() == OP_BUY || OrderType() == OP_SELL) {
               count++;
            }
         }
      }
   }
   return count;
}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
//---
   int getCount = getTradeCount();
   if(number_of_trades != getCount) {
      if(getCount > number_of_trades) {
         number_of_trades = getCount;
      } else {
         ntfy.currentBalanceStatus();
         number_of_trades = getCount;
      }
   }
}
//+------------------------------------------------------------------+
