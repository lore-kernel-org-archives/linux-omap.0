From: Constantine Shulyupin <const@MakeLinux.com>
Subject: [PATCH] ARM: OMAP2+: remove duplicated declaration of omap4430_init_late
Date: Fri, 26 Oct 2012 19:29:49 +0200
Message-ID: <1351272589-9885-1-git-send-email-const@MakeLinux.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from oproxy12-pub.bluehost.com ([50.87.16.10]:49174 "HELO
	oproxy12-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965459Ab2JZR34 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 13:29:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Constantine Shulyupin <const@MakeLinux.com>, linux-kernel@vger.kernel.org

From: Constantine Shulyupin <const@MakeLinux.com>

Problem:
Function omap4430_init_late is declared twice in arch/arm/mach-omap2/common.h.
Fix: remove out of order declaration, assuming all functions ordered accordingly processor number.
 

Signed-off-by: Constantine Shulyupin <const@MakeLinux.com>
---
 arch/arm/mach-omap2/common.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 7045e4d..45478d1 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -152,7 +152,6 @@ void am33xx_init_early(void);
 void omap4430_init_early(void);
 void omap5_init_early(void);
 void omap3_init_late(void);	/* Do not use this one */
-void omap4430_init_late(void);
 void omap2420_init_late(void);
 void omap2430_init_late(void);
 void omap3430_init_late(void);
-- 
1.7.9.5

