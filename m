From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 06/11] arm: omap2: timer: always call clocksource_of_init()
 when DT
Date: Tue, 6 Oct 2015 12:02:02 -0500
Message-ID: <1444150927-14771-7-git-send-email-balbi@ti.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444150927-14771-1-git-send-email-balbi@ti.com>
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
Cc: daniel.lezcano@linaro.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Felipe Balbi <balbi@ti.com>, tglx@linutronix.de, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

If booting with DT, let's make sure to always
call clocksource_of_init() as this will make
it easier to move timer code to drivers/clocksource
in the future.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/timer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index dcc0f032e717..b523426f38a5 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -496,6 +496,9 @@ void __init omap_sync32k_timer_init(void)
 {
 	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
 			2, "timer_sys_ck", NULL, false);
+
+	if (of_have_populated_dt())
+		clocksource_of_init();
 }
 
 #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
@@ -519,7 +522,6 @@ void __init omap3_gptimer_timer_init(void)
 void __init omap4_local_timer_init(void)
 {
 	omap_sync32k_timer_init();
-	clocksource_of_init();
 }
 #endif
 
@@ -640,10 +642,8 @@ sysclk1_based:
 
 void __init omap5_realtime_timer_init(void)
 {
-	omap_sync32k_timer_init();
 	realtime_counter_init();
-
-	clocksource_of_init();
+	omap_sync32k_timer_init();
 }
 #endif /* CONFIG_SOC_OMAP5 || CONFIG_SOC_DRA7XX */
 
-- 
2.5.3
