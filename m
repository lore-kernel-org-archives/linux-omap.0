From: ye janboe <janboe.ye@gmail.com>
Subject: [PATCH] flush the right address after memcpy in omap_sram_push
Date: Fri, 28 Aug 2009 17:09:36 +0800
Message-ID: <af3ea28a0908280209r54f3b4ebi3a4f2c66f891df2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f178.google.com ([209.85.222.178]:37660 "EHLO
	mail-pz0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751049AbZH1JJe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 05:09:34 -0400
Received: by pzk8 with SMTP id 8so1857924pzk.22
        for <linux-omap@vger.kernel.org>; Fri, 28 Aug 2009 02:09:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, tony@atomide.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org

Signed-off-by: janboe <janboe.ye@gmail.com>
---
 arch/arm/plat-omap/sram.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index f2b0fa6..f549d8a 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -270,7 +270,8 @@ void * omap_sram_push(void * start, unsigned long size)
        omap_sram_ceil -= size;
        omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
        memcpy((void *)omap_sram_ceil, start, size);
-       flush_icache_range((unsigned long)start, (unsigned long)(start + size));
+       flush_icache_range((unsigned long)omap_sram_ceil,
+               (unsigned long)(omap_sram_ceil + size));

        return (void *)omap_sram_ceil;
 }
