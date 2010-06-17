From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 8/8] usb: musb: Fix suspend interrupt issue in device
 mode
Date: Thu, 17 Jun 2010 17:33:17 +0400
Message-ID: <4C1A241D.1020509@ru.mvista.com>
References: <1276771242-5201-1-git-send-email-ajay.gupta@ti.com> <1276771242-5201-2-git-send-email-ajay.gupta@ti.com> <1276771242-5201-3-git-send-email-ajay.gupta@ti.com> <1276771242-5201-4-git-send-email-ajay.gupta@ti.com> <1276771242-5201-5-git-send-email-ajay.gupta@ti.com> <1276771242-5201-6-git-send-email-ajay.gupta@ti.com> <1276771242-5201-7-git-send-email-ajay.gupta@ti.com> <1276771242-5201-8-git-send-email-ajay.gupta@ti.com> <1276771242-5201-9-git-send-email-ajay.gupta@ti.com> <4C1A0687.4080002@ru.mvista.com> <006501cb0e16$c08bae00$808918ac@apr.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:60096 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753890Ab0FQNeQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Jun 2010 09:34:16 -0400
In-Reply-To: <006501cb0e16$c08bae00$808918ac@apr.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Maulik <x0082077@ti.com>
Cc: 'Sergei Shtylyov' <sshtylyov@mvista.com>, 'Ajay Kumar Gupta' <ajay.gupta@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, felipe.balbi@nokia.com, gregkh@suse.de, 'David Brownell' <david-b@pacbell.net>

Hello.

Maulik wrote:

>> -----Original Message-----
>> From: Sergei Shtylyov [mailto:sshtylyov@mvista.com]
>> Sent: Thursday, June 17, 2010 4:57 PM
>> To: Ajay Kumar Gupta
>> Cc: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org;
>> felipe.balbi@nokia.com; gregkh@suse.de; Maulik Mankad; David Brownell
>> Subject: Re: [PATCH 8/8] usb: musb: Fix suspend interrupt issue in device
>> mode
>>
>> Hello.
>>
>> Ajay Kumar Gupta wrote:
>>
>>> From: Maulik Mankad <x0082077@ti.com>
>>> As a part of aligning the ISR code for MUSB with the specs, the
>>> ISR code was re-written.
>>> See Commit 1c25fda4a09e8229800979986ef399401053b46e (usb: musb: handle
>>> irqs in the order dictated by programming guide)
>>> With this the suspend interrupt came accidently under
>> CONFIG_USB_MUSB_HDRC_HCD.
>>
>>> The fix brings suspend interrupt handling outside
>>> CONFIG_USB_MUSB_HDRC_HCD.
>>> Signed-off-by: Maulik Mankad <x0082077@ti.com>
>>> Acked-by: Felipe Balbi <felipe.balbi@nokia.com>
>>> Cc: David Brownell <david-b@pacbell.net>
>>> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
>> [...]
>>
>>> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
>>> index 4f43db7..64b08f9 100644
>>> --- a/drivers/usb/musb/musb_core.c
>>> +++ b/drivers/usb/musb/musb_core.c
>>> @@ -635,7 +635,7 @@ static irqreturn_t musb_stage0_irq(struct musb
>> *musb, u8 int_usb,
>>>  		handled = IRQ_HANDLED;
>>>  	}
>>>
>>> -
>>> +#endif

>>     Could you move #endif one line up, so that it closely embraces the
>> *if* statement?

> The patch is already in Greg's queue. 

    Hm, how come it ended up there before the patches submitted earlier 
-- namely before the patch that's needed for the suspend interrupt to be 
handled at all? :-/
    Felipe, could you also ACK the other pending patches, not this 
single one?

> Greg,

> Do you want me to resend this patch?

> Thanks,
> Maulik

WBR, Sergei
