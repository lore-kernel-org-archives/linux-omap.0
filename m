From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 04/19] OMAP3+: voltage: remove spurious pr_notice for debugfs
Date: Sat,  5 Mar 2011 20:59:07 +0530
Message-ID: <1299338962-5602-5-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:41455 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752464Ab1CEPaQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:30:16 -0500
Received: by gwj15 with SMTP id 15so1184247gwj.22
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:30:14 -0800 (PST)
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

cat of debugfs entry for vp_volt provides voltage. The additional pr_notice
is just spam on console and provides no additional information.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 1b40aa0..53c399f 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -150,7 +150,6 @@ static int vp_volt_debug_get(void *data, u64 *val)
 	}
 
 	vsel = vdd->read_reg(prm_mod_offs, vdd->vp_data->voltage);
-	pr_notice("curr_vsel = %x\n", vsel);
 
 	if (!vdd->pmic_info->vsel_to_uv) {
 		pr_warning("PMIC function to convert vsel to voltage"
-- 
1.7.1

