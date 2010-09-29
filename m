From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH] OMAP: ZOOM2: Change GPIO to enable LCD NEC
 NL8048HL11-01B on OMAP34x-II MDP
Date: Wed, 29 Sep 2010 10:35:32 +0300
Message-ID: <1285745732.6574.130.camel@tubuntu.research.nokia.com>
References: <1284381807.1801.38.camel@A05BPC17>
	 <1285071690.1783.34.camel@A05BPC17>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:22919 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750995Ab0I2Hfz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Sep 2010 03:35:55 -0400
In-Reply-To: <1285071690.1783.34.camel@A05BPC17>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Yanick Saugy <yanick.saugy@heig-vd.ch>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Rajkumar N <rajkumar.nagarajan@ti.com>

Hi,

On Tue, 2010-09-21 at 14:21 +0200, ext Yanick Saugy wrote:
> The PIN which controls LCD's reset signal (VGA_nRESET/h_GPIO_96) was not
> configured as a GPIO. We had to modify the OMAP MUX, and select this PIN
> (CAM_XCLKA) as an output GPIO (OMAP_MUX_MODE4). (kernel 2.6.35)
> 
> Be aware of changing this PIN will probably disable the camera, because
> it was previously configured as a camera clock.
> 
> 
> Signed-off-by: Yanick Saugy <yanick.saugy@heig-vd.ch>
> 
> --- a/arch/arm/mach-omap2/board-zoom2.c 2010-09-15 15:27:05.148399721 +0200
> +++ b/arch/arm/mach-omap2/board-zoom2.c 2010-09-15 14:46:09.792900019 +0200
> @@ -71,6 +71,7 @@ static struct twl4030_platform_data zoom
>  
>  #ifdef CONFIG_OMAP_MUX
>  static struct omap_board_mux board_mux[] __initdata = {
> +   OMAP3_MUX(CAM_XCLKA, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
>     { .reg_offset = OMAP_MUX_TERMINATOR },
>  };
>  #else
> @@ -82,6 +83,7 @@ static void __init omap_zoom2_init(void)
>     omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
>     zoom_peripherals_init();
>     zoom_debugboard_init();
> +    zoom_display_init(OMAP_DSS_VENC_TYPE_COMPOSITE);
>  }
>  
>  static void __init omap_zoom2_map_io(void)

How did you create this patch? It doesn't look like standard one, and
git am chokes on it. Also, it doesn't apply to the latest linux tree, so
you need to rebase.

 Tomi


