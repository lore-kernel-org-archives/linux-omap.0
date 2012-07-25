From: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
Subject: [PATCH v4 4/4] ARM: DT: Add support to system control module for
 OMAP4
Date: Wed, 25 Jul 2012 15:05:23 +0400
Message-ID: <500FD2F3.6060109@dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010105030204020602000906"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:58847 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755427Ab2GYLFZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jul 2012 07:05:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: b-cousson@ti.com, kishon@ti.com, santosh.shilimkar@ti.com, tony@atomide.com, paul@pwsan.com
Cc: balbi@ti.com, amit.kucheria@linaro.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, amit.kachhap@linaro.org, Eduardo Valentin <eduardo.valentin@ti.com>

This is a multi-part message in MIME format.
--------------010105030204020602000906
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit

This patch add device tree entries on OMAP4 based boards
for System Control Module (SCM).

Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
Signed-off-by: Konstantin Baydarov <kbaidarov@dev.rtsoft.ru>
---
 arch/arm/boot/dts/omap4.dtsi |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 04cbbcb..59f83c9 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -295,5 +295,15 @@
 			interrupt-parent = <&gic>;
 			ti,hwmods = "dmic";
 		};
+
+		ctrl_module_core: ctrl_module_core@4A0022C4 {
+			compatible = "ti,omap4-control";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* ranges; */
+			ti,hwmods = "ctrl_module_core";
+			reg = <0x4A0022C4 0x4>; /* CONTROL_STATUS register */
+		};
+
 	};
 };
-- 
1.7.7.6


--------------010105030204020602000906
Content-Type: text/plain; charset=UTF-8;
 name="Attached Message Part"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Attached Message Part"


--------------010105030204020602000906--
