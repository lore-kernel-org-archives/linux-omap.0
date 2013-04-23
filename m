From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ARM: OMAP: remove unused variable
Date: Tue, 23 Apr 2013 23:23:27 +0200
Message-ID: <201304232323.27751.arnd@arndb.de>
References: <1363818875-15978-1-git-send-email-robherring2@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1363818875-15978-1-git-send-email-robherring2@gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Russell King <linux@arm.linux.org.uk>, Kukjin Kim <kgene.kim@samsung.com>, Tony Lindgren <tony@atomide.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

ARM: OMAP: remove unused variable
    
Commit 0583fe478a7 "ARM: convert arm/arm64 arch timer to use CLKSRC_OF init"
has left the omap5_realtime_timer_init() function with a stale variable and
broken whitespace. This fixes both.
    
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I've applied this patch on top of the timer cleanup series

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 7dd6453..686e498 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -618,12 +618,10 @@ OMAP_SYS_32K_TIMER_INIT(5, 1, OMAP4_32K_SOURCE, "ti,timer-alwon",
 			2, OMAP4_MPU_SOURCE);
 void __init omap5_realtime_timer_init(void)
 {
-	int err;
-
 	omap5_sync32k_timer_init();
 	realtime_counter_init();
 
-        clocksource_of_init();
+	clocksource_of_init();
 }
 #endif /* CONFIG_SOC_OMAP5 */
 
