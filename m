From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 7/7] OMAP3: PM: Added support for L2 aux ctrl register save
	and restore
Date: Wed, 17 Feb 2010 18:02:30 -0600
Message-ID: <1266451350-4480-8-git-send-email-khilman@deeprootsystems.com>
References: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1266451350-4480-1-git-send-email-khilman@deeprootsystems.com>
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
Cc: Tero Kristo <tero.kristo@nokia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Tero Kristo <tero.kristo@nokia.com>

This patch adds a save and restore mechanism for ARM L2 auxiliary control
register. The feature is enabled by default for GP devices, but for HS/EMU
devices the user must enable the service and define the PPA service ID to
be used for setting L2 aux ctrl, as this is not currently supported by the
bootloader. If nobody alters the contents of L2 aux ctrl from its reset
value, this feature is not needed.

Kconfig option to enable HS/EMU L2 aux save and restore:
- OMAP3_L2_AUX_SECURE_SAVE_RESTORE
Kconfig option to select HS/EMU PPA service for setting L2 aux ctrl:
- OMAP3_L2_AUX_SECURE_SERVICE_SET_ID

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/sleep34xx.S |   26 ++++++++++++++++++++++++--
 arch/arm/plat-omap/Kconfig      |   17 +++++++++++++++++
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
index 12a8ba0..d522cd7 100644
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -284,6 +284,21 @@ restore:
 	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
 	.word	0xE1600071		@ call SMI monitor (smi #1)
 
+#ifdef CONFIG_OMAP3_L2_AUX_SECURE_SAVE_RESTORE
+	/* Restore L2 aux control register */
+	@ set service ID for PPA
+	mov	r0, #CONFIG_OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
+	mov	r12, r0		@ copy service ID in r12
+	mov	r1, #0		@ set task ID for ROM code in r1
+	mov	r2, #4		@ set some flags in r2, r6
+	mov	r6, #0xff
+	ldr	r4, scratchpad_base
+	ldr	r3, [r4, #0xBC]
+	adds	r3, r3, #8	@ r3 points to parameters
+	mcr	p15, 0, r0, c7, c10, 4	@ data write barrier
+	mcr	p15, 0, r0, c7, c10, 5	@ data memory barrier
+	.word	0xE1600071		@ call SMI monitor (smi #1)
+#endif
 	b	logic_l1_restore
 l2_inv_api_params:
 	.word   0x1, 0x00
@@ -297,6 +312,11 @@ smi:    .word 0xE1600070		@ Call SMI monitor (smieq)
 	ldr	r0, [r3,#4]
 	mov	r12, #0x3
 	.word 0xE1600070	@ Call SMI monitor (smieq)
+	ldr	r4, scratchpad_base
+	ldr	r3, [r4,#0xBC]
+	ldr	r0, [r3,#12]
+	mov	r12, #0x2
+	.word 0xE1600070	@ Call SMI monitor (smieq)
 logic_l1_restore:
 	mov	r1, #0
 	/* Invalidate all instruction caches to PoU
@@ -305,7 +325,7 @@ logic_l1_restore:
 
 	ldr	r4, scratchpad_base
 	ldr	r3, [r4,#0xBC]
-	adds	r3, r3, #8
+	adds	r3, r3, #16
 	ldmia	r3!, {r4-r6}
 	mov	sp, r4
 	msr	spsr_cxsf, r5
@@ -424,7 +444,9 @@ save_context_wfi:
 	mov	r8, r0 /* Store SDRAM address in r8 */
 	mrc	p15, 0, r5, c1, c0, 1	@ Read Auxiliary Control Register
 	mov	r4, #0x1		@ Number of parameters for restore call
-	stmia	r8!, {r4-r5}
+	stmia	r8!, {r4-r5}		@ Push parameters for restore call
+	mrc	p15, 1, r5, c9, c0, 2	@ Read L2 AUX ctrl register
+	stmia	r8!, {r4-r5}		@ Push parameters for restore call
         /* Check what that target sleep state is:stored in r1*/
         /* 1 - Only L1 and logic lost */
         /* 2 - Only L2 lost */
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 97d0c79..be9484a 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -135,6 +135,23 @@ config OMAP_32K_TIMER
 
 endchoice
 
+config OMAP3_L2_AUX_SECURE_SAVE_RESTORE
+	bool "OMAP3 HS/EMU save and restore for L2 AUX control register"
+	depends on ARCH_OMAP3 && PM
+	default n
+	help
+	  Without this option, L2 Auxiliary control register contents are
+	  lost during off-mode entry on HS/EMU devices. This feature
+	  requires support from PPA / boot-loader in HS/EMU devices, which
+	  currently does not exist by default.
+
+config OMAP3_L2_AUX_SECURE_SERVICE_SET_ID
+	int "Service ID for the support routine to set L2 AUX control"
+	depends on OMAP3_L2_AUX_SECURE_SAVE_RESTORE
+	default 43
+	help
+	  PPA routine service ID for setting L2 auxiliary control register.
+
 config OMAP_32K_TIMER_HZ
 	int "Kernel internal timer frequency for 32KHz timer"
 	range 32 1024
-- 
1.6.6
