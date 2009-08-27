From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH]OMAP3:PM :T2 keypad wakeup for OMAP3
Date: Thu, 27 Aug 2009 11:25:24 +0300
Message-ID: <87zl9lfytn.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9CD4D@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:55757 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbZH0IZ0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Aug 2009 04:25:26 -0400
Received: by bwz19 with SMTP id 19so801098bwz.37
        for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 01:25:27 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0309E9CD4D@dbde02.ent.ti.com> (Teerth Reddy's message of "Mon\, 24 Aug 2009 11\:58\:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Hi Teerth,

"Reddy, Teerth" <teerth@ti.com> writes:

> From : Teerth Reddy <teerth@ti.com>
>
> This patch changes for setting the padconf value for sys_nirq line
> which is connected to T2 INTR1.  This will fix the T2 keypad wakeup
> issue on OMAP3 SDP.
>
> Signed-off-by: Teerth Reddy < teerth@ti.com >

Patch looks good, thanks.  I'll pull this into PM branch and queue
in my PM fixes queue for next merge window.

I did a minor update by adding a comment in the
enable_board_wakeup_source function stating that this is the
interrupt pin used for T2.

Kevin

> ---
>  arch/arm/mach-omap2/board-3430sdp.c   |    6 ++++++
>  arch/arm/mach-omap2/mux.c             |    5 +++++
>  arch/arm/plat-omap/include/mach/mux.h |    3 +++
>  3 files changed, 14 insertions(+)
>
> Index: linux-omap-pm/arch/arm/mach-omap2/board-3430sdp.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/board-3430sdp.c
> +++ linux-omap-pm/arch/arm/mach-omap2/board-3430sdp.c
> @@ -574,6 +574,11 @@ static inline void board_smc91x_init(voi
>  
>  #endif
>  
> +static void enable_board_wakeup_source(void)
> +{
> +	omap_cfg_reg(AF26_34XX_SYS_NIRQ);
> +}
> +
>  static void __init omap_3430sdp_init(void)
>  {
>  	omap3430_i2c_init();
> @@ -590,6 +595,7 @@ static void __init omap_3430sdp_init(voi
>  	usb_musb_init();
>  	board_smc91x_init();
>  	usb_ehci_init(EHCI_HCD_OMAP_MODE_PHY, true, true, 57, 61);
> +	enable_board_wakeup_source();
>  }
>  
>  static void __init omap_3430sdp_map_io(void)
> Index: linux-omap-pm/arch/arm/mach-omap2/mux.c
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/mach-omap2/mux.c
> +++ linux-omap-pm/arch/arm/mach-omap2/mux.c
> @@ -492,6 +492,11 @@ MUX_CFG_34XX("H16_34XX_SDRC_CKE0", 0x262
>  		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
>  MUX_CFG_34XX("H17_34XX_SDRC_CKE1", 0x264,
>  		OMAP34XX_MUX_MODE0 | OMAP34XX_PIN_OUTPUT)
> +
> +/* SYS_NIRQ T2 INT1 */
> +MUX_CFG_34XX("AF26_34XX_SYS_NIRQ", 0x1E0,
> +		OMAP3_WAKEUP_EN | OMAP34XX_PIN_INPUT_PULLUP |
> +		OMAP34XX_MUX_MODE0)
>  };
>  
>  #define OMAP34XX_PINS_SZ	ARRAY_SIZE(omap34xx_pins)
> Index: linux-omap-pm/arch/arm/plat-omap/include/mach/mux.h
> ===================================================================
> --- linux-omap-pm.orig/arch/arm/plat-omap/include/mach/mux.h
> +++ linux-omap-pm/arch/arm/plat-omap/include/mach/mux.h
> @@ -857,6 +857,9 @@ enum omap34xx_index {
>  	/* OMAP3 SDRC CKE signals to SDR/DDR ram chips */
>  	H16_34XX_SDRC_CKE0,
>  	H17_34XX_SDRC_CKE1,
> +
> +	/* SYS_NIRQ T2 INT1 */
> +	AF26_34XX_SYS_NIRQ,
>  };
>  
>  struct omap_mux_cfg {
