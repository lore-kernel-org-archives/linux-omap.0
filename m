From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/2] rtc: omap: Add external clock enabling support
Date: Mon, 17 Aug 2015 14:10:02 +0200
Message-ID: <20150817121002.GG7053@localhost>
References: <1439787338-27396-1-git-send-email-j-keerthy@ti.com>
 <1439787338-27396-3-git-send-email-j-keerthy@ti.com>
 <20150817113000.GF7053@localhost>
 <55D1C7CF.3070406@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55D1C7CF.3070406-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Keerthy <a0393675-l0cyMroinI0@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, t-kristo-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Aug 17, 2015 at 05:08:55PM +0530, Keerthy wrote:
> 
> 
> On Monday 17 August 2015 05:00 PM, Johan Hovold wrote:
> > On Mon, Aug 17, 2015 at 10:25:38AM +0530, Keerthy wrote:
> >> Configure the clock source to either internal clock
> >> or external clock based on the availability of the clocks.
> >> External clock is preferred as it can be ticking during suspend.
> >>
> >> Signed-off-by: Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>
> >> ---
> >>
> >> Changes in V2:
> >>
> >>    * Changed clk_prepare calls to clk_prepare_enable.
> >>    * Changed clk_unprepare calls to clk_disable_unprepare.
> >>    * Added clk pointers for external and internal clock to omap_rtc structure.
> >>
> >>   drivers/rtc/rtc-omap.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >>   1 file changed, 40 insertions(+)
> >>
> >> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> >> index 8b6355f..46b3944 100644
> >> --- a/drivers/rtc/rtc-omap.c
> >> +++ b/drivers/rtc/rtc-omap.c
> >> @@ -25,6 +25,7 @@
> >>   #include <linux/of_device.h>
> >>   #include <linux/pm_runtime.h>
> >>   #include <linux/io.h>
> >> +#include <linux/clk.h>
> >>
> >>   /*
> >>    * The OMAP RTC is a year/month/day/hours/minutes/seconds BCD clock
> >> @@ -107,6 +108,7 @@
> >>
> >>   /* OMAP_RTC_OSC_REG bit fields: */
> >>   #define OMAP_RTC_OSC_32KCLK_EN		BIT(6)
> >> +#define OMAP_RTC_OSC_SEL_32KCLK_SRC	BIT(3)
> >>
> >>   /* OMAP_RTC_IRQWAKEEN bit fields: */
> >>   #define OMAP_RTC_IRQWAKEEN_ALARM_WAKEEN	BIT(1)
> >> @@ -132,10 +134,13 @@ struct omap_rtc_device_type {
> >>   struct omap_rtc {
> >>   	struct rtc_device *rtc;
> >>   	void __iomem *base;
> >> +	struct clk *ext_clk;
> >> +	struct clk *int_clk;
> >
> > As was already suggested, you could just use one clock here for now.
> 
> If the intent is to enable dynamic switching in future why not have both 
> the clock pointers ready?

Because it needlessly complicates the clock handling below, and those
bits would need to be rewritten anyway when/if dynamic switching is
implemented.

> >
> >>   	int irq_alarm;
> >>   	int irq_timer;
> >>   	u8 interrupts_reg;
> >>   	bool is_pmic_controller;
> >> +	bool has_ext_clk;
> >>   	const struct omap_rtc_device_type *type;
> >>   };
> >>
> >> @@ -553,6 +558,17 @@ static int omap_rtc_probe(struct platform_device *pdev)
> >>   	if (rtc->irq_alarm <= 0)
> >>   		return -ENOENT;
> >>
> >> +	rtc->ext_clk = devm_clk_get(&pdev->dev, "ext-clk");
> >> +	if (!IS_ERR(rtc->ext_clk)) {
> >> +		rtc->has_ext_clk = true;
> >> +		clk_prepare_enable(rtc->ext_clk);
> >> +	} else {
> >> +		rtc->int_clk = devm_clk_get(&pdev->dev, "int-clk");
> >> +
> >> +		if (!IS_ERR(rtc->int_clk))
> >> +			clk_prepare_enable(rtc->int_clk);
> >> +	}
> >> +
> >
> > Which would allow some simplification here.
> >
> > But shouldn't enabling the internal clock go in its own patch before you
> > add support for the external clock?
> 
> I am okay with splitting but for now its either or situation so enabling 
> in one patch made sense to me.

Since you're doing two different things here (fixing the missing clock
enable and adding support for the external clock), I'd suggest doing it
in two patches.

Johan
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
