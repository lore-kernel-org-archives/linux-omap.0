From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH v4] usb: musb: Adding names for IRQs in resource structure
Date: Fri, 10 Dec 2010 19:43:40 +0300
Message-ID: <4D0258BC.3080207@mvista.com>
References: <1285777599-24245-1-git-send-email-hemahk@ti.com> <8762xo62b5.fsf@deeprootsystems.com> <4D012F2C.9060303@ru.mvista.com> <AANLkTimF3Eotqa+jZvzCJStguGrDEeS9V-XUGOTa9qBt@mail.gmail.com> <4D02237B.2070708@mvista.com> <20101210132053.GN6027@legolas.emea.dhcp.ti.com> <4D022C92.7090308@ru.mvista.com> <20101210135803.GQ6027@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f45.google.com ([209.85.215.45]:43051 "EHLO
	mail-ew0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab0LJQpB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Dec 2010 11:45:01 -0500
In-Reply-To: <20101210135803.GQ6027@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Mike Frysinger <vapier@gentoo.org>

Hello.

Felipe Balbi wrote:

>>>>>>>> Index: linux-omap-pm/arch/arm/mach-davinci/usb.c
>>>>>>>> ===================================================================
>>>>>>>> --- linux-omap-pm.orig/arch/arm/mach-davinci/usb.c
>>>>>>>> +++ linux-omap-pm/arch/arm/mach-davinci/usb.c
>>>>>>>> @@ -64,10 +64,12 @@ static struct resource usb_resources[] =
>>>>>>>> {
>>>>>>>> .start = IRQ_USBINT,
>>>>>>>> .flags = IORESOURCE_IRQ,
>>>>>>>> + .name = "mc"
>>>>>>>> },
>>>>>>>> {
>>>>>>>> /* placeholder for the dedicated CPPI IRQ */
>>>>>>>> .flags = IORESOURCE_IRQ,
>>>>>>>> + .name = "dma"
>>>>>>>> },
>>>>>>>> };

>>>>>> Argh! This failed to also modify da8xx_usb20_resources[]... :-(

>>>>> I think when I posted these patch, da8xx support was not there in 
>>>>> mainline.

>>>> No, it was added long ago, before the glue layer itself.

>>>>> I will send patch to add this.

>>>> I will care about this myself now.

>>> Thanks, send me the patch and I'll put to the same branch.

>>   I was thinking about pushing this thru the DaVinci tree. Well, I'll 
>> post to both lists and let you figure out who will apply it... :-)

> If Kevin picks it up, fine by me :-)

    Hm, I thought this patch has already been applied but it's only in Greg's 
usb-next branch yet. I guess it's too late to update it now, so a separate patch 
should still be created? However, it's not a hot fix now as I thought, and 
doesn't apply to linux-davinci.git...

WBR, Sergei
