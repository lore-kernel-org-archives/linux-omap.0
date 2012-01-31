From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 03/19] ARM: OMAP3+: SmartReflex: fix err interrupt disable sequence
Date: Tue, 31 Jan 2012 10:58:16 +0100
Message-ID: <1328003912-11709-4-git-send-email-j-pihet@ti.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49867 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab2AaJ7B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:59:01 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so175586wer.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:59:00 -0800 (PST)
In-Reply-To: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

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

