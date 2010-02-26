From: Sergio Aguirre <saaguirre@ti.com>
Subject: [RFC v2][PATCH 2/5] OMAP clock: Add UART4 autoidle bit for 3630
Date: Fri, 26 Feb 2010 09:53:09 -0600
Message-ID: <1267199592-2245-3-git-send-email-saaguirre@ti.com>
References: <1267199592-2245-1-git-send-email-saaguirre@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34100 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965196Ab0BZPxG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Feb 2010 10:53:06 -0500
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o1QFr4in003742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 26 Feb 2010 09:53:04 -0600
In-Reply-To: <1267199592-2245-1-git-send-email-saaguirre@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sergio Aguirre <saaguirre@ti.com>

Signed-off-by: Sergio Aguirre <saaguirre@ti.com>
---
 arch/arm/mach-omap2/cm-regbits-34xx.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index a3a3ca0..834b671 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -649,6 +649,8 @@
 #define OMAP3430_ST_MCBSP2_MASK				(1 << 0)
 
 /* CM_AUTOIDLE_PER */
+#define OMAP3630_AUTO_UART4				(1 << 18)
+#define OMAP3630_AUTO_UART4_SHIFT			18
 #define OMAP3430_AUTO_GPIO6				(1 << 17)
 #define OMAP3430_AUTO_GPIO6_SHIFT			17
 #define OMAP3430_AUTO_GPIO5				(1 << 16)
-- 
1.6.3.3

