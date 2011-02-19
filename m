From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 04/19] omap3+: voltage: remove spurious pr_notice for debugfs
Date: Sat, 19 Feb 2011 17:31:43 +0530
Message-ID: <1298116918-30744-5-git-send-email-nm@ti.com>
References: <1298116918-30744-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:53051 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751648Ab1BSMCk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 19 Feb 2011 07:02:40 -0500
Received: by mail-yx0-f181.google.com with SMTP id 8so497985yxm.12
        for <linux-omap@vger.kernel.org>; Sat, 19 Feb 2011 04:02:39 -0800 (PST)
In-Reply-To: <1298116918-30744-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@ti.com>, Nishanth Menon <nm@ti.com>

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

