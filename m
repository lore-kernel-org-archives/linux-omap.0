From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
Date: Fri, 14 Nov 2008 15:28:57 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5F2B60D@dbde02.ent.ti.com>
References: <1A6706AF-F068-4DDC-86B1-312CB3817447@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45591 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918AbYKNJ7I convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Nov 2008 04:59:08 -0500
In-Reply-To: <1A6706AF-F068-4DDC-86B1-312CB3817447@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Koen Kooi [mailto:k.kooi@student.utwente.nl]
> Sent: Friday, November 14, 2008 3:26 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis
> FBDEV/DSS Patches
> 
> 
> Op 14 nov 2008, om 07:32 heeft hvaibhav@ti.com het volgende
> geschreven:
> 
> > From: Vaibhav Hiremath <hvaibhav@ti.com>
> >
> > diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> > omap2/board-omap3evm.c
> >
> > +	omap_set_gpio_dataout(LCD_PANEL_ENABLE_GPIO, 1);
> 
> omap_set_gpio_dataout changed to gpio_set_value 12 hours ago on l-o
> git
> 
[Hiremath, Vaibhav] Thanks for pointing me to this change, I will refresh the patch with this and post it again.

> regards,
> 
> Koen

