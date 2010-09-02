From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 5/5] wip: ARM: omap: move omap_board_config_kernel to .init.data
Date: Thu,  2 Sep 2010 10:03:42 +0200
Message-ID: <1283414622-2663-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38632 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752292Ab0IBIDp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Sep 2010 04:03:45 -0400
In-Reply-To: <1283408230-22652-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

Probably this works ...
---
 arch/arm/plat-omap/common.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 227d985..c8451c2 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -46,7 +46,7 @@
 
 #define NO_LENGTH_CHECK 0xffffffff
 
-struct omap_board_config_kernel *omap_board_config;
+struct omap_board_config_kernel *omap_board_config __initdata;
 int omap_board_config_size;
 
 static const void *get_config(u16 tag, size_t len, int skip, size_t *len_out)
-- 
1.7.1

