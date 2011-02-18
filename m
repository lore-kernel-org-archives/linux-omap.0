From: "Premi, Sanjeev" <premi@ti.com>
Subject: RE: [patch-v2.6.39 5/7] AM35xx: hwmod data: Add USBOTG
Date: Fri, 18 Feb 2011 16:59:15 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024B83BED5@dbde02.ent.ti.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
 <1297946466-9565-6-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45728 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754376Ab1BRL3a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Feb 2011 06:29:30 -0500
In-Reply-To: <1297946466-9565-6-git-send-email-balbi@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Balbi, Felipe" <balbi@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, "Kalliguddi, Hema" <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Balbi, Felipe
> Sent: Thursday, February 17, 2011 6:11 PM
> To: Tony Lindgren
> Cc: Linux OMAP Mailing List; Linux ARM Kernel Mailing List; Kalliguddi,
> Hema; Kevin Hilman; Cousson, Benoit; Paul Walmsley; Balbi, Felipe
> Subject: [patch-v2.6.39 5/7] AM35xx: hwmod data: Add USBOTG
> 
> From: Hema HK <hemahk@ti.com>
> 
> AM35xx hwmod data structures are populated for USBOTG with base address,
> L3 and L4 interface clocks and IRQ.
> 
> Signed-off-by: Hema HK <hemahk@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   65
> ++++++++++++++++++++++++++++
>  1 files changed, 65 insertions(+), 0 deletions(-)
> 
[snip]
> 
> +	/* usbotg for am35x */
> +	&am35xx_usbhsotg_hwmod,
> +
>  	NULL,

Felipe, Hema,

This patch will break all existing OMAP35x (and I believe
OMAP3430 - since there is no difference - unless there is
some trick in the USB driver code).

I have seen similar problems with smart reflex included in
the AM35x hwmod data.

In this case accessing "unknown" registers corresponding to
SmartReflex in _setup() causes crash.
(http://marc.info/?l=linux-omap&m=129777408503329&w=2)

I expect similar to be happening on OMAP35x with inclusion
of am35xx_usbhsotg_hwmod. If you don't see any crash, there
would be side-effects - and _setup() would be initializing
non-existent OTG registers on OMAP35x.

Did you see any problems while testing?

~sanjeev

PS: Sending mail via webmailer. Formatting may break

>  };
> 
> --
> 1.7.4.rc2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
