From: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH 8/8 v2] usb : musb: Using runtime pm apis for musb.
Date: Tue, 31 Aug 2010 08:24:00 -0700
Message-ID: <87hbiau7ov.fsf@deeprootsystems.com>
References: <1282140679-29963-1-git-send-email-hemahk@ti.com>
	<87bp8q5iz7.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402780D4101@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402780D4101-/tLxBxkBPtCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
	(Hema Kalliguddi's message of "Tue, 31 Aug 2010 14:22:27 +0530")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb@vger.kernel.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

"Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org> writes:

>>>  static int musb_platform_resume(struct musb *musb)
>>>  {
>>>      u32 l;
>>> +    struct device *dev = musb->controller;
>>> +    struct musb_hdrc_platform_data *pdata = dev->platform_data;
>>> +    struct platform_device *pdev = to_platform_device(dev);
>>>
>>>      if (!musb->clock)
>>>              return 0;
>>>
>>>      otg_set_suspend(musb->xceiv, 0);
>>> -
>>> -    if (musb->set_clock)
>>> -            musb->set_clock(musb->clock, 1);
>>> -    else
>>> -            clk_enable(musb->clock);
>>> -
>>> -    l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>>> -    l &= ~ENABLEWAKEUP;     /* disable wakeup */
>>> -    musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>>> -
>>> +    pm_runtime_enable(dev);
>>> +    pm_runtime_get_sync(dev);
>>> +    pdata->enable_wakeup(pdev);
>>
>>I think you mean ->disable_wakeup() here, right?
>>
>
> No I meant enable_wakeup only here. When smart idle/standby is enabled,
> wakeup bit has to be set to generate the s-wakeup when the devie is in idle
> and system is in ret.

OK, I'm confused.

The code being removed just above disables wakeups and the new code
enables wakeups.

Also, you don't ever call ->disable_wakeup() elsewhere in the patch.
You call pdata->enable_wakeup() both in suspend and resume.

Kevin
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
