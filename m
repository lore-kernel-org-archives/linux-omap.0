From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 11/13] ARM: OMAP3+: SmartReflex: micro-optimization for sanity check
Date: Wed, 29 Feb 2012 23:33:47 +0100
Message-ID: <1330554829-11347-12-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36364 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964936Ab2B2Wee (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 17:34:34 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm11so3014662wib.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 14:34:34 -0800 (PST)
In-Reply-To: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
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
index 2774cf3..d0867b6 100644
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

