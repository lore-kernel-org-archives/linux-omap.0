From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP1: fix redundant UARTs pin muxing that can break
	other hardware support
Date: Thu, 22 Oct 2009 11:43:00 -0700
Message-ID: <20091022184259.GR16230@atomide.com>
References: <200910210239.55194.jkrzyszt@tis.icnet.pl> <20091021005134.GE16230@atomide.com> <200910211827.54733.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:62024 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755382AbZJVSnA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 Oct 2009 14:43:00 -0400
Content-Disposition: inline
In-Reply-To: <200910211827.54733.jkrzyszt@tis.icnet.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, e3-hacking@earth.li

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [091021 10:11]:
> Wednesday 21 October 2009 02:51:35 Tony Lindgren napisa=C5=82(a):
> >
> > Let's just remove the omap_cfg_reg() calls from mach-omap1/serial.c=
, and
> > add them to the board-*.c files like you suggest above. We should b=
e able
> > to find which ports to mux by looking at the enabled_uarts mask in =
the
> > commit mentioned above.
>=20
> Here you are (board-*.c changes limited to those OMAP1510 based).
> Created against linux-2.6.32-rc5.
> Tested on Amsdtrad Delta only.

Thanks, I'll add it to the omap-fixes series for this -rc cycle with
a description on how things broke.

BTW, you might want to also take a look at adding support for powering
down the uarts with an idle timer for mach-omap1/serial.c the same
way as mach-omap2/serial.c does.

Otherwise the enabled serial ports keep the system from hitting
retention during idle.

Regards,

Tony
=20
> Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
>=20
> ---
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-ams-delta.c=
 linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-ams-delta.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-ams-delta.c	2009-=
