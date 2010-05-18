From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: [PATCH 14/23] OMAP: DSS2: TPO-TD03MTEA1: fix Kconfig dependency
Date: Tue, 18 May 2010 15:35:05 +0300
Message-ID: <1274186114-26951-15-git-send-email-tomi.valkeinen@nokia.com>
References: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:62572 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757570Ab0ERMgh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 May 2010 08:36:37 -0400
In-Reply-To: <1274186114-26951-1-git-send-email-tomi.valkeinen@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org
Cc: Grazvydas Ignotas <notasas@gmail.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>

From: Grazvydas Ignotas <notasas@gmail.com>

This panel depends on SPI, not I2C.

Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
---
 drivers/video/omap2/displays/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/omap2/displays/Kconfig b/drivers/video/omap2/displays/Kconfig
index ea8ccd3..4221957 100644
--- a/drivers/video/omap2/displays/Kconfig
+++ b/drivers/video/omap2/displays/Kconfig
@@ -34,7 +34,7 @@ config PANEL_TOPPOLY_TDO35S
 
 config PANEL_TPO_TD043MTEA1
         tristate "TPO TD043MTEA1 LCD Panel"
-        depends on OMAP2_DSS && I2C
+        depends on OMAP2_DSS && SPI
         help
           LCD Panel used in OMAP3 Pandora
 
-- 
1.7.0.4

