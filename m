From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] SDRC: prevent null pointer dereference if sdrc_init_params
 is null
Date: Mon, 23 Mar 2009 18:41:53 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0903231841030.4676@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:50727 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbZCXAl4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Mar 2009 20:41:56 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter Barada <peterb@logicpd.com>


omap2_sdrc_get_params() should check to see if a board-*.c file has
called omap2_init_common_hw() with a null pointer for the
omap_sdrc_params argument, rather than attempting to dereference it.
Otherwise, boot will fail after the "Reprogramming SDRC" boot message.
Problem found by Peter Barada <peterb@logicpd.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Tested-by: Peter Barada <peterb@logicpd.com>
---
 arch/arm/mach-omap2/sdrc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 7da6587..993fd25 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -56,6 +56,9 @@ struct omap_sdrc_params *omap2_sdrc_get_params(unsigned long r)
 {
 	struct omap_sdrc_params *sp;
 
+	if (!sdrc_init_params)
+		return NULL;
+
 	sp = sdrc_init_params;
 
 	while (sp->rate && sp->rate != r)
