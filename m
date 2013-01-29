From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH v2 8/9] ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3
Date: Tue, 29 Jan 2013 12:29:21 +0530
Message-ID: <1359442762-13697-9-git-send-email-vaibhav.bedia@ti.com>
References: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53253 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270Ab3A2G7s (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jan 2013 01:59:48 -0500
In-Reply-To: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Since AM33XX supports only DT-boot, this is needed
for the appropriate device nodes to be created.

Note: OCMC RAM is part of the PER power domain and supports
retention. The assembly code for low power entry/exit will
run from OCMC RAM. To ensure that the OMAP PM code does not
attempt to disable the clock to OCMC RAM as part of the
suspend process add the no_idle_on_suspend flag.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
v2: Add reg property

 arch/arm/boot/dts/am33xx.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c2f14e8..423f898 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -385,5 +385,19 @@
 				mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
+
+		ocmcram: ocmcram@40300000 {
+			compatible = "ti,ocmcram";
+			reg = <0x40300000 0x10000>;
+			ti,hwmods = "ocmcram";
+			ti,no_idle_on_suspend;
+		};
+
+		wkup_m3: wkup_m3@44d00000 {
+			compatible = "ti,wkup_m3";
+			reg = <0x44d00000 0x4000	/* M3 UMEM */
+			       0x44d80000 0x2000>;	/* M3 DMEM */
+			ti,hwmods = "wkup_m3";
+		};
 	};
 };
-- 
1.8.1

