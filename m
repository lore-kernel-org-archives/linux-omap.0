From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch 2.6.29-rc7-omap] OMAP1: OMAP_TAG_USB buildfix (OSK)
Date: Wed, 11 Mar 2009 09:19:48 -0700
Message-ID: <20090311161948.GI19229@atomide.com>
References: <200903110320.06011.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50297 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbZCKQTu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Mar 2009 12:19:50 -0400
Content-Disposition: inline
In-Reply-To: <200903110320.06011.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: OMAP <linux-omap@vger.kernel.org>

* David Brownell <david-b@pacbell.net> [090311 03:44]:
> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Build fix:
> 
>   CC      arch/arm/mach-omap1/board-osk.o
>   arch/arm/mach-omap1/board-osk.c: In function 'osk_mistral_init':
>   arch/arm/mach-omap1/board-osk.c:512: error: implicit declaration of function 'omap_usb_init'
>   make[1]: *** [arch/arm/mach-omap1/board-osk.o] Error 1
> 
> The error is twofold.  First, USB is on the mainboard, not the Mistral card;
> that's specific to the OSK.  Second, header goofage -- hurts all OMAP1 boards.
> 
> I'm puzzled by the notion tha the "OMAP1: get rid of OMAP_TAG_USB" patch could
> have been compile-tested.

Hmm, I built it on all boards, but maybe that was against the mainline
tree for omap-upstream patches. It's also possible that I hosed the osk
patch while refreshing the original patch.. Oh well, never trust me for
manually merging patches right :)

I'll apply this and update the omap-upstream patch accordingly.

Tony
 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  arch/arm/mach-omap1/board-osk.c       |    3 ++-
>  arch/arm/plat-omap/include/mach/usb.h |   10 +++++-----
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> --- a/arch/arm/mach-omap1/board-osk.c
> +++ b/arch/arm/mach-omap1/board-osk.c
> @@ -509,7 +509,6 @@ static void __init osk_mistral_init(void
>  	i2c_register_board_info(1, mistral_i2c_board_info,
>  			ARRAY_SIZE(mistral_i2c_board_info));
>  
> -	omap_usb_init(&osk_usb_config);
>  	platform_add_devices(mistral_devices, ARRAY_SIZE(mistral_devices));
>  }
>  #else
> @@ -541,6 +540,8 @@ static void __init osk_init(void)
>  	l |= (3 << 1);
>  	omap_writel(l, USB_TRANSCEIVER_CTRL);
>  
> +	omap_usb_init(&osk_usb_config);
> +
>  	/* irq for tps65010 chip */
>  	/* bootloader effectively does:  omap_cfg_reg(U19_1610_MPUIO1); */
>  	if (gpio_request(OMAP_MPUIO(1), "tps65010") == 0)
> --- a/arch/arm/plat-omap/include/mach/usb.h
> +++ b/arch/arm/plat-omap/include/mach/usb.h
> @@ -33,9 +33,7 @@ extern void usb_musb_init(void);
>  static inline void usb_musb_init(void)
>  {
>  }
> -#endif
> -
> -void omap_usb_init(struct omap_usb_config *pdata);
> +#endif	/* !OMAP1 && !MUSB */
>  
>  #if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
>  extern void usb_ehci_init(void);
> @@ -43,9 +41,11 @@ extern void usb_ehci_init(void);
>  static inline void usb_ehci_init(void)
>  {
>  }
> -#endif
> +#endif	/* !OMAP1 && !EHCI */
>  
> -#endif
> +#endif	/* !OMAP1 */
> +
> +void omap_usb_init(struct omap_usb_config *pdata);
>  
>  /*-------------------------------------------------------------------------*/
>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
