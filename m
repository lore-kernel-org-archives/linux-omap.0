From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 2/2] ARM: omap: timers: reduce rating of gp_timer clocksource
Date: Thu, 24 Nov 2016 11:49:15 +0530
Message-ID: <1479968355-18860-2-git-send-email-j-keerthy@ti.com>
References: <1479968355-18860-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1479968355-18860-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: j-keerthy@ti.com, t-kristo@ti.com, linux@armlinux.org.uk, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

Now ARM Global timer (rating 300) will not be selected as clocksource,
because it's initialized after OMAP GP Timer (rating 300) and
Timekeeping core will not allow to replace clocksource with new one if
both of them have the same rating.

Reduce rating of OMAP GP Timer (300->290) when it's used as
clocksource device - this will allow to select ARM Global timer (300)
as clocksource when enabled.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b2f2448..a0dbb0b 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -376,7 +376,7 @@ static cycle_t clocksource_read_cycles(struct clocksource *cs)
 }
 
 static struct clocksource clocksource_gpt = {
-	.rating		= 300,
+	.rating		= 290,
 	.read		= clocksource_read_cycles,
 	.mask		= CLOCKSOURCE_MASK(32),
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-- 
1.9.1
