From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 21/21] arm: omap: smartreflex: micro-optimization for sanity check
Date: Wed, 25 Jan 2012 16:16:23 +0100
Message-ID: <1327504583-13408-22-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:53734 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab2AYPRW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Jan 2012 10:17:22 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so3871040wer.19
        for <linux-omap@vger.kernel.org>; Wed, 25 Jan 2012 07:17:22 -0800 (PST)
In-Reply-To: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

From: Felipe Balbi <balbi@ti.com>

val && (val != 1) == val > 1

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index c2e3d6b..2fe882f 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -1065,7 +1065,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	}
 
 	/* Sanity check */
-	if (val && (val != 1)) {
+	if (val > 1) {
 		pr_warning("%s: Invalid argument %lld\n", __func__, val);
 		return -EINVAL;
 	}
-- 
1.7.5.4

