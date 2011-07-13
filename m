From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] dt: omap3: add generic board file for dt support
Date: Thu, 14 Jul 2011 08:15:16 +0900
Message-ID: <CACxGe6sELS=C==16TZ2pfrxJDDyqjS_qOwJUfwzwMO8hqo8Xag@mail.gmail.com>
References: <1310592975-25773-1-git-send-email-manjugk@ti.com> <1310592975-25773-4-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:41783 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562Ab1GMXPh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jul 2011 19:15:37 -0400
Received: by yia27 with SMTP id 27so2635573yia.19
        for <linux-omap@vger.kernel.org>; Wed, 13 Jul 2011 16:15:36 -0700 (PDT)
In-Reply-To: <1310592975-25773-4-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, ben-linux@fluff.org

On Thu, Jul 14, 2011 at 7:06 AM, G, Manjunath Kondaiah <manjugk@ti.com>=
 wrote:
>
> The generic board file is created and derived from beagle board file.
> The beagle board file is migrated to boot from flattened device tree =
and
> the cleanup of generic board file will happen in different stages.
>
> The changes here focus on i2c device registration through dt and upco=
ming
> patches in the series will adopt i2c driver to use dt registered i2c
> devices.

Since this is a new board file instead of a modification of an
existing one, I recommend *not* trying to completely duplicate the
behaviour of the beagle board.  Start small with only the registration
of the UART and i2c drivers from the device tree and build up
functionality until it can be used for all the OMAP3 boards.
Otherwise the patch just adds a lot of code that needs to be removed
again.

>
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> ---
> =A0arch/arm/mach-omap2/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 | =A0 12 +
> =A0arch/arm/mach-omap2/Makefile =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A02 +
> =A0arch/arm/mach-omap2/board-omap3-dt.c =A0 =A0| =A0623 +++++++++++++=
++++++++++++++++++
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 13 -
> =A04 files changed, 637 insertions(+), 13 deletions(-)
> =A0create mode 100644 arch/arm/mach-omap2/board-omap3-dt.c
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfi=
g
> index 19d5891..174f6d1 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -302,6 +302,18 @@ config MACH_OMAP_3630SDP
> =A0 =A0 =A0 =A0default y
> =A0 =A0 =A0 =A0select OMAP_PACKAGE_CBP
>
> +config MACH_OMAP3_DT
> + =A0 =A0 =A0 bool "Generic OMAP3 board(FDT support)"
> + =A0 =A0 =A0 depends on ARCH_OMAP3
> + =A0 =A0 =A0 select OMAP_PACKAGE_CBB
> + =A0 =A0 =A0 select USE_OF
> + =A0 =A0 =A0 select PROC_DEVICETREE

Don't select PROC_DEVICETREE

> +
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 Support for generic TI OMAP3 boards using Flattened=
 Device Tree.
> + =A0 =A0 =A0 =A0 Say Y here to enable OMAP3 device tree support
> + =A0 =A0 =A0 =A0 More information at Documentation/devicetree
> +
> =A0config MACH_TI8168EVM
> =A0 =A0 =A0 =A0bool "TI8168 Evaluation Module"
> =A0 =A0 =A0 =A0depends on SOC_OMAPTI816X
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makef=
ile
> index b148077..86e66f7 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -178,6 +178,8 @@ obj-$(CONFIG_MACH_OMAP_H4) =A0 =A0 =A0 =A0 =A0+=3D=
 board-h4.o
> =A0obj-$(CONFIG_MACH_OMAP_2430SDP) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-2430sdp.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hsmmc.o
> =A0obj-$(CONFIG_MACH_OMAP_APOLLON) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-apollon.o
> +obj-$(CONFIG_MACH_OMAP3_DT) =A0 =A0 =A0 =A0 =A0 =A0+=3D board-omap3-=
dt.o \
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0hsmmc.o
> =A0obj-$(CONFIG_MACH_OMAP3_BEAGLE) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 board-omap3beagle.o \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 hsmmc.o

This is an odd construct.  Tony, why does each board add hsmmc to the
oby-y variable instead of it having its own kconfig symbol?

