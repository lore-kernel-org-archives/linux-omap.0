From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] ARM: dts: OMAP4460: Fix CPU OPP voltages
Date: Fri, 26 Apr 2013 12:39:33 -0500
Message-ID: <1366997973-19120-3-git-send-email-nm@ti.com>
References: <1366997973-19120-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52166 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757107Ab3DZRjo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Apr 2013 13:39:44 -0400
In-Reply-To: <1366997973-19120-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>

commit d16fb25 (ARM: dts: OMAP4460: Add CPU OPP table)
introduced wrong OPP voltages per OPP by mistake. Sync the OPP
tables with existing OMAP4460 OPP data in
arch/arm/mach-omap2/opp4xxx_data.c

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap4460.dtsi |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap4460.dtsi b/arch/arm/boot/dts/omap4460.dtsi
index 7c2c23c..2cf227c 100644
--- a/arch/arm/boot/dts/omap4460.dtsi
+++ b/arch/arm/boot/dts/omap4460.dtsi
@@ -15,9 +15,9 @@
 		cpu@0 {
 			operating-points = <
 				/* kHz    uV */
-				350000   975000
-				700000  1075000
-				920000  1200000
+				350000  1025000
+				700000  1200000
+				920000  1313000
 			>;
 			clock-latency = <300000>; /* From legacy driver */
 		};
-- 
1.7.9.5

