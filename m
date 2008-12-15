From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH] OMAP2/3: SDRC: fix walking of SDRC params list
Date: Mon, 15 Dec 2008 15:31:48 -0800
Message-ID: <1229383908-15065-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.240]:52340 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbYLOXbx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 18:31:53 -0500
Received: by an-out-0708.google.com with SMTP id d40so1214244and.1
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 15:31:52 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

This patch fixes a bug where omap2_sdrc_get_params() does not properly
check for a valid table entry before continuing.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/sdrc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 2a30060..7da6587 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -58,7 +58,7 @@ struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r)
 
 	sp = sdrc_init_params;
 
-	while (sp->rate != r)
+	while (sp->rate && sp->rate != r)
 		sp++;
 
 	if (!sp->rate)
-- 
1.6.0.3

