From: Nishanth Menon <nm@ti.com>
Subject: [PATCH v2 18/18] omap3430: sr: class3: restrict cpu to run on
Date: Wed,  2 Mar 2011 16:25:31 +0530
Message-ID: <1299063331-27968-19-git-send-email-nm@ti.com>
References: <1299063331-27968-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:47082 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757116Ab1CBK6V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Mar 2011 05:58:21 -0500
Received: by mail-yx0-f171.google.com with SMTP id 35so3110861yxh.2
        for <linux-omap@vger.kernel.org>; Wed, 02 Mar 2011 02:58:20 -0800 (PST)
In-Reply-To: <1299063331-27968-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Kevin H <khilman@ti.com>, Tony L <tony@atomide.com>, linux-arm <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>

Use SmartReflex AVS Class3 initialization only for OMAP343x family of
processors.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 5f7a33e..f99e517 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <plat/cpu.h>
 #include <plat/smartreflex.h>
 
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

