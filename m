From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 4/8] i2c: omap: Fix missing device tree flags for omap2
Date: Thu, 14 Nov 2013 09:30:57 -0800
Message-ID: <20131114173057.GE10317@atomide.com>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-5-git-send-email-tony@atomide.com>
 <20131114110721.GE16396@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:11576 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752995Ab3KNRbE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 14 Nov 2013 12:31:04 -0500
Content-Disposition: inline
In-Reply-To: <20131114110721.GE16396@e106331-lin.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>

* Mark Rutland <mark.rutland@arm.com> [131114 03:08]:
> 
> Please update Documentation/devicetree/bindings/i2c/i2c-omap.txt
> 
> Otherwise, this is fine.

Here's this one with updated documentation.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 13 Nov 2013 16:36:37 -0800
Subject: [PATCH] i2c: omap: Fix missing device tree flags for omap2

As we claim to support device tree for mach-omap2, we
should have the necessary flags in the driver to make it
usable.

Cc: linux-i2c@vger.kernel.org
Acked-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/Documentation/devicetree/bindings/i2c/i2c-omap.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-omap.txt
@@ -1,7 +1,8 @@
 I2C for OMAP platforms
 
 Required properties :
-- compatible : Must be "ti,omap3-i2c" or "ti,omap4-i2c"
+- compatible : Must be "ti,omap2420-i2c", "ti,omap2430-i2c", "ti,omap3-i2c"
+  or "ti,omap4-i2c"
 - ti,hwmods : Must be "i2c<n>", n being the instance number (1-based)
 - #address-cells = <1>;
 - #size-cells = <0>;
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -1037,6 +1037,20 @@ static const struct i2c_algorithm omap_i2c_algo = {
 };
 
 #ifdef CONFIG_OF
+static struct omap_i2c_bus_platform_data omap2420_pdata = {
+	.rev = OMAP_I2C_IP_VERSION_1,
+	.flags = OMAP_I2C_FLAG_NO_FIFO |
+			OMAP_I2C_FLAG_SIMPLE_CLOCK |
+			OMAP_I2C_FLAG_16BIT_DATA_REG |
+			OMAP_I2C_FLAG_BUS_SHIFT_2,
+};
+
+static struct omap_i2c_bus_platform_data omap2430_pdata = {
+	.rev = OMAP_I2C_IP_VERSION_1,
+	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2 |
+			OMAP_I2C_FLAG_FORCE_19200_INT_CLK,
+};
+
 static struct omap_i2c_bus_platform_data omap3_pdata = {
 	.rev = OMAP_I2C_IP_VERSION_1,
 	.flags = OMAP_I2C_FLAG_BUS_SHIFT_2,
@@ -1055,6 +1069,14 @@ static const struct of_device_id omap_i2c_of_match[] = {
 		.compatible = "ti,omap3-i2c",
 		.data = &omap3_pdata,
 	},
+	{
+		.compatible = "ti,omap2430-i2c",
+		.data = &omap2430_pdata,
+	},
+	{
+		.compatible = "ti,omap2420-i2c",
+		.data = &omap2420_pdata,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, omap_i2c_of_match);
