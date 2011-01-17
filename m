From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 5/7] arm: omap2: mux: fix compile warning
Date: Mon, 17 Jan 2011 06:31:18 +0200
Message-ID: <1295238680-26738-6-git-send-email-balbi@ti.com>
References: <1295238680-26738-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41247 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752338Ab1AQEcE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sun, 16 Jan 2011 23:32:04 -0500
Received: by yxt3 with SMTP id 3so2043893yxt.5
        for <linux-omap@vger.kernel.org>; Sun, 16 Jan 2011 20:32:03 -0800 (PST)
In-Reply-To: <1295238680-26738-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

Fix the following compile warning:
arch/arm/mach-omap2/mux.c: In function '_omap_mux_get_by_name':
arch/arm/mach-omap2/mux.c:163:17: warning: 'found_mode' may be used
uninitialized in this function

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/mux.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index df8d2f2..fae49d1 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -160,7 +160,7 @@ static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
 	struct omap_mux *mux = NULL;
 	struct omap_mux_entry *e;
 	const char *mode_name;
-	int found = 0, found_mode, mode0_len = 0;
+	int found = 0, found_mode = 0, mode0_len = 0;
 	struct list_head *muxmodes = &partition->muxmodes;
 
 	mode_name = strchr(muxname, '.');
-- 
1.7.3.4.598.g85356

