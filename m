From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v4] usb: musb: Adding names for IRQs in resource
 structure
Date: Wed, 29 Sep 2010 09:59:52 +0300
Message-ID: <20100929065952.GJ2728@legolas.emea.dhcp.ti.com>
References: <1285777599-24245-1-git-send-email-hemahk@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59521 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab0I2HAD (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Sep 2010 03:00:03 -0400
Content-Disposition: inline
In-Reply-To: <1285777599-24245-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Kalliguddi, Hema" <hemahk@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Mike Frysinger <vapier@gentoo.org>

Hi,

On Wed, Sep 29, 2010 at 11:26:39AM -0500, Kalliguddi, Hema wrote:
>Index: linux-omap-pm/arch/arm/mach-davinci/usb.c
>===================================================================
>--- linux-omap-pm.orig/arch/arm/mach-davinci/usb.c
>+++ linux-omap-pm/arch/arm/mach-davinci/usb.c
>@@ -64,10 +64,12 @@ static struct resource usb_resources[] =
> 	{
> 		.start          = IRQ_USBINT,
> 		.flags          = IORESOURCE_IRQ,
>+		.name		= "mc"
> 	},
> 	{
> 		/* placeholder for the dedicated CPPI IRQ */
> 		.flags          = IORESOURCE_IRQ,
>+		.name		= "dma"
> 	},
> };

you add names only to the IRQs, this will still require the memory base
to be the first resource. Maybe adding a name like "regs" to the memory
base and changing to platform_get_resource_byname(pdev, "regs") on
musb-core.c

-- 
balbi
