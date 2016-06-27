From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/4] ARM: OMAP4+: Prevent CPU1 related hang with kexec
Date: Mon, 27 Jun 2016 06:26:48 -0700
Message-ID: <20160627132648.GA28140@atomide.com>
References: <1466495565-17480-1-git-send-email-tony@atomide.com>
 <1466495565-17480-3-git-send-email-tony@atomide.com>
 <4439074.kx9oBqeAS1@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <4439074.kx9oBqeAS1@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Nishanth Menon <nm@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Arnd Bergmann <arnd@arndb.de> [160624 00:41]:
> This doesn't work:
> 
> arch/arm/mach-omap2/built-in.o: In function `omap5_secondary_startup':
> dss-common.c:(.text+0x4cc4): undefined reference to `secondary_startup'
> arch/arm/mach-omap2/built-in.o: In function `hyp_boot':
> dss-common.c:(.text+0x4cf0): undefined reference to `secondary_startup'
> arch/arm/mach-omap2/built-in.o: In function `omap4_secondary_startup':
> dss-common.c:(.text+0x4d14): undefined reference to `secondary_startup'
> arch/arm/mach-omap2/built-in.o: In function `omap4460_secondary_startup':
> dss-common.c:(.text+0x4d48): undefined reference to `secondary_startup'
> 
> secondary_startup() is not defined when CONFIG_SMP is disabled.

Oh sorry. Looks like I did not properly check the compiler output
while fixing up the randconfig errors I got earlier. Below is a
fix for this build error.

Regards,

Tony

8< -----------------
From: Tony Lindgren <tony@atomide.com>
Date: Sun, 26 Jun 2016 22:47:06 -0700
Subject: [PATCH] ARM: OMAP2+: Fix build if CONFIG_SMP is not set

Looks like I only partially fixed up things if CONFIG_SMP
is not set for the recent kexec changes. We don't have
boot_secondary available without SMP as reported by Arnd.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 6d1dffc..fe36ce2 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -24,6 +24,16 @@
 #define AUX_CORE_BOOT0_PA			0x48281800
 #define API_HYP_ENTRY				0x102
 
+ENTRY(omap_secondary_startup)
+#ifdef CONFIG_SMP
+	b	secondary_startup
+#else
+/* Should never get here */
+again:	wfi
+	b	again
+#endif
+#ENDPROC(omap_secondary_startup)
+
 /*
  * OMAP5 specific entry point for secondary CPU to jump from ROM
  * code.  This routine also provides a holding flag into which
@@ -39,7 +49,7 @@ wait:	ldr	r2, =AUX_CORE_BOOT0_PA	@ read from AuxCoreBoot0
 	and	r4, r4, #0x0f
 	cmp	r0, r4
 	bne	wait
-	b	secondary_startup
+	b	omap_secondary_startup
 ENDPROC(omap5_secondary_startup)
 /*
  * Same as omap5_secondary_startup except we call into the ROM to
@@ -59,7 +69,7 @@ wait_2:	ldr	r2, =AUX_CORE_BOOT0_PA	@ read from AuxCoreBoot0
 	adr	r0, hyp_boot
 	smc	#0
 hyp_boot:
-	b	secondary_startup
+	b	omap_secondary_startup
 ENDPROC(omap5_secondary_hyp_startup)
 /*
  * OMAP4 specific entry point for secondary CPU to jump from ROM
@@ -82,7 +92,7 @@ hold:	ldr	r12,=0x103
 	 * we've been released from the wait loop,secondary_stack
 	 * should now contain the SVC stack for this core
 	 */
-	b	secondary_startup
+	b	omap_secondary_startup
 ENDPROC(omap4_secondary_startup)
 
 ENTRY(omap4460_secondary_startup)
@@ -119,5 +129,5 @@ hold_2:	ldr	r12,=0x103
 	 * we've been released from the wait loop,secondary_stack
 	 * should now contain the SVC stack for this core
 	 */
-	b	secondary_startup
+	b	omap_secondary_startup
 ENDPROC(omap4460_secondary_startup)
