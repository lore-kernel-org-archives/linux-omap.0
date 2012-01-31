From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 14/19] ARM: OMAP3+: SmartReflex Class3: restrict CPU to run on
Date: Tue, 31 Jan 2012 10:58:27 +0100
Message-ID: <1328003912-11709-15-git-send-email-j-pihet@ti.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:61170 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab2AaJ7R (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:59:17 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so4219621wic.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:59:16 -0800 (PST)
In-Reply-To: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

Use SmartReflex AVS Class3 initialization only for OMAP343x family of
processors.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex-class3.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 9dcda93..735937a 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -11,6 +11,7 @@
  * published by the Free Software Foundation.
  */
 
+#include <plat/cpu.h>
 #include "smartreflex.h"
 
 static int sr_class3_enable(struct voltagedomain *voltdm,
@@ -58,6 +59,10 @@ static struct omap_sr_class_data class3_data = {
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
1.7.5.4

