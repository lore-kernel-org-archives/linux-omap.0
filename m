From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 2/2] arm/dts: omap4: Add ocp2scp data
Date: Wed, 18 Jul 2012 12:00:39 +0530
Message-ID: <1342593039-7728-3-git-send-email-kishon@ti.com>
References: <1342593039-7728-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:54906 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751817Ab2GRGbZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Jul 2012 02:31:25 -0400
In-Reply-To: <1342593039-7728-1-git-send-email-kishon@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, kishon@ti.com, b-cousson@ti.com, rnayak@ti.com, tony@atomide.com, gregkh@linuxfoundation.org, ohad@wizery.com, linus.walleij@linaro.org, myungjoo.ham@samsung.com, rusty@rustcorp.com.au, swarren@nvidia.com, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Add ocp2scp data node in omap4 device tree file.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..29c6243 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,13 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		ocp2scp {
+			compatible = "ti,omap-ocp2scp";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			ti,hwmods = "ocp2scp_usb_phy";
+		};
 	};
 };
-- 
1.7.5.4

