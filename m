From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [PATCHv5 02/14] arm: omap: voltage: renamed vp_vddmin and
 vp_vddmax fields
Date: Tue, 21 Feb 2012 08:40:22 -0600
Message-ID: <CAOMWX4cviUjAJ2eCB5LjUBmOpEWU5HP9-miPtZY1TwBGYyOPdA@mail.gmail.com>
References: <1329833098-19900-1-git-send-email-t-kristo@ti.com> <1329833098-19900-3-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:59579 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755363Ab2BUOko convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Feb 2012 09:40:44 -0500
Received: by mail-ww0-f50.google.com with SMTP id dq11so6083576wgb.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Feb 2012 06:40:42 -0800 (PST)
In-Reply-To: <1329833098-19900-3-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, khilman@ti.com, linux-arm-kernel@lists.infradead.org

On Tue, Feb 21, 2012 at 08:04, Tero Kristo <t-kristo@ti.com> wrote:
> These are now called vddmin and vddmax, as these fields will be used
> globally for selecting voltage ranges for a pmic channel, and not
> only for voltage processor.

NAK. I think we need to setup voltage for SoC limits as well. the
programmed voltage to the VP register should be:
VP->vlimito->min =3D MAX(soc->vdd_min, pmic->vdd_min)
VP->vlimito->max =3D MIN(soc->vdd_max, pmic->vdd_max)

else you could be running the SoC beyond design voltage potentially
damaging the device.

Regards,
Nishanth Menon


