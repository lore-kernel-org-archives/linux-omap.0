From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH v2] ARM: dts: tps65910 backup battery regulator
Date: Thu, 16 Jan 2014 17:08:23 +0100
Message-ID: <1389888503-32013-1-git-send-email-mpa@pengutronix.de>
References: <1387539808-24910-3-git-send-email-mpa@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50224 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbaAPQJC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Jan 2014 11:09:02 -0500
In-Reply-To: <1387539808-24910-3-git-send-email-mpa@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Markus Pargmann <mpa@pengutronix.de>

This patch adds a devicetree node for the backup battery regulator.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
Hi,

Mark Brown applied [1] the other part of the series which adds 'vbb' as
regulator-compatible. I forgot to add you in Cc.

Regards,

Markus

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/289815/focus=290089

 arch/arm/boot/dts/tps65910.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tps65910.dtsi b/arch/arm/boot/dts/tps65910.dtsi
index 92693a8..b0ac665 100644
--- a/arch/arm/boot/dts/tps65910.dtsi
+++ b/arch/arm/boot/dts/tps65910.dtsi
@@ -82,5 +82,10 @@
 			reg = <12>;
 			regulator-compatible = "vmmc";
 		};
+
+		vbb_reg: regulator@13 {
+			reg = <13>;
+			regulator-compatible = "vbb";
+		};
 	};
 };
-- 
1.8.5.2

