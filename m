From: Tero Kristo <t-kristo@ti.com>
Subject: RE: [RFC 1/2] OMAP3+: voltage / oscillator parameter segregation
Date: Fri, 5 Aug 2011 10:28:49 +0300
Message-ID: <1312529329.5010.6.camel@sokoban>
References: <1312385355-17029-1-git-send-email-t-kristo@ti.com> <1312385355-17029-2-git-send-email-t-kristo@ti.com> <053aee0d82be0f195b4a9ef1431bbaec@mail.gmail.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44975 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724Ab1HEH2y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Aug 2011 03:28:54 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p757SrjE022327
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:28:53 -0500
Received: from dlep26.itg.ti.com (smtp-le.itg.ti.com [157.170.170.27])
	by dlep34.itg.ti.com (8.13.7/8.13.8) with ESMTP id p757SrRh009232
	for <linux-omap@vger.kernel.org>; Fri, 5 Aug 2011 02:28:53 -0500 (CDT)
Content-Class: urn:content-classes:message
In-Reply-To: <053aee0d82be0f195b4a9ef1431bbaec@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Sripathy, Vishwanath" <vishwanath.bs@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, 2011-08-04 at 15:57 +0200, Sripathy, Vishwanath wrote:
> > 
Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus: 0115040-6. Kotipaikka: Helsinki
 
-----Original Message-----

