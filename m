From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 02/13] ARM: OMAP3+: SmartReflex: fix err interrupt disable sequence
Date: Wed, 29 Feb 2012 23:33:38 +0100
Message-ID: <1330554829-11347-3-git-send-email-j-pihet@ti.com>
References: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48113 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756558Ab2B2WeT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 29 Feb 2012 17:34:19 -0500
Received: by mail-ww0-f44.google.com with SMTP id dr13so4173817wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 14:34:19 -0800 (PST)
In-Reply-To: <1330554829-11347-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Hilman <khilman@ti.com>
Cc: balbi@ti.com, nm@ti.com, Jean Pihet <j-pihet@ti.com>

From: Nishanth Menon <nm@ti.com>

sr_modify_mask takes mask, value as parameters, the usage
currently is value, mask which is wrong, as a result
vpboundint_st which was supposed to have been disabled,
does not get disabled.

Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 7e755bb..ee224df 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -447,8 +447,8 @@ int sr_configure_errgen(struct voltagedomain *voltdm)
 		sr_errconfig);
 
 	/* Enabling the interrupts if the ERROR module is used */
-	sr_modify_reg(sr, errconfig_offs,
-		vpboundint_en, (vpboundint_en | vpboundint_st));
+	sr_modify_reg(sr, errconfig_offs, (vpboundint_en | vpboundint_st),
+		      vpboundint_en);
 
 	return 0;
 }
-- 
1.7.5.4

