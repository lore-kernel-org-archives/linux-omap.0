From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/28] omap2: Fix ARM processor check for 24xx
Date: Fri, 23 Apr 2010 16:11:17 -0700
Message-ID: <20100423231117.31953.35464.stgit@baageli.muru.com>
References: <20100423230829.31953.17334.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56681 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754895Ab0DWXLR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Apr 2010 19:11:17 -0400
In-Reply-To: <20100423230829.31953.17334.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

The value to check is 7 for V6 instead. The code has been
working as it falls through to 24xx code if the other checks
fail.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/include/mach/entry-macro.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/entry-macro.S b/arch/arm/mach-omap2/include/mach/entry-macro.S
index ff25c7e..50fd749 100644
--- a/arch/arm/mach-omap2/include/mach/entry-macro.S
+++ b/arch/arm/mach-omap2/include/mach/entry-macro.S
@@ -52,7 +52,7 @@ omap_irq_base:	.word	0
 
 		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
 		and	\tmp, \tmp, #0x000f0000	@ only check architecture
-		cmp	\tmp, #0x00060000	@ is v6?
+		cmp	\tmp, #0x00070000	@ is v6?
 		beq	2400f			@ found v6 so it's omap24xx
 		mrc	p15, 0, \tmp, c0, c0, 0	@ get processor revision
 		and	\tmp, \tmp, #0x000000f0	@ check cortex 8 or 9

