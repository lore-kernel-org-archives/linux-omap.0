From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 09/13] ARM: OMAP3+: SmartReflex: move late_initcall() closer to its argument
Date: Wed, 29 Feb 2012 23:33:45 +0100
Message-ID: <1330554829-11347-10-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:33567 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964876Ab2B2Wea (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 17:34:30 -0500
Received: by mail-we0-f174.google.com with SMTP id x9so2023831wej.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 14:34:29 -0800 (PST)
In-Reply-To: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
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
index 22fe442..fc59a24 100644
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

