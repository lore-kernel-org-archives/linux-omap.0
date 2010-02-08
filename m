From: "Guzman Lugo, Fernando" <x0095840@ti.com>
Subject: DSPBRIDGE: Replace page_address with kmap
Date: Mon, 8 Feb 2010 16:14:59 -0600
Message-ID: <496565EC904933469F292DDA3F1663E602AA6587B3@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51419 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859Ab0BHWPB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Feb 2010 17:15:01 -0500
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Ameya Palande <ameya.palande@nokia.com>, Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

>From 07880b3410ad19962d16ce1415f0423dfeed17da Mon Sep 17 00:00:00 2001
From: Fernando Guzman Lugo <x0095840@ti.com>
Date: Fri, 5 Feb 2010 01:35:35 -0600
Subject: [PATCH] DSPBRIDGE: Replace page_address with kmap

Replace page_address with kmap to get address in case of high mem allocation.

Signed-off-by: Fernando Guzman Lugo <x0095840@ti.com>
---
 drivers/dsp/bridge/rmgr/proc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dsp/bridge/rmgr/proc.c b/drivers/dsp/bridge/rmgr/proc.c
index 4f179ac..72c86df 100644
--- a/drivers/dsp/bridge/rmgr/proc.c
+++ b/drivers/dsp/bridge/rmgr/proc.c
@@ -585,11 +585,11 @@ static int memory_sync_page(struct vm_area_struct *vma, unsigned long start,
 		}
 
 		offset = start & ~PAGE_MASK;
-		kaddr = page_address(page) + offset;
+		kaddr = kmap(page) + offset;
 		rest = min_t(ssize_t, PAGE_SIZE - offset, len);
-
 		MEM_FlushCache(kaddr, rest, ftype);
 
+		kunmap(page);
 		put_page(page);
 		len -= rest;
 		start += rest;
-- 
1.6.0.4
