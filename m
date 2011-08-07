From: "Menon, Nishanth" <nm@ti.com>
Subject: Re: [RFC 1/2] OMAP3+: voltage / oscillator parameter segregation
Date: Sun, 7 Aug 2011 11:30:21 -0500
Message-ID: <CAOMWX4cTsoK_ejOq861wNMiUDJYjcvPtc+jLo3z398D-Y2e39w@mail.gmail.com>
References: <1312385355-17029-1-git-send-email-t-kristo@ti.com> <1312385355-17029-2-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:51320 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752605Ab1HGQao convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Aug 2011 12:30:44 -0400
Received: by eye4 with SMTP id 4so3428483eye.17
        for <linux-omap@vger.kernel.org>; Sun, 07 Aug 2011 09:30:41 -0700 (PDT)
In-Reply-To: <1312385355-17029-2-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>

here is my quick feedback:


On Wed, Aug 3, 2011 at 10:29, Tero Kristo <t-kristo@ti.com> wrote:
>
> This patch separates board specific voltage and oscillator ramp / set=
up
> times from the core code. Things changed:
>
> - on/sleep/ret/off voltage setup moved from common twl code to
> =A0VC / VP data (oppxxxx_data.c files)
> - added board support for vdd ramp up / down times
> - added board support for oscillator setup time declaration
>
> Todo: split patch into more easily manageable parts.
>
> Applies on top of pm/wip/voltdm branch, based on work done by Vishwan=
ath
> Sripathy.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> ---
> =A0arch/arm/mach-omap2/omap_opp_data.h =A0 =A0 =A0 =A0 =A0 | =A0 15 +=
++
> =A0arch/arm/mach-omap2/omap_twl.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0=
 59 ----------
> =A0arch/arm/mach-omap2/opp3xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 62=
 ++++++++++
> =A0arch/arm/mach-omap2/opp4xxx_data.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 47=
 ++++++++
