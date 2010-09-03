From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 8/8 v2] usb : musb: Using runtime pm apis for musb.
Date: Fri, 3 Sep 2010 15:50:34 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402781CE70B@dbde02.ent.ti.com>
References: <1282140679-29963-1-git-send-email-hemahk@ti.com>
	<87bp8q5iz7.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402780D4101@dbde02.ent.ti.com>
 <87hbiau7ov.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87hbiau7ov.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Basak, Partha" <p-basak2-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

 

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org] 
>Sent: Tuesday, August 31, 2010 8:54 PM
>To: Kalliguddi, Hema
>Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>Basak, Partha; Felipe Balbi; Tony Lindgren; Cousson, Benoit; 
>Paul Walmsley
>Subject: Re: [PATCH 8/8 v2] usb : musb: Using runtime pm apis for musb.
>
>"Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org> writes:
>
>>>>  static int musb_platform_resume(struct musb *musb)
>>>>  {
>>>>      u32 l;
>>>> +    struct device *dev = musb->controller;
>>>> +    struct musb_hdrc_platform_data *pdata = dev->platform_data;
>>>> +    struct platform_device *pdev = to_platform_device(dev);
>>>>
>>>>      if (!musb->clock)
>>>>              return 0;
>>>>
>>>>      otg_set_suspend(musb->xceiv, 0);
>>>> -
>>>> -    if (musb->set_clock)
>>>> -            musb->set_clock(musb->clock, 1);
>>>> -    else
>>>> -            clk_enable(musb->clock);
>>>> -
>>>> -    l = musb_readl(musb->mregs, OTG_SYSCONFIG);
>>>> -    l &= ~ENABLEWAKEUP;     /* disable wakeup */
>>>> -    musb_writel(musb->mregs, OTG_SYSCONFIG, l);
>>>> -
>>>> +    pm_runtime_enable(dev);
>>>> +    pm_runtime_get_sync(dev);
>>>> +    pdata->enable_wakeup(pdev);
>>>
>>>I think you mean ->disable_wakeup() here, right?
>>>
>>
>> No I meant enable_wakeup only here. When smart idle/standby 
>is enabled,
>> wakeup bit has to be set to generate the s-wakeup when the 
>devie is in idle
>> and system is in ret.
>
>OK, I'm confused.
>
>The code being removed just above disables wakeups and the new code
>enables wakeups.
>
The old code was not correct. The wakeup enable make sense only when the smart idle/smart
Standby is enabled. And with get_sync musb is configured to be in smart idle/standby mode.

>Also, you don't ever call ->disable_wakeup() elsewhere in the patch.
>You call pdata->enable_wakeup() both in suspend and resume.

Disable_wkaeup is not required now as there is no need of disabling this bit because with force idle/standby
there is no use of wakeup enable/disable bit.

Anyway again, we need have these APIs if Rajendra is going to post the patch to enable wkaeup in the 
framework if smart idle/standby is enabled.

>
>Kevin
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
