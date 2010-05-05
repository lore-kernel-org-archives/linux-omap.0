From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 15/18] omap: rx51: Change the TWL4030 VMMC2 voltage
	constraints andsupply name
Date: Wed, 05 May 2010 12:33:17 -0700
Message-ID: <20100505193317.21568.78824.stgit@baageli.muru.com>
References: <20100505192957.21568.19569.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57194 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757981Ab0EETdS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 May 2010 15:33:18 -0400
In-Reply-To: <20100505192957.21568.19569.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Jarkko Nikula <jhnikula@gmail.com>, linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@nokia.com>, Adrian Hunter <adrian.hunter@nokia.com>

From: Jarkko Nikula <jhnikula@gmail.com>

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
Signed-off-by: Tony Lindgren <tony@atomide.com>
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

