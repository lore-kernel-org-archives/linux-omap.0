From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [RFC] omap: rx51: Set regulator V28 always on
Date: Wed, 23 Jun 2010 11:19:51 +0300
Message-ID: <1277281191-511-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:49033 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab0FWI12 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Jun 2010 04:27:28 -0400
Received: by wwc33 with SMTP id 33so769617wwc.19
        for <linux-omap@vger.kernel.org>; Wed, 23 Jun 2010 01:27:26 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>

It seems that the battery cover sensor in Nokia N900 is powered from the
V28 domain. Now if this regulator is disabled it causes that the gpio 160
reads only zero which effectively causes uSD removal detection.

Currently the bootloader enabled V28 is kept on but this may change in the
future according to comment in
drivers/regulator/core.c: regulator_has_full_constraints.

Also if there are any consumers on the V28 domain doing regulator_enable
regulator_disable cycle the V28 will be disabled after that.

Prepare for these by defining the V28 as always_on regulator.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
---
This can be tested easily by setting full regulator constraints. Then the
regulator framework will disable in a late_initcall all the regulators with
zero use count and that don't have always_on flag set.

 void __init rx51_peripherals_init(void)
 {
+	regulator_has_full_constraints();
 	rx51_i2c_init();
 	board_onenand_init();
 	board_smc91x_init();
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index abdf321..aeeb91d 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -362,6 +362,7 @@ static struct regulator_init_data rx51_vaux1 = {
 		.name			= "V28",
 		.min_uV			= 2800000,
 		.max_uV			= 2800000,
+		.always_on		= true, /* due battery cover sensor */
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
-- 
1.7.1

