From: "Aguirre, Sergio" <saaguirre@ti.com>
Subject: RE: [PATCH 13/13 v2] OMAP3: SERIAL: Initialize all omap-uarts for
 zoom      boards
Date: Wed, 22 Sep 2010 11:06:09 -0500
Message-ID: <A24693684029E5489D1D202277BE894472767CED@dlee02.ent.ti.com>
References: <37596.172.24.137.131.1285168492.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <37596.172.24.137.131.1285168492.squirrel@dbdmail.itg.ti.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
To: "Raja, Govindraj" <govindraj.raja@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, "Gadiyar, Anand" <gadiyar@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Govindraj,

Just one non-functional comment below.

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Raja, Govindraj
> Sent: Wednesday, September 22, 2010 10:15 AM
> To: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org; linux-serial@vger.kernel.org;
> Kevin Hilman; Tony Lindgren; Gadiyar, Anand
> Subject: [PATCH 13/13 v2] OMAP3: SERIAL: Initialize all omap-uarts for
> zoom boards
> 
> Iniatize all omap-uarts for zoom boards.
> Remove serial_init from 3630sdp board init
> as zoom_peripheral_init does the same.

I think this description mismatches slightly to what is really 
being done in the patch.

I mean, the way you say it, it's like the omap_serial_init
was already in zoom_peripheral_init... which is not.

Regards,
Sergio

> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
> ---
>  arch/arm/mach-omap2/board-3630sdp.c          |    1 -
>  arch/arm/mach-omap2/board-zoom-peripherals.c |    1 +
>  2 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-3630sdp.c b/arch/arm/mach-
> omap2/board-3630sdp.c
> index b359c3f..d510451 100644
> --- a/arch/arm/mach-omap2/board-3630sdp.c
> +++ b/arch/arm/mach-omap2/board-3630sdp.c
> @@ -208,7 +208,6 @@ static struct flash_partitions sdp_flash_partitions[]
> = {
>  static void __init omap_sdp_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBP);
> -	omap_serial_init();
>  	zoom_peripherals_init();
>  	board_smc91x_init();
>  	board_flash_init(sdp_flash_partitions, chip_sel_sdp);
> diff --git a/arch/arm/mach-omap2/board-zoom-peripherals.c
> b/arch/arm/mach-omap2/board-zoom-peripherals.c
> index 6b39849..641765a 100644
> --- a/arch/arm/mach-omap2/board-zoom-peripherals.c
> +++ b/arch/arm/mach-omap2/board-zoom-peripherals.c
> @@ -282,4 +282,5 @@ void __init zoom_peripherals_init(void)
>  	omap_i2c_init();
>  	usb_musb_init(&musb_board_data);
>  	enable_board_wakeup_source();
> +	omap_serial_init();
>  }
> --
> 1.6.3.3
> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
