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

input string NTFY_TOPIC = "https://ntfy.sh/DragonForceFx";

Messages ntfy(NTFY_TOPIC);

//Time Units
int min = 0;

int OnInit()
  {
//---
   
//---
   ntfy.init("Live");
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---

   ntfy.currentBalanceStatus();
   
   
  }
//+------------------------------------------------------------------+
