From: Balaji T K <balajitk@ti.com>
Subject: [PATCH 5/6] ARM: dts: am335x-boneblack: remove unused ti,vcc-aux-disable-is-sleep
Date: Wed, 16 Oct 2013 20:48:26 +0530
Message-ID: <1381936707-10336-6-git-send-email-balajitk@ti.com>
References: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34238 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760309Ab3JPPT0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Oct 2013 11:19:26 -0400
In-Reply-To: <1381936707-10336-1-git-send-email-balajitk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: bcousson@baylibre.com, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, cjb@laptop.org
Cc: linux-omap@vger.kernel.org, uri.y@variscite.com, Balaji T K <balajitk@ti.com>

ti,vcc-aux-disable-is-sleep property does not exist, so remove it.

Signed-off-by: Balaji T K <balajitk@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 2e189cd..7c14801 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -27,7 +27,6 @@
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
-	ti,vcc-aux-disable-is-sleep;
 };
 
 &am33xx_pinmux {
-- 
1.7.5.4

