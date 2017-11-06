From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCH 04/27] clk: ti: clkctrl: use fallback udelay approach if
 timekeeping is suspended
Date: Mon, 6 Nov 2017 09:33:16 +0200
Message-ID: <3249933f-7f37-a6c9-ed0c-58d40f06578b@ti.com>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
 <1509368685-29112-5-git-send-email-t-kristo@ti.com>
 <20171103154317.GV11011@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <20171103154317.GV11011@codeaurora.org>
Content-Language: en-US
Sender: linux-clk-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 03/11/17 17:43, Stephen Boyd wrote:
> On 10/30, Tero Kristo wrote:
>> This will happen on certain platforms when entering / leaving suspend
>> and the system attempts to disable certain clocks at very early/late
>> phase, burping out a warning from timekeeping core. Avoid the issue
>> by checking if the timekeeping is suspended and using the fallback
>> udelay approach for checking timeouts.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/clk/ti/clkctrl.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
>> index 284ba449..91ddc92 100644
>> --- a/drivers/clk/ti/clkctrl.c
>> +++ b/drivers/clk/ti/clkctrl.c
>> @@ -21,6 +21,7 @@
>>   #include <linux/of_address.h>
>>   #include <linux/clk/ti.h>
>>   #include <linux/delay.h>
>> +#include <linux/timekeeping.h>
> 
>>   #include "clock.h"
>>   
>>   #define NO_IDLEST			0x1
>> @@ -90,7 +91,7 @@ static bool _omap4_is_ready(u32 val)
>>   
>>   static bool _omap4_is_timeout(union omap4_timeout *time, u32 timeout)
>>   {
>> -	if (unlikely(_early_timeout)) {
>> +	if (unlikely(_early_timeout || timekeeping_suspended)) {
>>   		if (time->cycles++ < timeout) {
> 
> This would be the second user of timekeeping_suspended outside of
> timekeeping core. Why don't we just udelay(1) every time we call
> this function? The loop on ktime without any sort of delay in it
> may actually spin faster, especially because we can't get
> interrupted here (irqs are off). And irqs + preemption enabled is
> typically where you would want to use ktime instead of counting
> udelay() calls to see if you hit a timeout.

It actually was originally just udelay() but I changed it to use the 
ktime_get() approach way back due to comments provided on some early 
revisions of this patch. See: https://patchwork.kernel.org/patch/7884371/

> 
> This code seems over-complicated given the constraints at the
> call-sites.
> 

True, I can easily change it to just use udelay() if wanted.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
