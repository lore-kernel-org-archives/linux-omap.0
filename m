From: Kishore Kadiyala <kishorek.kadiyala@gmail.com>
Subject: Re: [PATCH] OMAP2: add regulator for MMC1
Date: Wed, 9 Feb 2011 02:26:16 +0530
Message-ID: <AANLkTinGOQ6-FmVG=LbQHjYPZ_tm3yDtVdDLx7EqhHpw@mail.gmail.com>
References: <1297094927-727-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:59974 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755794Ab1BHU4k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Feb 2011 15:56:40 -0500
Received: by wwa36 with SMTP id 36so6473292wwa.1
        for <linux-omap@vger.kernel.org>; Tue, 08 Feb 2011 12:56:36 -0800 (PST)
In-Reply-To: <1297094927-727-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Mon, Feb 7, 2011 at 9:38 PM, Balaji T K <balajitk@ti.com> wrote:
> Add regulator VMMC1 used by SD/MMC card slot1 in 2430sdp.
>
> Signed-off-by: Balaji T K <balajitk@ti.com>

Tested-by: Kishore Kadiyala <kishore.kadiyala@ti.com>

Regards,
Kishore

> ---
> Tested on OMAP2430 SDP with busybox filesystem mounted on MMC1
>
> =A0arch/arm/mach-omap2/board-2430sdp.c | =A0 21 +++++++++++++++++++++
> =A01 files changed, 21 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap=
2/board-2430sdp.c
> index e066177..361f6cb 100644
> --- a/arch/arm/mach-omap2/board-2430sdp.c
> +++ b/arch/arm/mach-omap2/board-2430sdp.c
> @@ -22,6 +22,7 @@
> =A0#include <linux/mmc/host.h>
> =A0#include <linux/delay.h>
> =A0#include <linux/i2c/twl.h>
> +#include <linux/regulator/machine.h>
> =A0#include <linux/err.h>
> =A0#include <linux/clk.h>
> =A0#include <linux/io.h>
> @@ -148,6 +149,25 @@ static void __init omap_2430sdp_init_irq(void)
> =A0 =A0 =A0 =A0omap_init_irq();
> =A0}
>
> +static struct regulator_consumer_supply sdp2430_vmmc1_supplies[] =3D=
 {
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vmmc", "mmci-omap-hs.0"),
> +};
> +
> +/* VMMC1 for OMAP VDD_MMC1 (i/o) and MMC1 card */
> +static struct regulator_init_data sdp2430_vmmc1 =3D {
> + =A0 =A0 =A0 .constraints =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1850000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 3150000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGUL=
ATOR_MODE_NORMAL
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REG=
ULATOR_CHANGE_VOLTAGE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_MODE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_consumer_supplies =A0=3D ARRAY_SIZE(sdp2430_vmmc1_=
supplies),
> + =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &sdp2430_vmmc1_suppli=
es[0],
> +};
> +
> =A0static struct twl4030_gpio_platform_data sdp2430_gpio_data =3D {
> =A0 =A0 =A0 =A0.gpio_base =A0 =A0 =A0=3D OMAP_MAX_GPIO_LINES,
> =A0 =A0 =A0 =A0.irq_base =A0 =A0 =A0 =3D TWL4030_GPIO_IRQ_BASE,
> @@ -160,6 +180,7 @@ static struct twl4030_platform_data sdp2430_twlda=
ta =3D {
>
> =A0 =A0 =A0 =A0/* platform_data for children goes here */
> =A0 =A0 =A0 =A0.gpio =A0 =A0 =A0 =A0 =A0 =3D &sdp2430_gpio_data,
> + =A0 =A0 =A0 .vmmc1 =A0 =A0 =A0 =A0 =A0=3D &sdp2430_vmmc1,
> =A0};
>
> =A0static struct i2c_board_info __initdata sdp2430_i2c_boardinfo[] =3D=
 {
> --
> 1.7.0.4
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
