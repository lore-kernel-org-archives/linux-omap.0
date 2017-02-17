From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/3] ARM: socfpga: PM: Drop useless check for PM_SUSPEND_STANDBY
Date: Fri, 17 Feb 2017 17:10:36 +0100
Message-ID: <1487347836-14427-4-git-send-email-geert+renesas@glider.be>
References: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1487347836-14427-1-git-send-email-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Dinh Nguyen <dinguyen@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-omap@vger.kernel.org

As SoCFPGA uses the standard suspend_valid_only_mem() for its
platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
callback will never be called with state equal to PM_SUSPEND_STANDBY.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-socfpga/pm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-socfpga/pm.c b/arch/arm/mach-socfpga/pm.c
index c378ab0c24317ccf..d4866788702cb87a 100644
--- a/arch/arm/mach-socfpga/pm.c
+++ b/arch/arm/mach-socfpga/pm.c
@@ -116,7 +116,6 @@ static int socfpga_pm_suspend(unsigned long arg)
 static int socfpga_pm_enter(suspend_state_t state)
 {
 	switch (state) {
-	case PM_SUSPEND_STANDBY:
 	case PM_SUSPEND_MEM:
 		outer_disable();
 		cpu_suspend(0, socfpga_pm_suspend);
-- 
1.9.1
