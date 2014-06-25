From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 4/9] ARM: dts: DRA7: Add mailbox nodes
Date: Tue, 24 Jun 2014 20:04:50 -0500
Message-ID: <1403658295-54766-5-git-send-email-s-anna@ti.com>
References: <1403658295-54766-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34793 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752612AbaFYBGK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Jun 2014 21:06:10 -0400
In-Reply-To: <1403658295-54766-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>

DRA7xx has 13 system mailboxes, and is present on both the
DRA72x and DRA74x family of SoCs. Add the DT nodes for all
these 13 mailboxes. Except for mailbox 1, all other mailboxes
do not have interrupts mapped into the MPU GIC by default.

All the mailboxes have been disabled and the interrupts
property information is left out intentionally for now,
because of the dependencies against the crossbar driver.
These mailboxes can be enabled when a usecase arises
and the crossbar driver dependencies are met.

NOTE: The mailbox 1 is backward compatible with the mailbox
IP on OMAP4/OMAP5 with different number of mailbox fifos
and IP interrupts, and hence the omap4 compatibility string
is used.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 91 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c29945e..8d7626f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -338,6 +338,97 @@
 			status = "disabled";
 		};
 
+		mailbox1: mailbox@4a0f4000 {
+			compatible = "ti,omap4-mailbox";
+			reg = <0x4a0f4000 0x200>;
+			ti,hwmods = "mailbox1";
+			status = "disabled";
+		};
+
+		mailbox2: mailbox@4883a000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x4883a000 0x200>;
+			ti,hwmods = "mailbox2";
+			status = "disabled";
+		};
+
+		mailbox3: mailbox@4883c000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x4883c000 0x200>;
+			ti,hwmods = "mailbox3";
+			status = "disabled";
+		};
+
+		mailbox4: mailbox@4883e000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x4883e000 0x200>;
+			ti,hwmods = "mailbox4";
+			status = "disabled";
+		};
+
+		mailbox5: mailbox@48840000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x48840000 0x200>;
+			ti,hwmods = "mailbox5";
+			status = "disabled";
+		};
+
+		mailbox6: mailbox@48842000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x48842000 0x200>;
+			ti,hwmods = "mailbox6";
+			status = "disabled";
+		};
+
+		mailbox7: mailbox@48844000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x48844000 0x200>;
+			ti,hwmods = "mailbox7";
+			status = "disabled";
+		};
+
+		mailbox8: mailbox@48846000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x48846000 0x200>;
+			ti,hwmods = "mailbox8";
+			status = "disabled";
+		};
+
+		mailbox9: mailbox@4885e000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x4885e000 0x200>;
+			ti,hwmods = "mailbox9";
+			status = "disabled";
+		};
+
+		mailbox10: mailbox@48860000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x48860000 0x200>;
+			ti,hwmods = "mailbox10";
+			status = "disabled";
+		};
+
+		mailbox11: mailbox@48862000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x48862000 0x200>;
+			ti,hwmods = "mailbox11";
+			status = "disabled";
+		};
+
+		mailbox12: mailbox@48864000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x48864000 0x200>;
+			ti,hwmods = "mailbox12";
+			status = "disabled";
+		};
+
+		mailbox13: mailbox@48802000 {
+			compatible = "ti,dra7-mailbox";
+			reg = <0x48802000 0x200>;
+			ti,hwmods = "mailbox13";
+			status = "disabled";
+		};
+
 		timer1: timer@4ae18000 {
 			compatible = "ti,omap5430-timer";
 			reg = <0x4ae18000 0x80>;
-- 
2.0.0

