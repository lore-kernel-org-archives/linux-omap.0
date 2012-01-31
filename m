From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH] ARM: OMAP3+: PM debug: fix the use of debugfs_create_* API
Date: Tue, 31 Jan 2012 12:20:19 +0100
Message-ID: <1328008819-1110-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:58620 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab2AaLUb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 06:20:31 -0500
Received: by werb13 with SMTP id b13so229618wer.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 03:20:30 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

The debugfs_create_* API returns a NULL ptr in case of problem.
Fix the PM debug code to take this into account.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/pm-debug.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 4411163..e5bf367 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -264,8 +264,8 @@ static int __init pm_dbg_init(void)
 		return 0;
 
 	d = debugfs_create_dir("pm_debug", NULL);
-	if (IS_ERR(d))
-		return PTR_ERR(d);
+	if (!d)
+		return -ENOMEM;
 
 	(void) debugfs_create_file("count", S_IRUGO,
 		d, (void *)DEBUG_FILE_COUNTERS, &debug_fops);
-- 
1.7.5.4

