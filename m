From: Carlos Aguiar <carlos.aguiar@indt.org.br>
Subject: [PATCH 1/1] MMC: OMAP: Fix HSMMC driver name at host driver.
Date: Thu, 20 Mar 2008 16:24:30 -0400
Message-ID: <47E2C7FE.9020908@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:24264 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760576AbYCTUbb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 16:31:31 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>

This patch fixes the HSMMC driver name at host driver.

Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
---
 drivers/mmc/host/omap_hsmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 047c64d..0e7ee20 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -92,7 +92,7 @@
 #define OMAP_MMC_DATADIR_WRITE	2
 #define MMC_TIMEOUT_MS		20
 #define OMAP_MMC_MASTER_CLOCK	96000000
-#define DRIVER_NAME		"mmci-omap"
+#define DRIVER_NAME		"hsmmc-omap"
 /*
  * slot_id is device id - 1, device id is a static value
  * of 1 to represent device 1 etc..
-- 1.5.3.GIT

