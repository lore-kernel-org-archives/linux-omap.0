From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH] ARM: dts: am437x-gp-evm: Do not reset gpio5
Date: Fri, 21 Mar 2014 10:50:13 +0530
Message-ID: <1395379213-15451-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43105 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752549AbaCUFUy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 21 Mar 2014 01:20:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com, tony@atomide.com, devicetree@vger.kernel.org, nsekhar@ti.com, rnayak@ti.com, nm@ti.com, mark.rutland@arm.com, lokeshvutla@ti.com, Dave Gerlach <d-gerlach@ti.com>

From: Dave Gerlach <d-gerlach@ti.com>

Do not reset GPIO5 at boot-up because GPIO5_7 is used
on AM437x GP-EVM to control VTT regulators on DDR3.
Without this some GP-EVM boards will fail to boot because
of DDR3 corruption.

Reported-by: Nishanth Menon <nm@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
This is applied on top of current linux-next.
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master

 arch/arm/boot/dts/am437x-gp-evm.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index df8798e..a055f7f 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -117,6 +117,11 @@
 	status = "okay";
 };
 
+&gpio5 {
+	status = "okay";
+	ti,no-reset-on-init;
+};
+
 &mmc1 {
 	status = "okay";
 	vmmc-supply = <&vmmcsd_fixed>;
-- 
1.7.9.5

