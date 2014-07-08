From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/3] arm: dts: dra7: fixup qspi entry
Date: Tue,  8 Jul 2014 20:40:52 +0200
Message-ID: <1404844852-19980-3-git-send-email-bigeasy@linutronix.de>
References: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:34186 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbaGHSlQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Jul 2014 14:41:16 -0400
In-Reply-To: <1404844852-19980-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Felipe Balbi <balbi@ti.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The core complains that the number 343 is too large. The older code has
here 124. This avoids the warning, the driver hasn't been tested.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index daf7d36..1529bca 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -821,7 +821,7 @@
 			clocks = <&qspi_gfclk_div>;
 			clock-names = "fck";
 			num-cs = <4>;
-			interrupts = <0 343 0x4>;
+			interrupts = <0 124 0x4>;
 			status = "disabled";
 		};
 
-- 
2.0.1

