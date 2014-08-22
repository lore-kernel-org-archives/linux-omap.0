From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/6] ARM: OMAP4+: prminst: provide function to find prm_dev
 instance offset
Date: Fri, 22 Aug 2014 08:51:48 -0500
Message-ID: <1408715513-25851-2-git-send-email-nm@ti.com>
References: <1408715513-25851-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1408715513-25851-1-git-send-email-nm@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

PRM device instance can vary depending on SoC. We already handle the
same during reset of the device, However, this is also needed
for other logic instances. So, first abstract this out to a generic
function.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Minor note: this patch has a 'CHECK: extern prototypes should be avoided in .h files'
for prminst44xx.h but that is a continuation of existing style in the file.

 arch/arm/mach-omap2/prminst44xx.c |   40 +++++++++++++++++++++++--------------
 arch/arm/mach-omap2/prminst44xx.h |    3 +++
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/prminst44xx.c b/arch/arm/mach-omap2/prminst44xx.c
index 69f0dd0..225e025 100644
--- a/arch/arm/mach-omap2/prminst44xx.c
+++ b/arch/arm/mach-omap2/prminst44xx.c
@@ -31,6 +31,8 @@
 
 static void __iomem *_prm_bases[OMAP4_MAX_PRCM_PARTITIONS];
 
+static s32 prm_dev_inst = PRM_INSTANCE_UNKNOWN;
+
 /**
  * omap_prm_base_init - Populates the prm partitions
  *
@@ -43,6 +45,24 @@ void omap_prm_base_init(void)
 	_prm_bases[OMAP4430_PRCM_MPU_PARTITION] = prcm_mpu_base;
 }
 
+s32 omap4_prmst_get_prm_dev_inst(void)
+{
+	if (prm_dev_inst != PRM_INSTANCE_UNKNOWN)
+		return prm_dev_inst;
+
+	/* This cannot be done way early at boot.. as things are not setup */
+	if (cpu_is_omap44xx())
+		prm_dev_inst = OMAP4430_PRM_DEVICE_INST;
+	else if (soc_is_omap54xx())
+		prm_dev_inst = OMAP54XX_PRM_DEVICE_INST;
+	else if (soc_is_dra7xx())
+		prm_dev_inst = DRA7XX_PRM_DEVICE_INST;
+	else if (soc_is_am43xx())
+		prm_dev_inst = AM43XX_PRM_DEVICE_INST;
+
+	return prm_dev_inst;
+}
+
 /* Read a register in a PRM instance */
 u32 omap4_prminst_read_inst_reg(u8 part, s16 inst, u16 idx)
 {
@@ -169,28 +189,18 @@ int omap4_prminst_deassert_hardreset(u8 shift, u8 part, s16 inst,
 void omap4_prminst_global_warm_sw_reset(void)
 {
 	u32 v;
-	s16 dev_inst;
+	s32 inst = omap4_prmst_get_prm_dev_inst();
 
-	if (cpu_is_omap44xx())
-		dev_inst = OMAP4430_PRM_DEVICE_INST;
-	else if (soc_is_omap54xx())
-		dev_inst = OMAP54XX_PRM_DEVICE_INST;
-	else if (soc_is_dra7xx())
-		dev_inst = DRA7XX_PRM_DEVICE_INST;
-	else if (soc_is_am43xx())
-		dev_inst = AM43XX_PRM_DEVICE_INST;
-	else
+	if (inst == PRM_INSTANCE_UNKNOWN)
 		return;
 
-	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, dev_inst,
+	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, inst,
 					OMAP4_PRM_RSTCTRL_OFFSET);
 	v |= OMAP4430_RST_GLOBAL_WARM_SW_MASK;
 	omap4_prminst_write_inst_reg(v, OMAP4430_PRM_PARTITION,
-				 dev_inst,
-				 OMAP4_PRM_RSTCTRL_OFFSET);
+				 inst, OMAP4_PRM_RSTCTRL_OFFSET);
 
 	/* OCP barrier */
 	v = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
-				    dev_inst,
-				    OMAP4_PRM_RSTCTRL_OFFSET);
+				    inst, OMAP4_PRM_RSTCTRL_OFFSET);
 }
diff --git a/arch/arm/mach-omap2/prminst44xx.h b/arch/arm/mach-omap2/prminst44xx.h
index a2ede2d..583aa37 100644
--- a/arch/arm/mach-omap2/prminst44xx.h
+++ b/arch/arm/mach-omap2/prminst44xx.h
@@ -12,6 +12,9 @@
 #ifndef __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
 #define __ARCH_ASM_MACH_OMAP2_PRMINST44XX_H
 
+#define PRM_INSTANCE_UNKNOWN	-1
+extern s32 omap4_prmst_get_prm_dev_inst(void);
+
 /*
  * In an ideal world, we would not export these low-level functions,
  * but this will probably take some time to fix properly
-- 
1.7.9.5
