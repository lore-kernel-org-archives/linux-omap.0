From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 1/4] ARM: omap1/nokia770: mark some functions __init
Date: Wed,  9 Feb 2011 21:40:07 +0100
Message-ID: <1297284010-2286-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110209192727.GC20795@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50663 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab1BIUkQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Feb 2011 15:40:16 -0500
In-Reply-To: <20110209192727.GC20795@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

These are only called from omap_nokia770_init which is in .init.text, t=
oo.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-omap1/board-nokia770.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1=
/board-nokia770.c
index d21f09d..cfd0849 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c
@@ -115,7 +115,7 @@ static struct mipid_platform_data nokia770_mipid_pl=
atform_data =3D {
 	.shutdown =3D mipid_shutdown,
 };
=20
-static void mipid_dev_init(void)
+static void __init mipid_dev_init(void)
 {
 	const struct omap_lcd_config *conf;
=20
@@ -126,7 +126,7 @@ static void mipid_dev_init(void)
 	}
 }
=20
-static void ads7846_dev_init(void)
+static void __init ads7846_dev_init(void)
 {
 	if (gpio_request(ADS7846_PENDOWN_GPIO, "ADS7846 pendown") < 0)
 		printk(KERN_ERR "can't get ads7846 pen down GPIO\n");
@@ -170,7 +170,7 @@ static struct hwa742_platform_data nokia770_hwa742_=
platform_data =3D {
 	.te_connected		=3D 1,
 };
=20
-static void hwa742_dev_init(void)
+static void __init hwa742_dev_init(void)
 {
 	clk_add_alias("hwa_sys_ck", NULL, "bclk", NULL);
 	omapfb_set_ctrl_platform_data(&nokia770_hwa742_platform_data);
--=20
1.7.2.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
