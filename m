From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 03/19] OMAP3+: voltage: remove initial voltage
Date: Sat,  5 Mar 2011 20:59:06 +0530
Message-ID: <1299338962-5602-4-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:48208 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751282Ab1CEPaD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:30:03 -0500
Received: by gxk3 with SMTP id 3so181263gxk.12
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:30:01 -0800 (PST)
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

Blindly setting a 1.2V setting in the initial structure may not even
match the default voltages stored in the voltage table which are
supported for the domain. For example, OMAP3430 core domain does not
use 1.2V and ends up generating a warning on the first transition.

Further, since omap2_set_init_voltage is called as part of the pm
framework's initialization sequence to configure the voltage required
for the current OPP, the call does(and has to) setup the system
voltage(curr_volt as a result) using the right mechanisms appropriate
for the system at that point of time. This also overrides
initialization we are currently doing in voltage.c making it
redundant. So, remove the wrong and redundant initialization.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/voltage.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 56961df..1b40aa0 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -116,7 +116,6 @@ static int __init _config_common_vdd_data(struct omap_vdd_info *vdd)
 	sys_clk_speed /= 1000;
 
 	/* Generic voltage parameters */
-	vdd->curr_volt = 1200000;
 	vdd->volt_scale = vp_forceupdate_scale_voltage;
 	vdd->vp_enabled = false;
 
-- 
1.7.1

