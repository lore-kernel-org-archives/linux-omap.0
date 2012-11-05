From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/6] ARM: OMAP: SmartReflex: use pr_warn instead of pr_warning
Date: Mon, 5 Nov 2012 09:02:13 -0600
Message-ID: <1352127734-30103-7-git-send-email-nm@ti.com>
References: <1352127734-30103-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40035 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932618Ab2KEPCk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 10:02:40 -0500
In-Reply-To: <1352127734-30103-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Rafael <rjw@sisk.pl>, Kevin Hilman <khilman@ti.com>, Anton Vorontsov <cbouatmailru@gmail.com>, linux-pm <linux-pm@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Minor cleanup to use the preferred pr_warn

Acked-by: Jean Pihet <j-pihet@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 7ccf57f..23d45f9 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -18,8 +18,8 @@ static int sr_class3_enable(struct omap_sr *sr)
 	unsigned long volt = voltdm_get_voltage(sr->voltdm);
 
 	if (!volt) {
-		pr_warning("%s: Curr voltage unknown. Cannot enable %s\n",
-				__func__, sr->name);
+		pr_warn("%s: Curr voltage unknown. Cannot enable %s\n",
+			__func__, sr->name);
 		return -ENODATA;
 	}
 	if (!sr->soc_ops.vp_enable) {
-- 
1.7.9.5

