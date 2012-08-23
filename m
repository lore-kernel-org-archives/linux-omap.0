From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/6] ARM/dts: omap2420-h4: Include omap2420.dtsi file instead the common omap2
Date: Thu, 23 Aug 2012 12:29:09 +0300
Message-ID: <1345714153-13094-3-git-send-email-peter.ujfalusi@ti.com>
References: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog120.obsmtp.com ([74.125.149.140]:42251 "EHLO
	na3sys009aog120.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758187Ab2HWJ33 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Aug 2012 05:29:29 -0400
Received: by obbta14 with SMTP id ta14so966919obb.4
        for <linux-omap@vger.kernel.org>; Thu, 23 Aug 2012 02:29:27 -0700 (PDT)
In-Reply-To: <1345714153-13094-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Since the board is based on OMAP2420 we should include the dedicated dtsi
file (which includes the common omap2 dtsi).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap2420-h4.dts |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/omap2420-h4.dts b/arch/arm/boot/dts/omap2420-h4.dts
index 25b50b7..77b84e1 100644
--- a/arch/arm/boot/dts/omap2420-h4.dts
+++ b/arch/arm/boot/dts/omap2420-h4.dts
@@ -7,7 +7,7 @@
  */
 /dts-v1/;
 
-/include/ "omap2.dtsi"
+/include/ "omap2420.dtsi"
 
 / {
 	model = "TI OMAP2420 H4 board";
-- 
1.7.8.6

