From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH] OMAP3EVM: Add vio regulator supply required for ads7846
 TSC driver
Date: Mon, 24 Jan 2011 20:12:57 +0530
Message-ID: <AANLkTi=pYjxQkw2a+7R_H6HBYpKyg74uEKS9oGqtN9cO@mail.gmail.com>
References: <hvaibhav@ti.com> <1295879565-13144-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50916 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752902Ab1AXOni convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Jan 2011 09:43:38 -0500
Received: by mail-gx0-f177.google.com with SMTP id 21so1308025gxk.36
        for <linux-omap@vger.kernel.org>; Mon, 24 Jan 2011 06:43:37 -0800 (PST)
In-Reply-To: <1295879565-13144-1-git-send-email-hvaibhav@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com
Cc: linux-omap@vger.kernel.org, tony@atomide.com

On Mon, Jan 24, 2011 at 20:02,  <hvaibhav@ti.com> wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>

Please add a patch description.

>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> ---
> =A0arch/arm/mach-omap2/board-omap3evm.c | =A0 20 ++++++++++++++++++++
> =A01 files changed, 20 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-oma=
p2/board-omap3evm.c
> index a158d21..ed0311c 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -538,6 +538,25 @@ static struct regulator_init_data omap3_evm_vpll=
2 =3D {
> =A0 =A0 =A0 =A0.consumer_supplies =A0 =A0 =A0=3D &omap3_evm_vpll2_sup=
ply,
> =A0};
>
> +/* ads7846 on SPI */
> +static struct regulator_consumer_supply omap3evm_vio_supply =3D
> + =A0 =A0 =A0 REGULATOR_SUPPLY("vcc", "spi1.0");
> +
> +/* VIO for ads7846 */
> +static struct regulator_init_data omap3evm_vio =3D {
> + =A0 =A0 =A0 .constraints =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .min_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1800000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .max_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =3D 1800000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .apply_uV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=
 true,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_modes_mask =A0 =A0 =A0 =3D REGUL=
ATOR_MODE_NORMAL
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_MODE_STANDBY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .valid_ops_mask =A0 =A0 =A0 =A0 =3D REG=
ULATOR_CHANGE_MODE
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | REGULATOR_CHANGE_STATUS,
> + =A0 =A0 =A0 },
> + =A0 =A0 =A0 .num_consumer_supplies =A0=3D 1,
> + =A0 =A0 =A0 .consumer_supplies =A0 =A0 =A0=3D &omap3evm_vio_supply,
> +};
> +
> =A0static struct twl4030_platform_data omap3evm_twldata =3D {
> =A0 =A0 =A0 =A0.irq_base =A0 =A0 =A0 =3D TWL4030_IRQ_BASE,
> =A0 =A0 =A0 =A0.irq_end =A0 =A0 =A0 =A0=3D TWL4030_IRQ_END,
> @@ -550,6 +569,7 @@ static struct twl4030_platform_data omap3evm_twld=
ata =3D {
> =A0 =A0 =A0 =A0.codec =A0 =A0 =A0 =A0 =A0=3D &omap3evm_codec_data,
> =A0 =A0 =A0 =A0.vdac =A0 =A0 =A0 =A0 =A0 =3D &omap3_evm_vdac,
> =A0 =A0 =A0 =A0.vpll2 =A0 =A0 =A0 =A0 =A0=3D &omap3_evm_vpll2,
> + =A0 =A0 =A0 .vio =A0 =A0 =A0 =A0 =A0 =A0=3D &omap3evm_vio,
> =A0};
>
> =A0static struct i2c_board_info __initdata omap3evm_i2c_boardinfo[] =3D=
 {
> --
> 1.6.2.4
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
