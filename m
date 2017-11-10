From: Tony Lindgren <tony@atomide.com>
Subject: Re: n900 in next-20170901
Date: Thu, 9 Nov 2017 22:23:40 -0800
Message-ID: <20171110062340.GL28152@atomide.com>
References: <20171108074645.GA18747@js1304-P5Q-DELUXE>
 <20171108163413.GU28152@atomide.com>
 <20171109000801.GA23982@js1304-P5Q-DELUXE>
 <20171109001113.GZ28152@atomide.com>
 <20171109003639.GB23982@js1304-P5Q-DELUXE>
 <20171109035031.GA24383@js1304-P5Q-DELUXE>
 <20171109150854.GC28152@atomide.com>
 <20171110001315.GA29669@js1304-P5Q-DELUXE>
 <20171110032610.GJ28152@atomide.com>
 <20171110061917.GK28152@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171110061917.GK28152@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Russell King <linux@armlinux.org.uk>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [171109 22:19]:
> * Tony Lindgren <tony@atomide.com> [171110 03:28]:
> > Then I'll follow up on cleaning up save_secure_ram_context later.
> 
> Here's a better version, the static mapping did not get used.. It
> just moved the area so it happened to work. It needs to be set
> up as MT_MEMORY_RWX_NONCACHED instead.

And FYI, here's what I currently have for the follow-up patch,
but that can wait a bit.

Regards,

Tony

8< ------------------------
diff --git a/arch/arm/mach-omap2/sleep34xx.S b/arch/arm/mach-omap2/sleep34xx.S
--- a/arch/arm/mach-omap2/sleep34xx.S
+++ b/arch/arm/mach-omap2/sleep34xx.S
@@ -45,7 +45,6 @@
 #define PM_PWSTCTRL_MPU_P	OMAP3430_PRM_BASE + MPU_MOD + OMAP2_PM_PWSTCTRL
 #define CM_IDLEST1_CORE_V	OMAP34XX_CM_REGADDR(CORE_MOD, CM_IDLEST1)
 #define CM_IDLEST_CKGEN_V	OMAP34XX_CM_REGADDR(PLL_MOD, CM_IDLEST)
-#define SRAM_BASE_P		OMAP3_SRAM_PA
 #define CONTROL_STAT		OMAP343X_CTRL_BASE + OMAP343X_CONTROL_STATUS
 #define CONTROL_MEM_RTA_CTRL	(OMAP343X_CTRL_BASE +\
 					OMAP36XX_CONTROL_MEM_RTA_CTRL)
@@ -103,10 +102,8 @@ ENTRY(save_secure_ram_context)
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
 	adr	r3, api_params		@ r3 points to parameters
 	str	r0, [r3,#0x4]		@ r0 has sdram address
-	ldr	r12, high_mask
-	and	r3, r3, r12
-	ldr	r12, sram_phy_addr_mask
-	orr	r3, r3, r12
+	ldr	r12, sram_phys_offset	@ load sram physical offset
+	sub	r3, r3, r12		@ parameters physical address
 	mov	r0, #25			@ set service ID for PPA
 	mov	r12, r0			@ copy secure service ID in r12
 	mov	r1, #0			@ set task id for ROM code in r1
@@ -121,10 +118,8 @@ ENTRY(save_secure_ram_context)
 	nop
 	ldmfd	sp!, {r4 - r11, pc}
 	.align
-sram_phy_addr_mask:
-	.word	SRAM_BASE_P
-high_mask:
-	.word	0xffff
+sram_phys_offset:
+	.word	OMAP34XX_SRAM_VIRT - OMAP34XX_SRAM_PHYS
 api_params:
 	.word	0x4, 0x0, 0x0, 0x1, 0x1
 ENDPROC(save_secure_ram_context)
@@ -521,7 +516,7 @@ pm_pwstctrl_mpu:
 scratchpad_base:
 	.word	SCRATCHPAD_BASE_P
 sram_base:
-	.word	SRAM_BASE_P + 0x8000
+	.word	OMAP34XX_SRAM_PHYS + 0x8000
 control_stat:
 	.word	CONTROL_STAT
 control_mem_rta:
diff --git a/arch/arm/mach-omap2/sram.c b/arch/arm/mach-omap2/sram.c
--- a/arch/arm/mach-omap2/sram.c
+++ b/arch/arm/mach-omap2/sram.c
@@ -31,7 +31,7 @@
 #include "sram.h"
 
 #define OMAP2_SRAM_PUB_PA	(OMAP2_SRAM_PA + 0xf800)
-#define OMAP3_SRAM_PUB_PA       (OMAP3_SRAM_PA + 0x8000)
+#define OMAP3_SRAM_PUB_PA       (OMAP34XX_SRAM_PHYS + 0x8000)
 
 #define SRAM_BOOTLOADER_SZ	0x00
 
@@ -105,7 +105,7 @@ static void __init omap_detect_sram(void)
 		}
 	} else {
 		if (cpu_is_omap34xx()) {
-			omap_sram_start = OMAP3_SRAM_PA;
+			omap_sram_start = OMAP34XX_SRAM_PHYS;
 			omap_sram_size = 0x10000; /* 64K */
 		} else {
 			omap_sram_start = OMAP2_SRAM_PA;
diff --git a/arch/arm/mach-omap2/sram.h b/arch/arm/mach-omap2/sram.h
--- a/arch/arm/mach-omap2/sram.h
+++ b/arch/arm/mach-omap2/sram.h
@@ -59,4 +59,3 @@ static inline void omap_push_sram_idle(void) {}
  * Used by the SRAM management code and the idle sleep code.
  */
 #define OMAP2_SRAM_PA		0x40200000
-#define OMAP3_SRAM_PA           0x40200000
-- 
2.15.0
