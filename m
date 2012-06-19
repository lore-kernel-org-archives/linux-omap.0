From: Venkatraman S <svenkatr@ti.com>
Subject: [PATCH] spi: omap2-mcspi: fix section mismatch regression in probe
Date: Tue, 19 Jun 2012 15:27:48 +0530
Message-ID: <1340099868-24290-1-git-send-email-svenkatr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47265 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab2FSJ6V (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 05:58:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org, balbi@ti.com, Venkatraman S <svenkatr@ti.com>

Commit 7d6b6d83(make it behave as a module) annotated probe with
__devinit, but a referenced function was not.

This introduced a section mismatch warning:
WARNING: vmlinux.o(.devinit.text+0x3eec): Section mismatch in reference
from the function omap2_mcspi_probe() to the function
.init.text:omap2_mcspi_master_setup()

Signed-off-by: Venkatraman S <svenkatr@ti.com>
---
 drivers/spi/spi-omap2-mcspi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 46ef5fe..1618e89 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1031,7 +1031,7 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 	return 0;
 }
 
-static int __init omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
+static int __devinit omap2_mcspi_master_setup(struct omap2_mcspi *mcspi)
 {
 	struct spi_master	*master = mcspi->master;
 	struct omap2_mcspi_regs	*ctx = &mcspi->ctx;
-- 
1.7.0.4

