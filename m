From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2+: sdrc: fix compile break on OMAP4-only config on
 current omap-for-linus
Date: Fri, 25 Feb 2011 18:40:22 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1102251839360.6198@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:38680 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750860Ab1BZBkX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 20:40:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com


On non-OMAP2 and non-OMAP3 kernel configs, turn omap2_sdrc_init() into
a no-op.  Otherwise, compilation breaks on an OMAP4-only config with
the current omap-for-linus branch:

arch/arm/mach-omap2/built-in.o: In function `omap2_init_common_devices':
../mach-omap2/io.c:421: undefined reference to `omap2_sdrc_init'

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/sdrc.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/sdrc.h b/arch/arm/plat-omap/include/plat/sdrc.h
index efd87c8..5a44b14 100644
--- a/arch/arm/plat-omap/include/plat/sdrc.h
+++ b/arch/arm/plat-omap/include/plat/sdrc.h
@@ -124,8 +124,13 @@ struct omap_sdrc_params {
 	u32 mr;
 };
 
+#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3)
 void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 			    struct omap_sdrc_params *sdrc_cs1);
+#else
+#define omap2_sdrc_init(x, y)		0
+#endif
+
 int omap2_sdrc_get_params(unsigned long r,
 			  struct omap_sdrc_params **sdrc_cs0,
 			  struct omap_sdrc_params **sdrc_cs1);
-- 
1.7.2.3

