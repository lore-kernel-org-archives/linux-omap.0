From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 3/5] ARM: OMAP: prm: Allow prm init to success on OMAP5 SOCs
Date: Fri, 18 Jan 2013 21:02:19 +0530
Message-ID: <1358523141-12295-4-git-send-email-santosh.shilimkar@ti.com>
References: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40032 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751395Ab3ARPbf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 10:31:35 -0500
In-Reply-To: <1358523141-12295-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, Santosh Shilimkar <santosh.shilimkar@ti.com>

Allow prm init to success on OMAP5 SOCs.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/prm44xx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/prm44xx.c b/arch/arm/mach-omap2/prm44xx.c
index c05a343..1aae198 100644
--- a/arch/arm/mach-omap2/prm44xx.c
+++ b/arch/arm/mach-omap2/prm44xx.c
@@ -650,7 +650,7 @@ static struct prm_ll_data omap44xx_prm_ll_data = {
 
 int __init omap44xx_prm_init(void)
 {
-	if (!cpu_is_omap44xx())
+	if (!cpu_is_omap44xx() && !soc_is_omap54xx())
 		return 0;
 
 	return prm_register(&omap44xx_prm_ll_data);
-- 
1.7.9.5

