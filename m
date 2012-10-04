From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 4/9] ARM/dts: omap4-sdp: Disable unused McBSP3
Date: Thu,  4 Oct 2012 14:57:23 +0300
Message-ID: <1349351848-12972-5-git-send-email-peter.ujfalusi@ti.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog116.obsmtp.com ([74.125.149.240]:36699 "EHLO
	na3sys009aog116.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755222Ab2JDL40 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 07:56:26 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so339666oag.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 04:56:25 -0700 (PDT)
In-Reply-To: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

McBSP3 is not usable on OMAP4 SDP/Blaze (the pins used for McPDM).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index 94a23b3..cf09875 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -349,3 +349,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart4_pins>;
 };
+
+&mcbsp3 {
+	status = "disabled";
+};
-- 
1.7.12

