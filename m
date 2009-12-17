From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCHv2 03/18] DSPBRIDGE: Remove preproessor condition that could never work
Date: Wed, 16 Dec 2009 20:15:48 -0600
Message-ID: <1261016163-11091-4-git-send-email-omar.ramirez@ti.com>
References: <1261016163-11091-1-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-2-git-send-email-omar.ramirez@ti.com>
 <1261016163-11091-3-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57400 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763897AbZLQCIs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Dec 2009 21:08:48 -0500
In-Reply-To: <1261016163-11091-3-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: Hiroshi Doyu <Hiroshi.DOYU@nokia.com>, Ameya Palande <ameya.palande@nokia.com>, Felipe Contreras <felipe.contreras@nokia.com>, Fernando Guzman <x0095840@ti.com>, Ernesto Ramos <ernesto@ti.com>, Rebecca Schultz Zavin <rebecca@android.com>

From: Rebecca Schultz Zavin <rebecca@android.com>

This macro can refer to a varible not defined in this scope.
gcc 4.4 and later will view this as an error and this code
will not compile.

Signed-off-by: Rebecca Schultz Zavin <rebecca@android.com>
---
 drivers/dsp/bridge/dynload/cload.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/drivers/dsp/bridge/dynload/cload.c b/drivers/dsp/bridge/dynload/cload.c
index ef5d7d9..4fead55 100644
--- a/drivers/dsp/bridge/dynload/cload.c
+++ b/drivers/dsp/bridge/dynload/cload.c
@@ -1475,10 +1475,6 @@ static char *copy_tgt_strings(void *dstp, void *srcp, unsigned charcount)
 #if TARGET_AU_BITS <= BITS_PER_AU
 		/* byte-swapping issues may exist for strings on target */
 		*dst++ = *src++;
-#elif TARGET_ENDIANNESS_DIFFERS(TARGET_BIG_ENDIAN)
-		register TgtAU_t tmp;
-		tmp = *src++;
-		*dst++ = SWAP16BY8(tmp);  /* right for TARGET_AU_BITS == 16 */
 #else
 		*dst++ = *src++;
 #endif
@@ -1486,8 +1482,6 @@ static char *copy_tgt_strings(void *dstp, void *srcp, unsigned charcount)
 	/*apply force to make sure that the string table has null terminator */
 #if (BITS_PER_AU == BITS_PER_BYTE) && (TARGET_AU_BITS == BITS_PER_BYTE)
 	dst[-1] = 0;
-#elif TARGET_BIG_ENDIAN
-	dst[-1] &= ~BYTE_MASK;	/*  big-endian */
 #else
 	dst[-1] &= (1 << (BITS_PER_AU - BITS_PER_BYTE)) - 1; /* little endian */
 #endif
-- 
1.6.2.4

