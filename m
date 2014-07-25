From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] ARM: dts: Revert enabling of twl configuration for n900
Date: Fri, 25 Jul 2014 04:41:25 -0700
Message-ID: <20140725114124.GE29045@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:46776 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752077AbaGYLmv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jul 2014 07:42:51 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>, Pavel Machek <pavel@ucw.cz>

Commit 9188883fd66e9 (ARM: dts: Enable twl4030 off-idle configuration
for selected omaps) allowed n900 to cut off core voltages during
off-idle. This however caused a regression where twl regulator
vaux1 was not getting enabled for the LCD panel as we are not
requesting it for the panel.

Turns out quite a few devices on n900 are using vaux1, and we need
to either stop idling it, or add proper regulator_get calls for all
users. But until we have a proper solution implemented and tested,
let's just disable the twl off-idle configuration for now for n900.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Fixes: 9188883fd66e9 (ARM: dts: Enable twl4030 off-idle configuration for selected omaps)
Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -361,7 +361,7 @@
 	};
 
 	twl_power: power {
-		compatible = "ti,twl4030-power-n900", "ti,twl4030-power-idle-osc-off";
+		compatible = "ti,twl4030-power-n900";
 		ti,use_poweroff;
 	};
 };
