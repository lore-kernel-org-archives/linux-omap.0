From: Tomi Valkeinen <tomi.valkeinen@iki.fi>
Subject: Re: [PATCH] ARM: OMAP4: change the device names in usb_bind_phy
Date: Wed, 15 May 2013 13:53:58 +0300
Message-ID: <51936946.3030507@iki.fi>
References: <1366697656-14315-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1366697656-14315-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On 23/04/13 09:14, Kishon Vijay Abraham I wrote:
> After the device names are created using PLATFORM_DEVID_AUTO, the old
> device names given in usb_bind_phy are no longer valid causing the musb
> controller not to get the phy reference. Updated the usb_bind_phy with
> the new device names to get MUSB functional in omap4 panda.
> 
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

I'm seeing

[    2.190155] unable to find transceiver
[    2.190155] HS USB OTG: no transceiver configured
[    2.190155] musb-hdrc musb-hdrc.0.auto: musb_init_controller failed
with status -517
[    2.207458] platform musb-hdrc.0.auto: Driver musb-hdrc requests
probe deferral

on 4430sdp with v3.10-rc1. Does that mean that the musb-hdrc.0.auto was
indeed correct, and the new value of musb-hdrc.2.auto is not?

The musb-hdrc id is wrong on overo also.

 Tomi
