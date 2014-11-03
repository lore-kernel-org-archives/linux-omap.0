From: Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/2] ARM: dts: DRA7: Add interrupts property to mailbox nodes
Date: Mon, 3 Nov 2014 17:07:34 -0600
Message-ID: <1415056055-64201-2-git-send-email-s-anna@ti.com>
References: <1415056055-64201-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49110 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbaKCXIA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 3 Nov 2014 18:08:00 -0500
In-Reply-To: <1415056055-64201-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Dave Gerlach <d-gerlach@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Suman Anna <s-anna@ti.com>

Add the interrupts property to all the 13 mailbox nodes in
DRA7xx. The interrupts property information added is inline
with the expected values with the DRA7xx crossbar driver,
and is common to both DRA74x and DRA72x SoCs.

Do note that the mailbox 1 is only capable of generating out
3 interrupts, while all the remaining mailboxes have 4
interrupts each.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 51 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 9cc9843..b8c9c67 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -421,6 +421,9 @@
 		mailbox1: mailbox@4a0f4000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x4a0f4000 0x200>;
+			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox1";
 			ti,mbox-num-users = <3>;
 			ti,mbox-num-fifos = <8>;
@@ -430,6 +433,10 @@
 		mailbox2: mailbox@4883a000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x4883a000 0x200>;
+			interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 239 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox2";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -439,6 +446,10 @@
 		mailbox3: mailbox@4883c000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x4883c000 0x200>;
+			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox3";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -448,6 +459,10 @@
 		mailbox4: mailbox@4883e000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x4883e000 0x200>;
+			interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox4";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -457,6 +472,10 @@
 		mailbox5: mailbox@48840000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x48840000 0x200>;
+			interrupts = <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox5";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -466,6 +485,10 @@
 		mailbox6: mailbox@48842000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x48842000 0x200>;
+			interrupts = <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox6";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -475,6 +498,10 @@
 		mailbox7: mailbox@48844000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x48844000 0x200>;
+			interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 258 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 259 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 260 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox7";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -484,6 +511,10 @@
 		mailbox8: mailbox@48846000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x48846000 0x200>;
+			interrupts = <GIC_SPI 261 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 262 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox8";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -493,6 +524,10 @@
 		mailbox9: mailbox@4885e000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x4885e000 0x200>;
+			interrupts = <GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox9";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -502,6 +537,10 @@
 		mailbox10: mailbox@48860000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x48860000 0x200>;
+			interrupts = <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 270 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 271 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 272 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox10";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -511,6 +550,10 @@
 		mailbox11: mailbox@48862000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x48862000 0x200>;
+			interrupts = <GIC_SPI 273 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 274 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 275 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 276 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox11";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -520,6 +563,10 @@
 		mailbox12: mailbox@48864000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x48864000 0x200>;
+			interrupts = <GIC_SPI 277 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox12";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
@@ -529,6 +576,10 @@
 		mailbox13: mailbox@48802000 {
 			compatible = "ti,omap4-mailbox";
 			reg = <0x48802000 0x200>;
+			interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 380 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 381 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH>;
 			ti,hwmods = "mailbox13";
 			ti,mbox-num-users = <4>;
 			ti,mbox-num-fifos = <12>;
-- 
2.1.0