>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_twl.c | =A0 27 ++++++++++----------------=
-
> =A0arch/arm/mach-omap2/voltage.h =A0| =A0 =A04 ++--
> =A0arch/arm/mach-omap2/vp.c =A0 =A0 =A0 | =A0 =A04 ++--
> =A03 files changed, 14 insertions(+), 21 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/oma=
p_twl.c
> index df4e7c3..5224fbd 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -149,8 +149,8 @@ static struct omap_voltdm_pmic omap3_mpu_pmic =3D=
 {
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP3_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTEP=
MAX_VSTEPMAX,
> - =A0 =A0 =A0 .vp_vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3430_VP1_=
VLIMITTO_VDDMIN,
> - =A0 =A0 =A0 .vp_vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3430_VP1_=
VLIMITTO_VDDMAX,
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 600000,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 1450000,
> =A0 =A0 =A0 =A0.vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VLIMITT=
O_TIMEOUT_US,
> =A0 =A0 =A0 =A0.i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP3_SRI2C_SLAVE_=
ADDR,
> =A0 =A0 =A0 =A0.volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP3_VDD_MPU_SR=
_CONTROL_REG,
> @@ -170,8 +170,8 @@ static struct omap_voltdm_pmic omap3_core_pmic =3D=
 {
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP3_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VSTEP=
MAX_VSTEPMAX,
> - =A0 =A0 =A0 .vp_vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3430_VP2_=
VLIMITTO_VDDMIN,
> - =A0 =A0 =A0 .vp_vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3430_VP2_=
VLIMITTO_VDDMAX,
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 600000,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 1450000,
> =A0 =A0 =A0 =A0.vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VLIMITT=
O_TIMEOUT_US,
> =A0 =A0 =A0 =A0.i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP3_SRI2C_SLAVE_=
ADDR,
> =A0 =A0 =A0 =A0.volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP3_VDD_CORE_S=
R_CONTROL_REG,
> @@ -191,8 +191,8 @@ static struct omap_voltdm_pmic omap4_mpu_pmic =3D=
 {
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP4_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MAX_VSTEPMAX,
> - =A0 =A0 =A0 .vp_vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_MPU_=
VLIMITTO_VDDMIN,
> - =A0 =A0 =A0 .vp_vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_MPU_=
VLIMITTO_VDDMAX,
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 1500000,
> =A0 =A0 =A0 =A0.vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VLIMITT=
O_TIMEOUT_US,
> =A0 =A0 =A0 =A0.i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP4_SRI2C_SLAVE_=
ADDR,
> =A0 =A0 =A0 =A0.volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP4_VDD_MPU_SR=
_VOLT_REG,
> @@ -213,8 +213,8 @@ static struct omap_voltdm_pmic omap4_iva_pmic =3D=
 {
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP4_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MAX_VSTEPMAX,
> - =A0 =A0 =A0 .vp_vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_IVA_=
VLIMITTO_VDDMIN,
> - =A0 =A0 =A0 .vp_vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_IVA_=
VLIMITTO_VDDMAX,
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 1500000,
> =A0 =A0 =A0 =A0.vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VLIMITT=
O_TIMEOUT_US,
> =A0 =A0 =A0 =A0.i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP4_SRI2C_SLAVE_=
ADDR,
> =A0 =A0 =A0 =A0.volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP4_VDD_IVA_SR=
_VOLT_REG,
> @@ -235,8 +235,8 @@ static struct omap_voltdm_pmic omap4_core_pmic =3D=
 {
> =A0 =A0 =A0 =A0.vp_erroroffset =A0 =A0 =A0 =A0 =3D OMAP4_VP_CONFIG_ER=
ROROFFSET,
> =A0 =A0 =A0 =A0.vp_vstepmin =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MIN_VSTEPMIN,
> =A0 =A0 =A0 =A0.vp_vstepmax =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VSTEP=
MAX_VSTEPMAX,
> - =A0 =A0 =A0 .vp_vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_CORE=
_VLIMITTO_VDDMIN,
> - =A0 =A0 =A0 .vp_vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_CORE=
_VLIMITTO_VDDMAX,
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 1500000,
> =A0 =A0 =A0 =A0.vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VLIMITT=
O_TIMEOUT_US,
> =A0 =A0 =A0 =A0.i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP4_SRI2C_SLAVE_=
ADDR,
> =A0 =A0 =A0 =A0.volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP4_VDD_CORE_S=
R_VOLT_REG,
> @@ -271,13 +271,6 @@ int __init omap3_twl_init(void)
> =A0 =A0 =A0 =A0if (!cpu_is_omap34xx())
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>
> - =A0 =A0 =A0 if (cpu_is_omap3630()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_mpu_pmic.vp_vddmin =3D OMAP3630_V=
P1_VLIMITTO_VDDMIN;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_mpu_pmic.vp_vddmax =3D OMAP3630_V=
P1_VLIMITTO_VDDMAX;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_core_pmic.vp_vddmin =3D OMAP3630_=
VP2_VLIMITTO_VDDMIN;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_core_pmic.vp_vddmax =3D OMAP3630_=
VP2_VLIMITTO_VDDMAX;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * The smartreflex bit on twl4030 specifies if the set=
ting of voltage
> =A0 =A0 =A0 =A0 * is done over the I2C_SR path. Since this setting is=
 independent of
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/volt=
age.h
> index fa5b3dc..949938d 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -162,8 +162,8 @@ struct omap_voltdm_pmic {
> =A0 =A0 =A0 =A0u8 vp_erroroffset;
> =A0 =A0 =A0 =A0u8 vp_vstepmin;
> =A0 =A0 =A0 =A0u8 vp_vstepmax;
> - =A0 =A0 =A0 u32 vp_vddmin;
> - =A0 =A0 =A0 u32 vp_vddmax;
> + =A0 =A0 =A0 u32 vddmin;
> + =A0 =A0 =A0 u32 vddmax;
> =A0 =A0 =A0 =A0u8 vp_timeout_us;
> =A0 =A0 =A0 =A0bool i2c_high_speed;
> =A0 =A0 =A0 =A0u8 i2c_mcode;
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 6ee0b4a..d9e0650 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -53,8 +53,8 @@ void __init omap_vp_init(struct voltagedomain *volt=
dm)
> =A0 =A0 =A0 =A0sys_clk_rate =3D voltdm->sys_clk.rate / 1000;
>
> =A0 =A0 =A0 =A0timeout =3D (sys_clk_rate * voltdm->pmic->vp_timeout_u=
s) / 1000;
> - =A0 =A0 =A0 vddmin =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vd=
dmin);
> - =A0 =A0 =A0 vddmax =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->vp_vd=
dmax);
> + =A0 =A0 =A0 vddmin =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->vddmi=
n);
> + =A0 =A0 =A0 vddmax =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->vddma=
x);
>
> =A0 =A0 =A0 =A0waittime =3D ((voltdm->pmic->step_size / voltdm->pmic-=
>slew_rate) *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sys_clk_rate) / 1000;
> --
> 1.7.4.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
