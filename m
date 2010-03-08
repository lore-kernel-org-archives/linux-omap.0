From: Scott Ellis <scott@jumpnowtek.com>
Subject: [PATCH] omap2_mcspi.c: Clock divider range check wrong for OMAP3
Date: Mon, 08 Mar 2010 06:56:51 -0500
Message-ID: <1268049411.2558.76.camel@quad>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pan.gwi.net ([207.5.128.165]:1209 "EHLO pan.gwi.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253Ab0CHL4x (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 8 Mar 2010 06:56:53 -0500
Received: from [192.168.10.4] (66-63-88-74.static.suscom-maine.net [66.63.88.74])
	by pan.gwi.net (8.13.1/8.13.1) with ESMTP id o28BuqCK098762
	for <linux-omap@vger.kernel.org>; Mon, 8 Mar 2010 06:56:52 -0500 (EST)
	(envelope-from scott@jumpnowtek.com)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The clock divider range check is wrong for the OMAP3.

The MCSPI_CHxCONF.CLKD register field has a max value 0x0C 
not 0x0F. Reference was the OMAP3 TRM Rev. D manual.

I don't know whether the old value was correct for OMAP24xxx 
boards so I put in some #ifdef stuff. Maybe someone with access
to the OMAP24xxx manual could check if that is necessary.


Signed-off-by: Scott Ellis <scott@jumpnowtek.com>


 drivers/spi/omap2_mcspi.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index fe1b56d..a73127b 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -38,8 +38,17 @@
 #include <plat/dma.h>
 #include <plat/clock.h>
 
+#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
+#define OMAP2_MCSPI_MAX_CLK_DIV                12
+#else
+/* could be 12 for OMAP24xxx also, no docs to check */
+#define OMAP2_MCSPI_MAX_CLK_DIV                15
+#endif
 
 #define OMAP2_MCSPI_MAX_FREQ           48000000
+#define OMAP2_MCSPI_MIN_FREQ   (OMAP2_MCSPI_MAX_FREQ \
+                                       / (1 << OMAP2_MCSPI_MAX_CLK_DIV))
+
 
 /* OMAP2 has 3 SPI controllers, while OMAP3 has 4 */
 #define OMAP2_MCSPI_MAX_CTRL           4
@@ -588,11 +597,12 @@ static int omap2_mcspi_setup_transfer(struct spi_device *spi,
        cs->word_len = word_len;
 
        if (spi->max_speed_hz) {
-               while (div <= 15 && (OMAP2_MCSPI_MAX_FREQ / (1 << div))
-                                       > spi->max_speed_hz)
+               while (div <= OMAP2_MCSPI_MAX_CLK_DIV && 
+                       (OMAP2_MCSPI_MAX_FREQ / (1 << div)) > spi->max_speed_hz)
                        div++;
-       } else
-               div = 15;
+       } else {
+               div = OMAP2_MCSPI_MAX_CLK_DIV;
+       }
 
        l = mcspi_cached_chconf0(spi);
 
@@ -917,10 +927,10 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
                                        t->bits_per_word);
                        return -EINVAL;
                }
-               if (t->speed_hz && t->speed_hz < OMAP2_MCSPI_MAX_FREQ/(1<<16)) {
-                       dev_dbg(&spi->dev, "%d Hz max exceeds %d\n",
+               if (t->speed_hz && t->speed_hz < OMAP2_MCSPI_MIN_FREQ) {
+                       dev_dbg(&spi->dev, "%d Hz slower then hardware minimum %d\n",
                                        t->speed_hz,
-                                       OMAP2_MCSPI_MAX_FREQ/(1<<16));
+                                       OMAP2_MCSPI_MIN_FREQ);
                        return -EINVAL;
                }



