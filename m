From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCHv3 3/9] ARM: OMAP: DTB: Update IRQ data for WKUP_M3
Date: Tue, 6 Aug 2013 12:49:30 -0500
Message-ID: <1375811376-49985-4-git-send-email-d-gerlach@ti.com>
References: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:60795 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756130Ab3HFRuh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 6 Aug 2013 13:50:37 -0400
In-Reply-To: <1375811376-49985-1-git-send-email-d-gerlach@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@linaro.org>, Vaibhav Bedia <vaibhav.bedia@ti.com>, Dave Gerlach <d-gerlach@ti.com>, Benoit Cousson <benoit.cousson@linaro.org>

From: Vaibhav Bedia <vaibhav.bedia@ti.com>

Allow interrupt for wkup_m3 to be set from DT.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
Cc: Benoit Cousson <benoit.cousson@linaro.org>
---
 arch/arm/boot/dts/am33xx.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 38b446b..05353bf 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -491,6 +491,7 @@
 			compatible = "ti,am3353-wkup-m3";
 			reg = <0x44d00000 0x4000	/* M3 UMEM */
 			       0x44d80000 0x2000>;	/* M3 DMEM */
+			interrupts = <78>;
 			ti,hwmods = "wkup_m3";
 		};
 
-- 
1.7.9.5

