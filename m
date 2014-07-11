From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH v4 07/11] ARM: dts: am33xx: Update wkup_m3 node
Date: Thu, 10 Jul 2014 21:55:45 -0500
Message-ID: <1405047349-15101-8-git-send-email-d-gerlach@ti.com>
References: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60127 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752288AbaGKC5q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jul 2014 22:57:46 -0400
In-Reply-To: <1405047349-15101-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Russ Dill <russ.dill@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Daniel Mack <daniel@zonque.org>, Suman Anna <s-anna@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Dave Gerlach <d-gerlach@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>

Allow interrupt for wkup_m3 to be set from DT, add regs for
IPC regs to allow pm code to communicate with wkup_m3, and add data
needed for mailbox channel.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
CC: Ohad Ben-Cohen <ohad@wizery.com>
CC: Benoit Cousson <bcousson@baylibre.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 6f8f7cf..fe0cff5 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -736,10 +736,15 @@
 
 		wkup_m3: wkup_m3@44d00000 {
 			compatible = "ti,am3353-wkup-m3";
-			reg = <0x44d00000 0x4000	/* M3 UMEM */
-			       0x44d80000 0x2000>;	/* M3 DMEM */
+			reg = <0x44d00000 0x4000
+			       0x44d80000 0x2000
+			       0x44e11324 0x0024>;
+			reg-names = "m3_umem", "m3_dmem", "ipc_regs";
+			interrupts = <78>;
 			ti,hwmods = "wkup_m3";
 			ti,no-reset-on-init;
+			mbox-names = "wkup_m3";
+			mbox = <&mailbox &mbox_wkupm3>;
 		};
 
 		elm: elm@48080000 {
-- 
1.9.0

