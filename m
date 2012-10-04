From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 3/9] ARM/dts: omap4-panda: Disable unused audio IPs
Date: Thu,  4 Oct 2012 14:57:22 +0300
Message-ID: <1349351848-12972-4-git-send-email-peter.ujfalusi@ti.com>
References: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog128.obsmtp.com ([74.125.149.141]:48545 "EHLO
	na3sys009aog128.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755222Ab2JDL4Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Oct 2012 07:56:24 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so333253obb.19
        for <linux-omap@vger.kernel.org>; Thu, 04 Oct 2012 04:56:23 -0700 (PDT)
In-Reply-To: <1349351848-12972-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

McBSP2, McBSP3 and DMIC is not usable on PandaBoard (not connected, no
external pins provided for them).

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 20b966e..771cefd 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -137,3 +137,15 @@
 	cs1-used;
 	device-handle = <&elpida_ECB240ABACN>;
 };
+
+&mcbsp2 {
+	status = "disabled";
+};
+
+&mcbsp3 {
+	status = "disabled";
+};
+
+&dmic {
+	status = "disabled";
+};
-- 
1.7.12

