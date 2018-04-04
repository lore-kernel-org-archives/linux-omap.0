From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: omap2: fix am43xx build without L2X0
Date: Wed,  4 Apr 2018 12:25:36 +0200
Message-ID: <20180404102550.3692501-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Dave Gerlach <d-gerlach@ti.com>, Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

When CONFIG_CACHE_L2X0 is disabled, the am43xx specific suspend
implemnentation fails to link:

arch/arm/mach-omap2/sleep43xx.o: In function `get_l2cache_base':
(.text+0x180): undefined reference to `omap4_get_l2cache_base'

This adds an #ifdef protection around the code, like we do for am44xx.

Fixes: 41d37e61372f ("ARM: OMAP2+: Introduce low-level suspend code for AM43XX")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/sleep43xx.S | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/sleep43xx.S b/arch/arm/mach-omap2/sleep43xx.S
index 59770a69396b..b24be624e8b9 100644
--- a/arch/arm/mach-omap2/sleep43xx.S
+++ b/arch/arm/mach-omap2/sleep43xx.S
@@ -52,10 +52,12 @@
 ENTRY(am43xx_do_wfi)
 	stmfd	sp!, {r4 - r11, lr}	@ save registers on stack
 
+#ifdef CONFIG_CACHE_L2X0
 	/* Retrieve l2 cache virt address BEFORE we shut off EMIF */
 	ldr	r1, get_l2cache_base
 	blx	r1
 	mov	r8, r0
+#endif
 
 	/*
 	 * Flush all data from the L1 and L2 data cache before disabling
@@ -334,8 +336,6 @@ ENDPROC(am43xx_resume_from_deep_sleep)
 	.align
 resume_addr:
 	.word	cpu_resume - PAGE_OFFSET + 0x80000000
-get_l2cache_base:
-	.word	omap4_get_l2cache_base
 kernel_flush:
 	.word   v7_flush_dcache_all
 ddr_start:
@@ -354,7 +354,10 @@ am43xx_phys_emif_clkctrl:
 	.word	(AM43XX_CM_BASE + AM43XX_CM_PER_INST + \
 		 AM43XX_CM_PER_EMIF_CLKCTRL_OFFSET)
 
+#ifdef CONFIG_CACHE_L2X0
 /* L2 cache related defines for AM437x */
+get_l2cache_base:
+	.word	omap4_get_l2cache_base
 l2_cache_base:
 	.word	OMAP44XX_L2CACHE_BASE
 l2_smc1:
@@ -365,6 +368,7 @@ l2_smc3:
 	.word	OMAP4_MON_L2X0_CTRL_INDEX
 l2_val:
 	.word	0xffff
+#endif
 
 .align 3
 /* DDR related defines */
-- 
2.9.0
