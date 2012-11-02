From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 13/15] ARM: DTS: AM33XX: Add nodes for OCMCRAM and Mailbox
Date: Fri, 2 Nov 2012 18:02:44 +0530
Message-ID: <1351859566-24818-14-git-send-email-vaibhav.bedia@ti.com>
References: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45210 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760919Ab2KBMeZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 08:34:25 -0400
In-Reply-To: <1351859566-24818-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: khilman@ti.com, paul@pwsan.com, b-cousson@ti.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index bb31bff..e2cbf24 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -210,5 +210,16 @@
 			interrupt-parent = <&intc>;
 			interrupts = <91>;
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