> > From: Tero Kristo [mailto:t-kristo@ti.com]
> > Sent: Wednesday, August 03, 2011 8:59 PM
> > To: linux-omap@vger.kernel.org
> > Cc: Vishwanath Sripathy
> > Subject: [RFC 1/2] OMAP3+: voltage / oscillator parameter
> > segregation
> >
> > This patch separates board specific voltage and oscillator ramp /
> > setup
> > times from the core code. Things changed:
> >
> > - on/sleep/ret/off voltage setup moved from common twl code to
> >   VC / VP data (oppxxxx_data.c files)
> > - added board support for vdd ramp up / down times
> > - added board support for oscillator setup time declaration
> >
> > Todo: split patch into more easily manageable parts.
> >
> > Applies on top of pm/wip/voltdm branch, based on work done by
> > Vishwanath
> > Sripathy.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
> > ---
> >  arch/arm/mach-omap2/omap_opp_data.h           |   15 +++
> >  arch/arm/mach-omap2/omap_twl.c                |   59 ----------
> >  arch/arm/mach-omap2/opp3xxx_data.c            |   62 ++++++++++
> >  arch/arm/mach-omap2/opp4xxx_data.c            |   47 ++++++++
> >  arch/arm/mach-omap2/prcm.c                    |   11 ++
> >  arch/arm/mach-omap2/prm2xxx_3xxx.c            |    6 +
> >  arch/arm/mach-omap2/prm2xxx_3xxx.h            |    1 +
> >  arch/arm/mach-omap2/prm44xx.c                 |    7 +
> >  arch/arm/mach-omap2/prm44xx.h                 |    1 +
> >  arch/arm/mach-omap2/vc.c                      |  153
> > +++++++++++++++++++++----
> >  arch/arm/mach-omap2/vc.h                      |    1 -
> >  arch/arm/mach-omap2/voltage.c                 |   22 ++++
> >  arch/arm/mach-omap2/voltage.h                 |   55 ++++++++-
> >  arch/arm/mach-omap2/voltagedomains3xxx_data.c |    8 ++
> >  arch/arm/mach-omap2/voltagedomains44xx_data.c |    8 ++
> >  arch/arm/mach-omap2/vp.c                      |    4 +-
> >  arch/arm/plat-omap/include/plat/prcm.h        |    7 +
> >  17 files changed, 377 insertions(+), 90 deletions(-)
> >
> > diff --git a/arch/arm/mach-omap2/omap_opp_data.h b/arch/arm/mach-
> > omap2/omap_opp_data.h
> > index c784c12..b5fe711 100644
> > --- a/arch/arm/mach-omap2/omap_opp_data.h
> > +++ b/arch/arm/mach-omap2/omap_opp_data.h
> > @@ -86,11 +86,26 @@ extern int __init omap_init_opp_table(struct
> > omap_opp_def *opp_def,
> >
> >  extern struct omap_volt_data omap34xx_vddmpu_volt_data[];
> >  extern struct omap_volt_data omap34xx_vddcore_volt_data[];
> > +extern struct omap_vp_param omap34xx_mpu_vp_data;
> > +extern struct omap_vp_param omap34xx_core_vp_data;
> > +extern struct omap_vc_param omap34xx_mpu_vc_data;
> > +extern struct omap_vc_param omap34xx_core_vc_data;
> > +
> >  extern struct omap_volt_data omap36xx_vddmpu_volt_data[];
> >  extern struct omap_volt_data omap36xx_vddcore_volt_data[];
> > +extern struct omap_vp_param omap36xx_mpu_vp_data;
> > +extern struct omap_vp_param omap36xx_core_vp_data;
> > +extern struct omap_vc_param omap36xx_mpu_vc_data;
> > +extern struct omap_vc_param omap36xx_core_vc_data;
> >
> >  extern struct omap_volt_data omap44xx_vdd_mpu_volt_data[];
> >  extern struct omap_volt_data omap44xx_vdd_iva_volt_data[];
> >  extern struct omap_volt_data omap44xx_vdd_core_volt_data[];
> > +extern struct omap_vp_param omap44xx_mpu_vp_data;
> > +extern struct omap_vp_param omap44xx_iva_vp_data;
> > +extern struct omap_vp_param omap44xx_core_vp_data;
> > +extern struct omap_vc_param omap44xx_mpu_vc_data;
> > +extern struct omap_vc_param omap44xx_iva_vc_data;
> > +extern struct omap_vc_param omap44xx_core_vc_data;
> >
> >  #endif               /* __ARCH_ARM_MACH_OMAP2_OMAP_OPP_DATA_H */
> > diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-
> > omap2/omap_twl.c
> > index f515a1a..d239792 100644
> > --- a/arch/arm/mach-omap2/omap_twl.c
> > +++ b/arch/arm/mach-omap2/omap_twl.c
> > @@ -30,16 +30,6 @@
> >  #define OMAP3_VP_VSTEPMAX_VSTEPMAX   0x04
> >  #define OMAP3_VP_VLIMITTO_TIMEOUT_US 200
> >
> > -#define OMAP3430_VP1_VLIMITTO_VDDMIN 0x14
> > -#define OMAP3430_VP1_VLIMITTO_VDDMAX 0x42
> > -#define OMAP3430_VP2_VLIMITTO_VDDMIN 0x18
> > -#define OMAP3430_VP2_VLIMITTO_VDDMAX 0x2c
> > -
> > -#define OMAP3630_VP1_VLIMITTO_VDDMIN 0x18
> > -#define OMAP3630_VP1_VLIMITTO_VDDMAX 0x3c
> > -#define OMAP3630_VP2_VLIMITTO_VDDMIN 0x18
> > -#define OMAP3630_VP2_VLIMITTO_VDDMAX 0x30
> > -
> >  #define OMAP4_SRI2C_SLAVE_ADDR               0x12
> >  #define OMAP4_VDD_MPU_SR_VOLT_REG    0x55
> >  #define OMAP4_VDD_MPU_SR_CMD_REG     0x56
> > @@ -53,13 +43,6 @@
> >  #define OMAP4_VP_VSTEPMAX_VSTEPMAX   0x04
> >  #define OMAP4_VP_VLIMITTO_TIMEOUT_US 200
> >
> > -#define OMAP4_VP_MPU_VLIMITTO_VDDMIN 0xA
> > -#define OMAP4_VP_MPU_VLIMITTO_VDDMAX 0x39
> > -#define OMAP4_VP_IVA_VLIMITTO_VDDMIN 0xA
> > -#define OMAP4_VP_IVA_VLIMITTO_VDDMAX 0x2D
> > -#define OMAP4_VP_CORE_VLIMITTO_VDDMIN        0xA
> > -#define OMAP4_VP_CORE_VLIMITTO_VDDMAX        0x28
> > -
> >  static bool is_offset_valid;
> >  static u8 smps_offset;
> >  /*
> > @@ -158,16 +141,9 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
> >  static struct omap_voltdm_pmic omap3_mpu_pmic = {
> >       .slew_rate              = 4000,
> >       .step_size              = 12500,
> > -     .on_volt                = 1200000,
> > -     .onlp_volt              = 1000000,
> > -     .ret_volt               = 975000,
> > -     .off_volt               = 600000,
> > -     .volt_setup_time        = 0xfff,
> >       .vp_erroroffset         = OMAP3_VP_CONFIG_ERROROFFSET,
> >       .vp_vstepmin            = OMAP3_VP_VSTEPMIN_VSTEPMIN,
> >       .vp_vstepmax            = OMAP3_VP_VSTEPMAX_VSTEPMAX,
> > -     .vp_vddmin              = OMAP3430_VP1_VLIMITTO_VDDMIN,
> > -     .vp_vddmax              = OMAP3430_VP1_VLIMITTO_VDDMAX,
> Each of PMIC has it's own min and max allowed voltage. So you probably
> would need some parameter to keep that info. Also VP shold be configured
> which falls within OMAP Limit and PMIC Limit.

Ok, that makes sense. I was actually wondering why that part of the code
was like it was.

> >       .vp_timeout_us          = OMAP3_VP_VLIMITTO_TIMEOUT_US,
> >       .i2c_slave_addr         = OMAP3_SRI2C_SLAVE_ADDR,
> >       .volt_reg_addr          = OMAP3_VDD_MPU_SR_CONTROL_REG,
> > @@ -179,16 +155,9 @@ static struct omap_voltdm_pmic omap3_mpu_pmic =
> > {
> >  static struct omap_voltdm_pmic omap3_core_pmic = {
> >       .slew_rate              = 4000,
> >       .step_size              = 12500,
> > -     .on_volt                = 1200000,
> > -     .onlp_volt              = 1000000,
> > -     .ret_volt               = 975000,
> > -     .off_volt               = 600000,
> > -     .volt_setup_time        = 0xfff,
> >       .vp_erroroffset         = OMAP3_VP_CONFIG_ERROROFFSET,
> >       .vp_vstepmin            = OMAP3_VP_VSTEPMIN_VSTEPMIN,
> >       .vp_vstepmax            = OMAP3_VP_VSTEPMAX_VSTEPMAX,
> > -     .vp_vddmin              = OMAP3430_VP2_VLIMITTO_VDDMIN,
> > -     .vp_vddmax              = OMAP3430_VP2_VLIMITTO_VDDMAX,
> >       .vp_timeout_us          = OMAP3_VP_VLIMITTO_TIMEOUT_US,
> >       .i2c_slave_addr         = OMAP3_SRI2C_SLAVE_ADDR,
> >       .volt_reg_addr          = OMAP3_VDD_CORE_SR_CONTROL_REG,
> > @@ -200,16 +169,9 @@ static struct omap_voltdm_pmic omap3_core_pmic
> > = {
> >  static struct omap_voltdm_pmic omap4_mpu_pmic = {
> >       .slew_rate              = 4000,
> >       .step_size              = 12660,
> > -     .on_volt                = 1375000,
> > -     .onlp_volt              = 1375000,
> > -     .ret_volt               = 830000,
> > -     .off_volt               = 0,
> > -     .volt_setup_time        = 0,
> >       .vp_erroroffset         = OMAP4_VP_CONFIG_ERROROFFSET,
> >       .vp_vstepmin            = OMAP4_VP_VSTEPMIN_VSTEPMIN,
> >       .vp_vstepmax            = OMAP4_VP_VSTEPMAX_VSTEPMAX,
> > -     .vp_vddmin              = OMAP4_VP_MPU_VLIMITTO_VDDMIN,
> > -     .vp_vddmax              = OMAP4_VP_MPU_VLIMITTO_VDDMAX,
> >       .vp_timeout_us          = OMAP4_VP_VLIMITTO_TIMEOUT_US,
> >       .i2c_slave_addr         = OMAP4_SRI2C_SLAVE_ADDR,
> >       .volt_reg_addr          = OMAP4_VDD_MPU_SR_VOLT_REG,
> > @@ -222,16 +184,9 @@ static struct omap_voltdm_pmic omap4_mpu_pmic =
> > {
> >  static struct omap_voltdm_pmic omap4_iva_pmic = {
> >       .slew_rate              = 4000,
> >       .step_size              = 12660,
> > -     .on_volt                = 1188000,
> > -     .onlp_volt              = 1188000,
> > -     .ret_volt               = 830000,
> > -     .off_volt               = 0,
> > -     .volt_setup_time        = 0,
> >       .vp_erroroffset         = OMAP4_VP_CONFIG_ERROROFFSET,
> >       .vp_vstepmin            = OMAP4_VP_VSTEPMIN_VSTEPMIN,
> >       .vp_vstepmax            = OMAP4_VP_VSTEPMAX_VSTEPMAX,
> > -     .vp_vddmin              = OMAP4_VP_IVA_VLIMITTO_VDDMIN,
> > -     .vp_vddmax              = OMAP4_VP_IVA_VLIMITTO_VDDMAX,
> >       .vp_timeout_us          = OMAP4_VP_VLIMITTO_TIMEOUT_US,
> >       .i2c_slave_addr         = OMAP4_SRI2C_SLAVE_ADDR,
> >       .volt_reg_addr          = OMAP4_VDD_IVA_SR_VOLT_REG,
> > @@ -244,16 +199,9 @@ static struct omap_voltdm_pmic omap4_iva_pmic =
> > {
> >  static struct omap_voltdm_pmic omap4_core_pmic = {
> >       .slew_rate              = 4000,
> >       .step_size              = 12660,
> > -     .on_volt                = 1200000,
> > -     .onlp_volt              = 1200000,
> > -     .ret_volt               = 830000,
> > -     .off_volt               = 0,
> > -     .volt_setup_time        = 0,
> >       .vp_erroroffset         = OMAP4_VP_CONFIG_ERROROFFSET,
> >       .vp_vstepmin            = OMAP4_VP_VSTEPMIN_VSTEPMIN,
> >       .vp_vstepmax            = OMAP4_VP_VSTEPMAX_VSTEPMAX,
> > -     .vp_vddmin              = OMAP4_VP_CORE_VLIMITTO_VDDMIN,
> > -     .vp_vddmax              = OMAP4_VP_CORE_VLIMITTO_VDDMAX,
> >       .vp_timeout_us          = OMAP4_VP_VLIMITTO_TIMEOUT_US,
> >       .i2c_slave_addr         = OMAP4_SRI2C_SLAVE_ADDR,
> >       .volt_reg_addr          = OMAP4_VDD_CORE_SR_VOLT_REG,
> > @@ -288,13 +236,6 @@ int __init omap3_twl_init(void)
> >       if (!cpu_is_omap34xx())
> >               return -ENODEV;
> >
> > -     if (cpu_is_omap3630()) {
> > -             omap3_mpu_pmic.vp_vddmin = OMAP3630_VP1_VLIMITTO_VDDMIN;
> > -             omap3_mpu_pmic.vp_vddmax = OMAP3630_VP1_VLIMITTO_VDDMAX;
> > -             omap3_core_pmic.vp_vddmin =
> > OMAP3630_VP2_VLIMITTO_VDDMIN;
> > -             omap3_core_pmic.vp_vddmax =
> > OMAP3630_VP2_VLIMITTO_VDDMAX;
> > -     }
> > -
> >       /*
> >        * The smartreflex bit on twl4030 specifies if the setting of
> > voltage
> >        * is done over the I2C_SR path. Since this setting is
> > independent of
> > diff --git a/arch/arm/mach-omap2/opp3xxx_data.c b/arch/arm/mach-
> > omap2/opp3xxx_data.c
> > index d95f3f9..b5d8294 100644
> > --- a/arch/arm/mach-omap2/opp3xxx_data.c
> > +++ b/arch/arm/mach-omap2/opp3xxx_data.c
> > @@ -26,6 +26,16 @@
> >  #include "pm.h"
> >
> >  /* 34xx */
> > +/* OMAP VP parameter values */
> > +#define OMAP3430_VP1_VLIMITTO_VDDMIN 0x14
> > +#define OMAP3430_VP1_VLIMITTO_VDDMAX 0x42
> > +#define OMAP3430_VP2_VLIMITTO_VDDMIN 0x18
> > +#define OMAP3430_VP2_VLIMITTO_VDDMAX 0x2c
> > +
> > +#define OMAP3_ON_VOLTAGE_UV          1200000
> > +#define OMAP3_ONLP_VOLTAGE_UV                1000000
> > +#define OMAP3_RET_VOLTAGE_UV         975000
> > +#define OMAP3_OFF_VOLTAGE_UV         600000
> >
> >  /* VDD1 */
> >
> > @@ -44,6 +54,18 @@ struct omap_volt_data omap34xx_vddmpu_volt_data[]
> > = {
> >       VOLT_DATA_DEFINE(0, 0, 0, 0),
> >  };
> >
> > +struct omap_vp_param omap34xx_mpu_vp_data = {
> > +     .vddmin                 = OMAP3430_VP1_VLIMITTO_VDDMIN,
> > +     .vddmax                 = OMAP3430_VP1_VLIMITTO_VDDMAX,
> > +};
> > +
> > +struct omap_vc_param omap34xx_mpu_vc_data = {
> > +     .on             = OMAP3_ON_VOLTAGE_UV,
> > +     .onlp           = OMAP3_ONLP_VOLTAGE_UV,
> > +     .ret            = OMAP3_RET_VOLTAGE_UV,
> > +     .off            = OMAP3_OFF_VOLTAGE_UV,
> > +};
> > +
> >  /* VDD2 */
> >
> >  #define OMAP3430_VDD_CORE_OPP1_UV            975000
> > @@ -57,7 +79,23 @@ struct omap_volt_data
> > omap34xx_vddcore_volt_data[] = {
> >       VOLT_DATA_DEFINE(0, 0, 0, 0),
> >  };
> >
> > +struct omap_vp_param omap34xx_core_vp_data = {
> > +     .vddmin                 = OMAP3430_VP2_VLIMITTO_VDDMIN,
> > +     .vddmax                 = OMAP3430_VP2_VLIMITTO_VDDMAX,
> > +};
> > +
> > +struct omap_vc_param omap34xx_core_vc_data = {
> > +     .on             = OMAP3_ON_VOLTAGE_UV,
> > +     .onlp           = OMAP3_ONLP_VOLTAGE_UV,
> > +     .ret            = OMAP3_RET_VOLTAGE_UV,
> > +     .off            = OMAP3_OFF_VOLTAGE_UV,
> > +};
> > +
> >  /* 36xx */
> > +#define OMAP3630_VP1_VLIMITTO_VDDMIN 0x18
> > +#define OMAP3630_VP1_VLIMITTO_VDDMAX 0x3c
> > +#define OMAP3630_VP2_VLIMITTO_VDDMIN 0x18
> > +#define OMAP3630_VP2_VLIMITTO_VDDMAX 0x30
> >
> >  /* VDD1 */
> >
> > @@ -74,6 +112,18 @@ struct omap_volt_data
> > omap36xx_vddmpu_volt_data[] = {
> >       VOLT_DATA_DEFINE(0, 0, 0, 0),
> >  };
> >
> > +struct omap_vp_param omap36xx_mpu_vp_data = {
> > +     .vddmin                 = OMAP3630_VP1_VLIMITTO_VDDMIN,
> > +     .vddmax                 = OMAP3630_VP1_VLIMITTO_VDDMAX,
> > +};
> > +
> > +struct omap_vc_param omap36xx_mpu_vc_data = {
> > +     .on             = OMAP3_ON_VOLTAGE_UV,
> > +     .onlp           = OMAP3_ONLP_VOLTAGE_UV,
> > +     .ret            = OMAP3_RET_VOLTAGE_UV,
> > +     .off            = OMAP3_OFF_VOLTAGE_UV,
> > +};
> > +
> >  /* VDD2 */
> >
> >  #define OMAP3630_VDD_CORE_OPP50_UV           1000000
> > @@ -85,6 +135,18 @@ struct omap_volt_data
> > omap36xx_vddcore_volt_data[] = {
> >       VOLT_DATA_DEFINE(0, 0, 0, 0),
> >  };
> >
> > +struct omap_vp_param omap36xx_core_vp_data = {
> > +     .vddmin                 = OMAP3630_VP2_VLIMITTO_VDDMIN,
> > +     .vddmax                 = OMAP3630_VP2_VLIMITTO_VDDMAX,
> > +};
> > +
> > +struct omap_vc_param omap36xx_core_vc_data = {
> > +     .on             = OMAP3_ON_VOLTAGE_UV,
> > +     .onlp           = OMAP3_ONLP_VOLTAGE_UV,
> > +     .ret            = OMAP3_RET_VOLTAGE_UV,
> > +     .off            = OMAP3_OFF_VOLTAGE_UV,
> > +};
> > +
> >  /* OPP data */
> >
> >  static struct omap_opp_def __initdata omap34xx_opp_def_list[] = {
> > diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-
> > omap2/opp4xxx_data.c
> > index 2293ba2..59f695b 100644
> > --- a/arch/arm/mach-omap2/opp4xxx_data.c
> > +++ b/arch/arm/mach-omap2/opp4xxx_data.c
> > @@ -31,6 +31,18 @@
> >   * voltage dependent data for each VDD.
> >   */
> >
> > +#define OMAP4_VP_MPU_VLIMITTO_VDDMIN         0x0a
> > +#define OMAP4_VP_MPU_VLIMITTO_VDDMAX         0x39
> > +#define OMAP4_VP_IVA_VLIMITTO_VDDMIN         0x0a
> > +#define OMAP4_VP_IVA_VLIMITTO_VDDMAX         0x2d
> > +#define OMAP4_VP_CORE_VLIMITTO_VDDMIN                0x0a
> > +#define OMAP4_VP_CORE_VLIMITTO_VDDMAX                0x28
> > +
> > +#define OMAP4_ON_VOLTAGE_UV                  1350000
> > +#define OMAP4_ONLP_VOLTAGE_UV                        1350000
> > +#define OMAP4_RET_VOLTAGE_UV                 837500
> > +#define OMAP4_OFF_VOLTAGE_UV                 600000
> > +
> >  #define OMAP4430_VDD_MPU_OPP50_UV            1025000
> >  #define OMAP4430_VDD_MPU_OPP100_UV           1200000
> >  #define OMAP4430_VDD_MPU_OPPTURBO_UV         1313000
> > @@ -44,6 +56,18 @@ struct omap_volt_data
> > omap44xx_vdd_mpu_volt_data[] = {
> >       VOLT_DATA_DEFINE(0, 0, 0, 0),
> >  };
> >
> > +struct omap_vp_param omap44xx_mpu_vp_data = {
> > +     .vddmin                 = OMAP4_VP_MPU_VLIMITTO_VDDMIN,
> > +     .vddmax                 = OMAP4_VP_MPU_VLIMITTO_VDDMAX,
> > +};
> > +
> > +struct omap_vc_param omap44xx_mpu_vc_data = {
> > +     .on                     = OMAP4_ON_VOLTAGE_UV,
> > +     .onlp                   = OMAP4_ONLP_VOLTAGE_UV,
> > +     .ret                    = OMAP4_RET_VOLTAGE_UV,
> > +     .off                    = OMAP4_OFF_VOLTAGE_UV,
> > +};
> > +
> >  #define OMAP4430_VDD_IVA_OPP50_UV            1013000
> >  #define OMAP4430_VDD_IVA_OPP100_UV           1188000
> >  #define OMAP4430_VDD_IVA_OPPTURBO_UV         1300000
> > @@ -55,6 +79,18 @@ struct omap_volt_data
> > omap44xx_vdd_iva_volt_data[] = {
> >       VOLT_DATA_DEFINE(0, 0, 0, 0),
> >  };
> >
> > +struct omap_vp_param omap44xx_iva_vp_data = {
> > +     .vddmin                 = OMAP4_VP_IVA_VLIMITTO_VDDMIN,
> > +     .vddmax                 = OMAP4_VP_IVA_VLIMITTO_VDDMAX,
> > +};
> > +
> > +struct omap_vc_param omap44xx_iva_vc_data = {
> > +     .on                     = OMAP4_ON_VOLTAGE_UV,
> > +     .onlp                   = OMAP4_ONLP_VOLTAGE_UV,
> > +     .ret                    = OMAP4_RET_VOLTAGE_UV,
> > +     .off                    = OMAP4_OFF_VOLTAGE_UV,
> > +};
> > +
> >  #define OMAP4430_VDD_CORE_OPP50_UV           1025000
> >  #define OMAP4430_VDD_CORE_OPP100_UV          1200000
> >
> > @@ -64,6 +100,17 @@ struct omap_volt_data
> > omap44xx_vdd_core_volt_data[] = {
> >       VOLT_DATA_DEFINE(0, 0, 0, 0),
> >  };
> >
> > +struct omap_vp_param omap44xx_core_vp_data = {
> > +     .vddmin                 = OMAP4_VP_CORE_VLIMITTO_VDDMIN,
> > +     .vddmax                 = OMAP4_VP_CORE_VLIMITTO_VDDMAX,
> > +};
> > +
> > +struct omap_vc_param omap44xx_core_vc_data = {
> > +     .on                     = OMAP4_ON_VOLTAGE_UV,
> > +     .onlp                   = OMAP4_ONLP_VOLTAGE_UV,
> > +     .ret                    = OMAP4_RET_VOLTAGE_UV,
> > +     .off                    = OMAP4_OFF_VOLTAGE_UV,
> > +};
> >
> >  static struct omap_opp_def __initdata omap44xx_opp_def_list[] = {
> >       /* MPU OPP1 - OPP50 */
> > diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
> > index 2e40a5c..5d94e91 100644
> > --- a/arch/arm/mach-omap2/prcm.c
> > +++ b/arch/arm/mach-omap2/prcm.c
> > @@ -42,6 +42,7 @@
> >  void __iomem *prm_base;
> >  void __iomem *cm_base;
> >  void __iomem *cm2_base;
> > +static struct omap_osc_data *osc_setup;
> >
> >  #define MAX_MODULE_ENABLE_WAIT               100000
> >
> > @@ -165,3 +166,13 @@ void __init omap2_set_globals_prcm(struct
> > omap_globals *omap2_globals)
> >               WARN_ON(!cm2_base);
> >       }
> >  }
> > +
> > +void __init omap_osc_register(struct omap_osc_data *osc)
> > +{
> > +     osc_setup = osc;
> > +}
> > +
> > +struct omap_osc_data *omap_osc_get(void)
> > +{
> > +     return osc_setup;
> > +}
> > diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-
> > omap2/prm2xxx_3xxx.c
> > index 3b83763..2c678e9 100644
> > --- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
> > +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
> > @@ -212,3 +212,9 @@ u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8
> > offset)
> >  {
> >       return omap2_prm_rmw_mod_reg_bits(mask, bits, OMAP3430_GR_MOD,
> > offset);
> >  }
> > +
> > +void omap3_prm_set_clksetup(unsigned long clksetup)
> > +{
> > +     clksetup = clksetup * 32768 / (1000 * 1000) + 1;
> > +     omap3_prm_vcvp_write(clksetup, OMAP3_PRM_CLKSETUP_OFFSET);
> > +}
> > diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-
> > omap2/prm2xxx_3xxx.h
> > index cef533d..32740a0 100644
> > --- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
> > +++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
> > @@ -314,6 +314,7 @@ void omap3_prm_vp_clear_txdone(u8 vp_id);
> >  extern u32 omap3_prm_vcvp_read(u8 offset);
> >  extern void omap3_prm_vcvp_write(u32 val, u8 offset);
> >  extern u32 omap3_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
> > +extern void omap3_prm_set_clksetup(unsigned long clksetup);
> >  #endif       /* CONFIG_ARCH_OMAP4 */
> >
> >  #endif
> > diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-
> > omap2/prm44xx.c
> > index 495a31a..c91c66f 100644
> > --- a/arch/arm/mach-omap2/prm44xx.c
> > +++ b/arch/arm/mach-omap2/prm44xx.c
> > @@ -26,6 +26,7 @@
> >  #include "prm-regbits-44xx.h"
> >  #include "prcm44xx.h"
> >  #include "prminst44xx.h"
> > +#include "scrm44xx.h"
> >
> >  /* PRM low-level functions */
> >
> > @@ -121,3 +122,9 @@ u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8
> > offset)
> >                                              OMAP4430_PRM_DEVICE_INST,
> >                                              offset);
> >  }
> > +
> > +void omap4_prm_set_clksetup(unsigned long clksetup)
> > +{
> > +     clksetup = clksetup * 32768 / (1000 * 1000) + 1;
> > +     __raw_writel(clksetup, OMAP4_SCRM_CLKSETUPTIME);
> > +}
> > diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-
> > omap2/prm44xx.h
> > index 3d66ccd..9b21f33 100644
> > --- a/arch/arm/mach-omap2/prm44xx.h
> > +++ b/arch/arm/mach-omap2/prm44xx.h
> > @@ -762,6 +762,7 @@ void omap4_prm_vp_clear_txdone(u8 vp_id);
> >  extern u32 omap4_prm_vcvp_read(u8 offset);
> >  extern void omap4_prm_vcvp_write(u32 val, u8 offset);
> >  extern u32 omap4_prm_vcvp_rmw(u32 mask, u32 bits, u8 offset);
> > +extern void omap4_prm_set_clksetup(unsigned long clksetup);
> >
> >  # endif
> >
> > diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> > index 16fa912..8bbc95a 100644
> > --- a/arch/arm/mach-omap2/vc.c
> > +++ b/arch/arm/mach-omap2/vc.c
> > @@ -1,14 +1,18 @@
> >  #include <linux/kernel.h>
> >  #include <linux/delay.h>
> >  #include <linux/init.h>
> > +#include <linux/clk.h>
> > +#include <linux/io.h>
> >
> >  #include <plat/cpu.h>
> > +#include <plat/prcm.h>
> >
> >  #include "voltage.h"
> >  #include "vc.h"
> >  #include "prm-regbits-34xx.h"
> >  #include "prm-regbits-44xx.h"
> >  #include "prm44xx.h"
> > +#include "scrm44xx.h"
> >
> >  /**
> >   * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
> > @@ -196,42 +200,153 @@ int omap_vc_bypass_scale(struct voltagedomain
> > *voltdm,
> >
> >  static void __init omap3_vfsm_init(struct voltagedomain *voltdm)
> >  {
> > +     unsigned long clksetup;
> > +     unsigned long voltsetup2;
> > +     struct omap_osc_data *osc;
> >       /*
> >        * Voltage Manager FSM parameters init
> >        * XXX This data should be passed in from the board file
> >        */
> > -     voltdm->write(OMAP3_CLKSETUP, OMAP3_PRM_CLKSETUP_OFFSET);
> > -     voltdm->write(OMAP3_VOLTOFFSET, OMAP3_PRM_VOLTOFFSET_OFFSET);
> > -     voltdm->write(OMAP3_VOLTSETUP2, OMAP3_PRM_VOLTSETUP2_OFFSET);
> > +     osc = omap_osc_get();
> > +     if (osc) {
> > +             clksetup = osc->clk_setup_off;
> > +             omap3_prm_set_clksetup(clksetup);
> > +     }
> > +
> > +     clksetup = voltdm->read(OMAP3_PRM_CLKSETUP_OFFSET);
> > +
> > +     voltsetup2 = voltdm->board_data->vdd_setup_off.ramp_up;
> > +     voltsetup2 = voltsetup2 * 32768 / (1000 * 1000) + 1;
> > +     voltdm->write(voltsetup2, OMAP3_PRM_VOLTSETUP2_OFFSET);
> > +
> > +     voltdm->write(clksetup - voltsetup2,
> > OMAP3_PRM_VOLTOFFSET_OFFSET);
> >  }
> >
> >  static void __init omap3_vc_init_channel(struct voltagedomain
> > *voltdm)
> >  {
> > -     static bool is_initialized;
> > +     unsigned long temp;
> > +     struct clk *sys_ck;
> > +     u32 sys_clk_rate;
> >
> > -     if (is_initialized)
> > +     if (!voltdm->board_data) {
> > +             pr_warning("%s: no voltdm board data for %s\n", __func__,
> > +                     voltdm->name);
> >               return;
> > +     }
> >
> > -     omap3_vfsm_init(voltdm);
> > +     sys_ck = clk_get(NULL, "sys_ck");
> > +     if (IS_ERR(sys_ck)) {
> > +             pr_warning("%s: could not get the sys clk to calculate "
> > +                     "various vdd_%s params\n", __func__, voltdm-
> > >name);
> > +             return;
> > +     }
> > +     sys_clk_rate = clk_get_rate(sys_ck);
> > +     clk_put(sys_ck);
> > +     /* Divide to avoid overflow */
> > +     sys_clk_rate /= 1000000;
> > +
> > +     temp = voltdm->board_data->vdd_setup_off.ramp_up;
> > +     temp = temp * sys_clk_rate / 8;
> > +
> > +     /* Configure the setup times */
> > +     voltdm->rmw(voltdm->vfsm->voltsetup_mask,
> > +                 temp << __ffs(voltdm->vfsm->voltsetup_mask),
> > +                 voltdm->vfsm->voltsetup_reg);
> >
> > -     is_initialized = true;
> > +     omap3_vfsm_init(voltdm);
> >  }
> >
> > +static u32 omap4_calc_volt_ramp(u32 time, u32 clk_rate)
> > +{
> > +     u32 prescaler;
> > +     u32 cycles;
> > +
> > +     cycles = clk_rate / 1000 * time;
> > +
> > +     cycles /= 64;
> > +     prescaler = 0;
> > +
> > +     /* shift to next prescaler until no overflow */
> > +
> > +     /* scale for div 256 = 64 * 4 */
> > +     if (cycles > 63) {
> > +             cycles /= 4;
> > +             prescaler++;
> > +     }
> > +
> > +     /* scale for div 512 = 256 * 2 */
> > +     if (cycles > 63) {
> > +             cycles /= 2;
> > +             prescaler++;
> > +     }
> > +
> > +     /* scale for div 2048 = 512 * 4 */
> > +     if (cycles > 63) {
> > +             cycles /= 4;
> > +             prescaler++;
> > +     }
> > +
> > +     /* check for overflow => invalid ramp time */
> > +     if (cycles > 63)
> > +             return 0;
> > +
> > +     cycles++;
> > +
> > +     return (prescaler << OMAP4430_RAMP_UP_PRESCAL_SHIFT) |
> > +             (cycles << OMAP4430_RAMP_UP_COUNT_SHIFT);
> > +}
> >
> >  /* OMAP4 specific voltage init functions */
> >  static void __init omap4_vc_init_channel(struct voltagedomain
> > *voltdm)
> >  {
> > -     static bool is_initialized;
> Why is this removed?

Each VDD channel has its own settings for the ramp-up / ramp-down times.
Previously only one channel was configured, now we configure them all.
Same thing for OMAP3.

> > -     u32 vc_val;
> > +     u32 vc_val, temp;
> > +     struct clk *sys_ck;
> > +     u32 sys_clk_rate;
> > +     unsigned long val;
> > +     struct omap_osc_data *osc;
> > +
> > +     sys_ck = clk_get(NULL, "sys_clkin_ck");
> > +     if (IS_ERR(sys_ck)) {
> > +             pr_warning("%s: Could not get sys clk to calculate "
> > +                     "various vdd_%s params\n", __func__, voltdm-
> > >name);
> > +             return;
> > +     }
> > +     sys_clk_rate = clk_get_rate(sys_ck);
> > +     clk_put(sys_ck);
> >
> > -     if (is_initialized)
> > +     /* Configure the setup times */
> > +     vc_val = voltdm->read(voltdm->vfsm->voltsetup_reg);
> > +
> > +     temp = omap4_calc_volt_ramp(voltdm->board_data-
> > >vdd_setup_off.ramp_down,
> > +                                 sys_clk_rate);
> > +     if (!temp) {
> > +             pr_warning("%s: Invalid VoltOff setup time for vdd%s\n",
> > +                     __func__, voltdm->name);
> >               return;
> > +     }
> > +     vc_val |= temp << OMAP4430_RAMP_DOWN_COUNT_SHIFT;
> > +
> > +     temp = omap4_calc_volt_ramp(voltdm->board_data-
> > >vdd_setup_off.ramp_up,
> > +                                 sys_clk_rate);
> > +     if (!temp) {
> > +             pr_warning("%s: Invalid VoltOff setup time for vdd%s\n",
> > +                     __func__, voltdm->name);
> > +             return;
> > +     }
> > +     vc_val |= temp << OMAP4430_RAMP_UP_COUNT_SHIFT;
> > +
> > +     voltdm->write(vc_val, voltdm->vfsm->voltsetup_reg);
> > +
> > +     osc = omap_osc_get();
> > +
> > +     if (osc) {
> > +             val = osc->clk_setup_off;
> > +             omap4_prm_set_clksetup(val);
> > +     }
> >
> >       /* XXX These are magic numbers and do not belong! */
> >       vc_val = (0x60 << OMAP4430_SCLL_SHIFT | 0x26 <<
> > OMAP4430_SCLH_SHIFT);
> >       voltdm->write(vc_val, OMAP4_PRM_VC_CFG_I2C_CLK_OFFSET);
> > -
> > -     is_initialized = true;
> >  }
> >
> >  /**
> > @@ -305,7 +420,6 @@ void __init omap_vc_init_channel(struct
> > voltagedomain *voltdm)
> >       vc->i2c_slave_addr = voltdm->pmic->i2c_slave_addr;
> >       vc->volt_reg_addr = voltdm->pmic->volt_reg_addr;
> >       vc->cmd_reg_addr = voltdm->pmic->cmd_reg_addr;
> > -     vc->setup_time = voltdm->pmic->volt_setup_time;
> >
> >       /* Configure the i2c slave address for this VC */
> >       voltdm->rmw(vc->smps_sa_mask,
> > @@ -329,10 +443,10 @@ void __init omap_vc_init_channel(struct
> > voltagedomain *voltdm)
> >       }
> >
> >       /* Set up the on, inactive, retention and off voltage */
> > -     on_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->on_volt);
> > -     onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->onlp_volt);
> > -     ret_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->ret_volt);
> > -     off_vsel = voltdm->pmic->uv_to_vsel(voltdm->pmic->off_volt);
> > +     on_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->on);
> > +     onlp_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->onlp);
> > +     ret_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->ret);
> > +     off_vsel = voltdm->pmic->uv_to_vsel(voltdm->vc_param->off);
> >       val = ((on_vsel << vc->common->cmd_on_shift) |
> >              (onlp_vsel << vc->common->cmd_onlp_shift) |
> >              (ret_vsel << vc->common->cmd_ret_shift) |
> > @@ -343,11 +457,6 @@ void __init omap_vc_init_channel(struct
> > voltagedomain *voltdm)
> >       /* Channel configuration */
> >       omap_vc_config_channel(voltdm);
> >
> > -     /* Configure the setup times */
> > -     voltdm->rmw(voltdm->vfsm->voltsetup_mask,
> > -                 vc->setup_time << __ffs(voltdm->vfsm-
> > >voltsetup_mask),
> > -                 voltdm->vfsm->voltsetup_reg);
> > -
> >       omap_vc_i2c_init(voltdm);
> >
> >       if (cpu_is_omap34xx())
> > diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
> > index ec50643..e6fdd23 100644
> > --- a/arch/arm/mach-omap2/vc.h
> > +++ b/arch/arm/mach-omap2/vc.h
> > @@ -80,7 +80,6 @@ struct omap_vc_channel {
> >       u16 i2c_slave_addr;
> >       u16 volt_reg_addr;
> >       u16 cmd_reg_addr;
> > -     u16 setup_time;
> >       u8 cfg_channel;
> >       bool i2c_high_speed;
> >
> > diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-
> > omap2/voltage.c
> > index cebc8b1..a95d2dd4 100644
> > --- a/arch/arm/mach-omap2/voltage.c
> > +++ b/arch/arm/mach-omap2/voltage.c
> > @@ -428,3 +428,25 @@ void voltdm_init(struct voltagedomain
> > **voltdms)
> >                       _voltdm_register(*v);
> >       }
> >  }
> > +
> > +/**
> > + * omap_voltage_register_board_params - set board values for a
> > voltagedomain
> > + * @voltdm: voltagedomain whose parameters should be set
> > + * @board_params: board parameters for voltagedomain
> > + *
> > + * Sets up board parameters for a voltagedomain. These include the
> > ramp up
> > + * and ramp down times for the domain. Return 0 for success, -
> > EINVAL for
> > + * invalid voltagedomain.
> > + */
> > +int omap_voltage_register_board_params(struct voltagedomain *voltdm,
> > +     struct omap_volt_board_data *board_params)
> > +{
> > +     if (!voltdm || IS_ERR(voltdm)) {
> > +             pr_warning("%s: VDD specified does not exist!\n",
> > __func__);
> > +             return -EINVAL;
> > +     }
> > +
> > +     voltdm->board_data = board_params;
> > +
> > +     return 0;
> > +}
> > diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-
> > omap2/voltage.h
> > index b4c6259..e4b9e0e 100644
> > --- a/arch/arm/mach-omap2/voltage.h
> > +++ b/arch/arm/mach-omap2/voltage.h
> > @@ -70,6 +70,9 @@ struct voltagedomain {
> >       const struct omap_vfsm_instance *vfsm;
> >       struct omap_vp_instance *vp;
> >       struct omap_voltdm_pmic *pmic;
> > +     struct omap_vp_param *vp_param;
> > +     struct omap_vc_param *vc_param;
> > +     struct omap_volt_board_data *board_data;
> >
> >       /* VC/VP register access functions: SoC specific */
> >       u32 (*read) (u8 offset);
> > @@ -89,6 +92,28 @@ struct voltagedomain {
> >  };
> >
> >  /**
> > + * omap_vdd_setuptime - vdd set up time info
> > + * @ramp_up    : VDD ramp up time in us
> > + * @ramp_down  : VDD ramp down time in us, not used in OMAP3
> > + * @clksetup   : setup time of the oscillator system clock
> > (sys_clk) in us
> OMAP4 also has pmic set up time. You probably need to account that as
> well.

Ok, need to take a look at this.

> > + */
> > +struct omap_vdd_setuptime {
> > +     u16 ramp_up;
> > +     u16 ramp_down;
> > +     u16 clksetup;
> > +};
> > +
> > +/**
> > + * omap_volt_board_data - vdd set up time
> > + * @vdd_setup_ret      : VDD setup time for retention mode
> Can't this be calculated dynamically based on number of voltage steps
> required for ramp and pmic slew rate? Basically ((on_voltage -
> retention_voltage) / step_size) * slew_rate?
> 
> I think we should be able to calculate all the timing settings based on
> below parameters
> 1. oscillator ramp up/ramp down delay (part of board parameter)
> 2. PMIC slew rate (part of pmic data)
> 3. PMIC sleep/activation delay (also part of pmic data)
> 
> > + * @vdd_setup_off      : VDD setup time for off mode
> Similarly here?

Hmm, I think you are right. Measured voltage ramp up/down values are
usually shorter than what is said in datasheet, thus we should most
likely go for the datasheet values. I'll take a look at this also.

> 
> Vishwa
> > + */
> > +struct omap_volt_board_data {
> > +     struct omap_vdd_setuptime vdd_setup_ret;
> > +     struct omap_vdd_setuptime vdd_setup_off;
> > +};
> > +
> > +/**
> >   * struct omap_volt_data - Omap voltage specific data.
> >   * @voltage_nominal: The possible voltage value in uV
> >   * @sr_efuse_offs:   The offset of the efuse register(from system
> > @@ -119,10 +148,6 @@ struct omap_volt_data {
> >  struct omap_voltdm_pmic {
> >       int slew_rate;
> >       int step_size;
> > -     u32 on_volt;
> > -     u32 onlp_volt;
> > -     u32 ret_volt;
> > -     u32 off_volt;
> >       u16 volt_setup_time;
> >       u16 i2c_slave_addr;
> >       u16 volt_reg_addr;
> > @@ -130,8 +155,6 @@ struct omap_voltdm_pmic {
> >       u8 vp_erroroffset;
> >       u8 vp_vstepmin;
> >       u8 vp_vstepmax;
> > -     u8 vp_vddmin;
> > -     u8 vp_vddmax;
> >       u8 vp_timeout_us;
> >       bool i2c_high_speed;
> >       u8 i2c_mcode;
> > @@ -139,6 +162,18 @@ struct omap_voltdm_pmic {
> >       u8 (*uv_to_vsel) (unsigned long uV);
> >  };
> >
> > +struct omap_vp_param {
> > +     u8 vddmax;
> > +     u8 vddmin;
> > +};
> > +
> > +struct omap_vc_param {
> > +     u32 on;
> > +     u32 onlp;
> > +     u32 ret;
> > +     u32 off;
> > +};
> > +
> >  void omap_voltage_get_volttable(struct voltagedomain *voltdm,
> >               struct omap_volt_data **volt_data);
> >  struct omap_volt_data *omap_voltage_get_voltdata(struct
> > voltagedomain *voltdm,
> > @@ -149,6 +184,8 @@ int omap_voltage_register_pmic(struct
> > voltagedomain *voltdm,
> >  void omap_change_voltscale_method(struct voltagedomain *voltdm,
> >               int voltscale_method);
> >  int omap_voltage_late_init(void);
> > +int omap_voltage_register_board_params(struct voltagedomain *voltdm,
> > +                     struct omap_volt_board_data *board_params);
> >  #else
> >  static inline int omap_voltage_register_pmic(struct voltagedomain
> > *voltdm,
> >                                            struct omap_voltdm_pmic
> *pmic)
> > @@ -161,6 +198,12 @@ static inline int omap_voltage_late_init(void)
> >  {
> >       return -EINVAL;
> >  }
> > +static inline int omap_voltage_register_board_params(
> > +             struct voltagedomain *voltdm,
> > +             struct omap_volt_board_data *board_params)
> > +{
> > +     return -EINVAL;
> > +}
> >  #endif
> >
> >  extern void omap2xxx_voltagedomains_init(void);
> > diff --git a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> > b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> > index b0d0ae1..9c907af 100644
> > --- a/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> > +++ b/arch/arm/mach-omap2/voltagedomains3xxx_data.c
> > @@ -90,9 +90,17 @@ void __init omap3xxx_voltagedomains_init(void)
> >       if (cpu_is_omap3630()) {
> >               omap3_voltdm_mpu.volt_data = omap36xx_vddmpu_volt_data;
> >               omap3_voltdm_core.volt_data =
> > omap36xx_vddcore_volt_data;
> > +             omap3_voltdm_mpu.vp_param = &omap36xx_mpu_vp_data;
> > +             omap3_voltdm_core.vp_param = &omap36xx_core_vp_data;
> > +             omap3_voltdm_mpu.vc_param = &omap36xx_mpu_vc_data;
> > +             omap3_voltdm_core.vc_param = &omap36xx_core_vc_data;
> >       } else {
> >               omap3_voltdm_mpu.volt_data = omap34xx_vddmpu_volt_data;
> >               omap3_voltdm_core.volt_data =
> > omap34xx_vddcore_volt_data;
> > +             omap3_voltdm_mpu.vp_param = &omap34xx_mpu_vp_data;
> > +             omap3_voltdm_core.vp_param = &omap34xx_core_vp_data;
> > +             omap3_voltdm_mpu.vc_param = &omap34xx_mpu_vc_data;
> > +             omap3_voltdm_core.vc_param = &omap34xx_core_vc_data;
> >       }
> >
> >       for (i = 0; voltdm = voltagedomains_omap3[i], voltdm; i++)
> > diff --git a/arch/arm/mach-omap2/voltagedomains44xx_data.c
> > b/arch/arm/mach-omap2/voltagedomains44xx_data.c
> > index c4584e9..0a22960 100644
> > --- a/arch/arm/mach-omap2/voltagedomains44xx_data.c
> > +++ b/arch/arm/mach-omap2/voltagedomains44xx_data.c
> > @@ -104,6 +104,14 @@ void __init omap44xx_voltagedomains_init(void)
> >       omap4_voltdm_iva.volt_data = omap44xx_vdd_iva_volt_data;
> >       omap4_voltdm_core.volt_data = omap44xx_vdd_core_volt_data;
> >
> > +     omap4_voltdm_mpu.vp_param = &omap44xx_mpu_vp_data;
> > +     omap4_voltdm_iva.vp_param = &omap44xx_iva_vp_data;
> > +     omap4_voltdm_core.vp_param = &omap44xx_core_vp_data;
> > +
> > +     omap4_voltdm_mpu.vc_param = &omap44xx_mpu_vc_data;
> > +     omap4_voltdm_iva.vc_param = &omap44xx_iva_vc_data;
> > +     omap4_voltdm_core.vc_param = &omap44xx_core_vc_data;
> > +
> >       for (i = 0; voltdm = voltagedomains_omap4[i], voltdm; i++)
> >               voltdm->sys_clk.name = sys_clk_name;
> >
> > diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
> > index 66bd700..34bced5 100644
> > --- a/arch/arm/mach-omap2/vp.c
> > +++ b/arch/arm/mach-omap2/vp.c
> > @@ -53,8 +53,8 @@ void __init omap_vp_init(struct voltagedomain
> > *voltdm)
> >       sys_clk_rate = voltdm->sys_clk.rate / 1000;
> >
> >       timeout = (sys_clk_rate * voltdm->pmic->vp_timeout_us) / 1000;
> > -     vddmin = voltdm->pmic->vp_vddmin;
> > -     vddmax = voltdm->pmic->vp_vddmax;
> > +     vddmin = voltdm->vp_param->vddmin;
> > +     vddmax = voltdm->vp_param->vddmax;
> >
> >       waittime = ((voltdm->pmic->step_size / voltdm->pmic-
> > >slew_rate) *
> >                   sys_clk_rate) / 1000;
> > diff --git a/arch/arm/plat-omap/include/plat/prcm.h b/arch/arm/plat-
> > omap/include/plat/prcm.h
> > index 267f43b..cc19997 100644
> > --- a/arch/arm/plat-omap/include/plat/prcm.h
> > +++ b/arch/arm/plat-omap/include/plat/prcm.h
> > @@ -27,9 +27,16 @@
> >  #ifndef __ASM_ARM_ARCH_OMAP_PRCM_H
> >  #define __ASM_ARM_ARCH_OMAP_PRCM_H
> >
> > +struct omap_osc_data {
> > +     u32 clk_setup_ret;
> > +     u32 clk_setup_off;
> > +};
> > +
> >  u32 omap_prcm_get_reset_sources(void);
> >  int omap2_cm_wait_idlest(void __iomem *reg, u32 mask, u8 idlest,
> >                        const char *name);
> > +void omap_osc_register(struct omap_osc_data *osc);
> > +struct omap_osc_data *omap_osc_get(void);
> >
> >  #endif
> >
> > --
> > 1.7.4.1
> >
> >
> > Texas Instruments Oy, Tekniikantie 12, 02150 Espoo. Y-tunnus:
> > 0115040-6. Kotipaikka: Helsinki
> >