> =A0arch/arm/mach-omap2/prcm.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 11 ++
> =A0arch/arm/mach-omap2/prm2xxx_3xxx.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
6 +
> =A0arch/arm/mach-omap2/prm2xxx_3xxx.h =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0=
1 +
> =A0arch/arm/mach-omap2/prm44xx.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A07 +
> =A0arch/arm/mach-omap2/prm44xx.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 +
> =A0arch/arm/mach-omap2/vc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0153 +++++++++++++++++++++----
> =A0arch/arm/mach-omap2/vc.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A01 -
> =A0arch/arm/mach-omap2/voltage.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 22 ++++
> =A0arch/arm/mach-omap2/voltage.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 55 ++++++++-
> =A0arch/arm/mach-omap2/voltagedomains3xxx_data.c | =A0 =A08 ++
> =A0arch/arm/mach-omap2/voltagedomains44xx_data.c | =A0 =A08 ++
> =A0arch/arm/mach-omap2/vp.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
| =A0 =A04 +-
> =A0arch/arm/plat-omap/include/plat/prcm.h =A0 =A0 =A0 =A0| =A0 =A07 +
> =A017 files changed, 377 insertions(+), 90 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-omap=
2/omap_opp_data.h
> index c784c12..b5fe711 100644
> --- a/arch/arm/mach-omap2/omap_opp_data.h
> +++ b/arch/arm/mach-omap2/omap_opp_data.h
> @@ -86,11 +86,26 @@ extern int __init omap_init_opp_table(struct omap=
_opp_def *opp_def,
>
> =A0extern struct omap_volt_data omap34xx_vddmpu_volt_data[];
> =A0extern struct omap_volt_data omap34xx_vddcore_volt_data[];
> +extern struct omap_vp_param omap34xx_mpu_vp_data;
> +extern struct omap_vp_param omap34xx_core_vp_data;
> +extern struct omap_vc_param omap34xx_mpu_vc_data;
> +extern struct omap_vc_param omap34xx_core_vc_data;
> +
> =A0extern struct omap_volt_data omap36xx_vddmpu_volt_data[];
> =A0extern struct omap_volt_data omap36xx_vddcore_volt_data[];
> +extern struct omap_vp_param omap36xx_mpu_vp_data;
> +extern struct omap_vp_param omap36xx_core_vp_data;
> +extern struct omap_vc_param omap36xx_mpu_vc_data;
> +extern struct omap_vc_param omap36xx_core_vc_data;
>
> =A0extern struct omap_volt_data omap44xx_vdd_mpu_volt_data[];
> =A0extern struct omap_volt_data omap44xx_vdd_iva_volt_data[];
> =A0extern struct omap_volt_data omap44xx_vdd_core_volt_data[];
> +extern struct omap_vp_param omap44xx_mpu_vp_data;
> +extern struct omap_vp_param omap44xx_iva_vp_data;
> +extern struct omap_vp_param omap44xx_core_vp_data;
> +extern struct omap_vc_param omap44xx_mpu_vc_data;
> +extern struct omap_vc_param omap44xx_iva_vc_data;
> +extern struct omap_vc_param omap44xx_core_vc_data;
>
> =A0#endif =A0 =A0 =A0 =A0 /* __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H */
> diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/oma=
p_twl.c
> index f515a1a..d239792 100644
> --- a/arch/arm/mach-omap2/omap_twl.c
> +++ b/arch/arm/mach-omap2/omap_twl.c
> @@ -30,16 +30,6 @@
> =A0#define OMAP3_VP_VSTEPMAX_VSTEPMAX =A0 =A0 0x04
> =A0#define OMAP3_VP_VLIMITTO_TIMEOUT_US =A0 200
>
> -#define OMAP3430_VP1_VLIMITTO_VDDMIN =A0 0x14
> -#define OMAP3430_VP1_VLIMITTO_VDDMAX =A0 0x42
> -#define OMAP3430_VP2_VLIMITTO_VDDMIN =A0 0x18
> -#define OMAP3430_VP2_VLIMITTO_VDDMAX =A0 0x2c
> -
> -#define OMAP3630_VP1_VLIMITTO_VDDMIN =A0 0x18
> -#define OMAP3630_VP1_VLIMITTO_VDDMAX =A0 0x3c
> -#define OMAP3630_VP2_VLIMITTO_VDDMIN =A0 0x18
> -#define OMAP3630_VP2_VLIMITTO_VDDMAX =A0 0x30
> -
> =A0#define OMAP4_SRI2C_SLAVE_ADDR =A0 =A0 =A0 =A0 0x12
> =A0#define OMAP4_VDD_MPU_SR_VOLT_REG =A0 =A0 =A00x55
> =A0#define OMAP4_VDD_MPU_SR_CMD_REG =A0 =A0 =A0 0x56
> @@ -53,13 +43,6 @@
> =A0#define OMAP4_VP_VSTEPMAX_VSTEPMAX =A0 =A0 0x04
> =A0#define OMAP4_VP_VLIMITTO_TIMEOUT_US =A0 200
>
> -#define OMAP4_VP_MPU_VLIMITTO_VDDMIN =A0 0xA
> -#define OMAP4_VP_MPU_VLIMITTO_VDDMAX =A0 0x39
> -#define OMAP4_VP_IVA_VLIMITTO_VDDMIN =A0 0xA
> -#define OMAP4_VP_IVA_VLIMITTO_VDDMAX =A0 0x2D
> -#define OMAP4_VP_CORE_VLIMITTO_VDDMIN =A00xA
> -#define OMAP4_VP_CORE_VLIMITTO_VDDMAX =A00x28
> -
> =A0static bool is_offset_valid;
> =A0static u8 smps_offset;
> =A0/*
> @@ -158,16 +141,9 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
> =A0static struct omap_voltdm_pmic omap3_mpu_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12500,
> - =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1200000,
> - =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1000000,
> - =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 975000,
> - =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 600000,
> - =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0xfff,
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
> =A0 =A0 =A0 =A0.vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VLIMITT=
O_TIMEOUT_US,
> =A0 =A0 =A0 =A0.i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP3_SRI2C_SLAVE_=
ADDR,
> =A0 =A0 =A0 =A0.volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP3_VDD_MPU_SR=
_CONTROL_REG,
> @@ -179,16 +155,9 @@ static struct omap_voltdm_pmic omap3_mpu_pmic =3D=
 {
> =A0static struct omap_voltdm_pmic omap3_core_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12500,
> - =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1200000,
> - =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1000000,
> - =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 975000,
> - =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 600000,
> - =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0xfff,
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
> =A0 =A0 =A0 =A0.vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP3_VP_VLIMITT=
O_TIMEOUT_US,
> =A0 =A0 =A0 =A0.i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP3_SRI2C_SLAVE_=
ADDR,
> =A0 =A0 =A0 =A0.volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP3_VDD_CORE_S=
R_CONTROL_REG,
> @@ -200,16 +169,9 @@ static struct omap_voltdm_pmic omap3_core_pmic =3D=
 {
> =A0static struct omap_voltdm_pmic omap4_mpu_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12660,
> - =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1375000,
> - =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1375000,
> - =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 830000,
> - =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0,
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
> =A0 =A0 =A0 =A0.vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VLIMITT=
O_TIMEOUT_US,
> =A0 =A0 =A0 =A0.i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP4_SRI2C_SLAVE_=
ADDR,
> =A0 =A0 =A0 =A0.volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP4_VDD_MPU_SR=
_VOLT_REG,
> @@ -222,16 +184,9 @@ static struct omap_voltdm_pmic omap4_mpu_pmic =3D=
 {
> =A0static struct omap_voltdm_pmic omap4_iva_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12660,
> - =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1188000,
> - =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1188000,
> - =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 830000,
> - =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0,
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
> =A0 =A0 =A0 =A0.vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VLIMITT=
O_TIMEOUT_US,
> =A0 =A0 =A0 =A0.i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP4_SRI2C_SLAVE_=
ADDR,
> =A0 =A0 =A0 =A0.volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP4_VDD_IVA_SR=
_VOLT_REG,
> @@ -244,16 +199,9 @@ static struct omap_voltdm_pmic omap4_iva_pmic =3D=
 {
> =A0static struct omap_voltdm_pmic omap4_core_pmic =3D {
> =A0 =A0 =A0 =A0.slew_rate =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 4000,
> =A0 =A0 =A0 =A0.step_size =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 12660,
> - =A0 =A0 =A0 .on_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1200000,
> - =A0 =A0 =A0 .onlp_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1200000,
> - =A0 =A0 =A0 .ret_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 830000,
> - =A0 =A0 =A0 .off_volt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 0,
> - =A0 =A0 =A0 .volt_setup_time =A0 =A0 =A0 =A0=3D 0,
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
> =A0 =A0 =A0 =A0.vp_timeout_us =A0 =A0 =A0 =A0 =A0=3D OMAP4_VP_VLIMITT=
O_TIMEOUT_US,
> =A0 =A0 =A0 =A0.i2c_slave_addr =A0 =A0 =A0 =A0 =3D OMAP4_SRI2C_SLAVE_=
ADDR,
> =A0 =A0 =A0 =A0.volt_reg_addr =A0 =A0 =A0 =A0 =A0=3D OMAP4_VDD_CORE_S=
R_VOLT_REG,
> @@ -288,13 +236,6 @@ int __init omap3_twl_init(void)
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
> diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-omap2=
/opp3xxx_data.c
> index d95f3f9..b5d8294 100644
> --- a/arch/arm/mach-omap2/opp3xxx_data.c
> +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> @@ -26,6 +26,16 @@
> =A0#include "pm.h"
>
> =A0/* 34xx */
> +/* OMAP VP parameter values */
> +#define OMAP3430_VP1_VLIMITTO_VDDMIN =A0 0x14
> +#define OMAP3430_VP1_VLIMITTO_VDDMAX =A0 0x42
> +#define OMAP3430_VP2_VLIMITTO_VDDMIN =A0 0x18
> +#define OMAP3430_VP2_VLIMITTO_VDDMAX =A0 0x2c
NAK -> we should be using voltages here -> depending on the PMIC used,
the rounding factor may not map to TWL4030.
I had posted patch for this earlier I believe in series
http://marc.info/?l=3Dlinux-omap&m=3D130741297821372&w=3D2

> +
> +#define OMAP3_ON_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A01200000
> +#define OMAP3_ONLP_VOLTAGE_UV =A0 =A0 =A0 =A0 =A01000000
> +#define OMAP3_RET_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 975000
> +#define OMAP3_OFF_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 600000
Here is what concerns me:
a) OMAP OFF voltage is 0
b) OMAP has Max and MIN operational voltages, however, PMIC connected
can have it's own voltage ranges as well -> here we remove the ability
for PMIC to state its capability and the matching with PMIC Vs OMAP
capabilties is not done.

