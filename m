From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 10/14] ARM: OMAP3+: SmartReflex: move late_initcall() closer to its argument
Date: Wed,  8 Feb 2012 18:43:55 +0100
Message-ID: <1328723039-15952-11-git-send-email-j-pihet@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:41928 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab2BHRok (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:44:40 -0500
Received: by mail-wi0-f174.google.com with SMTP id s10so579415wic.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 09:44:39 -0800 (PST)
In-Reply-To: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, nm@ti.com, Jean Pihet <j-pihet@ti.com>

From: Felipe Balbi <balbi@ti.com>

no functional changes, trivial patch.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index b5dc109..72fe4d1 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1117,12 +1117,12 @@ static int __init sr_init(void)
 
 	return 0;
 }
+late_initcall(sr_init);
 
 static void __exit sr_exit(void)
 {
 	platform_driver_unregister(&smartreflex_driver);
 }
-late_initcall(sr_init);
 module_exit(sr_exit);
 
 MODULE_DESCRIPTION("OMAP Smartreflex Driver");
-- 
1.7.5.4

