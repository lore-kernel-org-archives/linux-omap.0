From: Christoph Fritz <chf.fritz@googlemail.com>
Subject: [PATCH 3/5] ARM: dts: omap3: set mcbsp2 status
Date: Fri, 23 May 2014 01:06:24 +0200
Message-ID: <1400799986-20043-4-git-send-email-chf.fritz@googlemail.com>
References: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-la0-f41.google.com ([209.85.215.41]:64315 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752898AbaEVXG7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2014 19:06:59 -0400
Received: by mail-la0-f41.google.com with SMTP id e16so3306549lan.14
        for <linux-omap@vger.kernel.org>; Thu, 22 May 2014 16:06:57 -0700 (PDT)
In-Reply-To: <1400799986-20043-1-git-send-email-chf.fritz@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pekon Gupta <pekon@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This patch fixes audio support for omap3-lilly-a83x.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index cc1dce6..2b3af90 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -357,6 +357,10 @@
 	power = <50>;
 };
 
+&mcbsp2 {
+	status = "okay";
+};
+
 &gpmc {
 	ranges = <0 0 0x30000000 0x1000000>,
 		<7 0 0x15000000 0x01000000>;
-- 
1.7.10.4