>
> =A0/* VDD1 */
>
> @@ -44,6 +54,18 @@ struct omap_volt_data omap34xx_vddmpu_volt_data[] =
=3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap34xx_mpu_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3430_VP=
1_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3430_VP=
1_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap34xx_mpu_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ON_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ONLP_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_RET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_OFF_VOLTAGE_UV,
> +};
> +
> =A0/* VDD2 */
>
> =A0#define OMAP3430_VDD_CORE_OPP1_UV =A0 =A0 =A0 =A0 =A0 =A0 =A097500=
0
> @@ -57,7 +79,23 @@ struct omap_volt_data omap34xx_vddcore_volt_data[]=
 =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap34xx_core_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3430_VP=
2_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3430_VP=
2_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap34xx_core_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ON_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ONLP_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_RET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_OFF_VOLTAGE_UV,
> +};
> +
> =A0/* 36xx */
> +#define OMAP3630_VP1_VLIMITTO_VDDMIN =A0 0x18
> +#define OMAP3630_VP1_VLIMITTO_VDDMAX =A0 0x3c
> +#define OMAP3630_VP2_VLIMITTO_VDDMIN =A0 0x18
> +#define OMAP3630_VP2_VLIMITTO_VDDMAX =A0 0x30
>
> =A0/* VDD1 */
>
> @@ -74,6 +112,18 @@ struct omap_volt_data omap36xx_vddmpu_volt_data[]=
 =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap36xx_mpu_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3630_VP=
1_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3630_VP=
1_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap36xx_mpu_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ON_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ONLP_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_RET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_OFF_VOLTAGE_UV,
> +};
> +
> =A0/* VDD2 */
>
> =A0#define OMAP3630_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 1000000
> @@ -85,6 +135,18 @@ struct omap_volt_data omap36xx_vddcore_volt_data[=
] =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap36xx_core_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3630_VP=
2_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3630_VP=
2_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap36xx_core_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ON_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =3D OMAP3_ONLP_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_RET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP3_OFF_VOLTAGE_UV,
> +};
> +
> =A0/* OPP data */
>
> =A0static struct omap_opp_def __initdata omap34xx_opp_def_list[] =3D =
{
> diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2=
/opp4xxx_data.c
> index 2293ba2..59f695b 100644
> --- a/arch/arm/mach-omap2/opp4xxx_data.c
> +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> @@ -31,6 +31,18 @@
> =A0* voltage dependent data for each VDD.
> =A0*/
>
> +#define OMAP4_VP_MPU_VLIMITTO_VDDMIN =A0 =A0 =A0 =A0 =A0 0x0a
> +#define OMAP4_VP_MPU_VLIMITTO_VDDMAX =A0 =A0 =A0 =A0 =A0 0x39
> +#define OMAP4_VP_IVA_VLIMITTO_VDDMIN =A0 =A0 =A0 =A0 =A0 0x0a
> +#define OMAP4_VP_IVA_VLIMITTO_VDDMAX =A0 =A0 =A0 =A0 =A0 0x2d
> +#define OMAP4_VP_CORE_VLIMITTO_VDDMIN =A0 =A0 =A0 =A0 =A00x0a
> +#define OMAP4_VP_CORE_VLIMITTO_VDDMAX =A0 =A0 =A0 =A0 =A00x28
> +
> +#define OMAP4_ON_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01=
350000
> +#define OMAP4_ONLP_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0135=
0000
> +#define OMAP4_RET_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 837=
500
> +#define OMAP4_OFF_VOLTAGE_UV =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 600=
000
> +
> =A0#define OMAP4430_VDD_MPU_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A010250=
00
> =A0#define OMAP4430_VDD_MPU_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1200000
> =A0#define OMAP4430_VDD_MPU_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1313000
> @@ -44,6 +56,18 @@ struct omap_volt_data omap44xx_vdd_mpu_volt_data[]=
 =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap44xx_mpu_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_MP=
U_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_MP=
U_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap44xx_mpu_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_O=
N_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_ONL=
P_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_R=
ET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_O=
=46F_VOLTAGE_UV,
> +};
> +
> =A0#define OMAP4430_VDD_IVA_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 =A010130=
00
> =A0#define OMAP4430_VDD_IVA_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A0 1188000
> =A0#define OMAP4430_VDD_IVA_OPPTURBO_UV =A0 =A0 =A0 =A0 =A0 1300000
> @@ -55,6 +79,18 @@ struct omap_volt_data omap44xx_vdd_iva_volt_data[]=
 =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap44xx_iva_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_IV=
