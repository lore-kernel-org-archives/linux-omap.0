From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v3 01/11] ARM: OMAP2+: pm: Do not init statically the SR and voltage layer with DT
Date: Tue, 20 Dec 2011 17:27:14 +0100
Message-ID: <1324398444-23296-2-git-send-email-b-cousson@ti.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48125 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193Ab1LTQ1z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Dec 2011 11:27:55 -0500
In-Reply-To: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: rob.herring@calxeda.com, tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, Benoit Cousson <b-cousson@ti.com>

In the case of DT, the PMIC and SR initialization will be done using
a completely different mechanism.

Disable this part if a DT blob is available.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Kevin Hilman <khilman@ti.com>
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

