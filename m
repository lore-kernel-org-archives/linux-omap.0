From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/5] ARM: omap/fb: move omapfb_reserve_sram to .init.text
Date: Thu,  2 Sep 2010 10:03:39 +0200
Message-ID: <1283414622-2663-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38626 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0IBIDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 04:03:45 -0400
In-Reply-To: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This function is only called by omap_detect_sram which lives in .init.t=
ext,
too.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/fb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index a727133..72a36ca 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -262,7 +262,7 @@ void __init omapfb_reserve_sdram_memblock(void)
  * this point, since the driver built as a module would have problem w=
ith
  * freeing / reallocating the regions.
  */
-unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
 				  unsigned long pstart_avail,
@@ -392,7 +392,7 @@ void omapfb_reserve_sdram_memblock(void)
 {
 }
=20
-unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
 				  unsigned long start_avail,
@@ -411,7 +411,7 @@ void omapfb_reserve_sdram_memblock(void)
 {
 }
=20
-unsigned long omapfb_reserve_sram(unsigned long sram_pstart,
+unsigned long __init omapfb_reserve_sram(unsigned long sram_pstart,
 				  unsigned long sram_vstart,
 				  unsigned long sram_size,
 				  unsigned long start_avail,
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