10-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-ams-delta.c	2009=
-10-21 17:41:29.000000000 +0200
> @@ -219,6 +219,10 @@ static struct platform_device *ams_delta
> =20
>  static void __init ams_delta_init(void)
>  {
> +	/* setup mux pins for uarts, removed from serial.c */
> +	omap_cfg_reg(UART1_TX);
> +	omap_cfg_reg(UART1_RTS);
> +
>  	iotable_init(ams_delta_io_desc, ARRAY_SIZE(ams_delta_io_desc));
> =20
>  	omap_board_config =3D ams_delta_config;
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-generic.c l=
inux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-generic.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-generic.c	2009-10=
-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-generic.c	2009-1=
0-21 18:15:37.000000000 +0200
> @@ -64,6 +64,14 @@ static void __init omap_generic_init(voi
>  {
>  #ifdef CONFIG_ARCH_OMAP15XX
>  	if (cpu_is_omap15xx()) {
> +		/* setup mux pins for uarts, removed from serial.c */
> +		omap_cfg_reg(UART1_TX);
> +		omap_cfg_reg(UART1_RTS);
> +		omap_cfg_reg(UART2_TX);
> +		omap_cfg_reg(UART2_RTS);
> +		omap_cfg_reg(UART3_TX);
> +		omap_cfg_reg(UART3_RX);
> +
>  		omap_usb_init(&generic1510_usb_config);
>  	}
>  #endif
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-innovator.c=
 linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-innovator.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-innovator.c	2009-=
10-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-innovator.c	2009=
-10-21 18:16:59.000000000 +0200
> @@ -376,6 +376,24 @@ static void __init innovator_init(void)
>  {
>  #ifdef CONFIG_ARCH_OMAP15XX
>  	if (cpu_is_omap1510()) {
> +		/* setup mux pins for uarts, removed from serial.c */
> +		omap_cfg_reg(UART1_TX);
> +		omap_cfg_reg(UART1_RTS);
> +		omap_cfg_reg(UART2_TX);
> +		omap_cfg_reg(UART2_RTS);
> +		omap_cfg_reg(UART3_TX);
> +		omap_cfg_reg(UART3_RX);
> +
> +		reg =3D fpga_read(OMAP1510_FPGA_POWER);
> +		reg |=3D OMAP1510_FPGA_PCR_COM1_EN;
> +		fpga_write(reg, OMAP1510_FPGA_POWER);
> +		udelay(10);
> +
> +		reg =3D fpga_read(OMAP1510_FPGA_POWER);
> +		reg |=3D OMAP1510_FPGA_PCR_COM2_EN;
> +		fpga_write(reg, OMAP1510_FPGA_POWER);
> +		udelay(10);
> +
>  		platform_add_devices(innovator1510_devices, ARRAY_SIZE(innovator15=
10_devices));
>  		spi_register_board_info(innovator1510_boardinfo,
>  				ARRAY_SIZE(innovator1510_boardinfo));
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-palmte.c li=
nux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-palmte.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-palmte.c	2009-10-=
16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-palmte.c	2009-10=
-21 17:38:59.000000000 +0200
> @@ -342,6 +342,14 @@ static void __init palmte_misc_gpio_setu
> =20
>  static void __init omap_palmte_init(void)
>  {
> +	/* setup mux pins for uarts, removed from serial.c */
> +	omap_cfg_reg(UART1_TX);
> +	omap_cfg_reg(UART1_RTS);
> +	omap_cfg_reg(UART2_TX);
> +	omap_cfg_reg(UART2_RTS);
> +	omap_cfg_reg(UART3_TX);
> +	omap_cfg_reg(UART3_RX);
> +
>  	omap_board_config =3D palmte_config;
>  	omap_board_config_size =3D ARRAY_SIZE(palmte_config);
> =20
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-palmtt.c li=
nux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-palmtt.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-palmtt.c	2009-10-=
16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-palmtt.c	2009-10=
-21 17:39:19.000000000 +0200
> @@ -289,6 +289,14 @@ static void __init omap_mpu_wdt_mode(int
> =20
>  static void __init omap_palmtt_init(void)
>  {
> +	/* setup mux pins for uarts, removed from serial.c */
> +	omap_cfg_reg(UART1_TX);
> +	omap_cfg_reg(UART1_RTS);
> +	omap_cfg_reg(UART2_TX);
> +	omap_cfg_reg(UART2_RTS);
> +	omap_cfg_reg(UART3_TX);
> +	omap_cfg_reg(UART3_RX);
> +
>  	omap_mpu_wdt_mode(0);
> =20
>  	omap_board_config =3D palmtt_config;
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-palmz71.c l=
inux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-palmz71.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-palmz71.c	2009-10=
-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-palmz71.c	2009-1=
0-21 17:39:34.000000000 +0200
> @@ -307,6 +307,14 @@ palmz71_gpio_setup(int early)
>  static void __init
>  omap_palmz71_init(void)
>  {
> +	/* setup mux pins for uarts, removed from serial.c */
> +	omap_cfg_reg(UART1_TX);
> +	omap_cfg_reg(UART1_RTS);
> +	omap_cfg_reg(UART2_TX);
> +	omap_cfg_reg(UART2_RTS);
> +	omap_cfg_reg(UART3_TX);
> +	omap_cfg_reg(UART3_RX);
> +
>  	palmz71_gpio_setup(1);
>  	omap_mpu_wdt_mode(0);
> =20
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-sx1.c linux=
-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-sx1.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-sx1.c	2009-10-16 =
02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-sx1.c	2009-10-21=
 17:40:20.000000000 +0200
> @@ -377,6 +377,14 @@ static struct omap_board_config_kernel s
> =20
>  static void __init omap_sx1_init(void)
>  {
> +	/* setup mux pins for uarts, removed from serial.c */
> +	omap_cfg_reg(UART1_TX);
> +	omap_cfg_reg(UART1_RTS);
> +	omap_cfg_reg(UART2_TX);
> +	omap_cfg_reg(UART2_RTS);
> +	omap_cfg_reg(UART3_TX);
> +	omap_cfg_reg(UART3_RX);
> +
>  	platform_add_devices(sx1_devices, ARRAY_SIZE(sx1_devices));
> =20
>  	omap_board_config =3D sx1_config;
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-voiceblue.c=
 linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-voiceblue.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap1/board-voiceblue.c	2009-=
10-16 02:41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/board-voiceblue.c	2009=
-10-21 17:40:57.000000000 +0200
> @@ -152,6 +152,14 @@ static void __init voiceblue_init_irq(vo
> =20
>  static void __init voiceblue_init(void)
>  {
> +	/* setup mux pins for uarts, removed from serial.c */
> +	omap_cfg_reg(UART1_TX);
> +	omap_cfg_reg(UART1_RTS);
> +	omap_cfg_reg(UART2_TX);
> +	omap_cfg_reg(UART2_RTS);
> +	omap_cfg_reg(UART3_TX);
> +	omap_cfg_reg(UART3_RX);
> +
>  	/* Watchdog */
>  	gpio_request(0, "Watchdog");
>  	/* smc91x reset */
> diff -upr linux-2.6.32-rc5.orig/arch/arm/mach-omap1/serial.c linux-2.=
6.32-rc5.fixed/arch/arm/mach-omap1/serial.c
> --- linux-2.6.32-rc5.orig/arch/arm/mach-omap1/serial.c	2009-10-16 02:=
41:50.000000000 +0200
> +++ linux-2.6.32-rc5.fixed/arch/arm/mach-omap1/serial.c	2009-10-21 17=
:53:49.000000000 +0200
> @@ -143,16 +143,6 @@ void __init omap_serial_init(void)
>  				if (cpu_is_omap15xx())
>  					clk_set_rate(uart1_ck, 12000000);
>  			}
> -			if (cpu_is_omap15xx()) {
> -				omap_cfg_reg(UART1_TX);
> -				omap_cfg_reg(UART1_RTS);
> -				if (machine_is_omap_innovator()) {
> -					reg =3D fpga_read(OMAP1510_FPGA_POWER);
> -					reg |=3D OMAP1510_FPGA_PCR_COM1_EN;
> -					fpga_write(reg, OMAP1510_FPGA_POWER);
> -					udelay(10);
> -				}
> -			}
>  			break;
>  		case 1:
>  			uart2_ck =3D clk_get(NULL, "uart2_ck");
> @@ -165,16 +155,6 @@ void __init omap_serial_init(void)
>  				else
>  					clk_set_rate(uart2_ck, 48000000);
>  			}
> -			if (cpu_is_omap15xx()) {
> -				omap_cfg_reg(UART2_TX);
> -				omap_cfg_reg(UART2_RTS);
> -				if (machine_is_omap_innovator()) {
> -					reg =3D fpga_read(OMAP1510_FPGA_POWER);
> -					reg |=3D OMAP1510_FPGA_PCR_COM2_EN;
> -					fpga_write(reg, OMAP1510_FPGA_POWER);
> -					udelay(10);
> -				}
> -			}
>  			break;
>  		case 2:
>  			uart3_ck =3D clk_get(NULL, "uart3_ck");
> @@ -185,10 +165,6 @@ void __init omap_serial_init(void)
>  				if (cpu_is_omap15xx())
>  					clk_set_rate(uart3_ck, 12000000);
>  			}
> -			if (cpu_is_omap15xx()) {
> -				omap_cfg_reg(UART3_TX);
> -				omap_cfg_reg(UART3_RX);
> -			}
>  			break;
>  		}
>  		omap_serial_reset(&serial_platform_data[i]);
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
