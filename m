From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 04/11] OMAP4: powerdomains: add PRCM partition data;
	use OMAP4 PRM functions
Date: Tue, 07 Dec 2010 23:18:38 -0700
Message-ID: <20101208061837.30541.43725.stgit@twilight.localdomain>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37184 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138Ab0LHGTz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:19:55 -0500
In-Reply-To: <20101208061657.30541.79824.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

OMAP4 powerdomain control registers are split between the PRM hardware
module and the PRCM_MPU local PRCM.  Add this PRCM partition
information to each OMAP4 powerdomain record, and convert the OMAP4
powerdomain function implementations to use the OMAP4 PRM instance
functions.

Also fixes a potential null pointer dereference of pwrdm->name.

The autogeneration scripts have been updated.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Rajendra Nayak <rnayak@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c             |   10 ++
 arch/arm/mach-omap2/powerdomain44xx.c         |  122 +++++++++++++++++=
--------
 arch/arm/mach-omap2/powerdomains44xx_data.c   |   17 +++
 arch/arm/plat-omap/include/plat/powerdomain.h |    7 +
 4 files changed, 115 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/po=
werdomain.c
index 8a0dcd0..a76ad3f 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -20,6 +20,7 @@
 #include <linux/errno.h>
 #include <linux/string.h>
 #include "cm2xxx_3xxx.h"
+#include "prcm44xx.h"
 #include "cm44xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
@@ -72,12 +73,19 @@ static int _pwrdm_register(struct powerdomain *pwrd=
m)
 {
 	int i;
=20
-	if (!pwrdm)
+	if (!pwrdm || !pwrdm->name)
 		return -EINVAL;
=20
 	if (!omap_chip_is(pwrdm->omap_chip))
 		return -EINVAL;
=20
+	if (cpu_is_omap44xx() &&
+	    pwrdm->prcm_partition =3D=3D OMAP4430_INVALID_PRCM_PARTITION) {
+		pr_err("powerdomain: %s: missing OMAP4 PRCM partition ID\n",
+		       pwrdm->name);
+		return -EINVAL;
+	}
+
 	if (_pwrdm_lookup(pwrdm->name))
 		return -EEXIST;
=20
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap=
2/powerdomain44xx.c
index 4c5ab1a..28bf5e3 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -20,48 +20,70 @@
 #include <plat/prcm.h>
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
+#include "prminst44xx.h"
 #include "prm-regbits-44xx.h"
 #include "powerdomains.h"
=20
 static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pw=
rst)
 {
-	omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
-				(pwrst << OMAP_POWERSTATE_SHIFT),
-				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
+	omap4_prminst_rmw_inst_reg_bits(OMAP_POWERSTATE_MASK,
+					(pwrst << OMAP_POWERSTATE_SHIFT),
+					pwrdm->prcm_partition,
+					pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
 	return 0;
 }
=20
 static int omap4_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 {
-	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
-				OMAP4_PM_PWSTCTRL, OMAP_POWERSTATE_MASK);
+	u32 v;
+
+	v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_=
offs,
+					OMAP4_PM_PWSTCTRL);
+	v &=3D OMAP_POWERSTATE_MASK;
+	v >>=3D OMAP_POWERSTATE_SHIFT;
+
+	return v;
 }
=20
 static int omap4_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 {
-	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
-				OMAP4_PM_PWSTST, OMAP_POWERSTATEST_MASK);
+	u32 v;
+
+	v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_=
offs,
+					OMAP4_PM_PWSTST);
+	v &=3D OMAP_POWERSTATEST_MASK;
+	v >>=3D OMAP_POWERSTATEST_SHIFT;
+
+	return v;
 }
=20
 static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 {
-	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTS=
T,
-				OMAP4430_LASTPOWERSTATEENTERED_MASK);
+	u32 v;
+
+	v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_=
offs,
+					OMAP4_PM_PWSTST);
+	v &=3D OMAP4430_LASTPOWERSTATEENTERED_MASK;
+	v >>=3D OMAP4430_LASTPOWERSTATEENTERED_SHIFT;
+
+	return v;
 }
