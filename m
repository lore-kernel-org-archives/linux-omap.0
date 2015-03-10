From: Marek Belisko <marek@goldelico.com>
Subject: [PATCH v4 6/6] power: twl4030_madc_battery: Add missing MODULE_ALIAS
Date: Tue, 10 Mar 2015 22:27:27 +0100
Message-ID: <1426022847-30912-7-git-send-email-marek@goldelico.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f180.google.com ([74.125.82.180]:45536 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753572AbbCJV2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Mar 2015 17:28:12 -0400
In-Reply-To: <1426022847-30912-1-git-send-email-marek@goldelico.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, hns@goldelico.com, Marek Belisko <marek@goldelico.com>

Without MODULE_ALIAS twl4030_madc_battery won't get loaded automaticall=
y.

Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 drivers/power/twl4030_madc_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/twl4030_madc_battery.c b/drivers/power/twl40=
30_madc_battery.c
index 3e0005d..d0753f1 100644
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

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
