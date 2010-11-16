From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/8] OMAP2+: hwmod: fix a warning, add some docs,
	remove unused fields
Date: Tue, 16 Nov 2010 03:18:12 -0700
Message-ID: <20101116101810.22777.99107.stgit@twilight.localdomain>
References: <20101116101615.22777.49212.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:51538 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934183Ab0KPKTP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Nov 2010 05:19:15 -0500
In-Reply-To: <20101116101615.22777.49212.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

Trivial cleanup and documentation changes on the hwmod code and data:

- resolve the OMAP2430 hwmod data i2c_dev_attr warning

- add some hwmod documentation to indicate flags that should be moved
  outside the static hwmod data in a future patch

- remove some unused fields in the struct omap_hwmod_ocp_if and
  struct omap_hwmod structures

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    2 --
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   16 ++++------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_2430_data.c b/arch/arm/mach=
-omap2/omap_hwmod_2430_data.c
index 7cf0d3a..e4b8d7d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_2430_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_2430_data.c
@@ -475,8 +475,6 @@ static struct omap_hwmod_class i2c_class =3D {
 	.sysc		=3D &i2c_sysc,
 };
=20
-static struct omap_i2c_dev_attr i2c_dev_attr;
-
 /* I2C1 */
=20
 static struct omap_i2c_dev_attr i2c1_dev_attr =3D {
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index b588f47..62bdb23 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -23,7 +23,7 @@
  * - add pinmuxing
  * - init_conn_id_bit (CONNID_BIT_VECTOR)
  * - implement default hwmod SMS/SDRC flags?
- * - remove unused fields
+ * - move Linux-specific data ("non-ROM data") out
  *
  */
 #ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD_H
@@ -159,7 +159,7 @@ struct omap_hwmod_omap2_firewall {
  * ADDR_MAP_ON_INIT: Map this address space during omap_hwmod init.
  * ADDR_TYPE_RT: Address space contains module register target data.
  */
-#define ADDR_MAP_ON_INIT	(1 << 0)
+#define ADDR_MAP_ON_INIT	(1 << 0)	/* XXX does not belong */
 #define ADDR_TYPE_RT		(1 << 1)
=20
 /**
@@ -200,8 +200,6 @@ struct omap_hwmod_addr_space {
  * @fw: interface firewall data
  * @addr_cnt: ARRAY_SIZE(@addr)
  * @width: OCP data width
- * @thread_cnt: number of threads
- * @max_burst_len: maximum burst length in @width sized words (0 if un=
limited)
  * @user: initiators using this interface (see OCP_USER_* macros above=
)
  * @flags: OCP interface flags (see OCPIF_* macros above)
  *
@@ -221,8 +219,6 @@ struct omap_hwmod_ocp_if {
 	}				fw;
 	u8				addr_cnt;
 	u8				width;
-	u8				thread_cnt;
-	u8				max_burst_len;
 	u8				user;
 	u8				flags;
 };
@@ -357,9 +353,9 @@ struct omap_hwmod_omap4_prcm {
  * HWMOD_SWSUP_MSTDBY: omap_hwmod code should manually bring module in=
 and out
  *     of standby, rather than relying on module smart-standby
  * HWMOD_INIT_NO_RESET: don't reset this module at boot - important fo=
r
- *     SDRAM controller, etc.
+ *     SDRAM controller, etc. XXX probably belongs outside the main hw=
mod file
  * HWMOD_INIT_NO_IDLE: don't idle this module at boot - important for =
SDRAM
- *     controller, etc.
+ *     controller, etc. XXX probably belongs outside the main hwmod fi=
le
  * HWMOD_NO_AUTOIDLE: disable module autoidle (OCP_SYSCONFIG.AUTOIDLE)
  *     when module is enabled, rather than the default, which is to
  *     enable autoidle
@@ -459,8 +455,6 @@ struct omap_hwmod_class {
  * @_sysc_cache: internal-use hwmod flags
  * @_mpu_rt_va: cached register target start address (internal use)
  * @_mpu_port_index: cached MPU register target slave ID (internal use=
)
- * @msuspendmux_reg_id: CONTROL_MSUSPENDMUX register ID (1-6)
- * @msuspendmux_shift: CONTROL_MSUSPENDMUX register bit shift
  * @mpu_irqs_cnt: number of @mpu_irqs
  * @sdma_reqs_cnt: number of @sdma_reqs
  * @opt_clks_cnt: number of @opt_clks
@@ -506,8 +500,6 @@ struct omap_hwmod {
 	struct list_head		node;
 	u16				flags;
 	u8				_mpu_port_index;
-	u8				msuspendmux_reg_id;
-	u8				msuspendmux_shift;
 	u8				response_lat;
 	u8				mpu_irqs_cnt;
 	u8				sdma_reqs_cnt;


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
