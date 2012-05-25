From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [RFC PATCH 11/11] ARM: DT: Add support to system control module for OMAP4
Date: Fri, 25 May 2012 11:26:01 +0300
Message-ID: <1337934361-1606-12-git-send-email-eduardo.valentin@ti.com>
References: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48390 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756225Ab2EYI1a (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 May 2012 04:27:30 -0400
In-Reply-To: <1337934361-1606-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, kbaidarov@dev.rtsoft.ru, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

This patch add device tree entries on OMAP4 based boards
for System Control Module (SCM).

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..d2cb392 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,18 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		ctrl_module_core: ctrl_module_core@4a002000 {
+			compatible = "ti,omap4-control";
+			ti,hwmods = "ctrl_module_core";
+			bandgap {
+				compatible = "ti,omap4460-bandgap";
+				interrupts = <0 126 4>; /* talert */
+				ti,tshut-gpio = <86>; /* tshut */
+			};
+			usb {
+				compatible = "ti,omap4-usb-phy";
+			};
+		};
 	};
 };
-- 
1.7.7.1.488.ge8e1c

