From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2] OMAP4: Pandaboard: Fix MMC card detect gpio line
Date: Tue, 21 Dec 2010 08:14:34 -0600
Message-ID: <1292940874-21419-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32892 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751167Ab0LUOOs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 09:14:48 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>
Cc: Tony <tony@atomide.com>, Raghuveer Murthy <raghuveer.murthy@ti.com>, Kishore Kadiyala <kishore.kadiyala@ti.com>

From: Raghuveer Murthy <raghuveer.murthy@ti.com>

commit bf56f0a6668cd (2.6.37-rc1), from Nishanth Menon attempted
to fix card detection for PandaBoard, unfortunately, the fix missed
to initialize .gpio_cd member of omap2_hsmmc_info. This results
in a default value of '0', which is a valid GPIO line.
On PandaBoard, the side effect of this is that GPIO line 0 controls
the powering TFP410 DVI chip, and without the fix DVI chip is
inadvertently powered.

Tested-by: David Anders <x0132446@ti.com>

Acked-by: Nishanth Menon <nm@ti.com>

Signed-off-by: Kishore Kadiyala <kishore.kadiyala@ti.com>
Signed-off-by: Raghuveer Murthy <raghuveer.murthy@ti.com>
---
v2: updated comment description to point out the potential regression.
   it might be nice to have this in .37 rc cycle as the change was
   introduced in .37-rc1, however, the DVI functionality(which is impacted
   as a side effect) is not enabled in .37 rc.

v1: http://marc.info/?t=129172419600002&r=1&w=2
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 1ecd0a6..da24745 100644
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
1.6.3.3

