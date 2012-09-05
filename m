From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 2/8] ARM/dts: omap2420-h4: Include omap2420.dtsi file instead the common omap2
Date: Wed,  5 Sep 2012 14:58:50 +0300
Message-ID: <1346846336-27321-3-git-send-email-peter.ujfalusi@ti.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:44352 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753408Ab2IEL6s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 07:58:48 -0400
Received: by ggdk6 with SMTP id k6so50621ggd.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 04:58:47 -0700 (PDT)
In-Reply-To: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Since the board is based on OMAP2420 we should include the dedicated dtsi
file (which includes the common omap2 dtsi).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap2420-h4.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
1.7.12

