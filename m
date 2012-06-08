From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/7] arm/dts: omap4: Add entry for OMAP McPDM IP
Date: Fri,  8 Jun 2012 17:01:59 +0300
Message-ID: <1339164125-32534-2-git-send-email-peter.ujfalusi@ti.com>
References: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:55427 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755230Ab2FHOCY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 10:02:24 -0400
Received: by lbbgk8 with SMTP id gk8so1506787lbb.40
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 07:02:22 -0700 (PDT)
In-Reply-To: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Liam Girdwood <lrg@ti.com>

McPDM is used on OMAP4 based boards to communicate with an external audio
codec (twl6040).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 359c497..4c43f3b 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -272,5 +272,14 @@
 			ti,hwmods = "mmc5";
 			ti,needs-special-reset;
 		};
+
+		mcpdm: mcpdm@40132000 {
+			compatible = "ti,omap4-mcpdm";
+			reg = <0x40132000 0x7f>, /* MPU private access */
+			      <0x49032000 0x7f>; /* L3 Interconnect */
+			interrupts = <0 112 0x4>;
+			interrupt-parent = <&gic>;
+			ti,hwmods = "mcpdm";
+		};
 	};
 };
-- 
1.7.8.6

