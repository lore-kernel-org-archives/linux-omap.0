From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4] usb: musb: Adding names for IRQs in resource
 structure
Date: Fri, 10 Dec 2010 15:20:53 +0200
Message-ID: <20101210132053.GN6027@legolas.emea.dhcp.ti.com>
References: <1285777599-24245-1-git-send-email-hemahk@ti.com>
 <8762xo62b5.fsf@deeprootsystems.com>
 <4D012F2C.9060303@ru.mvista.com>
 <AANLkTimF3Eotqa+jZvzCJStguGrDEeS9V-XUGOTa9qBt@mail.gmail.com>
 <4D02237B.2070708@mvista.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:41168 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755869Ab0LJNU6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 10 Dec 2010 08:20:58 -0500
Content-Disposition: inline
In-Reply-To: <4D02237B.2070708@mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Mike Frysinger <vapier@gentoo.org>

On Fri, Dec 10, 2010 at 03:56:27PM +0300, Sergei Shtylyov wrote:
>Hello.
>
>On 10-12-2010 7:46, Kalliguddi, Hema wrote:
>
>>>>>The resource data is getting automatically populated from a set of data
>>>>>generated from TI's hardware database for the OMAP platform, While we
>>>>>could hack in some exceptions to that tool to generate resources
>>>>>in a specific order, it seems less fragile to use the resource name
>>>>>instead.That way, no matter what order the resources are generated, the
>>>>>driver still work.
>
>>>>>Modified the OMAP,Blackfin and Davinci architecture files to add the name
>>>>>of the IRQs
>>>>>in the resource structures and musb driver to use the get_irq_byname()
>>>>>api to
>>>>>get the device and dma irq numbers instead of using the index.
>
>>>>>Signed-off-by: Hema HK<hemahk@ti.com>
>>>>>Cc: Felipe Balbi<balbi@ti.com>
>>>>>Cc: Tony Lindgren<tony@atomide.com>
>>>>>Cc: Kevin Hilman<khilman@deeprootsystems.com>
>>>>>Cc: Cousson, Benoit<b-cousson@ti.com>
>>>>>Cc: Paul Walmsley<paul@pwsan.com>
>>>>>Cc: Mike Frysinger<vapier@gentoo.org>
>>>>>---
>
>>>>For the davinci changes:
>
>>>>Acked-by: Kevin Hilman<khilman@deeprootsystems.com>
>
>>>>Kevin
>
>>>[...]
>
>>>>>Index: linux-omap-pm/arch/arm/mach-davinci/usb.c
>>>>>===================================================================
>>>>>--- linux-omap-pm.orig/arch/arm/mach-davinci/usb.c
>>>>>+++ linux-omap-pm/arch/arm/mach-davinci/usb.c
>>>>>@@ -64,10 +64,12 @@ static struct resource usb_resources[] =
>>>>>        {
>>>>>                .start          = IRQ_USBINT,
>>>>>                .flags          = IORESOURCE_IRQ,
>>>>>+               .name           = "mc"
>>>>>        },
>>>>>        {
>>>>>                /* placeholder for the dedicated CPPI IRQ */
>>>>>                .flags          = IORESOURCE_IRQ,
>>>>>+               .name           = "dma"
>>>>>        },
>>>>>  };
>
>>>   Argh! This failed to also modify da8xx_usb20_resources[]... :-(
>
>>I think when I posted these patch, da8xx support was not there in mainline.
>
>   No, it was added long ago, before the glue layer itself.
>
>>I will send patch to add this.
>
>   I will care about this myself now.

Thanks, send me the patch and I'll put to the same branch.

-- 
balbi