A_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_IV=
A_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap44xx_iva_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_O=
N_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_ONL=
P_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_R=
ET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_O=
=46F_VOLTAGE_UV,
> +};
> +
> =A0#define OMAP4430_VDD_CORE_OPP50_UV =A0 =A0 =A0 =A0 =A0 =A0 1025000
> =A0#define OMAP4430_VDD_CORE_OPP100_UV =A0 =A0 =A0 =A0 =A0 =A01200000
>
> @@ -64,6 +100,17 @@ struct omap_volt_data omap44xx_vdd_core_volt_data=
[] =3D {
> =A0 =A0 =A0 =A0VOLT_DATA_DEFINE(0, 0, 0, 0),
> =A0};
>
> +struct omap_vp_param omap44xx_core_vp_data =3D {
> + =A0 =A0 =A0 .vddmin =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_CO=
RE_VLIMITTO_VDDMIN,
> + =A0 =A0 =A0 .vddmax =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_VP_CO=
RE_VLIMITTO_VDDMAX,
> +};
> +
> +struct omap_vc_param omap44xx_core_vc_data =3D {
> + =A0 =A0 =A0 .on =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_O=
N_VOLTAGE_UV,
> + =A0 =A0 =A0 .onlp =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D OMAP4_ONL=
P_VOLTAGE_UV,
> + =A0 =A0 =A0 .ret =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_R=
ET_VOLTAGE_UV,
> + =A0 =A0 =A0 .off =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D OMAP4_O=
=46F_VOLTAGE_UV,
> +};
>
> =A0static struct omap_opp_def __initdata omap44xx_opp_def_list[] =3D =
{
> =A0 =A0 =A0 =A0/* MPU OPP1 - OPP50 */
> diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> index 2e40a5c..5d94e91 100644
> --- a/arch/arm/mach-omap2/prcm.c
> +++ b/arch/arm/mach-omap2/prcm.c
> @@ -42,6 +42,7 @@
> =A0void __iomem *prm_base;
> =A0void __iomem *cm_base;
> =A0void __iomem *cm2_base;
> +static struct omap_osc_data *osc_setup;
>
> =A0#define MAX_MODULE_ENABLE_WAIT =A0 =A0 =A0 =A0 100000
>
> @@ -165,3 +166,13 @@ void __init omap2_set_globals_prcm(struct omap_g=
lobals *omap2_globals)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0WARN_ON(!cm2_base);
> =A0 =A0 =A0 =A0}
> =A0}
> +
> +void __init omap_osc_register(struct omap_osc_data *osc)
> +{
> + =A0 =A0 =A0 osc_setup =3D osc;
> +}
> +
> +struct omap_osc_data *omap_osc_get(void)
> +{
> + =A0 =A0 =A0 return osc_setup;
> +}
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2=
/prm2xxx_3xxx.c
> index 3b83763..2c678e9 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> @@ -212,3 +212,9 @@ u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 off=
set)
> =A0{
> =A0 =A0 =A0 =A0return omap2_prm_rmw_mod_reg_bits(mask, bits, OMAP3430=
_GR_MOD, offset);
> =A0}
> +
> +void omap3_prm_set_clksetup(unsigned long clksetup)
> +{
> + =A0 =A0 =A0 clksetup =3D clksetup * 32768 / (1000 * 1000) + 1;
> + =A0 =A0 =A0 omap3_prm_vcvp_write(clksetup, OMAP3_PRM_CLKSETUP_OFFSE=
T);
> +}
> diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2=
/prm2xxx_3xxx.h
> index cef533d..32740a0 100644
> --- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
> +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> @@ -314,6 +314,7 @@ void omap3_prm_vp_clear_txdone(u8 vp_id);
> =A0extern u32 omap3_prm_vcvp_read(u8 offset);
> =A0extern void omap3_prm_vcvp_write(u32 val, u8 offset);
> =A0extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
> +extern void omap3_prm_set_clksetup(unsigned long clksetup);
> =A0#endif /* CONFIG_ARCH_OMAP4 */
>
> =A0#endif
> diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm4=
4xx.c
> index 495a31a..c91c66f 100644
> --- a/arch/arm/mach-omap2/prm44xx.c
> +++ b/arch/arm/mach-omap2/prm44xx.c
> @@ -26,6 +26,7 @@
> =A0#include "prm-regbits-44xx.h"
> =A0#include "prcm44xx.h"
> =A0#include "prminst44xx.h"
> +#include "scrm44xx.h"
>
> =A0/* PRM low-level functions */
>
> @@ -121,3 +122,9 @@ u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 off=
set)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 OMAP4430_PRM_DEVICE_INST,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 offset);
> =A0}
> +
> +void omap4_prm_set_clksetup(unsigned long clksetup)
> +{
> + =A0 =A0 =A0 clksetup =3D clksetup * 32768 / (1000 * 1000) + 1;
> + =A0 =A0 =A0 __raw_writel(clksetup, OMAP4_SCRM_CLKSETUPTIME);
> +}
> diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm4=
4xx.h
> index 3d66ccd..9b21f33 100644
> --- a/arch/arm/mach-omap2/prm44xx.h
> +++ b/arch/arm/mach-omap2/prm44xx.h
> @@ -762,6 +762,7 @@ void omap4_prm_vp_clear_txdone(u8 vp_id);
> =A0extern u32 omap4_prm_vcvp_read(u8 offset);
> =A0extern void omap4_prm_vcvp_write(u32 val, u8 offset);
> =A0extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
> +extern void omap4_prm_set_clksetup(unsigned long clksetup);
>
> =A0# endif
>
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 16fa912..8bbc95a 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -1,14 +1,18 @@
> =A0#include <linux/kernel.h>
> =A0#include <linux/delay.h>
> =A0#include <linux/init.h>
> +#include <linux/clk.h>
> +#include <linux/io.h>
>
> =A0#include <plat/cpu.h>
> +#include <plat/prcm.h>
>
> =A0#include "voltage.h"
> =A0#include "vc.h"
> =A0#include "prm-regbits-34xx.h"
> =A0#include "prm-regbits-44xx.h"
> =A0#include "prm44xx.h"
> +#include "scrm44xx.h"
>
> =A0/**
> =A0* struct omap_vc_channel_cfg - describe the cfg_channel bitfield
> @@ -196,42 +200,153 @@ int omap_vc_bypass_scale(struct voltagedomain =
*voltdm,
>
> =A0static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
> =A0{
> + =A0 =A0 =A0 unsigned long clksetup;
> + =A0 =A0 =A0 unsigned long voltsetup2;
> + =A0 =A0 =A0 struct omap_osc_data *osc;
> =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 * Voltage Manager FSM parameters init
> =A0 =A0 =A0 =A0 * XXX This data should be passed in from the board fi=
le
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 voltdm->write(OMAP3_CLKSETUP, OMAP3_PRM_CLKSETUP_OFFSET=
);
> - =A0 =A0 =A0 voltdm->write(OMAP3_VOLTOFFSET, OMAP3_PRM_VOLTOFFSET_OF=
=46SET);
> - =A0 =A0 =A0 voltdm->write(OMAP3_VOLTSETUP2, OMAP3_PRM_VOLTSETUP2_OF=
=46SET);
> + =A0 =A0 =A0 osc =3D omap_osc_get();
> + =A0 =A0 =A0 if (osc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clksetup =3D osc->clk_setup_off;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_prm_set_clksetup(clksetup);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 clksetup =3D voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
> +
> + =A0 =A0 =A0 voltsetup2 =3D voltdm->board_data->vdd_setup_off.ramp_u=
p;
> + =A0 =A0 =A0 voltsetup2 =3D voltsetup2 * 32768 / (1000 * 1000) + 1;
> + =A0 =A0 =A0 voltdm->write(voltsetup2, OMAP3_PRM_VOLTSETUP2_OFFSET);
> +
> + =A0 =A0 =A0 voltdm->write(clksetup - voltsetup2, OMAP3_PRM_VOLTOFFS=
ET_OFFSET);
> =A0}
>
> =A0static void __init omap3_vc_init_channel(struct voltagedomain *vol=
tdm)
> =A0{
> - =A0 =A0 =A0 static bool is_initialized;
> + =A0 =A0 =A0 unsigned long temp;
> + =A0 =A0 =A0 struct clk *sys_ck;
> + =A0 =A0 =A0 u32 sys_clk_rate;
>
> - =A0 =A0 =A0 if (is_initialized)
> + =A0 =A0 =A0 if (!voltdm->board_data) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: no voltdm board data fo=
r %s\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->name);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 omap3_vfsm_init(voltdm);
> + =A0 =A0 =A0 sys_ck =3D clk_get(NULL, "sys_ck");
> + =A0 =A0 =A0 if (IS_ERR(sys_ck)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: could not get the sys c=
lk to calculate "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "various vdd_%s params\=
n", __func__, voltdm->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 sys_clk_rate =3D clk_get_rate(sys_ck);
> + =A0 =A0 =A0 clk_put(sys_ck);
> + =A0 =A0 =A0 /* Divide to avoid overflow */
> + =A0 =A0 =A0 sys_clk_rate /=3D 1000000;
> +
> + =A0 =A0 =A0 temp =3D voltdm->board_data->vdd_setup_off.ramp_up;
> + =A0 =A0 =A0 temp =3D temp * sys_clk_rate / 8;
> +
> + =A0 =A0 =A0 /* Configure the setup times */
> + =A0 =A0 =A0 voltdm->rmw(voltdm->vfsm->voltsetup_mask,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 temp << __ffs(voltdm->vfsm->vol=
tsetup_mask),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->vfsm->voltsetup_reg);
>
> - =A0 =A0 =A0 is_initialized =3D true;
> + =A0 =A0 =A0 omap3_vfsm_init(voltdm);
> =A0}
>
> +static u32 omap4_calc_volt_ramp(u32 time, u32 clk_rate)
> +{
> + =A0 =A0 =A0 u32 prescaler;
> + =A0 =A0 =A0 u32 cycles;
> +
> + =A0 =A0 =A0 cycles =3D clk_rate / 1000 * time;
> +
> + =A0 =A0 =A0 cycles /=3D 64;
> + =A0 =A0 =A0 prescaler =3D 0;
> +
> + =A0 =A0 =A0 /* shift to next prescaler until no overflow */
> +
> + =A0 =A0 =A0 /* scale for div 256 =3D 64 * 4 */
> + =A0 =A0 =A0 if (cycles > 63) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cycles /=3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescaler++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* scale for div 512 =3D 256 * 2 */
> + =A0 =A0 =A0 if (cycles > 63) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cycles /=3D 2;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescaler++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* scale for div 2048 =3D 512 * 4 */
> + =A0 =A0 =A0 if (cycles > 63) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 cycles /=3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prescaler++;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* check for overflow =3D> invalid ramp time */
> + =A0 =A0 =A0 if (cycles > 63)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 cycles++;
> +
> + =A0 =A0 =A0 return (prescaler << OMAP4430_RAMP_UP_PRESCAL_SHIFT) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (cycles << OMAP4430_RAMP_UP_COUNT_SHIFT=
);
> +}
>
> =A0/* OMAP4 specific voltage init functions */
> =A0static void __init omap4_vc_init_channel(struct voltagedomain *vol=
tdm)
> =A0{
> - =A0 =A0 =A0 static bool is_initialized;
> - =A0 =A0 =A0 u32 vc_val;
> + =A0 =A0 =A0 u32 vc_val, temp;
> + =A0 =A0 =A0 struct clk *sys_ck;
> + =A0 =A0 =A0 u32 sys_clk_rate;
> + =A0 =A0 =A0 unsigned long val;
> + =A0 =A0 =A0 struct omap_osc_data *osc;
> +
> + =A0 =A0 =A0 sys_ck =3D clk_get(NULL, "sys_clkin_ck");
> + =A0 =A0 =A0 if (IS_ERR(sys_ck)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Could not get sys clk t=
o calculate "
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "various vdd_%s params\=
n", __func__, voltdm->name);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 sys_clk_rate =3D clk_get_rate(sys_ck);
> + =A0 =A0 =A0 clk_put(sys_ck);
>
> - =A0 =A0 =A0 if (is_initialized)
> + =A0 =A0 =A0 /* Configure the setup times */
> + =A0 =A0 =A0 vc_val =3D voltdm->read(voltdm->vfsm->voltsetup_reg);
> +
> + =A0 =A0 =A0 temp =3D omap4_calc_volt_ramp(voltdm->board_data->vdd_s=
etup_off.ramp_down,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 sys_clk_rate);
> + =A0 =A0 =A0 if (!temp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Invalid VoltOff setup t=
ime for vdd%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 vc_val |=3D temp << OMAP4430_RAMP_DOWN_COUNT_SHIFT;
> +
> + =A0 =A0 =A0 temp =3D omap4_calc_volt_ramp(voltdm->board_data->vdd_s=
etup_off.ramp_up,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 sys_clk_rate);
> + =A0 =A0 =A0 if (!temp) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Invalid VoltOff setup t=
ime for vdd%s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__, voltdm->name)=
;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 vc_val |=3D temp << OMAP4430_RAMP_UP_COUNT_SHIFT;
> +
> + =A0 =A0 =A0 voltdm->write(vc_val, voltdm->vfsm->voltsetup_reg);
> +
> + =A0 =A0 =A0 osc =3D omap_osc_get();
> +
> + =A0 =A0 =A0 if (osc) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 val =3D osc->clk_setup_off;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap4_prm_set_clksetup(val);
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0/* XXX These are magic numbers and do not belong! */
> =A0 =A0 =A0 =A0vc_val =3D (0x60 << OMAP4430_SCLL_SHIFT | 0x26 << OMAP=
4430_SCLH_SHIFT);
> =A0 =A0 =A0 =A0voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET)=
;
> -
> - =A0 =A0 =A0 is_initialized =3D true;
> =A0}
>
> =A0/**
> @@ -305,7 +420,6 @@ void __init omap_vc_init_channel(struct voltagedo=
main *voltdm)
> =A0 =A0 =A0 =A0vc->i2c_slave_addr =3D voltdm->pmic->i2c_slave_addr;
> =A0 =A0 =A0 =A0vc->volt_reg_addr =3D voltdm->pmic->volt_reg_addr;
> =A0 =A0 =A0 =A0vc->cmd_reg_addr =3D voltdm->pmic->cmd_reg_addr;
> - =A0 =A0 =A0 vc->setup_time =3D voltdm->pmic->volt_setup_time;
>
> =A0 =A0 =A0 =A0/* Configure the i2c slave address for this VC */
> =A0 =A0 =A0 =A0voltdm->rmw(vc->smps_sa_mask,
> @@ -329,10 +443,10 @@ void __init omap_vc_init_channel(struct voltage=
domain *voltdm)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Set up the on, inactive, retention and off voltage =
*/
> - =A0 =A0 =A0 on_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->on_v=
olt);
> - =A0 =A0 =A0 onlp_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->on=
lp_volt);
> - =A0 =A0 =A0 ret_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->ret=
_volt);
> - =A0 =A0 =A0 off_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->pmic->off=
_volt);
> + =A0 =A0 =A0 on_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->vc_param->=
on);
> + =A0 =A0 =A0 onlp_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->vc_param=
->onlp);
> + =A0 =A0 =A0 ret_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->vc_param-=
>ret);
> + =A0 =A0 =A0 off_vsel =3D voltdm->pmic->uv_to_vsel(voltdm->vc_param-=
>off);
> =A0 =A0 =A0 =A0val =3D ((on_vsel << vc->common->cmd_on_shift) |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (onlp_vsel << vc->common->cmd_onlp_shift)=
 |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 (ret_vsel << vc->common->cmd_ret_shift) |
> @@ -343,11 +457,6 @@ void __init omap_vc_init_channel(struct voltaged=
omain *voltdm)
> =A0 =A0 =A0 =A0/* Channel configuration */
> =A0 =A0 =A0 =A0omap_vc_config_channel(voltdm);
>
> - =A0 =A0 =A0 /* Configure the setup times */
> - =A0 =A0 =A0 voltdm->rmw(voltdm->vfsm->voltsetup_mask,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 vc->setup_time << __ffs(voltdm-=
>vfsm->voltsetup_mask),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 voltdm->vfsm->voltsetup_reg);
> -
> =A0 =A0 =A0 =A0omap_vc_i2c_init(voltdm);
>
> =A0 =A0 =A0 =A0if (cpu_is_omap34xx())
> diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> index ec50643..e6fdd23 100644
> --- a/arch/arm/mach-omap2/vc.h
> +++ b/arch/arm/mach-omap2/vc.h
> @@ -80,7 +80,6 @@ struct omap_vc_channel {
> =A0 =A0 =A0 =A0u16 i2c_slave_addr;
> =A0 =A0 =A0 =A0u16 volt_reg_addr;
> =A0 =A0 =A0 =A0u16 cmd_reg_addr;
> - =A0 =A0 =A0 u16 setup_time;
> =A0 =A0 =A0 =A0u8 cfg_channel;
> =A0 =A0 =A0 =A0bool i2c_high_speed;
>
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/volt=
age.c
> index cebc8b1..a95d2dd4 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -428,3 +428,25 @@ void voltdm_init(struct voltagedomain **voltdms)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_voltdm_register(*v);
> =A0 =A0 =A0 =A0}
> =A0}
> +
> +/**
> + * omap_voltage_register_board_params - set board values for a volta=
gedomain
> + * @voltdm: voltagedomain whose parameters should be set
> + * @board_params: board parameters for voltagedomain
> + *
> + * Sets up board parameters for a voltagedomain. These include the r=
amp up
> + * and ramp down times for the domain. Return 0 for success, -EINVAL=
 for
> + * invalid voltagedomain.
> + */
> +int omap_voltage_register_board_params(struct voltagedomain *voltdm,
> + =A0 =A0 =A0 struct omap_volt_board_data *board_params)
> +{
> + =A0 =A0 =A0 if (!voltdm || IS_ERR(voltdm)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: VDD specified does not =
exist!\n", __func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 voltdm->board_data =3D board_params;
> +
> + =A0 =A0 =A0 return 0;
> +}
> diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/volt=
age.h
> index b4c6259..e4b9e0e 100644
> --- a/arch/arm/mach-omap2/voltage.h
> +++ b/arch/arm/mach-omap2/voltage.h
> @@ -70,6 +70,9 @@ struct voltagedomain {
> =A0 =A0 =A0 =A0const struct omap_vfsm_instance *vfsm;
> =A0 =A0 =A0 =A0struct omap_vp_instance *vp;
> =A0 =A0 =A0 =A0struct omap_voltdm_pmic *pmic;
> + =A0 =A0 =A0 struct omap_vp_param *vp_param;
> + =A0 =A0 =A0 struct omap_vc_param *vc_param;
> + =A0 =A0 =A0 struct omap_volt_board_data *board_data;
>
> =A0 =A0 =A0 =A0/* VC/VP register access functions: SoC specific */
> =A0 =A0 =A0 =A0u32 (*read) (u8 offset);
> @@ -89,6 +92,28 @@ struct voltagedomain {
> =A0};
>
> =A0/**
> + * omap_vdd_setuptime - vdd set up time info
> + * @ramp_up =A0 =A0: VDD ramp up time in us
> + * @ramp_down =A0: VDD ramp down time in us, not used in OMAP3
> + * @clksetup =A0 : setup time of the oscillator system clock (sys_cl=
k) in us
> + */
> +struct omap_vdd_setuptime {
> + =A0 =A0 =A0 u16 ramp_up;
> + =A0 =A0 =A0 u16 ramp_down;
> + =A0 =A0 =A0 u16 clksetup;
> +};
> +
> +/**
> + * omap_volt_board_data - vdd set up time
> + * @vdd_setup_ret =A0 =A0 =A0: VDD setup time for retention mode
> + * @vdd_setup_off =A0 =A0 =A0: VDD setup time for off mode
> + */
> +struct omap_volt_board_data {
> + =A0 =A0 =A0 struct omap_vdd_setuptime vdd_setup_ret;
> + =A0 =A0 =A0 struct omap_vdd_setuptime vdd_setup_off;
> +};
> +
> +/**
> =A0* struct omap_volt_data - Omap voltage specific data.
> =A0* @voltage_nominal: =A0 The possible voltage value in uV
> =A0* @sr_efuse_offs: =A0 =A0 The offset of the efuse register(from sy=
stem
> @@ -119,10 +148,6 @@ struct omap_volt_data {
> =A0struct omap_voltdm_pmic {
> =A0 =A0 =A0 =A0int slew_rate;
> =A0 =A0 =A0 =A0int step_size;
> - =A0 =A0 =A0 u32 on_volt;
> - =A0 =A0 =A0 u32 onlp_volt;
> - =A0 =A0 =A0 u32 ret_volt;
> - =A0 =A0 =A0 u32 off_volt;
> =A0 =A0 =A0 =A0u16 volt_setup_time;
> =A0 =A0 =A0 =A0u16 i2c_slave_addr;
> =A0 =A0 =A0 =A0u16 volt_reg_addr;
> @@ -130,8 +155,6 @@ struct omap_voltdm_pmic {
> =A0 =A0 =A0 =A0u8 vp_erroroffset;
> =A0 =A0 =A0 =A0u8 vp_vstepmin;
> =A0 =A0 =A0 =A0u8 vp_vstepmax;
> - =A0 =A0 =A0 u8 vp_vddmin;
> - =A0 =A0 =A0 u8 vp_vddmax;
> =A0 =A0 =A0 =A0u8 vp_timeout_us;
> =A0 =A0 =A0 =A0bool i2c_high_speed;
> =A0 =A0 =A0 =A0u8 i2c_mcode;
> @@ -139,6 +162,18 @@ struct omap_voltdm_pmic {
> =A0 =A0 =A0 =A0u8 (*uv_to_vsel) (unsigned long uV);
> =A0};
>
> +struct omap_vp_param {
> + =A0 =A0 =A0 u8 vddmax;
> + =A0 =A0 =A0 u8 vddmin;
> +};
> +
> +struct omap_vc_param {
> + =A0 =A0 =A0 u32 on;
> + =A0 =A0 =A0 u32 onlp;
> + =A0 =A0 =A0 u32 ret;
> + =A0 =A0 =A0 u32 off;
> +};
> +
> =A0void omap_voltage_get_volttable(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct omap_volt_data **volt_data);
> =A0struct omap_volt_data *omap_voltage_get_voltdata(struct voltagedom=
ain *voltdm,
> @@ -149,6 +184,8 @@ int omap_voltage_register_pmic(struct voltagedoma=
in *voltdm,
> =A0void omap_change_voltscale_method(struct voltagedomain *voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int voltscale_method);
> =A0int omap_voltage_late_init(void);
> +int omap_voltage_register_board_params(struct voltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_board_=
data *board_params);
> =A0#else
> =A0static inline int omap_voltage_register_pmic(struct voltagedomain =
*voltdm,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 struct omap_voltdm_pmic *pmic)
> @@ -161,6 +198,12 @@ static inline int omap_voltage_late_init(void)
> =A0{
> =A0 =A0 =A0 =A0return -EINVAL;
> =A0}
> +static inline int omap_voltage_register_board_params(
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct voltagedomain *voltdm,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap_volt_board_data *board_para=
ms)
> +{
> + =A0 =A0 =A0 return -EINVAL;
> +}
> =A0#endif
>
> =A0extern void omap2xxx_voltagedomains_init(void);
> diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c b/arch/arm=
/mach-omap2/voltagedomains3xxx_data.c
> index b0d0ae1..9c907af 100644
> --- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> @@ -90,9 +90,17 @@ void __init omap3xxx_voltagedomains_init(void)
> =A0 =A0 =A0 =A0if (cpu_is_omap3630()) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_voltdm_mpu.volt_data =3D omap36x=
x_vddmpu_volt_data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_voltdm_core.volt_data =3D omap36=
xx_vddcore_volt_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_mpu.vp_param =3D &omap36xx=
_mpu_vp_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_core.vp_param =3D &omap36x=
x_core_vp_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_mpu.vc_param =3D &omap36xx=
_mpu_vc_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_core.vc_param =3D &omap36x=
x_core_vc_data;
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_voltdm_mpu.volt_data =3D omap34x=
x_vddmpu_volt_data;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap3_voltdm_core.volt_data =3D omap34=
xx_vddcore_volt_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_mpu.vp_param =3D &omap34xx=
_mpu_vp_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_core.vp_param =3D &omap34x=
x_core_vp_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_mpu.vc_param =3D &omap34xx=
_mpu_vc_data;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap3_voltdm_core.vc_param =3D &omap34x=
x_core_vc_data;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0for (i =3D 0; voltdm =3D voltagedomains_omap3[i], volt=
dm; i++)
> diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c b/arch/arm=
/mach-omap2/voltagedomains44xx_data.c
> index c4584e9..0a22960 100644
> --- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
> +++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
> @@ -104,6 +104,14 @@ void __init omap44xx_voltagedomains_init(void)
> =A0 =A0 =A0 =A0omap4_voltdm_iva.volt_data =3D omap44xx_vdd_iva_volt_d=
ata;
> =A0 =A0 =A0 =A0omap4_voltdm_core.volt_data =3D omap44xx_vdd_core_volt=
_data;
>
> + =A0 =A0 =A0 omap4_voltdm_mpu.vp_param =3D &omap44xx_mpu_vp_data;
> + =A0 =A0 =A0 omap4_voltdm_iva.vp_param =3D &omap44xx_iva_vp_data;
> + =A0 =A0 =A0 omap4_voltdm_core.vp_param =3D &omap44xx_core_vp_data;
> +
> + =A0 =A0 =A0 omap4_voltdm_mpu.vc_param =3D &omap44xx_mpu_vc_data;
> + =A0 =A0 =A0 omap4_voltdm_iva.vc_param =3D &omap44xx_iva_vc_data;
> + =A0 =A0 =A0 omap4_voltdm_core.vc_param =3D &omap44xx_core_vc_data;
> +
> =A0 =A0 =A0 =A0for (i =3D 0; voltdm =3D voltagedomains_omap4[i], volt=
dm; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0voltdm->sys_clk.name =3D sys_clk_name;
>
> diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> index 66bd700..34bced5 100644
> --- a/arch/arm/mach-omap2/vp.c
> +++ b/arch/arm/mach-omap2/vp.c
> @@ -53,8 +53,8 @@ void __init omap_vp_init(struct voltagedomain *volt=
dm)
> =A0 =A0 =A0 =A0sys_clk_rate =3D voltdm->sys_clk.rate / 1000;
>
> =A0 =A0 =A0 =A0timeout =3D (sys_clk_rate * voltdm->pmic->vp_timeout_u=
s) / 1000;
> - =A0 =A0 =A0 vddmin =3D voltdm->pmic->vp_vddmin;
> - =A0 =A0 =A0 vddmax =3D voltdm->pmic->vp_vddmax;
> + =A0 =A0 =A0 vddmin =3D voltdm->vp_param->vddmin;
> + =A0 =A0 =A0 vddmax =3D voltdm->vp_param->vddmax;
>
> =A0 =A0 =A0 =A0waittime =3D ((voltdm->pmic->step_size / voltdm->pmic-=
>slew_rate) *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sys_clk_rate) / 1000;
> diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-o=
map/include/plat/prcm.h
> index 267f43b..cc19997 100644
> --- a/arch/arm/plat-omap/include/plat/prcm.h
> +++ b/arch/arm/plat-omap/include/plat/prcm.h
> @@ -27,9 +27,16 @@
> =A0#ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
> =A0#define __ASM_ARM_ARCH_OMAP_PRCM_H
>
> +struct omap_osc_data {
> + =A0 =A0 =A0 u32 clk_setup_ret;
> + =A0 =A0 =A0 u32 clk_setup_off;
> +};
> +
> =A0u32 omap_prcm_get_reset_sources(void);
> =A0int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const char *name);
> +void omap_osc_register(struct omap_osc_data *osc);
> +struct omap_osc_data *omap_osc_get(void);
>
> =A0#endif
>
> --


Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
