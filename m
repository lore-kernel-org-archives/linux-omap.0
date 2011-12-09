From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 01/10] ARM: OMAP2+: pm: Do not init statically the SR and voltage layer with DT
Date: Fri, 9 Dec 2011 15:02:32 +0100
Message-ID: <1323439361-1647-2-git-send-email-b-cousson@ti.com>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45306 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751693Ab1LIODG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Dec 2011 09:03:06 -0500
In-Reply-To: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, rob.herring@calxeda.com
Cc: devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>, Kevin Hilman <khilman@ti.com>

In the case of DT, the PMIC and SR initialization will be done using
a completely different mechanism.

Disable this part if a DT blob is available.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/pm.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
index 1881fe9..ad4f693 100644
--- a/arch/arm/mach-omap2/pm.c
+++ b/arch/arm/mach-omap2/pm.c
@@ -227,6 +227,14 @@ postcore_initcall(omap2_common_pm_init);
 
 static int __init omap2_common_pm_late_init(void)
 {
+	/*
+	 * In the case of DT, the PMIC and SR initialization will be done using
+	 * a completely different mechanism.
+	 * Disable this part if a DT blob is available.
+	 */
+	if (of_have_populated_dt())
+		return 0;
+
 	/* Init the voltage layer */
 	omap_pmic_late_init();
 	omap_voltage_late_init();
-- 
1.7.0.4

