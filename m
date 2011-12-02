From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/5] ARM: OMAP4: DTS: Support for dmic, and McPDM in device tree
Date: Fri,  2 Dec 2011 11:53:00 +0200
Message-ID: <1322819580-7424-6-git-send-email-peter.ujfalusi@ti.com>
References: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog124.obsmtp.com ([74.125.149.151]:39448 "EHLO
	na3sys009aog124.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753597Ab1LBJx0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Dec 2011 04:53:26 -0500
Received: by mail-bw0-f42.google.com with SMTP id jm19so1814619bkc.15
        for <linux-omap@vger.kernel.org>; Fri, 02 Dec 2011 01:53:25 -0800 (PST)
In-Reply-To: <1322819580-7424-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Add DT support for dmic, and McPDM on OMAP4 platforms.
Panda board does not have DMIC lines accessable, so
disable the dmic on panda.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts |    4 ++++
 arch/arm/boot/dts/omap4.dtsi      |    9 +++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index c702657..b73b641 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -27,3 +27,7 @@
 		reg = <0x80000000 0x40000000>; /* 1 GB */
 	};
 };
+
+&dmic_dai {
+	status = "disabled";
+};
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 4c61c82..00cfb73 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -99,5 +99,14 @@
 			reg = <0x48241000 0x1000>,
 			      <0x48240100 0x0100>;
 		};
+
+		dmic_dai: dmic@4012e000 {
+			compatible = "ti,omap4-dmic";
+			ti,hwmods = "dmic";
+		};
+		mcpdm_dai: mcpdm@40132000 {
+			compatible = "ti,omap4-mcpdm";
+			ti,hwmods = "mcpdm";
+		};
 	};
 };
-- 
1.7.8.rc4

