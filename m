From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 10/27] OMAP3: PM: MPU off-mode support
Date: Wed, 14 Oct 2009 14:57:53 -0700
Message-ID: <1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Rajendra Nayak <rnayak@ti.com>

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c    |   11 ++++++++++-
 arch/arm/mach-omap2/sleep34xx.S |   11 ++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 8c9a036..4eef146 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -28,6 +28,7 @@
 #include <mach/powerdomain.h>
 #include <mach/control.h>
 #include <mach/serial.h>
+#include <mach/sdrc.h>
 
 #include <asm/tlbflush.h>
 
@@ -223,6 +224,9 @@ static void omap_sram_idle(void)
 		/* No need to save context */
 		save_state = 0;
 		break;
+	case PWRDM_POWER_OFF:
+		save_state = 3;
+		break;
 	default:
 		/* Invalid state */
 		printk(KERN_ERR "Invalid mpu state in sram_idle\n");
@@ -248,7 +252,12 @@ static void omap_sram_idle(void)
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 	}
 
-	_omap_sram_idle(NULL, save_state);
+	/*
+	 * omap3_arm_context is the location where ARM registers
+	 * get saved. The restore path then reads from this
+	 * location and restores them back.
+	 */
+	_omap_sram_idle(omap3_arm_context, save_state);
 	cpu_init();
 
 	/* Restore table entry modified during MMU restoration */
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index e5e2553..5e761ec 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -36,12 +36,11 @@
 				OMAP3430_PM_PREPWSTST)
 #define PM_PREPWSTST_MPU_V	OMAP34XX_PRM_REGADDR(MPU_MOD, \
 				OMAP3430_PM_PREPWSTST)
-#define PM_PWSTCTRL_MPU_P	OMAP34XX_PRM_REGADDR(MPU_MOD, PM_PWSTCTRL)
+#define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + PM_PWSTCTRL
 #define SCRATCHPAD_MEM_OFFS	0x310 /* Move this as correct place is
 				       * available */
-#define SCRATCHPAD_BASE_P	OMAP343X_CTRL_REGADDR(\
-				OMAP343X_CONTROL_MEM_WKUP +\
-				SCRATCHPAD_MEM_OFFS)
+#define SCRATCHPAD_BASE_P	(OMAP343X_CTRL_BASE + OMAP343X_CONTROL_MEM_WKUP\
+						+ SCRATCHPAD_MEM_OFFS)
 #define SDRC_POWER_V		OMAP34XX_SDRC_REGADDR(SDRC_POWER)
 
 	.text
@@ -96,7 +95,7 @@ loop:
 
 	ldmfd	sp!, {r0-r12, pc}		@ restore regs and return
 restore:
-	/* b restore*/ 	@ Enable to debug restore code
+	/* b restore*/  @ Enable to debug restore code
         /* Check what was the reason for mpu reset and store the reason in r9*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost - In this case, we wont be here */
@@ -416,8 +415,6 @@ scratchpad_base:
 	.word	SCRATCHPAD_BASE_P
 sdrc_power:
 	.word SDRC_POWER_V
-context_mem:
-	.word	0x803E3E14
 clk_stabilize_delay:
 	.word 0x000001FF
 assoc_mask:
-- 
1.6.4.3
