From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 2/2] ARM: dts: sbc-t54: fix model property
Date: Thu,  4 Sep 2014 16:02:53 +0300
Message-ID: <1409835773-22782-3-git-send-email-lifshitz@compulab.co.il>
References: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:38662 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479AbaIDNDU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Sep 2014 09:03:20 -0400
In-Reply-To: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

CM-T54 CoM can be used with various custom baseboards, other
than SB-T54 (supplied with SBC-T54 single board computer).

Update model property of SBC-T54 DT to clarify this.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap5-sbc-t54.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-sbc-t54.dts b/arch/arm/boot/dts/omap5-sbc-t54.dts
index aa98fea..8e89793 100644
--- a/arch/arm/boot/dts/omap5-sbc-t54.dts
+++ b/arch/arm/boot/dts/omap5-sbc-t54.dts
@@ -1,11 +1,11 @@
 /*
- * Suppport for CompuLab SBC-T54 with CM-T54
+ * Suppport for CompuLab CM-T54 on SB-T54 baseboard
  */
 
 #include "omap5-cm-t54.dts"
 
 / {
-	model = "CompuLab SBC-T54 with CM-T54";
+	model = "CompuLab CM-T54 on SB-T54";
 	compatible = "compulab,omap5-sbc-t54", "compulab,omap5-cm-t54", "ti,omap5";
 };
 
-- 
1.7.5.4