=20
 static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 {
-	omap2_prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
-				(1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
-				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
+	omap4_prminst_rmw_inst_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
+					(1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
+					pwrdm->prcm_partition,
+					pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
 	return 0;
 }
=20
 static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 {
-	omap2_prm_rmw_mod_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
-				OMAP4430_LASTPOWERSTATEENTERED_MASK,
-				pwrdm->prcm_offs, OMAP4_PM_PWSTST);
+	omap4_prminst_rmw_inst_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
+					OMAP4430_LASTPOWERSTATEENTERED_MASK,
+					pwrdm->prcm_partition,
+					pwrdm->prcm_offs, OMAP4_PM_PWSTST);
 	return 0;
 }
=20
@@ -70,69 +92,91 @@ static int omap4_pwrdm_set_logic_retst(struct power=
domain *pwrdm, u8 pwrst)
 	u32 v;
=20
 	v =3D pwrst << __ffs(OMAP4430_LOGICRETSTATE_MASK);
-	omap2_prm_rmw_mod_reg_bits(OMAP4430_LOGICRETSTATE_MASK, v,
-				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
+	omap4_prminst_rmw_inst_reg_bits(OMAP4430_LOGICRETSTATE_MASK, v,
+					pwrdm->prcm_partition, pwrdm->prcm_offs,
+					OMAP4_PM_PWSTCTRL);
=20
 	return 0;
 }
=20
 static int omap4_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank=
,
-								u8 pwrst)
+				    u8 pwrst)
 {
 	u32 m;
=20
 	m =3D omap2_pwrdm_get_mem_bank_onstate_mask(bank);
=20
-	omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
-				OMAP4_PM_PWSTCTRL);
+	omap4_prminst_rmw_inst_reg_bits(m, (pwrst << __ffs(m)),
+					pwrdm->prcm_partition, pwrdm->prcm_offs,
+					OMAP4_PM_PWSTCTRL);
=20
 	return 0;
 }
=20
 static int omap4_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 ban=
k,
-								u8 pwrst)
+				     u8 pwrst)
 {
 	u32 m;
=20
 	m =3D omap2_pwrdm_get_mem_bank_retst_mask(bank);
=20
-	omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
-				OMAP4_PM_PWSTCTRL);
+	omap4_prminst_rmw_inst_reg_bits(m, (pwrst << __ffs(m)),
+					pwrdm->prcm_partition, pwrdm->prcm_offs,
+					OMAP4_PM_PWSTCTRL);
=20
 	return 0;
 }
=20
 static int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
-	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTS=
T,
-				OMAP4430_LOGICSTATEST_MASK);
+	u32 v;
+
+	v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_=
offs,
+					OMAP4_PM_PWSTST);
+	v &=3D OMAP4430_LOGICSTATEST_MASK;
+	v >>=3D OMAP4430_LOGICSTATEST_SHIFT;
+
+	return v;
 }
=20
 static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 {
-	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
-					     OMAP4_PM_PWSTCTRL,
-					     OMAP4430_LOGICRETSTATE_MASK);
+	u32 v;
+
+	v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_=
offs,
+					OMAP4_PM_PWSTCTRL);
+	v &=3D OMAP4430_LOGICRETSTATE_MASK;
+	v >>=3D OMAP4430_LOGICRETSTATE_SHIFT;
+
+	return v;
 }
=20
 static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 ba=
nk)
 {
-	u32 m;
+	u32 m, v;
=20
 	m =3D omap2_pwrdm_get_mem_bank_stst_mask(bank);
=20
-	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTS=
T,
-					     m);
+	v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_=
offs,
+					OMAP4_PM_PWSTST);
+	v &=3D m;
+	v >>=3D __ffs(m);
+
+	return v;
 }
=20
 static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 ba=
