From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH v2 2/2] ARM: OMAP4: Register the OPP table only for 4430 device
Date: Thu, 9 Aug 2012 12:38:22 +0530
Message-ID: <1344496102-24451-3-git-send-email-rnayak@ti.com>
References: <1344496102-24451-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51996 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755563Ab2HIHIk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 9 Aug 2012 03:08:40 -0400
In-Reply-To: <1344496102-24451-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>

The 4430 OPP table was being registered for all other OMAP4 variants
too, like 4460 and 4470 causing issues with cpufreq driver
enabled. 4460 and 4470 devices have different OPPs as compared to
4430, and they should be populated seperately. As long as that
happens, let the OPP table registeration happen only on 4430 device.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/opp4xxx_data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/opp4xxx_data.c b/arch/arm/mach-omap2/opp4xxx_data.c
index 2293ba2..c95415d 100644
--- a/arch/arm/mach-omap2/opp4xxx_data.c
+++ b/arch/arm/mach-omap2/opp4xxx_data.c
@@ -94,7 +94,7 @@ int __init omap4_opp_init(void)
 {
 	int r = -ENODEV;
 
-	if (!cpu_is_omap44xx())
+	if (!cpu_is_omap443x())
 		return r;
 
 	r = omap_init_opp_table(omap44xx_opp_def_list,
-- 
1.7.9.5

