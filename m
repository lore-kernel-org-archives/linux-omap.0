From: Nishanth Menon <nm@ti.com>
Subject: [PM-SR] [PATCH 1/7] omap3: voltage: cleanup pr_xxxx
Date: Fri, 25 Jun 2010 16:46:34 -0500
Message-ID: <1277502400-9915-2-git-send-email-nm@ti.com>
References: <1277502400-9915-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40637 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078Ab0FYVqq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jun 2010 17:46:46 -0400
In-Reply-To: <1277502400-9915-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>

few more pr_xxxx need cleanup for printing the function name and
not using multiline prints when c allows us to do "".

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Thara Gopinath <thara@ti.com>

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index d289691..963b037 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -253,8 +253,9 @@ static int vp_debug_set(void *data, u64 val)
 		u32 *option = data;
 		*option = val;
 	} else {
-		pr_notice("DEBUG option not enabled!\n	\
-			echo 1 > pm_debug/enable_sr_vp_debug - to enable\n");
+		pr_notice("%s: DEBUG option not enabled! "
+			"echo 1 > pm_debug/enable_sr_vp_debug - to enable\n",
+			__func__);
 	}
 	return 0;
 }
@@ -265,7 +266,7 @@ static int vp_volt_debug_get(void *data, u64 *val)
 	u8 vsel;
 
 	vsel = voltage_read_reg(info->vp_offs.voltage_reg);
-	pr_notice("curr_vsel = %x\n", vsel);
+	pr_notice("%s: curr_vsel = %x\n", __func__, vsel);
 	*val = vsel * 12500 + 600000;
 
 	return 0;
-- 
1.6.3.3

