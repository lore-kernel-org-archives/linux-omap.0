From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/3] ARM: dts: OMAP5: Add mailbox dt node to fix boot warning
Date: Tue, 22 Apr 2014 17:23:35 -0500
Message-ID: <1398205417-1575-2-git-send-email-s-anna@ti.com>
References: <1398205417-1575-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59432 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbaDVWYI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Apr 2014 18:24:08 -0400
In-Reply-To: <1398205417-1575-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Add the mailbox device DT node for OMAP5 SoC. The OMAP5 mailbox
IP is identical to that used in OMAP4.

The OMAP5 hwmod data no longer publishes the module address space,
so this patch fixes the WARN_ON backtrace associated with the
following trace during the kernel boot:
"omap_hwmod: mailbox: doesn't have mpu register target base".

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 6f3de22..e8988bb 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -630,6 +630,13 @@
 			status = "disabled";
 		};
 
+		mailbox: mailbox@4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4a0f4000 0x200>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "mailbox";
+		};
+
 		timer1: timer@4ae18000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x4ae18000 0x80>;
-- 
1.9.2

