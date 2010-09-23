From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Thu, 23 Sep 2010 14:13:45 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863DA42@dbde02.ent.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
 <20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E94027863D9E5@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863D9E5-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org 
>[mailto:linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Kalliguddi, Hema
>Sent: Thursday, September 23, 2010 1:21 PM
>To: Balbi, Felipe
>Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>Basak, Partha; Tony Lindgren; Kevin Hilman; Cousson, Benoit; 
>Paul Walmsley
>Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
>
> 
>
>>-----Original Message-----
>>From: Balbi, Felipe 
>>Sent: Thursday, September 23, 2010 12:06 PM
>>To: Kalliguddi, Hema
>>Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>>Basak, Partha; Balbi, Felipe; Tony Lindgren; Kevin Hilman; 
>>Cousson, Benoit; Paul Walmsley
>>Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis 
>for musb.
>>
>>Hi,
>>
>>On Wed, Sep 22, 2010 at 07:30:30PM -0500, Kalliguddi, Hema wrote:
>>>Calling runtime pm APIs pm_runtime_put_sync() and 
>>pm_runtime_get_sync()
>>>for enabling/disabling the clocks,sysconfig settings.
>>>
>>>Also need to put the USB in force standby and force idle mode 
>>when usb not used
>>>and set it back to no idle and no stndby after wakeup.
>>>For OMAP3 auto idle bit has to be disabled because of the 
>>errata.So using
>>>HWMOD_NO_OCP_AUTOIDLE flag for OMAP3430.
>>>
>>>Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>>Signed-off-by: Basak, Partha <p-basak2-l0cyMroinI0@public.gmane.org>
>>>Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
>>>Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>>Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>>>Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
>>>Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
>>
>>these two should a separate series, otherwise it's difficult for
>>different maintainers to decide what they need to pick up :-)
>>
>I don't mind 

I mean I don't mind posting them as separate series. But this will have still the driver
And architecture files changes.

>>Anyways, let me continue;
>>
>>>@@ -2424,13 +2425,16 @@ static int musb_suspend(struct device *d
>>> 		 * they will even be wakeup-enabled.
>>> 		 */
>>> 	}
>>>+	pm_runtime_put_sync(dev);
>>>
>>>+#ifndef CONFIG_PM_RUNTIME
>>> 	musb_save_context(musb);
>>>
>>> 	if (musb->set_clock)
>>> 		musb->set_clock(musb->clock, 0);
>>> 	else
>>> 		clk_disable(musb->clock);
>>>+#endif
>>
>>I would rather remove these, adding ifdefs is bad :-( Unless 
>>other archs
>>(blackfin, davinci) would have problems if we remove those.
>>
>If we remove this then how the clock will be enabled for the 
>other platforms where runtime
>pm is not used?
>
>>>@@ -2457,9 +2465,26 @@ static int musb_resume_noirq(struct devi
>>> 	return 0;
>>> }
>>>
>>>+static int musb_runtime_suspend(struct device *dev)
>>>+{
>>>+	struct musb	*musb = dev_to_musb(dev);
>>
>>missing lock ??
>I am wondering whether we need the lock here? As these 
>functions are supposed to be
>Called by runtime pm framework only. 
>>
>>>+	musb_save_context(musb);
>>
>>shouldn't you disable the clock here ?
>>
>This hook is called when we call pm_runtime_put_sync api which 
>takes care of disabling
>clocks and configuring the sysconfig register.
>
>>>+	return 0;
>>>+}
>>>+
>>>+static int musb_runtime_resume(struct device *dev)
>>>+{
>>>+	struct musb	*musb = dev_to_musb(dev);
>>
>>re-enable clock here and missing lock ??
>>
>
>Not required. This hook gets aclled when pm_runtime_get_sync 
>is called by the driver
>Which will take care of enabling the clock.
>
>I am just wondering whether we need the lock here? As these 
>functions are supposed to be
>Called by runtime pm framework only. 
>
>>>@@ -253,15 +240,13 @@ int __init musb_platform_init(struct mus
>>> void musb_platform_save_context(struct musb *musb,
>>> 		struct musb_context_registers *musb_context)
>>> {
>>>-	musb_context->otg_sysconfig = musb_readl(musb->mregs, 
>>OTG_SYSCONFIG);
>>>-	musb_context->otg_forcestandby = 
>>musb_readl(musb->mregs, OTG_FORCESTDBY);
>>>+	musb_writel(musb->mregs, OTG_FORCESTDBY, ENABLEFORCE);
>>
>>not really saving context anymore :-p but that's ok, we will 
>>need change
>>all that mess anyway.
>>
>Yehh :-)
>
>>>@@ -277,37 +262,23 @@ static int musb_platform_suspend(struct
>>> 	l |= ENABLEFORCE;	/* enable MSTANDBY */
>>> 	musb_writel(musb->mregs, OTG_FORCESTDBY, l);
>>>
>>>-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>>>-	l |= ENABLEWAKEUP;	/* enable wakeup */
>>>-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>>>-
>>> 	otg_set_suspend(musb->xceiv, 1);
>>>
>>>-	if (musb->set_clock)
>>>-		musb->set_clock(musb->clock, 0);
>>>-	else
>>>-		clk_disable(musb->clock);
>>>-
>>
>>should you pm_runtime_put_sync(dev) here ??
>>
>Calling pm_runtime_put_sync leading to crash as
>driver_detach calls __device_release_driver which intern calls 
>pm_runtime_put_sync function, with this the musb clocks are 
>already disabled
>And usecount is 0.
> 
>>> 	return 0;
>>> }
>>>
>>> static int musb_platform_resume(struct musb *musb)
>>> {
>>> 	u32 l;
>>>+	struct device *dev = musb->controller;
>>>
>>> 	if (!musb->clock)
>>> 		return 0;
>>
>>you're not touching clock anymore, this can go too.
>>
>Yes. This can be removed.
>
>>> 	otg_set_suspend(musb->xceiv, 0);
>>>
>>>-	if (musb->set_clock)
>>>-		musb->set_clock(musb->clock, 1);
>>>-	else
>>>-		clk_enable(musb->clock);
>>>-
>>>-	l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>>>-	l &= ~ENABLEWAKEUP;	/* disable wakeup */
>>>-	musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>>>+	pm_runtime_enable(dev);
>>>+	pm_runtime_get_sync(dev);
>>
>>seems like you're going to call pm_runtime_get_sync twice ? once here
>>and another time on musb_resume_noirq(). why ?
>
>pm_runtime_get_sync is called in the musb_platform_resume function 
>during the initialization of the driver. Where we need to 
>enable the clocks
>and put the sysconfig registers to known configurations.
>
>pm_runtime_get_sync is called in musb_resume_noirq() to 
>re-enable the cloks
>and configure the sysconfig because the clocks are disabled in 
>musb_suspend()
>by calling pm_runtime_put_sync() during global suspend/resume.
>
>
>>
>>-- 
>>balbi
>>--
>To unsubscribe from this list: send the line "unsubscribe linux-usb" in
>the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
