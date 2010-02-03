From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/9] omap: define _toggle_gpio_edge_triggering only for OMAP1
Date: Tue, 02 Feb 2010 18:25:55 -0800
Message-ID: <20100203022555.26347.62876.stgit@baageli.muru.com>
References: <20100203022318.26347.34734.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:59223 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331Ab0BCCZ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Feb 2010 21:25:29 -0500
In-Reply-To: <20100203022318.26347.34734.stgit@baageli.muru.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

The only usage of _toggle_gpio_edge_triggering is in an
CONFIG_ARCH_OMAP1 is defined, too.

This fixes a compiler warning:

	arch/arm/plat-omap/gpio.c:758: warning: '_toggle_gpio_edge_triggering'=
 defined but not used

when compiling for ARCH_OMAP2, ARCH_OMAP3 or ARCH_OMAP4.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/gpio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/gpio.c b/arch/arm/plat-omap/gpio.c
index d17620c..d2422c7 100644
--- a/arch/arm/plat-omap/gpio.c
+++ b/arch/arm/plat-omap/gpio.c
@@ -750,6 +750,7 @@ static inline void set_24xx_gpio_triggering(struct =
gpio_bank *bank, int gpio,
 }
 #endif
=20
+#ifdef CONFIG_ARCH_OMAP1
 /*
  * This only applies to chips that can't do both rising and falling ed=
ge
  * detection at once.  For all other chips, this function is a noop.
@@ -760,11 +761,9 @@ static void _toggle_gpio_edge_triggering(struct gp=
io_bank *bank, int gpio)
 	u32 l =3D 0;
=20
 	switch (bank->method) {
-#ifdef CONFIG_ARCH_OMAP1
 	case METHOD_MPUIO:
 		reg +=3D OMAP_MPUIO_GPIO_INT_EDGE;
 		break;
-#endif
 #ifdef CONFIG_ARCH_OMAP15XX
 	case METHOD_GPIO_1510:
 		reg +=3D OMAP1510_GPIO_INT_CONTROL;
@@ -787,6 +786,7 @@ static void _toggle_gpio_edge_triggering(struct gpi=
o_bank *bank, int gpio)
=20
 	__raw_writel(l, reg);
 }
+#endif
=20
 static int _set_gpio_triggering(struct gpio_bank *bank, int gpio, int =
trigger)
 {

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
