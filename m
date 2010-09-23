From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
Date: Thu, 23 Sep 2010 21:09:59 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E94027863DD4D@dbde02.ent.ti.com>
References: <1285201830-26561-1-git-send-email-hemahk@ti.com>
	<20100923063604.GE2563@legolas.emea.dhcp.ti.com>
 <87wrqc4gwd.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87wrqc4gwd.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Balbi, Felipe" <balbi-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org] 
>Sent: Thursday, September 23, 2010 9:00 PM
>To: Balbi, Felipe
>Cc: Kalliguddi, Hema; linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Basak, Partha; Tony Lindgren; 
>Cousson, Benoit; Paul Walmsley
>Subject: Re: [PATCH 8/9 v3] usb : musb: Using runtime pm apis for musb.
>
>Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> writes:
>
>> Hi,
>>
>> On Wed, Sep 22, 2010 at 07:30:30PM -0500, Kalliguddi, Hema wrote:
>>>Calling runtime pm APIs pm_runtime_put_sync() and 
>pm_runtime_get_sync()
>>>for enabling/disabling the clocks,sysconfig settings.
>>>
>>>Also need to put the USB in force standby and force idle 
>mode when usb not used
>>>and set it back to no idle and no stndby after wakeup.
>>>For OMAP3 auto idle bit has to be disabled because of the 
>errata.So using
>>>HWMOD_NO_OCP_AUTOIDLE flag for OMAP3430.
>
>[...]
>
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
>> I would rather remove these, adding ifdefs is bad :-( Unless 
>other archs
>> (blackfin, davinci) would have problems if we remove those.
>
>I didn't like these #ifdefs either, but davinci doesn't have 
>runtime PM,
>and I don't think blackfin does either.
>
>But, rather than the ifdef here, this could be done with different
>pointers in struct dev_pm_ops based on the arch.
>
>Also, this shouldn't be based on CONFIG_PM_RUNTIME, but rather on the
>arch.  We can still enable runtime PM on davinci for other subsystems
>(PCI, USB core, etc.) but not have it supported for on-chip devices.
>
Is it a good idea to use the musb->set_clock function pointer for OMAP architure and
call the runtime pm apis from this function defined in the usb platform driver(omap2430)

>Kevin
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
