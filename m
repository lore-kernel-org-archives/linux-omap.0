From: Hiroshi.DOYU@nokia.com
Subject: [PATCH 2/8] ARM: OMAP: Fix omap mmu framework for omap1
Date: Mon, 30 Jul 2007 14:03:59 +0300
Message-ID: <11857934482616-git-send-email-Hiroshi.DOYU@nokia.com>
References: <11857934452717-git-send-email-Hiroshi.DOYU@nokia.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11857934452717-git-send-email-Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
List-Id: linux-omap@vger.kernel.org

From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>

DSPGW specific part

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/dsp/mmu.h       |    4 +-
 arch/arm/plat-omap/dsp/omap1_dsp.h |   74 ------------------------------------
 arch/arm/plat-omap/dsp/omap2_dsp.h |   69 ---------------------------------
 3 files changed, 2 insertions(+), 145 deletions(-)

diff --git a/arch/arm/plat-omap/dsp/mmu.h b/arch/arm/plat-omap/dsp/mmu.h
index 7787b9f..9d60e9e 100644
--- a/arch/arm/plat-omap/dsp/mmu.h
+++ b/arch/arm/plat-omap/dsp/mmu.h
@@ -7,7 +7,7 @@
 struct omap_mmu dsp_mmu = {
 	.name		= "mmu:dsp",
 	.type		= OMAP_MMU_DSP,
-	.base		= DSP_MMU_BASE,
+	.base		= IO_ADDRESS(OMAP1510_DSP_MMU_BASE),
 	.membase	= OMAP1510_DSP_BASE,
 	.memsize	= OMAP1510_DSP_SIZE,
 	.nr_tlb_entries	= 32,
@@ -20,7 +20,7 @@ struct omap_mmu dsp_mmu = {
 struct omap_mmu dsp_mmu = {
 	.name		= "mmu:dsp",
 	.type		= OMAP_MMU_DSP,
-	.base		= DSP_MMU_BASE,
+	.base		= IO_ADDRESS(OMAP16XX_DSP_MMU_BASE),
 	.membase	= OMAP16XX_DSP_BASE,
 	.memsize	= OMAP16XX_DSP_SIZE,
 	.nr_tlb_entries	= 32,
diff --git a/arch/arm/plat-omap/dsp/omap1_dsp.h b/arch/arm/plat-omap/dsp/omap1_dsp.h
index 45fdb50..f4ec73e 100644
--- a/arch/arm/plat-omap/dsp/omap1_dsp.h
+++ b/arch/arm/plat-omap/dsp/omap1_dsp.h
@@ -101,80 +101,6 @@
 #define TC_ENDIANISM_EN			0x00000001
 
 /*
- * DSP MMU
- */
-#define DSP_MMU_BASE			(0xfefed200)
-#define DSP_MMU_PREFETCH		(DSP_MMU_BASE + 0x00)
-#define DSP_MMU_WALKING_ST		(DSP_MMU_BASE + 0x04)
-#define DSP_MMU_CNTL			(DSP_MMU_BASE + 0x08)
-#define DSP_MMU_FAULT_AD_H		(DSP_MMU_BASE + 0x0c)
-#define DSP_MMU_FAULT_AD_L		(DSP_MMU_BASE + 0x10)
-#define DSP_MMU_FAULT_ST		(DSP_MMU_BASE + 0x14)
-#define DSP_MMU_IT_ACK			(DSP_MMU_BASE + 0x18)
-#define DSP_MMU_TTB_H			(DSP_MMU_BASE + 0x1c)
-#define DSP_MMU_TTB_L			(DSP_MMU_BASE + 0x20)
-#define DSP_MMU_LOCK			(DSP_MMU_BASE + 0x24)
-#define DSP_MMU_LD_TLB			(DSP_MMU_BASE + 0x28)
-#define DSP_MMU_CAM_H			(DSP_MMU_BASE + 0x2c)
-#define DSP_MMU_CAM_L			(DSP_MMU_BASE + 0x30)
-#define DSP_MMU_RAM_H			(DSP_MMU_BASE + 0x34)
-#define DSP_MMU_RAM_L			(DSP_MMU_BASE + 0x38)
-#define DSP_MMU_GFLUSH			(DSP_MMU_BASE + 0x3c)
-#define DSP_MMU_FLUSH_ENTRY		(DSP_MMU_BASE + 0x40)
-#define DSP_MMU_READ_CAM_H		(DSP_MMU_BASE + 0x44)
-#define DSP_MMU_READ_CAM_L		(DSP_MMU_BASE + 0x48)
-#define DSP_MMU_READ_RAM_H		(DSP_MMU_BASE + 0x4c)
-#define DSP_MMU_READ_RAM_L		(DSP_MMU_BASE + 0x50)
-
-#define DSP_MMU_CNTL_BURST_16MNGT_EN	0x0020
-#define DSP_MMU_CNTL_WTL_EN		0x0004
-#define DSP_MMU_CNTL_MMU_EN		0x0002
-#define DSP_MMU_CNTL_RESET_SW		0x0001
-
-#define DSP_MMU_FAULT_AD_H_DP		0x0100
-#define DSP_MMU_FAULT_AD_H_ADR_MASK	0x00ff
-
-#define DSP_MMU_FAULT_ST_PREF		0x0008
-#define DSP_MMU_FAULT_ST_PERM		0x0004
-#define DSP_MMU_FAULT_ST_TLB_MISS	0x0002
-#define DSP_MMU_FAULT_ST_TRANS		0x0001
-
-#define DSP_MMU_IT_ACK_IT_ACK		0x0001
-
-#define DSP_MMU_LOCK_BASE_MASK		0xfc00
-#define DSP_MMU_LOCK_BASE_SHIFT		10
-#define DSP_MMU_LOCK_VICTIM_MASK	0x03f0
-#define DSP_MMU_LOCK_VICTIM_SHIFT	4
-
-#define DSP_MMU_CAM_H_VA_TAG_H_MASK		0x0003
-
-#define DSP_MMU_CAM_L_VA_TAG_L1_MASK		0xc000
-#define DSP_MMU_CAM_L_VA_TAG_L2_MASK_1MB	0x0000
-#define DSP_MMU_CAM_L_VA_TAG_L2_MASK_64KB	0x3c00
-#define DSP_MMU_CAM_L_VA_TAG_L2_MASK_4KB	0x3fc0
-#define DSP_MMU_CAM_L_VA_TAG_L2_MASK_1KB	0x3ff0
-#define DSP_MMU_CAM_L_P				0x0008
-#define DSP_MMU_CAM_L_V				0x0004
-#define DSP_MMU_CAM_L_PAGESIZE_MASK		0x0003
-#define DSP_MMU_CAM_L_PAGESIZE_1MB		0x0000
-#define DSP_MMU_CAM_L_PAGESIZE_64KB		0x0001
-#define DSP_MMU_CAM_L_PAGESIZE_4KB		0x0002
-#define DSP_MMU_CAM_L_PAGESIZE_1KB		0x0003
-
-#define DSP_MMU_RAM_L_RAM_LSB_MASK	0xfc00
-#define DSP_MMU_RAM_L_AP_MASK		0x0300
-#define DSP_MMU_RAM_L_AP_NA		0x0000
-#define DSP_MMU_RAM_L_AP_RO		0x0200
-#define DSP_MMU_RAM_L_AP_FA		0x0300
-
-#define DSP_MMU_GFLUSH_GFLUSH		0x0001
-
-#define DSP_MMU_FLUSH_ENTRY_FLUSH_ENTRY	0x0001
-
-#define DSP_MMU_LD_TLB_RD		0x0002
-#define DSP_MMU_LD_TLB_LD		0x0001
-
-/*
  * DSP ICR
  */
 #define DSPREG_ICR_RESERVED_BITS	0xffc0
diff --git a/arch/arm/plat-omap/dsp/omap2_dsp.h b/arch/arm/plat-omap/dsp/omap2_dsp.h
index af93be2..0dc43f0 100644
--- a/arch/arm/plat-omap/dsp/omap2_dsp.h
+++ b/arch/arm/plat-omap/dsp/omap2_dsp.h
@@ -78,75 +78,6 @@
 #define DSP_BOOT_ADR_INTERNAL		0x024000
 
 /*
- * DSP MMU: mapped to 0xe2000000 -- use readX(), writeX()
- */
-#define DSP_MMU_BASE			DSP_MMU_24XX_VIRT
-#define DSP_MMU_REVISION		(DSP_MMU_BASE + 0x00)
-#define DSP_MMU_SYSCONFIG		(DSP_MMU_BASE + 0x10)
-#define DSP_MMU_SYSSTATUS		(DSP_MMU_BASE + 0x14)
-#define DSP_MMU_IRQSTATUS		(DSP_MMU_BASE + 0x18)
-#define DSP_MMU_IRQENABLE		(DSP_MMU_BASE + 0x1c)
-#define DSP_MMU_WALKING_ST		(DSP_MMU_BASE + 0x40)
-#define DSP_MMU_CNTL			(DSP_MMU_BASE + 0x44)
-#define DSP_MMU_FAULT_AD		(DSP_MMU_BASE + 0x48)
-#define DSP_MMU_TTB			(DSP_MMU_BASE + 0x4c)
-#define DSP_MMU_LOCK			(DSP_MMU_BASE + 0x50)
-#define DSP_MMU_LD_TLB			(DSP_MMU_BASE + 0x54)
-#define DSP_MMU_CAM			(DSP_MMU_BASE + 0x58)
-#define DSP_MMU_RAM			(DSP_MMU_BASE + 0x5c)
-#define DSP_MMU_GFLUSH			(DSP_MMU_BASE + 0x60)
-#define DSP_MMU_FLUSH_ENTRY		(DSP_MMU_BASE + 0x64)
-#define DSP_MMU_READ_CAM		(DSP_MMU_BASE + 0x68)
-#define DSP_MMU_READ_RAM		(DSP_MMU_BASE + 0x6c)
-#define DSP_MMU_EMU_FAULT_AD		(DSP_MMU_BASE + 0x70)
-
-#define DSP_MMU_SYSCONFIG_CLOCKACTIVITY_MASK	0x00000300
-#define DSP_MMU_SYSCONFIG_IDLEMODE_MASK		0x00000018
-#define DSP_MMU_SYSCONFIG_SOFTRESET		0x00000002
-#define DSP_MMU_SYSCONFIG_AUTOIDLE		0x00000001
-
-#define DSP_MMU_IRQ_MULTIHITFAULT	0x00000010
-#define DSP_MMU_IRQ_TABLEWALKFAULT	0x00000008
-#define DSP_MMU_IRQ_EMUMISS		0x00000004
-#define DSP_MMU_IRQ_TRANSLATIONFAULT	0x00000002
-#define DSP_MMU_IRQ_TLBMISS		0x00000001
-
-#define DSP_MMU_CNTL_EMUTLBUPDATE	0x00000008
-#define DSP_MMU_CNTL_TWLENABLE		0x00000004
-#define DSP_MMU_CNTL_MMUENABLE		0x00000002
-
-#define DSP_MMU_LOCK_BASE_MASK		0x00007c00
-#define DSP_MMU_LOCK_BASE_SHIFT		10
-#define DSP_MMU_LOCK_VICTIM_MASK	0x000001f0
-#define DSP_MMU_LOCK_VICTIM_SHIFT	4
-
-#define DSP_MMU_CAM_VATAG_MASK		0xfffff000
-#define DSP_MMU_CAM_P			0x00000008
-#define DSP_MMU_CAM_V			0x00000004
-#define DSP_MMU_CAM_PAGESIZE_MASK	0x00000003
-#define DSP_MMU_CAM_PAGESIZE_1MB	0x00000000
-#define DSP_MMU_CAM_PAGESIZE_64KB	0x00000001
-#define DSP_MMU_CAM_PAGESIZE_4KB	0x00000002
-#define DSP_MMU_CAM_PAGESIZE_16MB	0x00000003
-
-#define DSP_MMU_RAM_PADDR_MASK		0xfffff000
-#define DSP_MMU_RAM_ENDIANNESS		0x00000200
-#define DSP_MMU_RAM_ENDIANNESS_BIG	0x00000200
-#define DSP_MMU_RAM_ENDIANNESS_LITTLE	0x00000000
-#define DSP_MMU_RAM_ELEMENTSIZE_MASK	0x00000180
-#define DSP_MMU_RAM_ELEMENTSIZE_8	0x00000000
-#define DSP_MMU_RAM_ELEMENTSIZE_16	0x00000080
-#define DSP_MMU_RAM_ELEMENTSIZE_32	0x00000100
-#define DSP_MMU_RAM_ELEMENTSIZE_NONE	0x00000180
-#define DSP_MMU_RAM_MIXED		0x00000040
-
-#define DSP_MMU_GFLUSH_GFLUSH		0x00000001
-
-#define DSP_MMU_FLUSH_ENTRY_FLUSH_ENTRY	0x00000001
-
-#define DSP_MMU_LD_TLB_LD		0x00000001
-
-/*
  * DSP ICR
  */
 #define DSPREG_ICR_RESERVED_BITS	0xfc00
-- 
1.5.3.rc3.24.g83b3d
