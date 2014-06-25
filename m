From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 3/9] ARM: dts: AM4372: Correct mailbox node data
Date: Tue, 24 Jun 2014 20:04:49 -0500
Message-ID: <1403658295-54766-4-git-send-email-s-anna@ti.com>
References: <1403658295-54766-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34786 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbaFYBGF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 21:06:05 -0400
In-Reply-To: <1403658295-54766-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>

The mailbox DT node for AM4372 has been corrected to include
the correct compatible flag, and remove the other properties
that have crept in by mistake.

Fixes: 9e3269b (ARM: dts: AM4372: Add L2, EDMA, mailbox, MMC and SHAM nodes)
Cc: Lokesh Vutla <lokeshvutla@ti.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 49fa596..390cbb53 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -162,15 +162,10 @@
 		};
 
 		mailbox: mailbox@480C8000 {
-			compatible = "ti,omap4-mailbox";
+			compatible = "ti,am4372-mailbox";
 			reg = <0x480C8000 0x200>;
 			interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox";
-			ti,mbox-num-users = <4>;
-			ti,mbox-num-fifos = <8>;
-			ti,mbox-names = "wkup_m3";
-			ti,mbox-data = <0 0 0 0>;
-			status = "disabled";
 		};
 
 		timer1: timer@44e31000 {
-- 
2.0.0