nk)
 {
-	u32 m;
+	u32 m, v;
=20
 	m =3D omap2_pwrdm_get_mem_bank_retst_mask(bank);
=20
-	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
-					     OMAP4_PM_PWSTCTRL, m);
+	v =3D omap4_prminst_read_inst_reg(pwrdm->prcm_partition, pwrdm->prcm_=
offs,
+					OMAP4_PM_PWSTCTRL);
+	v &=3D m;
+	v >>=3D __ffs(m);
+
+	return v;
 }
=20
 static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
@@ -146,14 +190,16 @@ static int omap4_pwrdm_wait_transition(struct pow=
erdomain *pwrdm)
 	 */
=20
 	/* XXX Is this udelay() value meaningful? */
-	while ((omap2_prm_read_mod_reg(pwrdm->prcm_offs, OMAP4_PM_PWSTST) &
+	while ((omap4_prminst_read_inst_reg(pwrdm->prcm_partition,
+					    pwrdm->prcm_offs,
+					    OMAP4_PM_PWSTST) &
 		OMAP_INTRANSITION_MASK) &&
-		(c++ < PWRDM_TRANSITION_BAILOUT))
-			udelay(1);
+	       (c++ < PWRDM_TRANSITION_BAILOUT))
+		udelay(1);
=20
 	if (c > PWRDM_TRANSITION_BAILOUT) {
 		printk(KERN_ERR "powerdomain: waited too long for "
-			"powerdomain %s to complete transition\n", pwrdm->name);
+		       "powerdomain %s to complete transition\n", pwrdm->name);
 		return -EAGAIN;
 	}
=20
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mac=
h-omap2/powerdomains44xx_data.c
index 069a21d..823f477 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -26,6 +26,7 @@
 #include "powerdomains.h"
=20
 #include "prcm-common.h"
+#include "prcm44xx.h"
 #include "prm-regbits-44xx.h"
 #include "prm44xx.h"
 #include "prcm_mpu44xx.h"
