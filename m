From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [2.6.29-rc5][PATCH 1/1] ARM: OMAP: BEAGLE: Remove dead code for CONFIG_I2C2_OMAP_BEAGLE
Date: Sun, 22 Feb 2009 18:47:28 +0200
Message-ID: <1235321248-5844-2-git-send-email-jarkko.nikula@nokia.com>
References: <1235321248-5844-1-git-send-email-jarkko.nikula@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:58842 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbZBVQoa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 22 Feb 2009 11:44:30 -0500
Received: by nf-out-0910.google.com with SMTP id d21so354402nfb.21
        for <linux-omap@vger.kernel.org>; Sun, 22 Feb 2009 08:44:28 -0800 (PST)
In-Reply-To: <1235321248-5844-1-git-send-email-jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>

There is no CONFIG_I2C2_OMAP_BEAGLE in mainline and it is under removal
in linux-omap also so remove this dead code now.

Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index e39cd2c..e3c8628 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -175,9 +175,6 @@ static int __init omap3_beagle_i2c_init(void)
 {
 	omap_register_i2c_bus(1, 2600, beagle_i2c_boardinfo,
 			ARRAY_SIZE(beagle_i2c_boardinfo));
-#ifdef CONFIG_I2C2_OMAP_BEAGLE
-	omap_register_i2c_bus(2, 400, NULL, 0);
-#endif
 	/* Bus 3 is attached to the DVI port where devices like the pico DLP
 	 * projector don't work reliably with 400kHz */
 	omap_register_i2c_bus(3, 100, NULL, 0);
-- 
1.5.6.5

