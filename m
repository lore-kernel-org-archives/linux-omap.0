From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v9 01/13] usb: musb: dsps: add phy control logic to glue
Date: Fri, 31 Aug 2012 09:00:29 -0700
Message-ID: <20120831160028.GM1303@atomide.com>
References: <1346411399-23964-1-git-send-email-ravibabu@ti.com>
 <1346411399-23964-2-git-send-email-ravibabu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:14986 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751631Ab2HaQAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Aug 2012 12:00:32 -0400
Content-Disposition: inline
In-Reply-To: <1346411399-23964-2-git-send-email-ravibabu@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ravi Babu <ravibabu@ti.com>
Cc: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, balbi@ti.com, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org

* Ravi Babu <ravibabu@ti.com> [120831 04:10]:
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -95,7 +95,6 @@ extern void am35x_musb_reset(void);
>  extern void am35x_musb_phy_power(u8 on);
>  extern void am35x_musb_clear_irq(void);
>  extern void am35x_set_mode(u8 musb_mode);
> -extern void ti81xx_musb_phy_power(u8 on);
>  
>  /* AM35x */
>  /* USB 2.0 PHY Control */
> @@ -120,8 +119,8 @@ extern void ti81xx_musb_phy_power(u8 on);
>  #define CONF2_DATPOL		(1 << 1)
>  
>  /* TI81XX specific definitions */
> -#define USBCTRL0	0x620
> -#define USBSTAT0	0x624
> +#define MUSB_USBSS_REV_816X	0x9
> +#define MUSB_USBSS_REV_814X	0xb
>  
>  /* TI816X PHY controls bits */
>  #define TI816X_USBPHY0_NORMAL_MODE	(1 << 0)

This file needs to move to include/linux/platform_data/usb-omap.h
as it's blocking the ARM single zImage changes so some coordination is
required here. Felipe, can you do a minimal immutable branch with just
one patch against v3.6-rc3 that move the header so I can pull in too?

Regards,

Tony
