From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH V2 6/8] usb: musb: Offmode fix for idle path
Date: Tue, 10 Aug 2010 15:19:45 +0400
Message-ID: <4C6135D1.2000909@ru.mvista.com>
References: <1281115624-1174-1-git-send-email-hemahk@ti.com> <4C5D7AE5.7040506@ru.mvista.com> <E0D41E29EB0DAC4E9F3FF173962E9E940270A49F92@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:55462 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757496Ab0HJLVS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 07:21:18 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940270A49F92@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: Sergei Shtylyov <sshtylyov@mvista.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hello.

Kalliguddi, Hema wrote:

>>> With OMAP core-off support musb was not functional as context was getting
>>> lost after wakeup from core-off. And also musb was blocking the core-off 
>>> after loading the gadget driver even with no cable connected sometimes.

>>> Added the conext save/restore api in the platform layer which will
>>> be called in the idle and wakeup path.
>>> Changed the usb sysconfig settings as per the usbotg functional spec.
>>> When the device is not active, configure to force idle and force standby mode.
>>> When it is being used, configure in smart standby and smart idle mode.
>>> So while attempting to coreoff the usb is configured to force standby and 
>>> force idle mode, after wakeup configured in smart idle and smart standby.

>>> Signed-off-by: Hema HK <hemahk@ti.com>
>>> Signed-off-by: Maulik Mankad <x0082077@ti.com>
>>> Cc: Felipe Balbi <felipe.balbi@nokia.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>

>> [...]

>>> Index: linux-omap-pm/drivers/usb/musb/musb_core.c
>>> ===================================================================
>>> --- linux-omap-pm.orig/drivers/usb/musb/musb_core.c	
>> 2010-08-06 09:24:21.069863329 -0400
>>> +++ linux-omap-pm/drivers/usb/musb/musb_core.c	
>> 2010-08-06 10:44:06.369863527 -0400
>>> @@ -2427,11 +2427,6 @@
>>>  	}
>>>  
>>>  	musb_save_context(musb);
>>> -
>>> -	if (musb->set_clock)
>>> -		musb->set_clock(musb->clock, 0);
>>> -	else
>>> -		clk_disable(musb->clock);
>>>  	spin_unlock_irqrestore(&musb->lock, flags);
>>>  	return 0;
>>>  }
>>> @@ -2443,12 +2438,6 @@
>>>  
>>>  	if (!musb->clock)
>>>  		return 0;
>>> -
>>> -	if (musb->set_clock)
>>> -		musb->set_clock(musb->clock, 1);
>>> -	else
>>> -		clk_enable(musb->clock);
>>> -
>>>  	musb_restore_context(musb);

>>   The same question again: are you sure that clocks are auto-gated on 
>> non-OMAP platfroms?

> Bon Lui confirmed that there is no clock for blackfin.

    What about DaVinci (and the coming DA8xx)?

WBR, Sergei

