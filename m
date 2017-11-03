From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 04/27] clk: ti: clkctrl: use fallback udelay approach if
 timekeeping is suspended
Date: Fri, 3 Nov 2017 08:43:17 -0700
Message-ID: <20171103154317.GV11011@codeaurora.org>
References: <1509368685-29112-1-git-send-email-t-kristo@ti.com>
 <1509368685-29112-5-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-clk-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1509368685-29112-5-git-send-email-t-kristo@ti.com>
Sender: linux-clk-owner@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On 10/30, Tero Kristo wrote:
> This will happen on certain platforms when entering / leaving suspend
> and the system attempts to disable certain clocks at very early/late
> phase, burping out a warning from timekeeping core. Avoid the issue
> by checking if the timekeeping is suspended and using the fallback
> udelay approach for checking timeouts.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/clk/ti/clkctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/ti/clkctrl.c b/drivers/clk/ti/clkctrl.c
> index 284ba449..91ddc92 100644
> --- a/drivers/clk/ti/clkctrl.c
> +++ b/drivers/clk/ti/clkctrl.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_address.h>
>  #include <linux/clk/ti.h>
>  #include <linux/delay.h>
> +#include <linux/timekeeping.h>

>  #include "clock.h"
>  
>  #define NO_IDLEST			0x1
> @@ -90,7 +91,7 @@ static bool _omap4_is_ready(u32 val)
>  
>  static bool _omap4_is_timeout(union omap4_timeout *time, u32 timeout)
>  {
> -	if (unlikely(_early_timeout)) {
> +	if (unlikely(_early_timeout || timekeeping_suspended)) {
>  		if (time->cycles++ < timeout) {

This would be the second user of timekeeping_suspended outside of
timekeeping core. Why don't we just udelay(1) every time we call
this function? The loop on ktime without any sort of delay in it
may actually spin faster, especially because we can't get
interrupted here (irqs are off). And irqs + preemption enabled is
typically where you would want to use ktime instead of counting
udelay() calls to see if you hit a timeout.

This code seems over-complicated given the constraints at the
call-sites.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
