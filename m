From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v5 3/3] omap3: beaglexm: fix power on of DVI
Date: Tue, 11 Jan 2011 17:55:03 -0600
Message-ID: <4D2CEDD7.4020507@ti.com>
References: <1294766017-12182-4-git-send-email-nm@ti.com> <20110111232329.GY4957@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030608000406040903000005"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:45075 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932474Ab1AKXzI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jan 2011 18:55:08 -0500
Received: by mail-gx0-f177.google.com with SMTP id 27so7592gxk.22
        for <linux-omap@vger.kernel.org>; Tue, 11 Jan 2011 15:55:07 -0800 (PST)
In-Reply-To: <20110111232329.GY4957@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: l-o <linux-omap@vger.kernel.org>, l-a <linux-arm-kernel@lists.infradead.org>, Kevin <khilman@ti.com>, Koen Kooi <koen@beagleboard.org>, Aaro <aaro.koskinen@nokia.com>

This is a multi-part message in MIME format.
--------------030608000406040903000005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tony Lindgren had written, on 01/11/2011 05:23 PM, the following:
[..]
>> -
>> -	gpio_request(gpio + 1, "EHCI_nOC");
>> -	gpio_direction_input(gpio + 1);
>> +	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
>> +		gpio_request(gpio + 1, "EHCI_nOC");
>> +		gpio_direction_input(gpio + 1);
>> +	}
> 
> The return value for gpio_request must be checked.
Ack.
we can go down two paths:
a) I can redo this patch as in v6.patch (attached)
OR
b) we take this patch and do another one cleaning the function up - 
gpio-check.patch

-- 
Regards,
Nishanth Menon

--------------030608000406040903000005
Content-Type: text/x-patch;
 name="v6.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="v6.patch"

>From d08694a8dff8506f1963d9249a89dae9fe508e70 Mon Sep 17 00:00:00 2001
From: Koen Kooi <koen@beagleboard.org>
Date: Thu, 6 Jan 2011 13:29:18 -0600
Subject: [PATCH v6 3/3] omap3: beaglexm: fix power on of DVI

TFP410 DVI chip is used to provide display out.
This chip is controlled by 2 lines:
LDO which supplies the power is controlled over gpio + 2
and the enable of the chip itself is done over gpio + 1
NOTE: the LDO is necessary for LED, serial blocks as well.

gpio + 1 was used to sense USB overcurrent in vanilla beagle.

Without this fix, the display would not function as the LDO
remains shut down.

[nm@ti.com: split up, added descriptive changelogs]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Koen Kooi <koen@beagleboard.org>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   42 ++++++++++++++++++++++++++++--
 1 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 673deb9..28dfe8e 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -273,6 +273,8 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	int r;
+
 	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
 		mmc[0].gpio_wp = -EINVAL;
 	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
@@ -293,9 +295,16 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	/* REVISIT: need ehci-omap hooks for external VBUS
 	 * power switch and overcurrent detect
 	 */
-
-	gpio_request(gpio + 1, "EHCI_nOC");
-	gpio_direction_input(gpio + 1);
+	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
+		r = gpio_request(gpio + 1, "EHCI_nOC");
+		if (!r) {
+			r = gpio_direction_input(gpio + 1);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
+	}
 
 	/*
 	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
@@ -316,6 +325,33 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
 
+	/*
+	 * gpio + 1 on Xm controls the TFP410's enable line (active low)
+	 * gpio + 2 control varies depending on the board rev as follows:
+	 * P7/P8 revisions(prototype): Camera EN
+	 * A2+ revisions (production): LDO (supplies DVI, serial, led blocks)
+	 */
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+		r = gpio_request(gpio + 1, "nDVI_PWR_EN");
+		if (!r) {
+			r = gpio_direction_output(gpio + 1, 0);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure nDVI_PWR_EN\n",
+				__func__);
+		r = gpio_request(gpio + 2, "DVI_LDO_EN");
+		if (!r) {
+			r = gpio_direction_output(gpio + 2, 1);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure DVI_LDO_EN\n",
+				__func__);
+	}
+
 	return 0;
 }
 
-- 
1.6.3.3


--------------030608000406040903000005
Content-Type: text/x-patch;
 name="gpio-check.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="gpio-check.patch"

>From f16524ab1cfba7d2a9bd0a8ef5a577a1fb41bfff Mon Sep 17 00:00:00 2001
From: Nishanth Menon <nm@ti.com>
Date: Tue, 11 Jan 2011 17:51:47 -0600
Subject: [PATCH] omap3: beagle: check gpio returns in gpio_setup

gpio request and set of directions need checks of return value
to ensure that operation succeeded or not.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |   49 ++++++++++++++++++++++++-------
 1 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 458aee4..fc598d3 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -273,6 +273,8 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
+	int r;
+
 	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
 		mmc[0].gpio_wp = -EINVAL;
 	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
@@ -294,19 +296,29 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	 * power switch and overcurrent detect
 	 */
 	if (omap3_beagle_get_rev() != OMAP3BEAGLE_BOARD_XM) {
-		gpio_request(gpio + 1, "EHCI_nOC");
-		gpio_direction_input(gpio + 1);
+		r = gpio_request(gpio + 1, "EHCI_nOC");
+		if (!r) {
+			r = gpio_direction_input(gpio + 1);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure EHCI_nOC\n", __func__);
 	}
 
 	/*
 	 * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
 	 * high / others active low)
 	 */
-	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
-		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
-	else
-		gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	r = gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
+	if (!r) {
+		if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
+			r = gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+		else
+			r = gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
+	}
+	if (r)
+		pr_err("%s: unable to configure nEN_USB_PWR\n", __func__);
 
 	/* DVI reset GPIO is different between beagle revisions */
 	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM)
@@ -324,12 +336,27 @@ static int beagle_twl_gpio_setup(struct device *dev,
 	 * A2+ revisions (production): LDO (supplies DVI, serial, led blocks)
 	 */
 	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
-		gpio_request(gpio + 1, "nDVI_PWR_EN");
-		gpio_direction_output(gpio + 1, 0);
-		gpio_request(gpio + 2, "DVI_LDO_EN");
-		gpio_direction_output(gpio + 2, 1);
+		r = gpio_request(gpio + 1, "nDVI_PWR_EN");
+		if (!r) {
+			r = gpio_direction_output(gpio + 1, 0);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure nDVI_PWR_EN\n",
+				__func__);
+		r = gpio_request(gpio + 2, "DVI_LDO_EN");
+		if (!r) {
+			r = gpio_direction_output(gpio + 2, 1);
+			if (r)
+				gpio_free(gpio + 1);
+		}
+		if (r)
+			pr_err("%s: unable to configure DVI_LDO_EN\n",
+				__func__);
 	}
 
+
 	return 0;
 }
 
-- 
1.6.3.3


--------------030608000406040903000005--
