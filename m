From: ye janboe <janboe.ye@gmail.com>
Subject: [PATCH] flush the function in sdram is not correct because sram is
	changed.
Date: Fri, 28 Aug 2009 13:56:57 +0800
Message-ID: <af3ea28a0908272256k1743b528pdfb3dcdb88848544@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f178.google.com ([209.85.222.178]:34529 "EHLO
	mail-pz0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbZH1F4z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Aug 2009 01:56:55 -0400
Received: by pzk8 with SMTP id 8so1743639pzk.22
        for <linux-omap@vger.kernel.org>; Thu, 27 Aug 2009 22:56:58 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, khilman@deeprootsystems.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org

>From f10090bf307066f1317d7152c6f9a6f395007d4a Mon Sep 17 00:00:00 2001
From: janboe <janboe.ye@gmail.com>
Date: Fri, 28 Aug 2009 13:50:57 +0800
Subject: [PATCH] flush the function in sdram is not correct because
sram is changed.

Signed-off-by: janboe <janboe.ye@gmail.com>
---
 arch/arm/plat-omap/sram.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index f2b0fa6..253fcf7 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -270,7 +270,7 @@ void * omap_sram_push(void * start, unsigned long size)
        omap_sram_ceil -= size;
        omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
        memcpy((void *)omap_sram_ceil, start, size);
-       flush_icache_range((unsigned long)start, (unsigned long)(start + size));
+       flush_icache_range((unsigned long)omap_sram_ceil, (unsigned
long)(omap_sram_ceil + size));

        return (void *)omap_sram_ceil;
 }
-- 
1.6.3.3
