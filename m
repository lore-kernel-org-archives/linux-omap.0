From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP2+: Fix omap3 off idle power consumption
 creeping up
Date: Wed, 22 Apr 2015 07:35:30 -0700
Message-ID: <20150422143529.GP18048@atomide.com>
References: <1429632619-23474-1-git-send-email-tony@atomide.com>
 <20150421214718.GN18048@atomide.com>
 <20150421221227.GA9919@kahuna>
 <20150422010026.GO18048@atomide.com>
 <553702CE.2030308@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:46218 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932874AbbDVOi3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2015 10:38:29 -0400
Content-Disposition: inline
In-Reply-To: <553702CE.2030308@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@kernel.org>, Tero Kristo <t-kristo@ti.com>

* Nishanth Menon <nm@ti.com> [150421 19:10]:
> On 04/21/2015 08:00 PM, Tony Lindgren wrote:
> > +	/*
> > +	 * Note that for omap3 OMAP3430_SREN_MASK clears SREN to work around
> > +	 * erratum i531 "Extra Power Consumed When Repeated Start Operation
> > +	 * Mode Is Enabled on I2C Interface Dedicated for Smart Reflex (I2C4)".
> > +	 * Otherwise I2C4 eventually leads into about 23mW extran power being
>
> nitpick: extran ;)

Thanks fixed.
 
> > @@ -40,6 +40,7 @@ static struct omap_vc_common omap3_vc_common = {
> >  	.cmd_onlp_shift	 = OMAP3430_VC_CMD_ONLP_SHIFT,
> >  	.cmd_ret_shift	 = OMAP3430_VC_CMD_RET_SHIFT,
> >  	.cmd_off_shift	 = OMAP3430_VC_CMD_OFF_SHIFT,
> > +	.i2c_cfg_clear_mask = OMAP3430_SREN_MASK,
> 
> I know that the prminst rmw current code does:
> v &= ~mask;
> v |= bits;
> and not
> v &= ~mask;
> v |= (bits & mask);
> but to maintain legacy behavior in case the PRCM cleanup sequences
> change anything..
> 
> 	.i2c_cfg_clear_mask = OMAP3430_SREN_MASK | OMAP3430_HSEN_MASK,
> ?
> or
> 		voltdm->rmw(vc->common->i2c_cfg_clear_mask |
>   			    vc->common->i2c_cfg_hsen_mask,
>   			    vc->common->i2c_cfg_hsen_mask,
>   			    vc->common->i2c_cfg_reg);
> 
> no strong feelings though...

OK updated to use OMAP3430_SREN_MASK | OMAP3430_HSEN_MASK.
 
> otherwise, please feel to add:
> Reviewed-by: Nishanth Menon <nm@ti.com>

Thanks added updated patch below.

Regards,

Tony

8< ----------------------
From: Tony Lindgren <tony@atomide.com>
Date: Tue, 21 Apr 2015 14:31:23 -0700
Subject: [PATCH] ARM: OMAP2+: Fix omap off idle power consumption creeping up

If we use a combination of VMODE and I2C4 for retention modes,
eventually the off idle power consumption will creep up by about
23mW, even during off mode with I2C4 always staying enabled.

Turns out this is because of erratum i531 "Extra Power Consumed
When Repeated Start Operation Mode Is Enabled on I2C Interface
Dedicated for Smart Reflex (I2C4)" as pointed out by Nishanth
Menon <nm@ti.com>.

Let's fix the issue by adding i2c_cfg_clear_mask for the bits
to clear when initializing the I2C4 adapter so we can clear
SREN bit that drives the I2C4 lines low otherwise when there
is no traffic.

Fixes: 3b8c4ebb7630 ("ARM: OMAP3: Fix idle mode signaling for
sys_clkreq and sys_off_mode")
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Tero Kristo <t-kristo@ti.com>
Reviewed-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/prm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-34xx.h
@@ -112,6 +112,7 @@
 #define OMAP3430_VC_CMD_ONLP_SHIFT			16
 #define OMAP3430_VC_CMD_RET_SHIFT			8
 #define OMAP3430_VC_CMD_OFF_SHIFT			0
+#define OMAP3430_SREN_MASK				(1 << 4)
 #define OMAP3430_HSEN_MASK				(1 << 3)
 #define OMAP3430_MCODE_MASK				(0x7 << 0)
 #define OMAP3430_VALID_MASK				(1 << 24)
--- a/arch/arm/mach-omap2/prm-regbits-44xx.h
+++ b/arch/arm/mach-omap2/prm-regbits-44xx.h
@@ -35,6 +35,7 @@
 #define OMAP4430_GLOBAL_WARM_SW_RST_SHIFT				1
 #define OMAP4430_GLOBAL_WUEN_MASK					(1 << 16)
 #define OMAP4430_HSMCODE_MASK						(0x7 << 0)
+#define OMAP4430_SRMODEEN_MASK						(1 << 4)
 #define OMAP4430_HSMODEEN_MASK						(1 << 3)
 #define OMAP4430_HSSCLL_SHIFT						24
 #define OMAP4430_ICEPICK_RST_SHIFT					9
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -316,7 +316,8 @@ static void __init omap3_vc_init_pmic_signaling(struct voltagedomain *voltdm)
 	 * idle. And we can also scale voltages to zero for off-idle.
 	 * Note that no actual voltage scaling during off-idle will
 	 * happen unless the board specific twl4030 PMIC scripts are
-	 * loaded.
+	 * loaded. See also omap_vc_i2c_init for comments regarding
+	 * erratum i531.
 	 */
 	val = voltdm->read(OMAP3_PRM_VOLTCTRL_OFFSET);
 	if (!(val & OMAP3430_PRM_VOLTCTRL_SEL_OFF)) {
@@ -704,9 +705,16 @@ static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
 		return;
 	}
 
