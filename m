From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH V2 6/8] usb: musb: Offmode fix for idle path
Date: Tue, 10 Aug 2010 17:53:13 +0400
Message-ID: <4C6159C9.6090204@ru.mvista.com>
References: <1281115624-1174-1-git-send-email-hemahk@ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB032401D637@dbde02.ent.ti.com> <E0D41E29EB0DAC4E9F3FF173962E9E940270A49FFB@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37178 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757505Ab0HJNyH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 09:54:07 -0400
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E940270A49FFB@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "DebBarma, Tarun Kanti" <tarun.kanti@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>

Hello.

Kalliguddi, Hema wrote:

>> Hema,

>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Hema HK
>>> Sent: Friday, August 06, 2010 10:57 PM
>>> To: linux-usb@vger.kernel.org; linux-omap@vger.kernel.org
>>> Cc: Kalliguddi, Hema; Mankad, Maulik Ojas; Felipe Balbi; Tony Lindgren;
>>> Kevin Hilman
>>> Subject: [PATCH V2 6/8] usb: musb: Offmode fix for idle path

>>> From: Hema HK  <hemahk@ti.com>

>>> With OMAP core-off support musb was not functional as context was getting
>>> lost after wakeup from core-off. And also musb was blocking the core-off
>>> after loading the gadget driver even with no cable connected sometimes.

>>> Added the conext save/restore api in the platform layer which will
>>> be called in the idle and wakeup path.

>>> Changed the usb sysconfig settings as per the usbotg functional spec.
>>> When the device is not active, configure to force idle and force standby
>>> mode.
>>> When it is being used, configure in smart standby and smart idle mode.
>>> So while attempting to coreoff the usb is configured to force standby and
>>> force idle mode, after wakeup configured in smart idle and smart standby.

>>> Signed-off-by: Hema HK <hemahk@ti.com>
>>> Signed-off-by: Maulik Mankad <x0082077@ti.com>

>>> Cc: Felipe Balbi <felipe.balbi@nokia.com>
>>> Cc: Tony Lindgren <tony@atomide.com>
>>> Cc: Kevin Hilman <khilman@deeprootsystems.com>

>>> Index: linux-omap-pm/drivers/usb/musb/omap2430.c
>>> ===================================================================
>>> --- linux-omap-pm.orig/drivers/usb/musb/omap2430.c	2010-08-06
>>> 09:24:21.069863329 -0400
>>> +++ linux-omap-pm/drivers/usb/musb/omap2430.c	2010-08-06
>>> 10:44:30.093914217 -0400
[...]
>>> @@ -259,15 +273,42 @@
>>>  void musb_platform_save_context(struct musb *musb,
>>>  		struct musb_context_registers *musb_context)
>>>  {
>>> -	musb_context->otg_sysconfig = musb_readl(musb->mregs, OTG_SYSCONFIG);
>>> -	musb_context->otg_forcestandby = musb_readl(musb->mregs, OTG_FORCESTDBY);
>>> +	/*
>>> +	 * As per the omap-usbotg specification, configure it to forced standby
>>> +	 * and  force idle mode when no activity on usb.
>>> +	 */
>>> +	void __iomem *musb_base = musb->mregs;
>>> +

>> Just to clarify, have you already taken care of ioremap() / 
>> request_mem_region() for musb_base?

> This is already done.

    Not quite. MUSB driver doesn't call request_mem_region().

WBR, Sergei
