From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH] ARM: OMAP: Fix section mismatch warnings in omap-rng
Date: Thu, 04 Jan 2007 16:32:13 +0100
Message-ID: <459D1DFD.6080606@googlemail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010200070505020907020009"
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

This is a multi-part message in MIME format.
--------------010200070505020907020009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


ARM: OMAP: Fix warnings

WARNING: drivers/char/hw_random/omap-rng.o - Section
mismatch: reference to .init.text: from .data between '$d'
(at offset 0x0) and 'omap_rng_ops'
WARNING: drivers/char/hw_random/omap-rng.o - Section
mismatch: reference to .exit.text: from .data between '$d'
(at offset 0x4) and 'omap_rng_ops'

Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>

--------------010200070505020907020009
Content-Type: text/plain;
 name="omap_rng_warning_fix.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="omap_rng_warning_fix.txt"

Index: linux-osk/drivers/char/hw_random/omap-rng.c
===================================================================
--- linux-osk.orig/drivers/char/hw_random/omap-rng.c
+++ linux-osk/drivers/char/hw_random/omap-rng.c
@@ -83,7 +83,7 @@ static struct hwrng omap_rng_ops = {
 	.data_read	= omap_rng_data_read,
 };
 
-static int __init omap_rng_probe(struct platform_device *pdev)
+static int __devinit omap_rng_probe(struct platform_device *pdev)
 {
 	struct resource *res, *mem;
 	int ret;
@@ -133,7 +133,7 @@ static int __init omap_rng_probe(struct 
 	return 0;
 }
 
-static int __exit omap_rng_remove(struct platform_device *pdev)
+static int __devexit omap_rng_remove(struct platform_device *pdev)
 {
 	struct resource *mem = dev_get_drvdata(&pdev->dev);
 


--------------010200070505020907020009
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------010200070505020907020009--
