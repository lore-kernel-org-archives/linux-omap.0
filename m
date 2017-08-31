From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 2/4] power: supply: bq27xxx: enable writing capacity values for bq27500
Date: Thu, 31 Aug 2017 08:59:51 +0200
Message-ID: <af9c1a4e95640e744a104780bfed269d0a6c63cb.1504162792.git.hns@goldelico.com>
References: <cover.1504162792.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1504162792.git.hns@goldelico.com>
In-Reply-To: <cover.1504162792.git.hns@goldelico.com>
References: <cover.1504162792.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: afd@ti.com, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, gta04-owner@goldelico.com, marek@goldelico.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Tested on OpenPandora with bq27500.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/power/supply/bq27xxx_battery.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index e80571cf7be1..5562f998330f 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -653,15 +653,11 @@ enum bq27xxx_dm_reg_id {
 #define bq2751x_dm_regs 0
 #define bq2752x_dm_regs 0
 
-#if 0 /* not yet tested */
 static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
 	[BQ27XXX_DM_DESIGN_CAPACITY]   = { 48, 10, 2,    0, 65535 },
 	[BQ27XXX_DM_DESIGN_ENERGY]     = { }, /* missing on chip */
 	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 48, 2, 1000, 32767 },
 };
-#else
-#define bq27500_dm_regs 0
-#endif
 
 /* todo create data memory definitions from datasheets and test on chips */
 #define bq27510g1_dm_regs 0
-- 
2.12.2
