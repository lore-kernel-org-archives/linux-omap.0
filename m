From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] omap: SRAM: flush the right address after memcpy in
	omap_sram_push
Date: Fri, 02 Oct 2009 15:40:16 -0700
Message-ID: <20091002224016.11962.18728.stgit@localhost>
References: <20091002223510.11962.21751.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:63473 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753954AbZJBWkN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Oct 2009 18:40:13 -0400
In-Reply-To: <20091002223510.11962.21751.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, janboe <janboe.ye@gmail.com>

From: ye janboe <janboe.ye@gmail.com>

the original flush operation is to flush the function address which is
copied from.
But we do not change the function code and it is not necessary to flush it.

Signed-off-by: janboe <janboe.ye@gmail.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/sram.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 925f647..75d1f26 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -270,7 +270,8 @@ void * omap_sram_push(void * start, unsigned long size)
 	omap_sram_ceil -= size;
 	omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
 	memcpy((void *)omap_sram_ceil, start, size);
-	flush_icache_range((unsigned long)start, (unsigned long)(start + size));
+	flush_icache_range((unsigned long)omap_sram_ceil,
+		(unsigned long)(omap_sram_ceil + size));
 
 	return (void *)omap_sram_ceil;
 }

