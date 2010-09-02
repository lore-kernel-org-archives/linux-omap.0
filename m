From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/5] ARM: omap/fb: move get_fbmem_region() to .init.text
Date: Thu,  2 Sep 2010 10:03:40 +0200
Message-ID: <1283414622-2663-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38629 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab0IBIDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 04:03:45 -0400
In-Reply-To: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

get_fbmem_region() is only called by omapfb_reserve_sdram_memblock() an=
d
omapfb_reserve_sram() that both live in .init.text.  So get_fbmem_regio=
n
can go there, too.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/fb.c b/arch/arm/plat-omap/fb.c
index 72a36ca..fffc1a0 100644
--- a/arch/arm/plat-omap/fb.c
+++ b/arch/arm/plat-omap/fb.c
@@ -94,7 +94,7 @@ static int fbmem_region_reserved(unsigned long start,=
 size_t size)
  * Get the region_idx`th region from board config/ATAG and convert it =
to
  * our internal format.
  */
-static int get_fbmem_region(int region_idx, struct omapfb_mem_region *=
rg)
+static int __init get_fbmem_region(int region_idx, struct omapfb_mem_r=
egion *rg)
 {
 	const struct omap_fbmem_config	*conf;
 	u32				paddr;
--=20
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