> +static void __init omap3_init(void)
> +{
> + =A0 =A0 =A0 struct device_node *node;
> +
> + =A0 =A0 =A0 node =3D of_find_matching_node_by_address(NULL, omap3_d=
t_intc_match,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 OMAP34XX_IC_BASE);
> + =A0 =A0 =A0 if (node)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_domain_add_simple(node, 0);
> +
> + =A0 =A0 =A0 omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> + =A0 =A0 =A0 omap3_beagle_init_rev();
> + =A0 =A0 =A0 omap3_beagle_i2c_init();
> + =A0 =A0 =A0 platform_add_devices(omap3_beagle_devices,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(omap3_beagle=
_devices));
> + =A0 =A0 =A0 omap_display_init(&beagle_dss_data);
> + =A0 =A0 =A0 omap_serial_init();
> +
> + =A0 =A0 =A0 omap_mux_init_gpio(170, OMAP_PIN_INPUT);
> + =A0 =A0 =A0 /* REVISIT leave DVI powered down until it's needed ...=
 */
> + =A0 =A0 =A0 gpio_request_one(170, GPIOF_OUT_INIT_HIGH, "DVI_nPD");
> +
> + =A0 =A0 =A0 usb_musb_init(NULL);
> + =A0 =A0 =A0 usbhs_init(&usbhs_bdata);
> + =A0 =A0 =A0 omap_nand_flash_init(NAND_BUSWIDTH_16, omap3beagle_nand=
_partitions,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(o=
map3beagle_nand_partitions));
> +
> + =A0 =A0 =A0 /* Ensure msecure is mux'd to be able to set the RTC. *=
/
> + =A0 =A0 =A0 omap_mux_init_signal("sys_drm_msecure", OMAP_PIN_OFF_OU=
TPUT_HIGH);
> +
> + =A0 =A0 =A0 /* Ensure SDRC pins are mux'd for self-refresh */
> + =A0 =A0 =A0 omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
> + =A0 =A0 =A0 omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
> +
> + =A0 =A0 =A0 beagle_display_init();
> + =A0 =A0 =A0 beagle_opp_init();
> + =A0 =A0 =A0 of_platform_populate(NULL, omap_dt_match_table, NULL, N=
ULL);

Hmmm, I don't think this will work for OMAP because it will not create
the i2c bus as an omap_device.  It will only be a plane
platform_deevice.  You'll need to have a hook in
of_platform_populate() to create devices the way omap3 infrastructure
expects.

> +}
> +
> +static const char *omap3_dt_match[] __initdata =3D {
> + =A0 =A0 =A0 "ti,omap3-beagle",
> + =A0 =A0 =A0 NULL

"ti,omap3" should be sufficient.

> +};
> +
> +DT_MACHINE_START(OMAP3_DT, "TI OMAP3 (Flattened Device Tree)")
> + =A0 =A0 =A0 .boot_params =A0 =A0=3D 0x80000100,

Drop boot_params.

> + =A0 =A0 =A0 .reserve =A0 =A0 =A0 =A0=3D omap_reserve,
> + =A0 =A0 =A0 .map_io =A0 =A0 =A0 =A0 =3D omap3_map_io,
> + =A0 =A0 =A0 .init_early =A0 =A0 =3D omap3_init_early,
> + =A0 =A0 =A0 .init_irq =A0 =A0 =A0 =3D omap3_init_irq,
> + =A0 =A0 =A0 .init_machine =A0 =3D omap3_init,
> + =A0 =A0 =A0 .timer =A0 =A0 =A0 =A0 =A0=3D &omap_timer,
> + =A0 =A0 =A0 .dt_compat =A0 =A0 =A0=3D omap3_dt_match,
> +MACHINE_END
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-=
omap2/board-omap3beagle.c
> index 213c4cd..7efb178 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -19,7 +19,6 @@
> =A0#include <linux/err.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/io.h>
> -#include <linux/of_platform.h>
> =A0#include <linux/leds.h>
> =A0#include <linux/gpio.h>
> =A0#include <linux/input.h>
> @@ -422,9 +421,7 @@ static int __init omap3_beagle_i2c_init(void)
> =A0 =A0 =A0 =A0/* Bus 3 is attached to the DVI port where devices lik=
e the pico DLP
> =A0 =A0 =A0 =A0 * projector don't work reliably with 400kHz */
> =A0 =A0 =A0 =A0omap_register_i2c_bus(3, 100, beagle_i2c_eeprom, ARRAY=
_SIZE(beagle_i2c_eeprom));
> -#ifdef CONFIG_OF
> =A0 =A0 =A0 =A0omap_register_i2c_bus(2, 100, NULL, 0);
> -#endif /* CONFIG_OF */
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -567,10 +564,6 @@ static void __init beagle_opp_init(void)
>
> =A0static void __init omap3_beagle_init(void)
> =A0{
> -#ifdef CONFIG_OF
> - =A0 =A0 =A0 of_platform_prepare(NULL, NULL);
> -#endif /* CONFIG_OF */
> -
> =A0 =A0 =A0 =A0omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> =A0 =A0 =A0 =A0omap3_beagle_init_rev();
> =A0 =A0 =A0 =A0omap3_beagle_i2c_init();
> @@ -599,11 +592,6 @@ static void __init omap3_beagle_init(void)
> =A0 =A0 =A0 =A0beagle_opp_init();
> =A0}
>
> -static const char *omap3_beagle_dt_match[] __initdata =3D {
> - =A0 =A0 =A0 "ti,omap3-beagle",
> - =A0 =A0 =A0 NULL
> -};
> -
> =A0MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
> =A0 =A0 =A0 =A0/* Maintainer: Syed Mohammed Khasim - http://beagleboa=
rd.org */
> =A0 =A0 =A0 =A0.boot_params =A0 =A0=3D 0x80000100,
> @@ -613,5 +601,4 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
> =A0 =A0 =A0 =A0.init_irq =A0 =A0 =A0 =3D omap3_beagle_init_irq,
> =A0 =A0 =A0 =A0.init_machine =A0 =3D omap3_beagle_init,
> =A0 =A0 =A0 =A0.timer =A0 =A0 =A0 =A0 =A0=3D &omap_timer,
> - =A0 =A0 =A0 .dt_compat =A0 =A0 =A0=3D omap3_beagle_dt_match,
> =A0MACHINE_END
> --
> 1.7.4.1
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
