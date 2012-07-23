From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 09/25] i2c/i2c-omap: add a const qualifier
Date: Mon, 23 Jul 2012 11:13:14 +0200
Message-ID: <1343034810-3386-10-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:35931 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751735Ab2GWJOK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Jul 2012 05:14:10 -0400
In-Reply-To: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, linux-omap@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org

This prepares *of_device_id.data becoming const. Without this change
the following warning would occur:

	drivers/i2c/busses/i2c-omap.c: In function 'omap_i2c_probe':
	drivers/i2c/busses/i2c-omap.c:1025: warning: assignment discards quali=
fiers from pointer target type

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/i2c/busses/i2c-omap.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-oma=
p.c
index 801df60..4fc585d 100644
--- a/drivers/i2c/busses/i2c-omap.c
+++ b/drivers/i2c/busses/i2c-omap.c
@@ -987,7 +987,8 @@ omap_i2c_probe(struct platform_device *pdev)
 	struct omap_i2c_dev	*dev;
 	struct i2c_adapter	*adap;
 	struct resource		*mem, *irq, *ioarea;
-	struct omap_i2c_bus_platform_data *pdata =3D pdev->dev.platform_data;
+	const struct omap_i2c_bus_platform_data *pdata =3D
+		pdev->dev.platform_data;
 	struct device_node	*node =3D pdev->dev.of_node;
 	const struct of_device_id *match;
 	irq_handler_t isr;
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
