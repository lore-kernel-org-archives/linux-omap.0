From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH 5/6] Generic twl4030 power script for 3430 based boards.
Date: Fri, 31 Oct 2008 21:50:31 +0200
Message-ID: <1225482631-5512-1-git-send-email-notasas@gmail.com>
References: <1224491876-4353-6-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:62281 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYJaT5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 31 Oct 2008 15:57:33 -0400
Received: by ey-out-2122.google.com with SMTP id 6so534288eyi.37
        for <linux-omap@vger.kernel.org>; Fri, 31 Oct 2008 12:56:58 -0700 (PDT)
In-Reply-To: <1224491876-4353-6-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: peter.de-schrijver@nokia.com, Grazvydas Ignotas <notasas@gmail.com>

+struct twl4030_power_data generic3430_t2scripts_data __initdata = {
+	.scripts        = twl4030_scripts,
+	.size           = ARRAY_SIZE(twl4030_scripts),
+};
+

This structure is declared with __initdata, but other structures referencing it
are not:

@@ -157,6 +156,7 @@ static struct twl4030_platform_data beagle_twldata = {
 	/* platform_data for children goes here */
 	.usb		= &beagle_usb_data,
 	.gpio		= &beagle_gpio_data,
+	.power		= &generic3430_t2scripts_data,
 };
 
This causes warning while building the kernel:

WARNING: modpost: Found 1 section mismatch(es).
