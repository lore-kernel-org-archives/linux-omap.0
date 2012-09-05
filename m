From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 5/8] ARM/dts: omap4: Add reg-names for McPDM and DMIC
Date: Wed,  5 Sep 2012 14:58:53 +0300
Message-ID: <1346846336-27321-6-git-send-email-peter.ujfalusi@ti.com>
References: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:33450 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757783Ab2IEL7B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 07:59:01 -0400
Received: by yhpp61 with SMTP id p61so55980yhp.11
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 04:59:00 -0700 (PDT)
In-Reply-To: <1346846336-27321-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

In order to get the memory areas by name when booted with DT.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 5ed3b94..9f851df 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -273,6 +273,7 @@
 			compatible = "ti,omap4-mcpdm";
 			reg = <0x40132000 0x7f>, /* MPU private access */
 			      <0x49032000 0x7f>; /* L3 Interconnect */
+			reg-names = "mpu", "dma";
 			interrupts = <0 112 0x4>;
 			interrupt-parent = <&gic>;
 			ti,hwmods = "mcpdm";
@@ -282,6 +283,7 @@
 			compatible = "ti,omap4-dmic";
 			reg = <0x4012e000 0x7f>, /* MPU private access */
 			      <0x4902e000 0x7f>; /* L3 Interconnect */
+			reg-names = "mpu", "dma";
 			interrupts = <0 114 0x4>;
 			interrupt-parent = <&gic>;
 			ti,hwmods = "dmic";
-- 
1.7.12

