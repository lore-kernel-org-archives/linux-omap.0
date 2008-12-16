From: Jean Pihet <jpihet@mvista.com>
Subject: Re: [PATCH] OMAP2 OneNAND GPIO fix
Date: Tue, 16 Dec 2008 19:28:48 +0100
Message-ID: <200812161928.49147.jpihet@mvista.com>
References: <200812111759.15180.jpihet@mvista.com> <20081216103909.60b9ba67.jarkko.nikula@nokia.com> <20081216163702.GQ19551@atomide.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hN/RJLRThUYbex0"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:24817 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317AbYLPS2v (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Dec 2008 13:28:51 -0500
In-Reply-To: <20081216163702.GQ19551@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

--Boundary-00=_hN/RJLRThUYbex0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Tony,

> Yeah, should be about to get pulled into Russell's queue, also
> available here:
>
> http://git.kernel.org/?p=3Dlinux/kernel/git/tmlind/linux-omap-2.6.git;a=
=3Dshort
>log;h=3Dhsmmc-init
>
> So Jean, if you can check what still needs to be patched there, and
> we can queue it via omap-fixes.
Here is the patch against the hsmmc-init branch.
The patch changes the include path and the request/free free omap calls to =
the
standard version.

Regards,
Jean.

=46rom a4f548c3f51c9a349decc761dd539499902873f5 Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Tue, 16 Dec 2008 19:22:45 +0100
Subject: [PATCH] ARM: OMAP: use GPIO standard in OneNAND driver

This patch replaces some legacy OMAP GPIO calls with the standard
calls.

Tested on OMAP3 EVM board.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 drivers/mtd/onenand/omap2.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index d1e0b8e..f223303 100644
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
@@ -629,7 +629,8 @@ static int __devinit omap2_onenand_probe(struct=20
platform_device *pdev)
 	}
=20
 	if (c->gpio_irq) {
=2D		if ((r =3D omap_request_gpio(c->gpio_irq)) < 0) {
+		r =3D gpio_request(c->gpio_irq, "OneNAND Irq");
+		if (r < 0) {
 			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
 				"OneNAND\n", c->gpio_irq);
 			goto err_iounmap;
@@ -726,7 +727,7 @@ err_release_dma:
 		free_irq(gpio_to_irq(c->gpio_irq), c);
 err_release_gpio:
 	if (c->gpio_irq)
=2D		omap_free_gpio(c->gpio_irq);
+		gpio_free(c->gpio_irq);
 err_iounmap:
 	iounmap(c->onenand.base);
 err_release_mem_region:
@@ -761,7 +762,7 @@ static int __devexit omap2_onenand_remove(struct=20
platform_device *pdev)
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

--Boundary-00=_hN/RJLRThUYbex0
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="ARM-OMAP-use-GPIO-standard-in-OneNAND-driver.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ARM-OMAP-use-GPIO-standard-in-OneNAND-driver.patch"

=46rom a4f548c3f51c9a349decc761dd539499902873f5 Mon Sep 17 00:00:00 2001
=46rom: Jean Pihet <jpihet@mvista.com>
Date: Tue, 16 Dec 2008 19:22:45 +0100
Subject: [PATCH] ARM: OMAP: use GPIO standard in OneNAND driver

This patch replaces some legacy OMAP GPIO calls with the standard
calls.

Tested on OMAP3 EVM board.

Signed-off-by: Jean Pihet <jpihet@mvista.com>
=2D--
 drivers/mtd/onenand/omap2.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mtd/onenand/omap2.c b/drivers/mtd/onenand/omap2.c
index d1e0b8e..f223303 100644
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
@@ -629,7 +629,8 @@ static int __devinit omap2_onenand_probe(struct platfor=
m_device *pdev)
 	}
=20
 	if (c->gpio_irq) {
=2D		if ((r =3D omap_request_gpio(c->gpio_irq)) < 0) {
+		r =3D gpio_request(c->gpio_irq, "OneNAND Irq");
+		if (r < 0) {
 			dev_err(&pdev->dev,  "Failed to request GPIO%d for "
 				"OneNAND\n", c->gpio_irq);
 			goto err_iounmap;
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


--Boundary-00=_hN/RJLRThUYbex0--
