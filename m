From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/2] ARM: dts: OMAP36xx: Fix CPU OPP voltages
Date: Fri, 26 Apr 2013 12:39:32 -0500
Message-ID: <1366997973-19120-2-git-send-email-nm@ti.com>
References: <1366997973-19120-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33749 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756831Ab3DZRjn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Apr 2013 13:39:43 -0400
In-Reply-To: <1366997973-19120-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

commit 3027e26 (ARM: dts: OMAP36xx: Add CPU OPP table)
introduced wrong OPP voltages per OPP by mistake. Sync the OPP
tables with existing OMAP36xx OPP data in
arch/arm/mach-omap2/opp3xxx_data.c

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap36xx.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index b89233e..f3447bc 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -20,9 +20,9 @@
 		cpu@0 {
 			operating-points = <
 				/* kHz    uV */
-				300000   975000
-				600000  1075000
-				800000  1200000
+				300000  1012500
+				600000  1200000
+				800000  1325000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
 		};
-- 
1.7.9.5

