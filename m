From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/4] ARM: omap: move omap_get_config et al. to .init.text
Date: Wed,  9 Feb 2011 21:40:08 +0100
Message-ID: <1297284010-2286-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110209192727.GC20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50667 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755074Ab1BIUkY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 15:40:24 -0500
In-Reply-To: <20110209192727.GC20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

All callers of these functions live in .init.text, so these can go ther=
e,
too.  There they must not be exported anymore, this is no problem thoug=
h,
as all callers are always built-in.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/plat-omap/common.c             |    6 ++----
 arch/arm/plat-omap/include/plat/board.h |    4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index f047318..30c698e 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -49,17 +49,15 @@ static const void *get_config(u16 tag, size_t len, =
int skip, size_t *len_out)
 	return kinfo->data;
 }
=20
-const void *__omap_get_config(u16 tag, size_t len, int nr)
+const void *__init __omap_get_config(u16 tag, size_t len, int nr)
 {
         return get_config(tag, len, nr, NULL);
 }
-EXPORT_SYMBOL(__omap_get_config);
=20
-const void *omap_get_var_config(u16 tag, size_t *len)
+const void *__init omap_get_var_config(u16 tag, size_t *len)
 {
         return get_config(tag, NO_LENGTH_CHECK, 0, len);
 }
-EXPORT_SYMBOL(omap_get_var_config);
=20
 void __init omap_reserve(void)
 {
diff --git a/arch/arm/plat-omap/include/plat/board.h b/arch/arm/plat-om=
ap/include/plat/board.h
index 3cf4fa2..97126df 100644
--- a/arch/arm/plat-omap/include/plat/board.h
+++ b/arch/arm/plat-omap/include/plat/board.h
@@ -151,14 +151,14 @@ struct omap_board_config_kernel {
 	const void *data;
 };
=20
-extern const void *__omap_get_config(u16 tag, size_t len, int nr);
+extern const void *__init __omap_get_config(u16 tag, size_t len, int n=
r);
=20
 #define omap_get_config(tag, type) \
 	((const type *) __omap_get_config((tag), sizeof(type), 0))
 #define omap_get_nr_config(tag, type, nr) \
 	((const type *) __omap_get_config((tag), sizeof(type), (nr)))
=20
-extern const void *omap_get_var_config(u16 tag, size_t *len);
+extern const void *__init omap_get_var_config(u16 tag, size_t *len);
=20
 extern struct omap_board_config_kernel *omap_board_config;
 extern int omap_board_config_size;
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