+	/*
+	 * Note that for omap3 OMAP3430_SREN_MASK clears SREN to work around
+	 * erratum i531 "Extra Power Consumed When Repeated Start Operation
+	 * Mode Is Enabled on I2C Interface Dedicated for Smart Reflex (I2C4)".
+	 * Otherwise I2C4 eventually leads into about 23mW extra power being
+	 * consumed even during off idle using VMODE.
+	 */
 	i2c_high_speed = voltdm->pmic->i2c_high_speed;
 	if (i2c_high_speed)
-		voltdm->rmw(vc->common->i2c_cfg_hsen_mask,
+		voltdm->rmw(vc->common->i2c_cfg_clear_mask,
 			    vc->common->i2c_cfg_hsen_mask,
 			    vc->common->i2c_cfg_reg);
 
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -34,6 +34,7 @@ struct voltagedomain;
  * @cmd_ret_shift: RET field shift in PRM_VC_CMD_VAL_* register
  * @cmd_off_shift: OFF field shift in PRM_VC_CMD_VAL_* register
  * @i2c_cfg_reg: I2C configuration register offset
+ * @i2c_cfg_clear_mask: high-speed mode bit clear mask in I2C config register
  * @i2c_cfg_hsen_mask: high-speed mode bit field mask in I2C config register
  * @i2c_mcode_mask: MCODE field mask for I2C config register
  *
@@ -52,6 +53,7 @@ struct omap_vc_common {
 	u8 cmd_ret_shift;
 	u8 cmd_off_shift;
 	u8 i2c_cfg_reg;
+	u8 i2c_cfg_clear_mask;
 	u8 i2c_cfg_hsen_mask;
 	u8 i2c_mcode_mask;
 };
--- a/arch/arm/mach-omap2/vc3xxx_data.c
+++ b/arch/arm/mach-omap2/vc3xxx_data.c
@@ -40,6 +40,7 @@ static struct omap_vc_common omap3_vc_common = {
 	.cmd_onlp_shift	 = OMAP3430_VC_CMD_ONLP_SHIFT,
 	.cmd_ret_shift	 = OMAP3430_VC_CMD_RET_SHIFT,
 	.cmd_off_shift	 = OMAP3430_VC_CMD_OFF_SHIFT,
+	.i2c_cfg_clear_mask = OMAP3430_SREN_MASK | OMAP3430_HSEN_MASK,
 	.i2c_cfg_hsen_mask = OMAP3430_HSEN_MASK,
 	.i2c_cfg_reg	 = OMAP3_PRM_VC_I2C_CFG_OFFSET,
 	.i2c_mcode_mask	 = OMAP3430_MCODE_MASK,
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -42,6 +42,7 @@ static const struct omap_vc_common omap4_vc_common = {
 	.cmd_ret_shift = OMAP4430_RET_SHIFT,
 	.cmd_off_shift = OMAP4430_OFF_SHIFT,
 	.i2c_cfg_reg = OMAP4_PRM_VC_CFG_I2C_MODE_OFFSET,
+	.i2c_cfg_clear_mask = OMAP4430_SRMODEEN_MASK | OMAP4430_HSMODEEN_MASK,
 	.i2c_cfg_hsen_mask = OMAP4430_HSMODEEN_MASK,
 	.i2c_mcode_mask	 = OMAP4430_HSMCODE_MASK,
 };
