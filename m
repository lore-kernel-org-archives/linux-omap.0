From: Jean Pihet <jpihet@mvista.com>
Subject: [PATCH] OMAP2 OneNAND GPIO fix
Date: Thu, 11 Dec 2008 17:59:14 +0100
Message-ID: <200812111759.15180.jpihet@mvista.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jbUQJp8IwwnNJkd"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:1408 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756033AbYLKQ7U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Dec 2008 11:59:20 -0500
Received: from ip6-localhost (asshur.mvista.com [10.0.0.11])
	by hermes.mvista.com (Postfix) with ESMTP id BE4D118741
	for <linux-omap@vger.kernel.org>; Thu, 11 Dec 2008 08:59:19 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

--Boundary-00=_jbUQJp8IwwnNJkd
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

Here is a patch to have the OMAP2 OneNAND driver compile on the latest tree.
I do not know if this has been addressed already, here is a patch.

Regards,
Jean



=46rom f95826f916cde9c0d0da79e006f090bc69112a1e Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Thu, 11 Dec 2008 17:48:31 +0100
Subject: [PATCH] ARM: OMAP: use GPIO standard in OneNAND driver

This patch replaces some legacy OMAP GPIO calls with the standard
calls that work on most platforms.

Tested on OMAP3 EVM board.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 drivers/mtd/onenand/omap2.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 762623f..f223303 100644
=2D-- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -34,11 +34,11 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/gpio.h>

 #include <asm/mach/flash.h>
 #include <mach/gpmc.h>
 #include <mach/onenand.h>
=2D#include <mach/gpio.h>
 #include <mach/pm.h>

 #include <mach/dma.h>
@@ -149,7 +149,7 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int=
=20
state)

                INIT_COMPLETION(c->irq_done);
                if (c->gpio_irq) {
=2D                       result =3D omap_get_gpio_datain(c->gpio_irq);
+                       result =3D gpio_get_value(c->gpio_irq);
                        if (result =3D=3D -1) {
                                ctrl =3D read_reg(c, ONENAND_REG_CTRL_STATU=
S);
                                intr =3D read_reg(c, ONENAND_REG_INTERRUPT);
@@ -629,12 +629,13 @@ static int __devinit omap2_onenand_probe(struct=20
platform_device *pdev)
        }

        if (c->gpio_irq) {
=2D               if ((r =3D omap_request_gpio(c->gpio_irq)) < 0) {
+               r =3D gpio_request(c->gpio_irq, "OneNAND Irq");
+               if (r < 0) {
                        dev_err(&pdev->dev,  "Failed to request GPIO%d for "
                                "OneNAND\n", c->gpio_irq);
                        goto err_iounmap;
        }
=2D       omap_set_gpio_direction(c->gpio_irq, 1);
+       gpio_direction_input(c->gpio_irq);

        if ((r =3D request_irq(gpio_to_irq(c->gpio_irq),
                             omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
@@ -726,7 +727,7 @@ err_release_dma:
                free_irq(gpio_to_irq(c->gpio_irq), c);
 err_release_gpio:
        if (c->gpio_irq)
=2D               omap_free_gpio(c->gpio_irq);
+               gpio_free(c->gpio_irq);
 err_iounmap:
        iounmap(c->onenand.base);
 err_release_mem_region:
@@ -761,7 +762,7 @@ static int __devexit omap2_onenand_remove(struct=20
platform_device *pdev)
        platform_set_drvdata(pdev, NULL);
        if (c->gpio_irq) {
                free_irq(gpio_to_irq(c->gpio_irq), c);
=2D               omap_free_gpio(c->gpio_irq);
+               gpio_free(c->gpio_irq);
        }
        iounmap(c->onenand.base);
        release_mem_region(c->phys_base, ONENAND_IO_SIZE);
=2D-
1.5.4.4.21.gc4a6c

--Boundary-00=_jbUQJp8IwwnNJkd
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="ARM-OMAP-use-GPIO-standard-in-OneNAND-driver.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ARM-OMAP-use-GPIO-standard-in-OneNAND-driver.patch"

=46rom f95826f916cde9c0d0da79e006f090bc69112a1e Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Thu, 11 Dec 2008 17:48:31 +0100
Subject: [PATCH] ARM: OMAP: use GPIO standard in OneNAND driver

This patch replaces some legacy OMAP GPIO calls with the standard
calls that work on most platforms.

Tested on OMAP3 EVM board.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 drivers/mtd/onenand/omap2.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index 762623f..f223303 100644
=2D-- a/drivers/mtd/onenand/omap2.c
+++ b/drivers/mtd/onenand/omap2.c
@@ -34,11 +34,11 @@
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/gpio.h>
=20
 #include <asm/mach/flash.h>
 #include <mach/gpmc.h>
 #include <mach/onenand.h>
=2D#include <mach/gpio.h>
 #include <mach/pm.h>
=20
 #include <mach/dma.h>
@@ -149,7 +149,7 @@ static int omap2_onenand_wait(struct mtd_info *mtd, int=
 state)
=20
 		INIT_COMPLETION(c->irq_done);
 		if (c->gpio_irq) {
=2D			result =3D omap_get_gpio_datain(c->gpio_irq);
+			result =3D gpio_get_value(c->gpio_irq);
 			if (result =3D=3D -1) {
 				ctrl =3D read_reg(c, ONENAND_REG_CTRL_STATUS);
 				intr =3D read_reg(c, ONENAND_REG_INTERRUPT);
@@ -629,12 +629,13 @@ static int __devinit omap2_onenand_probe(struct platf=
orm_device *pdev)
 	}
=20
 	if (c->gpio_irq) {
=2D		if ((r =3D omap_request_gpio(c->gpio_irq)) < 0) {
+		r =3D gpio_request(c->gpio_irq, "OneNAND Irq");
+		if (r < 0) {
 			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
 				"OneNAND\n", c->gpio_irq);
 			goto err_iounmap;
 	}
=2D	omap_set_gpio_direction(c->gpio_irq, 1);
+	gpio_direction_input(c->gpio_irq);
=20
 	if ((r =3D request_irq(gpio_to_irq(c->gpio_irq),
 			     omap2_onenand_interrupt, IRQF_TRIGGER_RISING,
@@ -726,7 +727,7 @@ err_release_dma:
 		free_irq(gpio_to_irq(c->gpio_irq), c);
 err_release_gpio:
 	if (c->gpio_irq)
=2D		omap_free_gpio(c->gpio_irq);
+		gpio_free(c->gpio_irq);
 err_iounmap:
 	iounmap(c->onenand.base);
 err_release_mem_region:
@@ -761,7 +762,7 @@ static int __devexit omap2_onenand_remove(struct platfo=
rm_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	if (c->gpio_irq) {
 		free_irq(gpio_to_irq(c->gpio_irq), c);
=2D		omap_free_gpio(c->gpio_irq);
+		gpio_free(c->gpio_irq);
 	}
 	iounmap(c->onenand.base);
 	release_mem_region(c->phys_base, ONENAND_IO_SIZE);
=2D-=20
1.5.4.4.21.gc4a6c


--Boundary-00=_jbUQJp8IwwnNJkd--
