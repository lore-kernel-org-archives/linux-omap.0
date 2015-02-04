From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v3 6/6] power: twl4030_madc_battery: Add missing MODULE_ALIAS
Date: Wed,  4 Feb 2015 23:14:35 +0100
Message-ID: <1423088075-10025-7-git-send-email-marek@goldelico.com>
References: <1423088075-10025-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423088075-10025-1-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: mark.rutland@arm.com, tony@atomide.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, gta04-owner@goldelico.com, Marek Belisko <marek@goldelico.com>
List-Id: linux-omap@vger.kernel.org

Without MODULE_ALIAS twl4030_madc_battery won't get loaded automaticall=
y.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/power/twl4030_madc_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl40=
30_madc_battery.c
index e6075ae..cea0927 100644
--- a/drivers/power/twl4030_madc_battery.c
+++ b/drivers/power/twl4030_madc_battery.c
@@ -355,3 +355,4 @@ module_platform_driver(twl4030_madc_battery_driver)=
;
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Lukas M=C3=A4rdian <lukas@goldelico.com>");
 MODULE_DESCRIPTION("twl4030_madc battery driver");
+MODULE_ALIAS("platform:twl4030_madc_battery");
--=20
1.9.1
