From: Abhilash K V <abhilash.kv@ti.com>
Subject: [PATCH v5 3/3] OMAP2+: voltage: add check for missing PMIC info in vp init
Date: Fri, 30 Sep 2011 11:42:33 +0530
Message-ID: <1317363153-10259-4-git-send-email-abhilash.kv@ti.com>
References: <1317363153-10259-1-git-send-email-abhilash.kv@ti.com>
 <1317363153-10259-2-git-send-email-abhilash.kv@ti.com>
 <1317363153-10259-3-git-send-email-abhilash.kv@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53716 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756830Ab1I3GNE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Sep 2011 02:13:04 -0400
In-Reply-To: <1317363153-10259-3-git-send-email-abhilash.kv@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: tony@atomide.com, linux@arm.linux.org.uk, b-cousson@ti.com, paul@pwsan.com, aneesh@ti.com, khilman@ti.com, santosh.shilimkar@ti.com, christian.gmeiner@gmail.com, Abhilash K V <abhilash.kv@ti.com>

From: Abhilash K V <abhilash.kv@ti.com>

If PMIC info is not available in omap_vp_init(), abort.

Signed-off-by: Abhilash K V <abhilash.kv@ti.com>
---
 arch/arm/mach-omap2/vp.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/vp.c b/arch/arm/mach-omap2/vp.c
index 66bd700..0ed3d13 100644
--- a/arch/arm/mach-omap2/vp.c
+++ b/arch/arm/mach-omap2/vp.c
@@ -41,6 +41,13 @@ void __init omap_vp_init(struct voltagedomain *voltdm)
 	u32 val, sys_clk_rate, timeout, waittime;
 	u32 vddmin, vddmax, vstepmin, vstepmax;
 
+	if (!voltdm->pmic || !voltdm->pmic->uv_to_vsel) {
+		pr_err("%s: PMIC info requried to configure VP for "
+			"vdd_%s not populated.Hence cannot initialize VP\n",
+			__func__, voltdm->name);
+		return;
+	}
+
 	if (!voltdm->read || !voltdm->write) {
 		pr_err("%s: No read/write API for accessing vdd_%s regs\n",
 			__func__, voltdm->name);
-- 
1.7.1

