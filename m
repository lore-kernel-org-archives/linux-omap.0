From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 1/4] power: supply: bq27xxx: enable writing capacity values for bq27421
Date: Thu, 31 Aug 2017 10:21:49 +0200
Message-ID: <8d323718d7d1dcd7633da236abcd782f88200113.1504167711.git.hns@goldelico.com>
References: <cover.1504167711.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504167711.git.hns@goldelico.com>
In-Reply-To: <cover.1504167711.git.hns@goldelico.com>
References: <cover.1504167711.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: afd@ti.com, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Tested on Pyra prototype with bq27421.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/bq27xxx_battery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index ad876a3abe01..e80571cf7be1 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -688,15 +688,11 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
 #define bq27545_dm_regs 0
 #endif
 
-#if 0 /* not yet tested */
 static struct bq27xxx_dm_reg bq27421_dm_regs[] = {
 	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 10, 2,    0,  8000 },
 	[BQ27XXX_DM_DESIGN_ENERGY]     = { 82, 12, 2,    0, 32767 },
 	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 16, 2, 2500,  3700 },
 };
-#else
-#define bq27421_dm_regs 0
-#endif
 
 static struct bq27xxx_dm_reg bq27425_dm_regs[] = {
 	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 82, 12, 2,    0, 32767 },
-- 
2.12.2
