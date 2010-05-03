From: Jarkko Nikula <jhnikula@gmail.com>
Subject: [PATCH 1/3] omap: rx51: Change the TWL4030 VMMC2 voltage constraints and supply name
Date: Mon,  3 May 2010 18:56:14 +0300
Message-ID: <1272902176-21033-1-git-send-email-jhnikula@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:31771 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759658Ab0ECPzR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 May 2010 11:55:17 -0400
Received: by ey-out-2122.google.com with SMTP id d26so145739eyd.19
        for <linux-omap@vger.kernel.org>; Mon, 03 May 2010 08:55:15 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Adrian Hunter <adrian.hunter@nokia.com>, Eduardo Valentin <eduardo.valentin@nokia.com>

I believe the VMMC2 constraints must be the same than with VAUX3. Older
boards are using TWL4030 VMMC2 supply for internal MMC whereas newer are
using VAUX3 that has more limited constraints defined in this same file.

More over, the VMMC2 supply is used also for analog audio domain and the
miminum analog voltage of the TLV320AIC34 codec is 2.7 V.

To combine these two facts, the patch changes supply name to V28_A as the
newer boards register VMMC2_30 for VAUX3 and uses the same constraints than
VAUX3 since those constraints are ok for the TLV320AIC34.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Eduardo Valentin <eduardo.valentin@nokia.com>

---

I was looking these from Maemo kernel sources, earlier patch [1] from
Eduardo and from commit f52eeee83d360d536cab1c0296eae0ec5f05e4dd.

I didn't find are the older boards using VMMC2 for audio but I assumed so.

1. http://marc.info/?l=linux-omap&m=125500330932605&w=2
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 4377a4c..b803f47 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -370,9 +370,9 @@ static struct regulator_init_data rx51_vmmc1 = {
 
 static struct regulator_init_data rx51_vmmc2 = {
 	.constraints = {
-		.name			= "VMMC2_30",
-		.min_uV			= 1850000,
-		.max_uV			= 3150000,
+		.name			= "V28_A",
+		.min_uV			= 2800000,
+		.max_uV			= 3000000,
 		.apply_uV		= true,
 		.valid_modes_mask	= REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
-- 
1.7.0

