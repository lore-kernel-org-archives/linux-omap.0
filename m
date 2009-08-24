From: charu@ti.com
Subject: [PATCH v2 1/4] RTC-MSECURE: platform data structure defined
Date: Mon, 24 Aug 2009 20:37:04 +0530
Message-ID: <1251126424-27148-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58285 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752413AbZHXPHM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Aug 2009 11:07:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, david-b@pacbell.net, sameo@linux.intel.com, p_gortmaker@yahoo.com, Charulatha V <charu@ti.com>

RTC Platform structure would be initialised in board file.
RTC msecure line initialization happens in RTC driver.
The same structure can be used for any future enhancements in RTC.

Signed-off-by: Charulatha V <charu@ti.com>
---
 include/linux/i2c/twl4030.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 15edfaa..0bf8443 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -341,6 +341,10 @@ struct twl4030_gpio_platform_data {
 				unsigned gpio, unsigned ngpio);
 };
 
+struct twl4030_rtc_platform_data {
+	int		msecure_gpio;
+};
+
 struct twl4030_madc_platform_data {
 	int		irq_line;
 };
@@ -395,6 +399,7 @@ struct twl4030_platform_data {
 	unsigned				irq_base, irq_end;
 	struct twl4030_bci_platform_data	*bci;
 	struct twl4030_gpio_platform_data	*gpio;
+	struct twl4030_rtc_platform_data	*rtc;
 	struct twl4030_madc_platform_data	*madc;
 	struct twl4030_keypad_data		*keypad;
 	struct twl4030_usb_data			*usb;
-- 
1.6.0.4

