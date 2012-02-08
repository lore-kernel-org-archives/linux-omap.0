From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 12/14] ARM: OMAP3+: SmartReflex: micro-optimization for sanity check
Date: Wed,  8 Feb 2012 18:43:57 +0100
Message-ID: <1328723039-15952-13-git-send-email-j-pihet@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:34688 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756610Ab2BHRon (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 12:44:43 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so574409wer.19
        for <linux-omap@vger.kernel.org>; Wed, 08 Feb 2012 09:44:42 -0800 (PST)
In-Reply-To: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, nm@ti.com, Jean Pihet <j-pihet@ti.com>

From: Felipe Balbi <balbi@ti.com>

val && (val != 1) == val > 1

Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index f1db4c6..daf8053 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -886,7 +886,7 @@ static int omap_sr_autocomp_store(void *data, u64 val)
 	}
 
 	/* Sanity check */
-	if (val && (val != 1)) {
+	if (val > 1) {
 		pr_warning("%s: Invalid argument %lld\n", __func__, val);
 		return -EINVAL;
 	}
-- 
1.7.5.4

