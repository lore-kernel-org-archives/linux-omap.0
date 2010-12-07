From: Raghuveer Murthy <raghuveer.murthy@ti.com>
Subject: [PATCH] OMAP4: Pandaboard: Fixing MMC card detect gpio line
Date: Tue,  7 Dec 2010 17:43:06 +0530
Message-ID: <1291723986-24658-1-git-send-email-raghuveer.murthy@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:59427 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752566Ab0LGMOG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Dec 2010 07:14:06 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id oB7CE2MS027730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 7 Dec 2010 06:14:04 -0600
Received: from localhost.localdomain (localhost [127.0.0.1])
	by dbdp31.itg.ti.com (8.13.8/8.13.8) with ESMTP id oB7CE1Cg021230
	for <linux-omap@vger.kernel.org>; Tue, 7 Dec 2010 17:44:01 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The .gpio_cd member of omap2_hsmmc_info is not initialized. This
will default to zero. On Pandaboard this interferes with gpio line
assigned for powering TFP410 DVI chip.

This fix was missed out in the previous commit bf56f0a6668cd, from
Nishanth Menon

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
Acked-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index ad6b5cc..0ccc24f 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -142,6 +142,7 @@ static struct omap2_hsmmc_info mmc[] = {
 		.mmc		= 1,
 		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_wp	= -EINVAL,
+		.gpio_cd	= -EINVAL,
 	},
 	{}	/* Terminator */
 };
-- 
1.7.0.4