@@ -34,6 +35,7 @@
 static struct powerdomain core_44xx_pwrdm =3D {
 	.name		  =3D "core_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_CORE_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
@@ -59,6 +61,7 @@ static struct powerdomain core_44xx_pwrdm =3D {
 static struct powerdomain gfx_44xx_pwrdm =3D {
 	.name		  =3D "gfx_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_GFX_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_ON,
 	.banks		  =3D 1,
@@ -75,6 +78,7 @@ static struct powerdomain gfx_44xx_pwrdm =3D {
 static struct powerdomain abe_44xx_pwrdm =3D {
 	.name		  =3D "abe_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_ABE_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_OFF,
@@ -94,6 +98,7 @@ static struct powerdomain abe_44xx_pwrdm =3D {
 static struct powerdomain dss_44xx_pwrdm =3D {
 	.name		  =3D "dss_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_DSS_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF,
@@ -111,6 +116,7 @@ static struct powerdomain dss_44xx_pwrdm =3D {
 static struct powerdomain tesla_44xx_pwrdm =3D {
 	.name		  =3D "tesla_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_TESLA_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
@@ -132,6 +138,7 @@ static struct powerdomain tesla_44xx_pwrdm =3D {
 static struct powerdomain wkup_44xx_pwrdm =3D {
 	.name		  =3D "wkup_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_WKUP_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_ON,
 	.banks		  =3D 1,
@@ -147,6 +154,7 @@ static struct powerdomain wkup_44xx_pwrdm =3D {
 static struct powerdomain cpu0_44xx_pwrdm =3D {
 	.name		  =3D "cpu0_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRCM_MPU_CPU0_INST,
+	.prcm_partition	  =3D OMAP4430_PRCM_MPU_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
@@ -163,6 +171,7 @@ static struct powerdomain cpu0_44xx_pwrdm =3D {
 static struct powerdomain cpu1_44xx_pwrdm =3D {
 	.name		  =3D "cpu1_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRCM_MPU_CPU1_INST,
+	.prcm_partition	  =3D OMAP4430_PRCM_MPU_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
@@ -179,6 +188,7 @@ static struct powerdomain cpu1_44xx_pwrdm =3D {
 static struct powerdomain emu_44xx_pwrdm =3D {
 	.name		  =3D "emu_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_EMU_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_ON,
 	.banks		  =3D 1,
@@ -194,6 +204,7 @@ static struct powerdomain emu_44xx_pwrdm =3D {
 static struct powerdomain mpu_44xx_pwrdm =3D {
 	.name		  =3D "mpu_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_MPU_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
@@ -214,6 +225,7 @@ static struct powerdomain mpu_44xx_pwrdm =3D {
 static struct powerdomain ivahd_44xx_pwrdm =3D {
 	.name		  =3D "ivahd_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_IVAHD_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRDM_POWER_OFF,
@@ -237,6 +249,7 @@ static struct powerdomain ivahd_44xx_pwrdm =3D {
 static struct powerdomain cam_44xx_pwrdm =3D {
 	.name		  =3D "cam_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_CAM_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_ON,
 	.banks		  =3D 1,
@@ -253,6 +266,7 @@ static struct powerdomain cam_44xx_pwrdm =3D {
 static struct powerdomain l3init_44xx_pwrdm =3D {
 	.name		  =3D "l3init_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_L3INIT_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
@@ -270,6 +284,7 @@ static struct powerdomain l3init_44xx_pwrdm =3D {
 static struct powerdomain l4per_44xx_pwrdm =3D {
 	.name		  =3D "l4per_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_L4PER_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret =3D PWRSTS_OFF_RET,
@@ -292,6 +307,7 @@ static struct powerdomain l4per_44xx_pwrdm =3D {
 static struct powerdomain always_on_core_44xx_pwrdm =3D {
 	.name		  =3D "always_on_core_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_ALWAYS_ON_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_ON,
 };
@@ -300,6 +316,7 @@ static struct powerdomain always_on_core_44xx_pwrdm=
 =3D {
 static struct powerdomain cefuse_44xx_pwrdm =3D {
 	.name		  =3D "cefuse_pwrdm",
 	.prcm_offs	  =3D OMAP4430_PRM_CEFUSE_INST,
+	.prcm_partition	  =3D OMAP4430_PRM_PARTITION,
 	.omap_chip	  =3D OMAP_CHIP_INIT(CHIP_IS_OMAP4430),
 	.pwrsts		  =3D PWRSTS_OFF_ON,
 };
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/p=
lat-omap/include/plat/powerdomain.h
index b79eebb..a0d3a30 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -1,5 +1,5 @@
 /*
- * OMAP2/3 powerdomain control
+ * OMAP2/3/4 powerdomain control
  *
  * Copyright (C) 2007-2008 Texas Instruments, Inc.
  * Copyright (C) 2007-2010 Nokia Corporation
@@ -24,7 +24,6 @@
=20
 #include <plat/cpu.h>
=20
-
 /* Powerdomain basic power states */
 #define PWRDM_POWER_OFF		0x0
 #define PWRDM_POWER_RET		0x1
@@ -84,6 +83,7 @@ struct powerdomain;
  * @name: Powerdomain name
  * @omap_chip: represents the OMAP chip types containing this pwrdm
  * @prcm_offs: the address offset from CM_BASE/PRM_BASE
+ * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prc=
m_offs
  * @pwrsts: Possible powerdomain power states
  * @pwrsts_logic_ret: Possible logic power states when pwrdm in RETENT=
ION
  * @flags: Powerdomain flags
@@ -96,6 +96,8 @@ struct powerdomain;
  * @state_counter:
  * @timer:
  * @state_timer:
+ *
+ * @prcm_partition possible values are defined in mach-omap2/prcm44xx.=
h.
  */
 struct powerdomain {
 	const char *name;
@@ -107,6 +109,7 @@ struct powerdomain {
 	const u8 banks;
 	const u8 pwrsts_mem_ret[PWRDM_MAX_MEM_BANKS];
 	const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
+	const u8 prcm_partition;
 	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
 	struct list_head node;
 	int state;


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
