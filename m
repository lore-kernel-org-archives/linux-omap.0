From: Kevin Hilman <khilman@ti.com>
Subject: Re: [pm_wip/voltdm_nm][PATCH v2 1/3] OMAP4: PM: VC: fix channel bit offset for MPU
Date: Fri, 03 Jun 2011 16:42:16 -0700
Message-ID: <87r57a8otj.fsf@ti.com>
References: <1306711180-8631-1-git-send-email-nm@ti.com>
	<1306711180-8631-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:36540 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752110Ab1FCXmU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 3 Jun 2011 19:42:20 -0400
Received: by mail-px0-f175.google.com with SMTP id 17so1344424pxi.20
        for <linux-omap@vger.kernel.org>; Fri, 03 Jun 2011 16:42:19 -0700 (PDT)
In-Reply-To: <1306711180-8631-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Sun, 29 May 2011 16:19:38 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> Patch "OMAP3+: VC: abstract out channel configuration" abstracts out
> VC channel configuration. However, TRM has it's little surprises such
> as the following for channel_cfg:
> CFG_CHANNEL_SA    BIT(0)
> CFG_CHANNEL_RAV   BIT(1)
> CFG_CHANNEL_RAC   BIT(2)
> CFG_CHANNEL_RACEN BIT(3)
> CFG_CHANNEL_CMD   BIT(4)
> is valid for core and iva, *but* for mpu, the channel offsets are as follows:
> CFG_CHANNEL_SA    BIT(0)
> CFG_CHANNEL_CMD   BIT(1)
> CFG_CHANNEL_RAV   BIT(2)
> CFG_CHANNEL_RAC   BIT(3)
> CFG_CHANNEL_RACEN BIT(4)
>
> To handle this on the fly, add a structure to describe this and use the
> structure for vc definition.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>

You're going to be irritated with me (again), but I changed my mind on
this one.

Initially I thought that this was intentional and that OMAP5+ was going
to have the bit fields in yet a different way, so I wanted to have this
very flexible at a per-channel level.  It turns out that this one
channel really is a mutant.  Somebody fat-fingered this in Bitwise and
resulted in a single anomaly. 

Now that I know this is a single mutant case, I prefer handling it as an
exception (kinda like you did in your original version.)

The RFC/patch below (currently at the tip of voltdm_nm, but only compile
tested) is my version of solving the problem to handle it as an
exception case.   What do you think?

Kevin


>From 6df1f45d4b2a732083992e47596c67e6bdd0311f Mon Sep 17 00:00:00 2001
From: Kevin Hilman <khilman@ti.com>
Date: Thu, 2 Jun 2011 17:28:13 -0700
Subject: [RFC/PATCH] OMAP3+: PM: VC: handle mutant channel config for OMAP4 MPU channel

On OMAP3+, all VC channels have the the same bitfield ordering for all
VC channels, except the OMAP4 MPU channel.  This appears to be a freak
accident as all other VC channel (including OMAP5) have the standard
configuration.  Handle the mutant case by adding a per-channel flag
to signal the deformity and handle it during VC init.

Special thanks to Nishanth Menon <nm@ti.com> for finding this problem
and for proposing the initial solution.

Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c          |   62 +++++++++++++++++++++++++++++--------
 arch/arm/mach-omap2/vc.h          |    1 +
 arch/arm/mach-omap2/vc44xx_data.c |    2 +-
 3 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index d027864..c4edc62 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -10,17 +10,51 @@
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 
-/*
- * Channel configuration bits, common for OMAP3 & 4
+/**
+ * struct omap_vc_channel_cfg - describe the cfg_channel bitfield
+ * @sa: bit for slave address 
+ * @rav: bit for voltage configuration register
+ * @rac: bit for command configuration register	
+ * @racen: enable bit for RAC
+ * @cmd: bit for command value set selection
+ *
+ * Channel configuration bits, common for OMAP3+
  * OMAP3 register: PRM_VC_CH_CONF
  * OMAP4 register: PRM_VC_CFG_CHANNEL
+ * OMAP5 register: PRM_VC_SMPS_<voltdm>_CONFIG
  */
-#define CFG_CHANNEL_SA    BIT(0)
-#define CFG_CHANNEL_RAV   BIT(1)
-#define CFG_CHANNEL_RAC   BIT(2)
-#define CFG_CHANNEL_RACEN BIT(3)
-#define CFG_CHANNEL_CMD   BIT(4)
-#define CFG_CHANNEL_MASK 0x3f
+struct omap_vc_channel_cfg {
+	u8 sa;
+	u8 rav;
+	u8 rac;
+	u8 racen;
+	u8 cmd;
+};
+
+static struct omap_vc_channel_cfg vc_default_channel_cfg = {
+	.sa    = BIT(0),
+	.rav   = BIT(1),
+	.rac   = BIT(2),
+	.racen = BIT(3),
+	.cmd   = BIT(4),
+};
+
+/*
+ * On OMAP3+, all VC channels have the above default bitfield
+ * configuration, except the OMAP4 MPU channel.  This appears
+ * to be a freak accident as every other VC channel has the
+ * default configuration, thus creating a mutant channel config.
+ */
+static struct omap_vc_channel_cfg vc_mutant_channel_cfg = {
+	.sa    = BIT(0),
+	.rav   = BIT(2),
+	.rac   = BIT(3),
+	.racen = BIT(4),
+	.cmd   = BIT(1),
+};
+
+static struct omap_vc_channel_cfg *vc_cfg_bits = &vc_default_channel_cfg;
+#define CFG_CHANNEL_MASK 0x1f
 
 /**
  * omap_vc_config_channel - configure VC channel to PMIC mappings
@@ -47,7 +81,7 @@ static int omap_vc_config_channel(struct voltagedomain *voltdm)
 	 * All others must stay at zero (see function comment above.)
 	 */
 	if (vc->flags & OMAP_VC_CHANNEL_DEFAULT)
