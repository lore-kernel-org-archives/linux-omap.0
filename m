From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 6/8] ARM: dts: OMAP5: Update keypad reg property
Date: Wed, 20 Feb 2013 21:08:53 +0530
Message-ID: <1361374735-22018-7-git-send-email-santosh.shilimkar@ti.com>
References: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54250 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935733Ab3BTPhk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Feb 2013 10:37:40 -0500
In-Reply-To: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>

Add missing OMAP keypad reg property information.

Cc: Benoit Cousson <b-cousson@ti.com>

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index fa0c66b..269a328 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -335,6 +335,7 @@
 
 		keypad: keypad@4ae1c000 {
 			compatible = "ti,omap4-keypad";
+			reg = <0x4ae1c000 0x400>;
 			ti,hwmods = "kbd";
 		};
 
-- 
1.7.9.5

