From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 4/6] ARM: dts: dra7-evm: mark eMMC as non removable
Date: Wed, 16 Oct 2013 20:48:25 +0530
Message-ID: <1381936707-10336-5-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59684 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759976Ab3JPPTW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Oct 2013 11:19:22 -0400
In-Reply-To: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, uri.y@variscite.com, Balaji T K <balajitk@ti.com>

Mark the eMMC on dra7-evm as non removable.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 3abf5f4..799890f 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -268,4 +268,5 @@
 	status = "okay";
 	vmmc-supply = <&mmc2_3v3>;
 	bus-width = <8>;
+	non-removable;
 };
-- 
1.7.5.4

