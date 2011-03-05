From: Nishanth Menon <nm@ti.com>
Subject: [PATCH V3 19/19] OMAP3430: SR: class3: restrict CPU to run on
Date: Sat,  5 Mar 2011 20:59:22 +0530
Message-ID: <1299338962-5602-20-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:42787 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752538Ab1CEPcj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 5 Mar 2011 10:32:39 -0500
Received: by gyd10 with SMTP id 10so1374212gyd.26
        for <linux-omap@vger.kernel.org>; Sat, 05 Mar 2011 07:32:38 -0800 (PST)
In-Reply-To: <1299338962-5602-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: linux-arm <linux-arm-kernel@lists.infradead.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, Nishanth Menon <nm@ti.com>

Use SmartReflex AVS Class3 initialization only for OMAP343x family of
processors.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 0136afb..6fbed0c 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <plat/cpu.h>
 #include "smartreflex.h"
 
 static int sr_class3_enable(struct voltagedomain *voltdm,
@@ -49,6 +50,10 @@ static struct omap_sr_class_data class3_data = {
 /* Smartreflex Class3 init API to be called from board file */
 static int __init sr_class3_init(void)
 {
+	/* Enable this class only for OMAP343x */
+	if (!cpu_is_omap343x())
+		return -EINVAL;
+
 	pr_info("SmartReflex Class3 initialized\n");
 	return sr_register_class(&class3_data);
 }
-- 
1.7.1

