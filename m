From: Ben Gamari <bgamari.foss@gmail.com>
Subject: [PATCH] mcspi: Add support for GPIO chip select lines
Date: Tue, 21 Dec 2010 12:56:35 -0500
Message-ID: <1292954195-20204-2-git-send-email-bgamari.foss@gmail.com>
References: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48541 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751736Ab0LUR4p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Dec 2010 12:56:45 -0500
Received: by vws16 with SMTP id 16so1814897vws.19
        for <linux-omap@vger.kernel.org>; Tue, 21 Dec 2010 09:56:45 -0800 (PST)
In-Reply-To: <1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: beagleboard <beagleboard@googlegroups.com>, linux-omap <linux-omap@vger.kernel.org>, David Brownell <dbrownell@users.sourceforge.net>, Eric Miao <eric.miao@marvell.com>, Michael
Cc: Ben Gamari <bgamari.foss@gmail.com>

This mechanism is in large part stolen from the s3c64xx-spi module. To
use this functionality, one simply must define a set_level function to
set the CS state and a omap2_mcspi_csinfo struct for each chip select in
the board file.

Each spi_board_info.controller_data should then be set
to point to the appropriate csinfo struct. This will cause the driver to
call the csinfo->set_level function instead of toggling the McSPI chip
select lines.

Signed-off-by: Ben Gamari <bgamari.foss@gmail.com>
---
 arch/arm/plat-omap/include/plat/mcspi.h |   14 ++++++++++++++
 drivers/spi/omap2_mcspi.c               |   14 +++++++++-----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/mcspi.h b/arch/arm/plat-omap/include/plat/mcspi.h
index 1254e49..ab84b8d 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -1,6 +1,20 @@
 #ifndef _OMAP2_MCSPI_H
 #define _OMAP2_MCSPI_H
 
+/**
+ * struct omap2_mcspi_csinfo - Chip Select description
+ * @line: Custom 'identity' of the CS line
+ * @set_level: Function to set the state of a given CS line
+ *
+ * This is to allow use of GPIO lines as CS lines. Allocate and initialize one
+ * in the machine init code and make spi_board_info.controller_data point to
+ * it.
+ */
+struct omap2_mcspi_csinfo {
+        unsigned line;
+        void (*set_level)(unsigned line_id, int lvl);
+};
+
 struct omap2_mcspi_platform_config {
 	unsigned short	num_cs;
 };
diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 2a651e6..92ccbd6 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -35,6 +35,7 @@
 #include <linux/slab.h>
 
 #include <linux/spi/spi.h>
+#include <linux/gpio.h>
 
 #include <plat/dma.h>
 #include <plat/clock.h>
@@ -235,11 +236,14 @@ static void omap2_mcspi_set_enable(const struct spi_device *spi, int enable)
 
 static void omap2_mcspi_force_cs(struct spi_device *spi, int cs_active)
 {
-	u32 l;
-
-	l = mcspi_cached_chconf0(spi);
-	MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
-	mcspi_write_chconf0(spi, l);
+	if (spi->controller_data) {
+		struct omap2_mcspi_csinfo *csinfo = spi->controller_data;
+		(*csinfo->set_level)(csinfo->line, cs_active);
+	} else {
+		u32 l = mcspi_cached_chconf0(spi);
+		MOD_REG_BIT(l, OMAP2_MCSPI_CHCONF_FORCE, cs_active);
+		mcspi_write_chconf0(spi, l);
+	}
 }
 
 static void omap2_mcspi_set_master_mode(struct spi_master *master)
-- 
1.7.1

