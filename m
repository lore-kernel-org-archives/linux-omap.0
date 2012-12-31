From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC v2 11/18] ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3
Date: Mon, 31 Dec 2012 18:37:04 +0530
Message-ID: <1356959231-17335-12-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52038 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751252Ab2LaNI2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Dec 2012 08:08:28 -0500
In-Reply-To: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

Since AM33XX supports only DT-boot, this is needed
for the appropriate device nodes to be created.

Note: OCMC RAM is part of the PER power domain and supports
retention. The assembly code for low power entry/exit will
run from OCMC RAM. To ensure that the OMAP PM code does not
attempt to disable the clock to OCMC RAM as part of the
suspend process add the no_idle_on_suspend flag.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
v1->v2:
	Add a proper changelog

 arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c2f14e8..4731748 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -385,5 +385,16 @@
 				mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
+
+		ocmcram: ocmcram@40300000 {
+			compatible = "ti,ocmcram";
+			ti,hwmods = "ocmcram";
+			ti,no_idle_on_suspend;
+		};
+
+		wkup_m3: wkup_m3@44d00000 {
+			compatible = "ti,wkup_m3";
+			ti,hwmods = "wkup_m3";
+		};
 	};
 };
-- 
1.7.0.4

