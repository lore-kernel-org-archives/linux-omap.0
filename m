From: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
Subject: [PATCH] ARM: dts: omap3-devkit8000: Fix NAND DT node
Date: Tue, 19 May 2015 23:09:53 +0200
Message-ID: <1432069793-10141-1-git-send-email-anthoine.bourgeois@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36277 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbbESVKY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2015 17:10:24 -0400
Received: by wgbgq6 with SMTP id gq6so31918462wgb.3
        for <linux-omap@vger.kernel.org>; Tue, 19 May 2015 14:10:22 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>

Add nand-ecc-opt and device-width properties to enable nand support on
Devkit8000.

Signed-off-by: Anthoine Bourgeois <anthoine.bourgeois@gmail.com>
---
 arch/arm/boot/dts/omap3-devkit8000.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-devkit8000.dts b/arch/arm/boot/dts/omap3-devkit8000.dts
index 169037e..283db1d 100644
--- a/arch/arm/boot/dts/omap3-devkit8000.dts
+++ b/arch/arm/boot/dts/omap3-devkit8000.dts
@@ -111,6 +111,8 @@
 	nand@0,0 {
 		reg = <0 0 4>; /* CS0, offset 0, IO size 4 */
 		nand-bus-width = <16>;
+		gpmc,device-width = <2>;
+		ti,nand-ecc-opt = "sw";
 
 		gpmc,sync-clk-ps = <0>;
 		gpmc,cs-on-ns = <0>;
-- 
2.0.5

