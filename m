From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 07/12] ARM: dts: Enable PMIC idle configuration for LDP
Date: Mon, 15 Sep 2014 20:12:01 -0700
Message-ID: <1410837126-31553-7-git-send-email-tony@atomide.com>
References: <1410837126-31553-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20036 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754369AbaIPDNM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Sep 2014 23:13:12 -0400
In-Reply-To: <1410837126-31553-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

With the IO chain reconfigure fixed, we can now enable the PMIC
scripts for LDP.

Note that at least on my es3.0 based LDP, the UART seems to be
flakey after wake-up events from off-idle and hangs but eventually
continues.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap3-ldp.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index af272c1..72dca0b 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -159,6 +159,11 @@
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+
+		twl_power: power {
+			compatible = "ti,twl4030-power-idle";
+			ti,use_poweroff;
+		};
 	};
 };
 
-- 
2.1.0

