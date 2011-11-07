From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH] ARM: omap4: prm: Fix up swapped offset macros
Date: Mon, 7 Nov 2011 15:36:26 +0530
Message-ID: <1320660386-18148-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44784 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752747Ab1KGKGg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Nov 2011 05:06:36 -0500
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id pA7A6XAl020995
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 7 Nov 2011 04:06:35 -0600
Received: from DBDE70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id pA7A6WkG014182
	for <linux-omap@vger.kernel.org>; Mon, 7 Nov 2011 15:36:33 +0530 (IST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>, Gina Glaser <g-glaser@ti.com>

The offset macros for OMAP4_RM_RSTST and OMAP4_RM_RSTTIME
are wrongly swapped up.

Thanks to Gina Glaser for identifying and reporting this.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Cc: Gina Glaser <g-glaser@ti.com>
---
 arch/arm/mach-omap2/prm44xx.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm44xx.h b/arch/arm/mach-omap2/prm44xx.h
index 3d66ccd..aa8593e 100644
--- a/arch/arm/mach-omap2/prm44xx.h
+++ b/arch/arm/mach-omap2/prm44xx.h
@@ -62,8 +62,8 @@
 
 /* OMAP4 specific register offsets */
 #define OMAP4_RM_RSTCTRL				0x0000
-#define OMAP4_RM_RSTTIME				0x0004
-#define OMAP4_RM_RSTST					0x0008
+#define OMAP4_RM_RSTST					0x0004
+#define OMAP4_RM_RSTTIME				0x0008
 #define OMAP4_PM_PWSTCTRL				0x0000
 #define OMAP4_PM_PWSTST					0x0004
 
-- 
1.7.1

