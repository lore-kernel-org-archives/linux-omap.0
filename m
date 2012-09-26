From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCHv7 17/21] ARM: OMAP4: TWL: enable high speed mode for PMIC
 communication
Date: Wed, 26 Sep 2012 14:39:08 +0300
Message-ID: <5062E95C.6050903@ti.com>
References: <1348590833-12335-1-git-send-email-t-kristo@ti.com> <1348590833-12335-18-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:57655 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755325Ab2IZLiB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 26 Sep 2012 07:38:01 -0400
Received: by oagh16 with SMTP id h16so422054oag.19
        for <linux-omap@vger.kernel.org>; Wed, 26 Sep 2012 04:37:59 -0700 (PDT)
In-Reply-To: <1348590833-12335-18-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

Hi Tero,

On 09/25/2012 07:33 PM, Tero Kristo wrote:
> With the new parameters, I2C can now be put to high speed mode for
> better performance.

We have twl6040 on the same bus. have you tried this with audio enabled=
?
twl6040 is in standard mode (up to 100 kbps) after power up...

>=20
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  arch/arm/mach-omap2/omap_twl.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/oma=
p_twl.c
> index 611cb63..7ff9667 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -218,6 +218,7 @@ static struct omap_voltdm_pmic omap4_core_pmic =3D=
 {
>  	.i2c_slave_addr		=3D OMAP4_SRI2C_SLAVE_ADDR,
>  	.volt_reg_addr		=3D OMAP4_VDD_CORE_SR_VOLT_REG,
>  	.cmd_reg_addr		=3D OMAP4_VDD_CORE_SR_CMD_REG,
> +	.i2c_high_speed		=3D true,
>  	.i2c_pad_load		=3D 3,
>  	.vsel_to_uv		=3D twl6030_vsel_to_uv,
>  	.uv_to_vsel		=3D twl6030_uv_to_vsel,
>=20


--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
