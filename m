From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH 13/14] ARM: hwmod: RTC: Don't assume lock/unlock will be called with irq enabled
Date: Thu, 12 Apr 2018 09:23:58 +0530
Message-ID: <1523505239-16229-14-git-send-email-j-keerthy@ti.com>
References: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523505239-16229-1-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linus.walleij@linaro.org, grygorii.strashko@ti.com, tony@atomide.com
Cc: j-keerthy@ti.com, t-kristo@ti.com, Russ.Dill@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, ssantosh@kernel.org, haojian.zhuang@linaro.org, linux-arm-kernel@lists.infradead.org, d-gerlach@ti.com
List-Id: linux-omap@vger.kernel.org

From: Dave Gerlach <d-gerlach@ti.com>

When the RTC lock and unlock functions were introduced it was likely
assumed that they would always be called from irq enabled context, hence
the use of local_irq_disable/enable. This is no longer true as the
RTC+DDR path makes a late call during the suspend path after irqs
have been disabled to enable the RTC hwmod which calls both unlock and
lock, leading to IRQs being reenabled through the local_irq_enable call
in omap_hwmod_rtc_lock call.

To avoid this change the local_irq_disable/enable to
local_irq_save/restore to ensure that from whatever context this is
called the proper IRQ configuration is maintained.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_reset.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_reset.c b/arch/arm/mach-omap2/omap_hwmod_reset.c
index b68f9c0..d5ddba0 100644
--- a/arch/arm/mach-omap2/omap_hwmod_reset.c
+++ b/arch/arm/mach-omap2/omap_hwmod_reset.c
@@ -92,11 +92,13 @@ static void omap_rtc_wait_not_busy(struct omap_hwmod *oh)
  */
 void omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
 {
-	local_irq_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	omap_rtc_wait_not_busy(oh);
 	omap_hwmod_write(OMAP_RTC_KICK0_VALUE, oh, OMAP_RTC_KICK0_REG);
 	omap_hwmod_write(OMAP_RTC_KICK1_VALUE, oh, OMAP_RTC_KICK1_REG);
-	local_irq_enable();
+	local_irq_restore(flags);
 }
 
 /**
@@ -110,9 +112,11 @@ void omap_hwmod_rtc_unlock(struct omap_hwmod *oh)
  */
 void omap_hwmod_rtc_lock(struct omap_hwmod *oh)
 {
-	local_irq_disable();
+	unsigned long flags;
+
+	local_irq_save(flags);
 	omap_rtc_wait_not_busy(oh);
 	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK0_REG);
 	omap_hwmod_write(0x0, oh, OMAP_RTC_KICK1_REG);
-	local_irq_enable();
+	local_irq_restore(flags);
 }
-- 
1.9.1
