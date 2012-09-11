From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] SPI: OMAP: remove unnecessary includes of plat/clock.h
Date: Tue, 11 Sep 2012 23:31:40 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1209112330290.9444@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38493 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753308Ab2IKXbl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 19:31:41 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org


Remove unnecessary includes of plat/clock.h from the OMAP SPI
controller drivers.  These need to be removed to build multi-subarch
ARM kernels which include these drivers.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 drivers/spi/spi-omap-100k.c   |    2 --
 drivers/spi/spi-omap2-mcspi.c |    1 -
 2 files changed, 3 deletions(-)

diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
index 9bd1c92..dfb4b7f 100644
--- a/drivers/spi/spi-omap-100k.c
+++ b/drivers/spi/spi-omap-100k.c
@@ -37,8 +37,6 @@
 
 #include <linux/spi/spi.h>
 
-#include <plat/clock.h>
-
 #define OMAP1_SPI100K_MAX_FREQ          48000000
 
 #define ICR_SPITAS      (OMAP7XX_ICR_BASE + 0x12)
diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index b2fb141..b5d6994 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -41,7 +41,6 @@
 
 #include <linux/spi/spi.h>
 
-#include <plat/clock.h>
 #include <plat/mcspi.h>
 
 #define OMAP2_MCSPI_MAX_FREQ		48000000
-- 
1.7.10.4

