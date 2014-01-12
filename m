From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 12/12] ARM: OMAP2+: make reset pulse for sbc-t3x usb hubs
Date: Sun, 12 Jan 2014 15:22:55 +0200
Message-ID: <1389532975-28281-13-git-send-email-lifshitz@compulab.co.il>
References: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:52062 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751090AbaALNXE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 12 Jan 2014 08:23:04 -0500
In-Reply-To: <1389532975-28281-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

sbc-t3x boards features two external USB ports on SB-T35 baseboard.
The baseboardi USB hub reset signal should be de-asserted to make
those ports functional.

sbc-t3517 features additional (assembled on CoM) USB hub which also
requires reset signal handling.

Add quirks code to handle proper reset pulse signal.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/mach-omap2/pdata-quirks.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pdata-quirks.c b/arch/arm/mach-omap2/pdata-quirks.c
index 1ee831f..3e1407c 100644
--- a/arch/arm/mach-omap2/pdata-quirks.c
+++ b/arch/arm/mach-omap2/pdata-quirks.c
@@ -108,6 +108,23 @@ static int omap3_sbc_t3730_twl_callback(struct device *dev,
 	return 0;
 }
 
+static void __init omap3_sbc_t3x_usb_hub_init(int gpio, char *hub_name)
+{
+	int err = gpio_request_one(gpio, GPIOF_OUT_INIT_LOW, hub_name);
+
+	if (err) {
+		pr_err("SBC-T3x: %s reset gpio request failed: %d\n",
+			hub_name, err);
+		return;
+	}
+
+	gpio_export(gpio, 0);
+
+	udelay(10);
+	gpio_set_value(gpio, 1);
+	msleep(1);
+}
+
 static void __init omap3_sbc_t3730_twl_init(void)
 {
 	twl_gpio_auxdata.setup = omap3_sbc_t3730_twl_callback;
@@ -115,12 +132,14 @@ static void __init omap3_sbc_t3730_twl_init(void)
 
 static void __init omap3_sbc_t3730_legacy_init(void)
 {
+	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
 	legacy_init_wl12xx(WL12XX_REFCLOCK_38, 0, 136);
 	omap_ads7846_init(1, 57, 0, NULL);
 }
 
 static void __init omap3_sbc_t3530_legacy_init(void)
 {
+	omap3_sbc_t3x_usb_hub_init(167, "sb-t35 usb hub");
 	omap_ads7846_init(1, 57, 0, NULL);
 }
 
@@ -198,6 +217,8 @@ static void __init omap3_sbc_t3517_wifi_init(void)
 
 static void __init omap3_sbc_t3517_legacy_init(void)
 {
+	omap3_sbc_t3x_usb_hub_init(152, "cm-t3517 usb hub");
+	omap3_sbc_t3x_usb_hub_init(98, "sb-t35 usb hub");
 	am35xx_emac_reset();
 	hsmmc2_internal_input_clk();
 	omap3_sbc_t3517_wifi_init();
-- 
1.7.5.4

