From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 16/19] ARM: OMAP3+: SmartReflex: move late_initcall() closer to its argument
Date: Tue, 31 Jan 2012 10:58:29 +0100
Message-ID: <1328003912-11709-17-git-send-email-j-pihet@ti.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49867 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846Ab2AaJ7U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:59:20 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so175586wer.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:59:19 -0800 (PST)
In-Reply-To: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
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

