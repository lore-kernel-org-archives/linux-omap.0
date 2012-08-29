From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 7/8] ARM/dts: omap4: Add reg-names for McPDM and DMIC
Date: Wed, 29 Aug 2012 16:31:06 +0300
Message-ID: <1346247067-9632-8-git-send-email-peter.ujfalusi@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog132.obsmtp.com ([74.125.149.250]:43766 "EHLO
	na3sys009aog132.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753681Ab2H2Nbs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 09:31:48 -0400
Received: by obbuo13 with SMTP id uo13so912279obb.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 06:31:20 -0700 (PDT)
In-Reply-To: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

In order to get the memory areas by name when booted with DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 258435f..115a502 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -282,6 +282,7 @@
 			compatible = "ti,omap4-mcpdm";
 			reg = <0x40132000 0x7f>, /* MPU private access */
 			      <0x49032000 0x7f>; /* L3 Interconnect */
+			reg-names = "mpu", "dma";
 			interrupts = <0 112 0x4>;
 			interrupt-parent = <&gic>;
 			ti,hwmods = "mcpdm";
@@ -291,6 +292,7 @@
 			compatible = "ti,omap4-dmic";
 			reg = <0x4012e000 0x7f>, /* MPU private access */
 			      <0x4902e000 0x7f>; /* L3 Interconnect */
+			reg-names = "mpu", "dma";
 			interrupts = <0 114 0x4>;
 			interrupt-parent = <&gic>;
 			ti,hwmods = "dmic";
-- 
1.7.8.6

