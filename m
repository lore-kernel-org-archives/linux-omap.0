From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP4: change the device names in usb_bind_phy
Date: Tue, 23 Apr 2013 10:36:23 -0700
Message-ID: <20130423173623.GG10155@atomide.com>
References: <1366697656-14315-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366697656-14315-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [130422 23:19]:
> After the device names are created using PLATFORM_DEVID_AUTO, the old
> device names given in usb_bind_phy are no longer valid causing the musb
> controller not to get the phy reference. Updated the usb_bind_phy with
> the new device names to get MUSB functional in omap4 panda.

Thanks will apply this into omap-for-v3.10/fixes.

Regards,

Tony
 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
> Tested in OMAP4 PANDA.
>  arch/arm/mach-omap2/board-4430sdp.c    |    2 +-
>  arch/arm/mach-omap2/board-omap4panda.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
> index 00d7290..56a9a4f 100644
> --- a/arch/arm/mach-omap2/board-4430sdp.c
> +++ b/arch/arm/mach-omap2/board-4430sdp.c
> @@ -730,7 +730,7 @@ static void __init omap_4430sdp_init(void)
>  	omap4_sdp4430_wifi_init();
>  	omap4_twl6030_hsmmc_init(mmc);
>  
> -	usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto");
> +	usb_bind_phy("musb-hdrc.2.auto", 0, "omap-usb2.3.auto");
>  	usb_musb_init(&musb_board_data);
>  
>  	status = omap_ethernet_init();
> diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
> index a71ad34..1e2c75e 100644
> --- a/arch/arm/mach-omap2/board-omap4panda.c
> +++ b/arch/arm/mach-omap2/board-omap4panda.c
> @@ -435,7 +435,7 @@ static void __init omap4_panda_init(void)
>  	omap_sdrc_init(NULL, NULL);
>  	omap4_twl6030_hsmmc_init(mmc);
>  	omap4_ehci_init();
> -	usb_bind_phy("musb-hdrc.0.auto", 0, "omap-usb2.1.auto");
> +	usb_bind_phy("musb-hdrc.2.auto", 0, "omap-usb2.3.auto");
>  	usb_musb_init(&musb_board_data);
>  	omap4_panda_display_init();
>  }
> -- 
> 1.7.10.4
> 
