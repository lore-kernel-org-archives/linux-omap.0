From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Thu, 23 Sep 2010 10:33:58 -0700
Message-ID: <87fwx02wl5.fsf@deeprootsystems.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
	<20100923063604.GE2563@legolas.emea.dhcp.ti.com>
	<87wrqc4gwd.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52733 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101Ab0IWReB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 13:34:01 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
	(Hema Kalliguddi's message of "Thu, 23 Sep 2010 21:09:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "Balbi, Felipe" <balbi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Basak, Partha" <p-basak2@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

"Kalliguddi, Hema" <hemahk@ti.com> writes:

>  
>
>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>>Sent: Thursday, September 23, 2010 9:00 PM
>>To: Balbi, Felipe
>>Cc: Kalliguddi, Hema; linux-omap@vger.kernel.org; 
>>linux-usb@vger.kernel.org; Basak, Partha; Tony Lindgren; 
>>Cousson, Benoit; Paul Walmsley
>>Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
>>
>>Felipe Balbi <balbi@ti.com> writes:
>>
>>> Hi,
>>>
>>> On Wed, Sep 22, 2010 at 07:30:30PM -0500, Kalliguddi, Hema wrote:
>>>>Calling runtime pm APIs pm_runtime_put_sync() and 
>>pm_runtime_get_sync()
>>>>for enabling/disabling the clocks,sysconfig settings.
>>>>
>>>>Also need to put the USB in force standby and force idle 
>>mode when usb not used
>>>>and set it back to no idle and no stndby after wakeup.
>>>>For OMAP3 auto idle bit has to be disabled because of the 
>>errata.So using
>>>>HWMOD_NO_OCP_AUTOIDLE flag for OMAP3430.
>>
>>[...]
>>
>>>>@@ -2424,13 +2425,16 @@ static int musb_suspend(struct device *d
>>>> 		 * they will even be wakeup-enabled.
>>>> 		 */
>>>> 	}
>>>>+	pm_runtime_put_sync(dev);
>>>>
>>>>+#ifndef CONFIG_PM_RUNTIME
>>>> 	musb_save_context(musb);
>>>>
>>>> 	if (musb->set_clock)
>>>> 		musb->set_clock(musb->clock, 0);
>>>> 	else
>>>> 		clk_disable(musb->clock);
>>>>+#endif
>>>
>>> I would rather remove these, adding ifdefs is bad :-( Unless 
>>other archs
>>> (blackfin, davinci) would have problems if we remove those.
>>
>>I didn't like these #ifdefs either, but davinci doesn't have 
>>runtime PM,
>>and I don't think blackfin does either.
>>
>>But, rather than the ifdef here, this could be done with different
>>pointers in struct dev_pm_ops based on the arch.
>>
>>Also, this shouldn't be based on CONFIG_PM_RUNTIME, but rather on the
>>arch.  We can still enable runtime PM on davinci for other subsystems
>>(PCI, USB core, etc.) but not have it supported for on-chip devices.
>>
> Is it a good idea to use the musb->set_clock function pointer for OMAP architure and
> call the runtime pm apis from this function defined in the usb platform driver(omap2430)

I guess that's Felipe's call, but I don't like that option.

I think it's cleaner to have the ->set_clock hook be a noop on OMAP and
the runtime hooks be noops on the other platforms.

Kevin