-		vc->cfg_channel &= CFG_CHANNEL_RACEN;
+		vc->cfg_channel &= vc_cfg_bits->racen;
 
 	voltdm->rmw(CFG_CHANNEL_MASK << vc->cfg_channel_sa_shift,
 		    vc->cfg_channel << vc->cfg_channel_sa_shift,
@@ -264,6 +298,8 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	}
 
 	vc->cfg_channel = 0;
+	if (vc->flags & OMAP_VC_CHANNEL_CFG_MUTANT)
+		vc_cfg_bits = vc_mutant_channel_cfg;
 
 	/* get PMIC/board specific settings */
 	vc->i2c_slave_addr = voltdm->pmic->i2c_slave_addr;
@@ -275,7 +311,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	voltdm->rmw(vc->smps_sa_mask,
 		    vc->i2c_slave_addr << __ffs(vc->smps_sa_mask),
 		    vc->common->smps_sa_reg);
-	vc->cfg_channel |= CFG_CHANNEL_SA;
+	vc->cfg_channel |= vc_cfg_bits->sa;
 
 	/*
 	 * Configure the PMIC register addresses.
@@ -283,13 +319,13 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	voltdm->rmw(vc->smps_volra_mask,
 		    vc->volt_reg_addr << __ffs(vc->smps_volra_mask),
 		    vc->common->smps_volra_reg);
-	vc->cfg_channel |= CFG_CHANNEL_RAV;
+	vc->cfg_channel |= vc_cfg_bits->rav;
 
 	if (vc->cmd_reg_addr) {
 		voltdm->rmw(vc->smps_cmdra_mask,
 			    vc->cmd_reg_addr << __ffs(vc->smps_cmdra_mask),
 			    vc->common->smps_cmdra_reg);
-		vc->cfg_channel |= CFG_CHANNEL_RAC | CFG_CHANNEL_RACEN;
+		vc->cfg_channel |= vc_cfg_bits->rac | vc_cfg_bits->racen;
 	}
 
 	/* Set up the on, inactive, retention and off voltage */
@@ -302,7 +338,7 @@ void __init omap_vc_init_channel(struct voltagedomain *voltdm)
 	       (ret_vsel << vc->common->cmd_ret_shift) |
 	       (off_vsel << vc->common->cmd_off_shift));
 	voltdm->write(val, vc->cmdval_reg);
-	vc->cfg_channel |= CFG_CHANNEL_CMD;
+	vc->cfg_channel |= vc_cfg_bits->cmd;
 
 	/* Channel configuration */
 	omap_vc_config_channel(voltdm);
diff --git a/arch/arm/mach-omap2/vc.h b/arch/arm/mach-omap2/vc.h
index e7d410c..e16dacf 100644
--- a/arch/arm/mach-omap2/vc.h
+++ b/arch/arm/mach-omap2/vc.h
@@ -64,6 +64,7 @@ struct omap_vc_common {
 
 /* omap_vc_channel.flags values */
 #define OMAP_VC_CHANNEL_DEFAULT BIT(0)
+#define OMAP_VC_CHANNEL_CFG_MUTANT BIT(1)
 
 /**
  * struct omap_vc_channel - VC per-instance data
diff --git a/arch/arm/mach-omap2/vc44xx_data.c b/arch/arm/mach-omap2/vc44xx_data.c
index 148be18..0a4fc37 100644
--- a/arch/arm/mach-omap2/vc44xx_data.c
+++ b/arch/arm/mach-omap2/vc44xx_data.c
@@ -52,7 +52,7 @@ static const struct omap_vc_common omap4_vc_common = {
 
 /* VC instance data for each controllable voltage line */
 struct omap_vc_channel omap4_vc_mpu = {
-	.flags = OMAP_VC_CHANNEL_DEFAULT,
+	.flags = OMAP_VC_CHANNEL_DEFAULT | OMAP_VC_CHANNEL_CFG_MUTANT,
 	.common = &omap4_vc_common,
 	.cmdval_reg = OMAP4_PRM_VC_VAL_CMD_VDD_MPU_L_OFFSET,
 	.smps_sa_mask = OMAP4430_SA_VDD_MPU_L_PRM_VC_SMPS_SA_MASK,
-- 
1.7.4

