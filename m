From: Roman Tereshonkov <roman.tereshonkov@nokia.com>
Subject: [PATCH 1/2] omap2_mcspi: Flush posted writes
Date: Wed, 10 Mar 2010 12:18:35 +0200
Message-ID: <1268216316-32552-1-git-send-email-roman.tereshonkov@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:39701 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142Ab0CJKS4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Mar 2010 05:18:56 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: scott@jumpnowtek.com, gadiyar@ti.com, Roman Tereshonkov <roman.tereshonkov@nokia.com>

mcspi_write_chconf0 is used to control rx/tx triggering.
Post-write flushing is needed to get the immediate effect.

Signed-off-by: Roman Tereshonkov <roman.tereshonkov@nokia.com>
---
 drivers/spi/omap2_mcspi.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 715c518..35b31fe 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -203,6 +203,7 @@ static inline void mcspi_write_chconf0(const struct spi_device *spi, u32 val)
 
 	cs->chconf0 = val;
 	mcspi_write_cs_reg(spi, OMAP2_MCSPI_CHCONF0, val);
+	mcspi_read_cs_reg(spi, OMAP2_MCSPI_CHCONF0);
 }
 
 static void omap2_mcspi_set_dma_req(const struct spi_device *spi,
-- 
1.6.2.rc1.3.g81d3f

