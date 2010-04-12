From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH] board-omap3-beagle: add DSS2 support
Date: Mon, 12 Apr 2010 14:15:51 +0300
Message-ID: <h2r6ed0b2681004120415m118f3e7cy2b884cafed1cf737@mail.gmail.com>
References: <1271063990-12819-1-git-send-email-koen@dominion.thruhere.net>
	 <1271068631.2690.40.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:42133 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295Ab0DLLVU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Apr 2010 07:21:20 -0400
Received: by bwz19 with SMTP id 19so4438bwz.21
        for <linux-omap@vger.kernel.org>; Mon, 12 Apr 2010 04:21:18 -0700 (PDT)
In-Reply-To: <1271068631.2690.40.camel@tubuntu.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext Koen Kooi <koen.kooi@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Koen Kooi <koen@dominion.thruhere.net>

On Mon, Apr 12, 2010 at 1:37 PM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
>
> On Mon, 2010-04-12 at 11:19 +0200, ext Koen Kooi wrote:
>> This patch adds DSS2 support to the beagleboard boardfile. DVI and T=
V-out are supported.
>>
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>
> Fiddling with TWL directly in tv enable/disable functions is a bit ug=
ly,
> but I'm not sure if there's a better way for that. Otherwise:

It's only toggling VDAC supply, don't we already do that in DSS2 core?
I think beagle_panel_enable_tv and beagle_panel_disable_tv can be
simply removed.

> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

A bit premature?

>
> =A0Tomi
>
>> ---
>> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0130 ++++++++++++++++=
++++++++-------
>> =A01 files changed, 103 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach=
-omap2/board-omap3beagle.c
>> index 962d377..534316c 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -39,6 +39,7 @@
>>
>> =A0#include <plat/board.h>
>> =A0#include <plat/common.h>
>> +#include <plat/display.h>
>> =A0#include <plat/gpmc.h>
>> =A0#include <plat/nand.h>
>> =A0#include <plat/usb.h>
>> @@ -106,6 +107,105 @@ static struct platform_device omap3beagle_nand=
_device =3D {
>> =A0 =A0 =A0 .resource =A0 =A0 =A0 =3D &omap3beagle_nand_resource,
>> =A0};
>>
>> +/* DSS */
>> +
>> +static int beagle_enable_dvi(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 if (dssdev->reset_gpio !=3D -1)

gpio_is_valid()?

>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(dssdev->reset_gpio, 1);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void beagle_disable_dvi(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 if (dssdev->reset_gpio !=3D -1)
>> + =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(dssdev->reset_gpio, 0);
>> +}
>> +
>> +static struct omap_dss_device beagle_dvi_device =3D {
>> + =A0 =A0 .type =3D OMAP_DISPLAY_TYPE_DPI,
>> + =A0 =A0 .name =3D "dvi",
>> + =A0 =A0 .driver_name =3D "generic_panel",
>> + =A0 =A0 .phy.dpi.data_lines =3D 24,
>> + =A0 =A0 .reset_gpio =3D 170,
>> + =A0 =A0 .platform_enable =3D beagle_enable_dvi,
>> + =A0 =A0 .platform_disable =3D beagle_disable_dvi,
>> +};
>> +
>> +static int beagle_panel_enable_tv(struct omap_dss_device *dssdev)
>> +{
>> +#define ENABLE_VDAC_DEDICATED =A0 =A0 =A0 =A0 =A0 0x03
>> +#define ENABLE_VDAC_DEV_GRP =A0 =A0 =A0 =A0 =A0 =A0 0x20
>> +
>> + =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ENABLE_VDAC_DEDICATED,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_VDAC_DEDICATED);
>> + =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ENABLE_VDAC_DEV_GRP, TWL40=
30_VDAC_DEV_GRP);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static void beagle_panel_disable_tv(struct omap_dss_device *dssdev)
>> +{
>> + =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_VDAC_DEDICATED);
>> + =A0 =A0 twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, 0x00,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TWL4030_VDAC_DEV_GRP);
>> +}
>> +
>> +static struct omap_dss_device beagle_tv_device =3D {
>> + =A0 =A0 .name =3D "tv",
>> + =A0 =A0 .driver_name =3D "venc",
>> + =A0 =A0 .type =3D OMAP_DISPLAY_TYPE_VENC,
>> + =A0 =A0 .phy.venc.type =3D OMAP_DSS_VENC_TYPE_SVIDEO,
>> + =A0 =A0 .platform_enable =3D beagle_panel_enable_tv,
>> + =A0 =A0 .platform_disable =3D beagle_panel_disable_tv,
>> +};
>> +
>> +static struct omap_dss_device *beagle_dss_devices[] =3D {
>> + =A0 =A0 &beagle_dvi_device,
>> + =A0 =A0 &beagle_tv_device,
>> +};
>> +
>> +static struct omap_dss_board_info beagle_dss_data =3D {
>> + =A0 =A0 .num_devices =3D ARRAY_SIZE(beagle_dss_devices),
>> + =A0 =A0 .devices =3D beagle_dss_devices,
>> + =A0 =A0 .default_device =3D &beagle_dvi_device,
>> +};
>> +
>> +static struct platform_device beagle_dss_device =3D {
>> + =A0 =A0 .name =A0 =A0 =A0 =A0 =A0=3D "omapdss",
>> + =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0=3D -1,
>> + =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =3D &beagle_dss_data,
>> + =A0 =A0 },
>> +};
>> +
>> +static struct regulator_consumer_supply beagle_vdac_supply =3D {
>> + =A0 =A0 .supply =A0 =A0 =A0 =A0 =3D "vdda_dac",
>> + =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D &beagle_dss_device.dev,
>> +};
>> +
>> +static struct regulator_consumer_supply beagle_vdvi_supply =3D {
>> + =A0 =A0 .supply =A0 =A0 =A0 =A0 =3D "vdds_dsi",
>> + =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D &beagle_dss_device.dev,
>> +};

