From: "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH V2 6/8] usb: musb: Offmode fix for idle path
Date: Tue, 10 Aug 2010 17:29:19 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E940270A4A257@dbde02.ent.ti.com>
References: <1281115624-1174-1-git-send-email-hemahk@ti.com>
 <4C5D7AE5.7040506@ru.mvista.com>
 <E0D41E29EB0DAC4E9F3FF173962E9E940270A49F92@dbde02.ent.ti.com>
 <4C6135D1.2000909@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C6135D1.2000909-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Mankad, Maulik Ojas" <x0082077-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi, 

>-----Original Message-----
>From: Sergei Shtylyov [mailto:sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org] 
>Sent: Tuesday, August 10, 2010 4:50 PM
>To: Kalliguddi, Hema
>Cc: Sergei Shtylyov; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; 
>linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Mankad, Maulik Ojas; Felipe Balbi; 
>Tony Lindgren; Kevin Hilman
>Subject: Re: [PATCH V2 6/8] usb: musb: Offmode fix for idle path
>
>Hello.
>
>Kalliguddi, Hema wrote:
>
>>>> With OMAP core-off support musb was not functional as 
>context was getting
>>>> lost after wakeup from core-off. And also musb was 
>blocking the core-off 
>>>> after loading the gadget driver even with no cable 
>connected sometimes.
>
>>>> Added the conext save/restore api in the platform layer which will
>>>> be called in the idle and wakeup path.
>>>> Changed the usb sysconfig settings as per the usbotg 
>functional spec.
>>>> When the device is not active, configure to force idle and 
>force standby mode.
>>>> When it is being used, configure in smart standby and 
>smart idle mode.
>>>> So while attempting to coreoff the usb is configured to 
>force standby and 
>>>> force idle mode, after wakeup configured in smart idle and 
>smart standby.
>
>>>> Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
>>>> Signed-off-by: Maulik Mankad <x0082077-l0cyMroinI0@public.gmane.org>
>>>> Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
>>>> Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>>>> Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
>
>>> [...]
>
>>>> Index: linux-omap-pm/drivers/usb/musb/musb_core.c
>>>> ===================================================================
>>>> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.c	
>>> 2010-08-06 09:24:21.069863329 -0400
>>>> +++ linux-omap-pm/drivers/usb/musb/musb_core.c	
>>> 2010-08-06 10:44:06.369863527 -0400
>>>> @@ -2427,11 +2427,6 @@
>>>>  	}
>>>>  
>>>>  	musb_save_context(musb);
>>>> -
>>>> -	if (musb->set_clock)
>>>> -		musb->set_clock(musb->clock, 0);
>>>> -	else
>>>> -		clk_disable(musb->clock);
>>>>  	spin_unlock_irqrestore(&musb->lock, flags);
>>>>  	return 0;
>>>>  }
>>>> @@ -2443,12 +2438,6 @@
>>>>  
>>>>  	if (!musb->clock)
>>>>  		return 0;
>>>> -
>>>> -	if (musb->set_clock)
>>>> -		musb->set_clock(musb->clock, 1);
>>>> -	else
>>>> -		clk_enable(musb->clock);
>>>> -
>>>>  	musb_restore_context(musb);
>
>>>   The same question again: are you sure that clocks are 
>auto-gated on 
>>> non-OMAP platfroms?
>
>> Bon Lui confirmed that there is no clock for blackfin.
>
>    What about DaVinci (and the coming DA8xx)?
>

I checked with Ajay, it is not auto gated for for Davinci so I can't just remove this.

I am thinking of adding a member variable(clk_autogated) in them usb_hdrc_platform_data structure and 
check this in the musb_suspend() And musb_resume() APIs. Do you see any problem with it?

Regards,
Hema



>WBR, Sergei
>
>--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
