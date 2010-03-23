From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH] musb: Add extvbus in musb_board_data
Date: Tue, 23 Mar 2010 18:16:18 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DE0EB5E@dbde02.ent.ti.com>
References: <1266985840-15220-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:44867 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848Ab0CWMqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 23 Mar 2010 08:46:24 -0400
In-Reply-To: <1266985840-15220-1-git-send-email-ajay.gupta@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

Hi,
> -----Original Message-----
> From: Gupta, Ajay Kumar
> Sent: Wednesday, February 24, 2010 10:01 AM
> To: linux-omap@vger.kernel.org
> Cc: felipe.balbi@nokia.com; Gupta, Ajay Kumar
> Subject: [PATCH] musb: Add extvbus in musb_board_data
> 
> EXTVBUS programming is required by OMAP3EVM REV >=E to supply 500mA
> power so adding a flag which can be used by musb driver to program
> EXTVBUS.

Felipe,

Any comment on this one ?

Regards,
ajay
> 
> Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
> ---
> Created against l-o master branch and on top of below patch.
> 
> [PATCH] musb: fix power field to hold all possible values
> 
>  arch/arm/mach-omap2/board-omap3evm.c  |    3 +++
>  arch/arm/mach-omap2/usb-musb.c        |    1 +
>  arch/arm/plat-omap/include/plat/usb.h |    1 +
>  3 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index d6bc88c..b7ea9b7 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -702,6 +702,9 @@ static void __init omap3_evm_init(void)
>  		omap_mux_init_gpio(21, OMAP_PIN_INPUT_PULLUP);
>  		ehci_pdata.reset_gpio_port[1] = 21;
> 
> +		/* EVM REV >= E can supply 500mA with EXTVBUS programming */
> +		musb_board_data.power = 500;
> +		musb_board_data.extvbus = 1;
>  	} else {
>  		/* setup EHCI phy reset on MDC */
>  		omap_mux_init_gpio(135, OMAP_PIN_OUTPUT);
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-
> musb.c
> index 53a9638..17726ac 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -106,6 +106,7 @@ void __init usb_musb_init(struct omap_musb_board_data
> *board_data)
>  	musb_plat.board_data = board_data;
>  	musb_plat.power = board_data->power >> 1;
>  	musb_plat.mode = board_data->mode;
> +	musb_plat.extvbus = board_data->extvbus;
> 
>  	if (platform_device_register(&musb_device) < 0)
>  		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
> diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-
> omap/include/plat/usb.h
> index b181297..d82bf77 100644
> --- a/arch/arm/plat-omap/include/plat/usb.h
> +++ b/arch/arm/plat-omap/include/plat/usb.h
> @@ -47,6 +47,7 @@ struct omap_musb_board_data {
>  	u8	interface_type;
>  	u8	mode;
>  	u16	power;
> +	unsigned extvbus:1;
>  };
> 
>  enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
> --
> 1.6.2.4

