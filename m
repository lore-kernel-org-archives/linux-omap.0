From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 03/18] omap3+: voltage: remove spurious pr_notice for debugfs
Date: Wed,  2 Mar 2011 16:25:16 +0530
Message-ID: <1299063331-27968-4-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:45499 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757004Ab1CBK4I (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:56:08 -0500
Received: by mail-gy0-f178.google.com with SMTP id 8so2915642gyg.37
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:56:07 -0800 (PST)
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

cat of debugfs entry for vp_volt provides voltage. The additional pr_notice
is just spam on console and provides no additional information.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 280ee12..992b383 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -347,7 +347,6 @@ static int vp_volt_debug_get(void *data, u64 *val)
 	}
 
 	vsel = vdd->read_reg(vdd->vp_reg.prm_mod, vdd->vp_offs.voltage);
-	pr_notice("curr_vsel = %x\n", vsel);
 
 	if (!vdd->pmic_info->vsel_to_uv) {
 		pr_warning("PMIC function to convert vsel to voltage"
-- 
1.7.1

