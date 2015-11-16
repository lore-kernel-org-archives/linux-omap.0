From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: OMAP2: use correct timer function for AM43XX and TI81XX
Date: Mon, 16 Nov 2015 22:10:01 +0100
Message-ID: <4016134.4bReocePei@wuerfel>
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
To: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

AM43XX and TI81XX use omap3_gptimer_timer_init(), but that is only
built into the kernel for OMAP3 and AM33XX, otherwise we get:

arch/arm/mach-omap2/built-in.o:(.arch.info.init+0x124): undefined reference to `omap3_gptimer_timer_init'

This changes the Kconfig logic for building the function to
match the callers. Consequently, we no longer need to build
the omap3_secure_sync32k_timer_init and omap4_local_timer_init
for the platforms that have been moved over to other functions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
The code has changed a couple of times, but this version no longer
produces build errors for me.

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b18ebbefae09..b07dd70b2de1 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -494,7 +494,7 @@ void __init omap_init_time(void)
 		clocksource_probe();
 }
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
+#if defined(CONFIG_ARCH_OMAP3)
 void __init omap3_secure_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
@@ -502,7 +502,7 @@ void __init omap3_secure_sync32k_timer_init(void)
 }
 #endif /* CONFIG_ARCH_OMAP3 */
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX)
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM33XX) || defined(CONFIG_SOC_TI81XX)
 void __init omap3_gptimer_timer_init(void)
 {
 	__omap_sync32k_timer_init(2, "timer_sys_ck", NULL,
@@ -510,8 +510,7 @@ void __init omap3_gptimer_timer_init(void)
 }
 #endif
 
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) ||		\
-	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
 static void __init omap4_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
