From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 1/8] OMAP: hwmod: Fix the addr spaces count API.
Date: Thu, 8 Sep 2011 10:52:00 +0530
Message-ID: <1315459327-3285-2-git-send-email-santosh.shilimkar@ti.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38742 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab1IHFWX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Sep 2011 01:22:23 -0400
In-Reply-To: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>

From: sricharan <r.sricharan@ti.com>

The address space count API returns the number of address space
entries for a hwmod including a additional null value present in the
address space structure introduced recently. The devices which
have multiple hwmods and use device_build_ss are broken with this,
as their address resources are populated with a extra null value,
subsequently the probe fails. So fix the API not to add the null value.

Signed-off-by: sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 84cc0bd..32a0f48a 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -791,9 +791,11 @@ static int _count_ocp_if_addr_spaces(struct omap_hwmod_ocp_if *os)
 	if (!os || !os->addr)
 		return 0;
 
-	do {
-		mem = &os->addr[i++];
-	} while (mem->pa_start != mem->pa_end);
+	mem = &os->addr[i];
+
+	while (mem->pa_start != mem->pa_end) {
+		mem = &os->addr[++i];
+	};
 
 	return i;
 }
-- 
1.7.4.1

