From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP: GPIO: fix auto-disable of debounce clock
Date: Wed,  2 Jun 2010 08:22:29 -0700
Message-ID: <1275492149-29063-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55315 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932340Ab0FBPWd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jun 2010 11:22:33 -0400
Received: by pxi8 with SMTP id 8so3510pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 02 Jun 2010 08:22:31 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

The addition of the new debounce code (commit
168ef3d9a56bd8bffe0ef4189c450888b4aefefe) broke the auto-disable of
debounce clocks on idle by forgetting to update the debounce clock
enable mask.

Add back the updating of bank->dbck_enable_mask so debounce clocks are
auto-disabled.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
Please include for 2.6.35-rc series.

 arch/arm/plat-omap/gpio.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index 393e921..9b7e354 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -673,6 +673,7 @@ static void _set_gpio_debounce(struct gpio_bank *bank, unsigned gpio,
 		if (cpu_is_omap34xx() || cpu_is_omap44xx())
 			clk_disable(bank->dbck);
 	}
+	bank->dbck_enable_mask = val;
 
 	__raw_writel(val, reg);
 }
-- 
1.7.0.2

