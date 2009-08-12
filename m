From: charu@ti.com
Subject: [RFC][PATCH 0/3] RTC platform data structure defined
Date: Wed, 12 Aug 2009 21:15:12 +0530
Message-ID: <1250091912-5334-1-git-send-email-charu@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51947 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751648AbZHLPp3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 12 Aug 2009 11:45:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, david-b@pacbell.net, sameo@linux.intel.com, p_gortmaker@yahoo.com, Charulatha V <charu@ti.com>

This series contains patches which
        1. define TWL4030 rtc platform data which has msecure gpio line info
        2. initialise msecure gpio line from rtc driver
        3. twl core file passes rtc platform data from board file to rtc driver
        4. Board files handle mux configuration of msecure gpio line

This series applies on top of linux-2.6.31-rc5.

CharuLatha (4):

        [PATCH 0/3] RTC platform data structure defined
        [PATCH 1/3] RTC periodic interrupts enabling and msecure init
        [PATCH 2/3] handling rtc platform data
        [PATCH 3/3] board files do msecure line mux configuration

Structure "twl4030_rtc_platform_data" is defined with msecure_gpio in it. 
This structure would be initialised in board file. 
RTC msecure line initialization happens in RTC driver.
The same structure can be used for any future enhancements in RTC.


Signed-off-by: Charulatha V <charu@ti.com>
---
 include/linux/i2c/twl4030.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/i2c/twl4030.h b/include/linux/i2c/twl4030.h
index 15edfaa..6ae582b 100644
--- a/include/linux/i2c/twl4030.h
+++ b/include/linux/i2c/twl4030.h
@@ -341,6 +341,13 @@ struct twl4030_gpio_platform_data {
 				unsigned gpio, unsigned ngpio);
 };
 
+struct twl4030_rtc_platform_data {
+	int 		msecure_gpio;
+	/* More structures/elements can be added
+	 * for future Triton RTC driver enhancements
+	 */
+};
+
 struct twl4030_madc_platform_data {
 	int		irq_line;
 };
@@ -395,6 +402,7 @@ struct twl4030_platform_data {
 	unsigned				irq_base, irq_end;
 	struct twl4030_bci_platform_data	*bci;
 	struct twl4030_gpio_platform_data	*gpio;
+	struct twl4030_rtc_platform_data	*rtc;
 	struct twl4030_madc_platform_data	*madc;
 	struct twl4030_keypad_data		*keypad;
 	struct twl4030_usb_data			*usb;
-- 
1.6.0.4

