From: "Kalliguddi, Hema" <hemahk@ti.com>
Subject: RE: [PATCH v4] usb: musb: Adding names for IRQs in resource
 structure
Date: Wed, 29 Sep 2010 14:24:45 +0530
Message-ID: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB7FE486@dbde02.ent.ti.com>
References: <1285777599-24245-1-git-send-email-hemahk@ti.com>
 <20100929065952.GJ2728@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:37093 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056Ab0I2Iy4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 04:54:56 -0400
In-Reply-To: <20100929065952.GJ2728@legolas.emea.dhcp.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Mike Frysinger <vapier@gentoo.org>

 Hi,

>-----Original Message-----
>From: Balbi, Felipe 
>Sent: Wednesday, September 29, 2010 12:30 PM
>To: Kalliguddi, Hema
>Cc: linux-omap@vger.kernel.org; linux-usb@vger.kernel.org; 
>Balbi, Felipe; Tony Lindgren; Kevin Hilman; Cousson, Benoit; 
>Paul Walmsley; Mike Frysinger
>Subject: Re: [PATCH v4] usb: musb: Adding names for IRQs in 
>resource structure
>
>Hi,
>
>On Wed, Sep 29, 2010 at 11:26:39AM -0500, Kalliguddi, Hema wrote:
>>Index: linux-omap-pm/arch/arm/mach-davinci/usb.c
>>===================================================================
>>--- linux-omap-pm.orig/arch/arm/mach-davinci/usb.c
>>+++ linux-omap-pm/arch/arm/mach-davinci/usb.c
>>@@ -64,10 +64,12 @@ static struct resource usb_resources[] =
>> 	{
>> 		.start          = IRQ_USBINT,
>> 		.flags          = IORESOURCE_IRQ,
>>+		.name		= "mc"
>> 	},
>> 	{
>> 		/* placeholder for the dedicated CPPI IRQ */
>> 		.flags          = IORESOURCE_IRQ,
>>+		.name		= "dma"
>> 	},
>> };
>
>you add names only to the IRQs, this will still require the memory base
>to be the first resource. Maybe adding a name like "regs" to the memory
>base and changing to platform_get_resource_byname(pdev, "regs") on
>musb-core.c
>
It does not mandate the base address to be the first resource, as the api
used for getting the base address takes the resource type as parameter.
"platform_get_resource(struct platform_device *dev,unsigned int type,
unsigned int num)". but it mandates the base addresses have to be in 
certain order if there are multiple base address.Since for musb there
is one base address.

>-- 
>balbi
>