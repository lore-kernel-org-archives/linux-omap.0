From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/4] ARM: omap: move omap_board_config_kernel to .init.data
Date: Wed,  9 Feb 2011 21:40:09 +0100
Message-ID: <1297284010-2286-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110209192727.GC20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50670 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754055Ab1BIUkc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 15:40:32 -0500
In-Reply-To: <20110209192727.GC20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

This variable is only assigned in __init functions and never used later=
=2E

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/common.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 30c698e..d9f10a3 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -24,10 +24,11 @@
=20
 #define NO_LENGTH_CHECK 0xffffffff
=20
-struct omap_board_config_kernel *omap_board_config;
+struct omap_board_config_kernel *omap_board_config __initdata;
 int omap_board_config_size;
=20
-static const void *get_config(u16 tag, size_t len, int skip, size_t *l=
en_out)
+static const void *__init get_config(u16 tag, size_t len,
+		int skip, size_t *len_out)
 {
 	struct omap_board_config_kernel *kinfo =3D NULL;
 	int i;
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
