From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 16/20] ARM: OMAP3+: SmartReflex: move late_initcall() closer to its argument
Date: Wed,  1 Feb 2012 09:49:55 +0100
Message-ID: <1328086199-28486-17-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:40135 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676Ab2BAIuq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 03:50:46 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so753770wer.19
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 00:50:45 -0800 (PST)
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Felipe Balbi <balbi@ti.com>

no functional changes, trivial patch.

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index eacf4b3..c86880d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1291,12 +1291,12 @@ static int __init sr_init(void)
 
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

