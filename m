From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 3/4] ARM: dts: sbc-t3x: add TV out display alias
Date: Sun, 23 Nov 2014 11:42:01 +0200
Message-ID: <1416735722-26167-4-git-send-email-lifshitz@compulab.co.il>
References: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:33168 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751414AbaKWJm1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 23 Nov 2014 04:42:27 -0500
In-Reply-To: <1416735722-26167-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Add display alias for TV out.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap3-sbc-t3517.dts |    1 +
 arch/arm/boot/dts/omap3-sbc-t3530.dts |    1 +
 arch/arm/boot/dts/omap3-sbc-t3730.dts |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-sbc-t3517.dts b/arch/arm/boot/dts/omap3-sbc-t3517.dts
index 4ec5d86..1798653 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3517.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3517.dts
@@ -11,6 +11,7 @@
 
 	aliases {
 		display0 = &dvi0;
+		display1 = &tv0;
 	};
 
 	/* Only one GPMC smsc9220 on SBC-T3517, CM-T3517 uses am35x Ethernet */
diff --git a/arch/arm/boot/dts/omap3-sbc-t3530.dts b/arch/arm/boot/dts/omap3-sbc-t3530.dts
index 8dfc1df..c994f0f 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3530.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3530.dts
@@ -11,6 +11,7 @@
 
 	aliases {
 		display0 = &dvi0;
+		display1 = &tv0;
 	};
 };
 
diff --git a/arch/arm/boot/dts/omap3-sbc-t3730.dts b/arch/arm/boot/dts/omap3-sbc-t3730.dts
index 6b69864..5bdddf2 100644
--- a/arch/arm/boot/dts/omap3-sbc-t3730.dts
+++ b/arch/arm/boot/dts/omap3-sbc-t3730.dts
@@ -11,6 +11,7 @@
 
 	aliases {
 		display0 = &dvi0;
+		display1 = &tv0;
 	};
 };
 
-- 
1.7.5.4

