From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ARM/dts: omap4-panda: Enable GPO functionality for twl6040
Date: Wed, 19 Sep 2012 12:43:05 +0300
Message-ID: <1348047785-1681-3-git-send-email-peter.ujfalusi@ti.com>
References: <1348047785-1681-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:33134 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755489Ab2ISJmY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Sep 2012 05:42:24 -0400
Received: by obbuo13 with SMTP id uo13so183804obb.19
        for <linux-omap@vger.kernel.org>; Wed, 19 Sep 2012 02:42:23 -0700 (PDT)
In-Reply-To: <1348047785-1681-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Add the needed properties for twl6040 so the GPO functionality can be used
by other drivers.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-panda.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 20b966e..94adabb 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -71,6 +71,9 @@
 
 	twl6040: twl@4b {
 		compatible = "ti,twl6040";
+		gpio-controller;
+		#gpio-cells = <1>;
+
 		reg = <0x4b>;
 		/* SPI = 0, IRQ# = 119, 4 = active high level-sensitive */
 		interrupts = <0 119 4>; /* IRQ_SYS_2N cascaded to gic */
-- 
1.7.12

