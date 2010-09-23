From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Thu, 23 Sep 2010 09:36:04 +0300
Message-ID: <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38553 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750730Ab0IWGgK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Sep 2010 02:36:10 -0400
Content-Disposition: inline
In-Reply-To: <1285201830-26561-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

On Wed, Sep 22, 2010 at 07:30:30PM -0500, Kalliguddi, Hema wrote:
>Calling runtime pm APIs pm_runtime_put_sync() and pm_runtime_get_sync()
>for enabling/disabling the clocks,sysconfig settings.
>
>Also need to put the USB in force standby and force idle mode when usb not used
>and set it back to no idle and no stndby after wakeup.
>For OMAP3 auto idle bit has to be disabled because of the errata.So using
>HWMOD_NO_OCP_AUTOIDLE flag for OMAP3430.
>
>Signed-off-by: Hema HK <hemahk@ti.com>
>Signed-off-by: Basak, Partha <p-basak2@ti.com>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>
>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>Cc: Cousson, Benoit <b-cousson@ti.com>
>Cc: Paul Walmsley <paul@pwsan.com>

these two should a separate series, otherwise it's difficult for
different maintainers to decide what they need to pick up :-)

Anyways, let me continue;

>@@ -2424,13 +2425,16 @@ static int musb_suspend(struct device *d
> 		 * they will even be wakeup-enabled.
> 		 */
> 	}
>+	pm_runtime_put_sync(dev);
>
>+#ifndef CONFIG_PM_RUNTIME
> 	musb_save_context(musb);
>
> 	if (musb->set_clock)
> 		musb->set_clock(musb->clock, 0);
> 	else
> 		clk_disable(musb->clock);
>+#endif

I would rather remove these, adding ifdefs is bad :-( Unless other archs
(blackfin, davinci) would have problems if we remove those.

>@@ -2457,9 +2465,26 @@ static int musb_resume_noirq(struct devi
> 	return 0;
> }
>
>+static int musb_runtime_suspend(struct device *dev)
>+{
>+	struct musb	*musb = dev_to_musb(dev);

missing lock ??

>+	musb_save_context(musb);

shouldn't you disable the clock here ?

>+	return 0;
>+}
>+
>+static int musb_runtime_resume(struct device *dev)
>+{
>+	struct musb	*musb = dev_to_musb(dev);

re-enable clock here and missing lock ??

>@@ -253,15 +240,13 @@ int __init musb_platform_init(struct mus
> void musb_platform_save_context(struct musb *musb,
> 		struct musb_context_registers *musb_context)
> {
>-	musb_context->otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
>-	musb_context->otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
>+	musb_writel(musb->mregs, OTG_FORCESTDBY, ENABLEFORCE);

not really saving context anymore :-p but that's ok, we will need change
all that mess anyway.

>@@ -277,37 +262,23 @@ static int musb_platform_suspend(struct
> 	l |= ENABLEFORCE;	/* enable MSTANDBY */
> 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
>
>-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>-	l |= ENABLEWAKEUP;	/* enable wakeup */
>-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>-
> 	otg_set_suspend(musb->xceiv, 1);
>
>-	if (musb->set_clock)
>-		musb->set_clock(musb->clock, 0);
>-	else
>-		clk_disable(musb->clock);
>-

should you pm_runtime_put_sync(dev) here ??

> 	return 0;
> }
>
> static int musb_platform_resume(struct musb *musb)
> {
> 	u32 l;
>+	struct device *dev = musb->controller;
>
> 	if (!musb->clock)
> 		return 0;

you're not touching clock anymore, this can go too.

> 	otg_set_suspend(musb->xceiv, 0);
>
>-	if (musb->set_clock)
>-		musb->set_clock(musb->clock, 1);
>-	else
>-		clk_enable(musb->clock);
>-
>-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
>-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>+	pm_runtime_enable(dev);
>+	pm_runtime_get_sync(dev);

seems like you're going to call pm_runtime_get_sync twice ? once here
and another time on musb_resume_noirq(). why ?

-- 
balbi
