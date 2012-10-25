From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] ARM: OMAP2+: PM: add missing newline to VC warning message
Date: Thu, 25 Oct 2012 10:35:01 -0700
Message-ID: <1351186501-32223-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38222 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757204Ab2JYRfD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 13:35:03 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so2171356pbb.19
        for <linux-omap@vger.kernel.org>; Thu, 25 Oct 2012 10:35:03 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <rmk+kernel@arm.linux.org.uk>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Kevin Hilman <khilman@ti.com>

Add missing newline to warning message to avoid annoying
wrapping problems during kernel boot like this one:

   omap_vc_i2c_init: I2C config for vdd_iva does not match other channels (0).
   omap_vc_i2c_init: I2C config for vdd_mpu does not match other channels (0).Power Management for TI OMAP4.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/vc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 880249b..75878c3 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -264,7 +264,7 @@ static void __init omap_vc_i2c_init(struct voltagedomain *voltdm)
 
 	if (initialized) {
 		if (voltdm->pmic->i2c_high_speed != i2c_high_speed)
-			pr_warn("%s: I2C config for vdd_%s does not match other channels (%u).",
+			pr_warn("%s: I2C config for vdd_%s does not match other channels (%u).\n",
 				__func__, voltdm->name, i2c_high_speed);
 		return;
 	}
-- 
1.8.0

