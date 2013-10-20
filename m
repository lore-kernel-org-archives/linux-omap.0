From: Balaji T K <balajitk@ti.com>
Subject: [PATCH v2 4/6] ARM: dts: dra7-evm: mark eMMC as non removable
Date: Mon, 21 Oct 2013 00:19:57 +0530
Message-ID: <1382294999-18790-5-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
 <1382294999-18790-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43011 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751559Ab3JTSud (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 20 Oct 2013 14:50:33 -0400
In-Reply-To: <1382294999-18790-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org, uri.y@variscite.com, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, Balaji T K <balajitk@ti.com>

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

