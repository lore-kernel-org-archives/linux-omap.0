From: Marek Belisko <marek.belisko@open-nandra.com>
Subject: [PATCH] omap1: htc_herald: Fix compilation warning.
Date: Mon,  6 Dec 2010 13:49:05 +0100
Message-ID: <1291639745-17320-1-git-send-email-marek.belisko@open-nandra.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com
Cc: Russell King <linux@arm.linux.org.uk>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Marek Belisko <marek.belisko@open-nandra.com>
List-Id: linux-omap@vger.kernel.org

Patch fix following compilation warning:
arch/arm/mach-omap1/board-htcherald.c:442:
warning: large integer implicitly truncated to unsigned type

Hopefully this is just a typo.

Signed-off-by: Marek Belisko <marek.belisko@open-nandra.com>
---
 arch/arm/mach-omap1/board-htcherald.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/board-htcherald.c b/arch/arm/mach-omap1/board-htcherald.c
index 071af3e..cdbf3b1 100644
--- a/arch/arm/mach-omap1/board-htcherald.c
+++ b/arch/arm/mach-omap1/board-htcherald.c
@@ -439,7 +439,7 @@ static const struct ads7846_platform_data htcherald_ts_platform_data = {
 	.keep_vref_on		= 1,
 	.x_plate_ohms		= 496,
 	.gpio_pendown		= HTCHERALD_GPIO_TS,
-	.pressure_max		= 100000,
+	.pressure_max		= 10000,
 	.pressure_min		= 5000,
 	.x_min			= 528,
 	.x_max			= 3760,
-- 
1.7.1