Regulator framework recommends using device names instead of dev pointe=
r:

static struct regulator_consumer_supply beagle_vdac_supply =3D
        REGULATOR_SUPPLY("vdda_dac", "omapdss");

static struct regulator_consumer_supply beagle_vdvi_supply =3D
        REGULATOR_SUPPLY("vdds_dsi", "omapdss");

>> +
>> +static void __init beagle_display_init(void)
>> +{
>> + =A0 =A0 int r;
>> +
>> + =A0 =A0 r =3D gpio_request(beagle_dvi_device.reset_gpio, "DVI rese=
t");
>> + =A0 =A0 if (r < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Unable to get DVI reset G=
PIO\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 gpio_direction_output(beagle_dvi_device.reset_gpio, 0);
>> +}
>> +
>> =A0#include "sdram-micron-mt46h32m32lf-6.h"
>>
>> =A0static struct omap2_hsmmc_info mmc[] =3D {
>> @@ -117,15 +217,6 @@ static struct omap2_hsmmc_info mmc[] =3D {
>> =A0 =A0 =A0 {} =A0 =A0 =A0/* Terminator */
>> =A0};
>>
>> -static struct platform_device omap3_beagle_lcd_device =3D {
>> - =A0 =A0 .name =A0 =A0 =A0 =A0 =A0 =3D "omap3beagle_lcd",
>> - =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =3D -1,
>> -};
>> -
>> -static struct omap_lcd_config omap3_beagle_lcd_config __initdata =3D=
 {
>> - =A0 =A0 .ctrl_name =A0 =A0 =A0=3D "internal",
>> -};
>> -
>> =A0static struct regulator_consumer_supply beagle_vmmc1_supply =3D {
>> =A0 =A0 =A0 .supply =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "vmmc",
>> =A0};
>> @@ -181,16 +272,6 @@ static struct twl4030_gpio_platform_data beagle=
_gpio_data =3D {
>> =A0 =A0 =A0 .setup =A0 =A0 =A0 =A0 =A0=3D beagle_twl_gpio_setup,
>> =A0};
>>
>> -static struct regulator_consumer_supply beagle_vdac_supply =3D {
>> - =A0 =A0 .supply =A0 =A0 =A0 =A0 =3D "vdac",
>> - =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D &omap3_beagle_lcd_device.d=
ev,
>> -};
>> -
>> -static struct regulator_consumer_supply beagle_vdvi_supply =3D {
>> - =A0 =A0 .supply =A0 =A0 =A0 =A0 =3D "vdvi",
>> - =A0 =A0 .dev =A0 =A0 =A0 =A0 =A0 =A0=3D &omap3_beagle_lcd_device.d=
ev,
>> -};
>> -
>> =A0/* VMMC1 for MMC1 pins CMD, CLK, DAT0..DAT3 (20 mA, plus card =3D=
=3D max 220 mA) */
>> =A0static struct regulator_init_data beagle_vmmc1 =3D {
>> =A0 =A0 =A0 .constraints =3D {
>> @@ -349,14 +430,8 @@ static struct platform_device keys_gpio =3D {
>> =A0 =A0 =A0 },
>> =A0};
>>
>> -static struct omap_board_config_kernel omap3_beagle_config[] __init=
data =3D {
>> - =A0 =A0 { OMAP_TAG_LCD, =A0 =A0 =A0 =A0 &omap3_beagle_lcd_config }=
,
>> -};
>> -
>> =A0static void __init omap3_beagle_init_irq(void)
>> =A0{
>> - =A0 =A0 omap_board_config =3D omap3_beagle_config;
>> - =A0 =A0 omap_board_config_size =3D ARRAY_SIZE(omap3_beagle_config)=
;
>> =A0 =A0 =A0 omap2_init_common_hw(mt46h32m32lf6_sdrc_params,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mt46h32m32lf6=
_sdrc_params);
>> =A0 =A0 =A0 omap_init_irq();
>> @@ -367,9 +442,9 @@ static void __init omap3_beagle_init_irq(void)
>> =A0}
>>
>> =A0static struct platform_device *omap3_beagle_devices[] __initdata =
=3D {
>> - =A0 =A0 &omap3_beagle_lcd_device,
>> =A0 =A0 =A0 &leds_gpio,
>> =A0 =A0 =A0 &keys_gpio,
>> + =A0 =A0 &beagle_dss_device,
>> =A0};
>>
>> =A0static void __init omap3beagle_flash_init(void)
>> @@ -456,8 +531,9 @@ static void __init omap3_beagle_init(void)
>> =A0 =A0 =A0 /* Ensure SDRC pins are mux'd for self-refresh */
>> =A0 =A0 =A0 omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
>> =A0 =A0 =A0 omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
>> -}
>>
>> + =A0 =A0 beagle_display_init();
>> +}
>> =A0static void __init omap3_beagle_map_io(void)
>> =A0{
>> =A0 =A0 =A0 omap2_set_globals_343x();
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
