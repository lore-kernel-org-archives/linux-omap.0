From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/5] Input: tsc2005 - fix Kconfig indentation
Date: Wed, 22 Jul 2015 22:04:42 +0200
Message-ID: <1437595485-16421-3-git-send-email-sre@kernel.org>
References: <1437595485-16421-1-git-send-email-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437595485-16421-1-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: Michael Welling <mwelling@emacinc.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
List-Id: linux-omap@vger.kernel.org

Replace spaces with tab, so that the tsc2005 Kconfig entry matches
the other entries in drivers/input/touchscreen/Kconfig.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/input/touchscreen/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index a854c6e..f0bc42c 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -915,10 +915,10 @@ config TOUCHSCREEN_TSC_SERIO
 	  module will be called tsc40.
 
 config TOUCHSCREEN_TSC2005
-        tristate "TSC2005 based touchscreens"
-        depends on SPI_MASTER
-        help
-          Say Y here if you have a TSC2005 based touchscreen.
+	tristate "TSC2005 based touchscreens"
+	depends on SPI_MASTER
+	help
+	  Say Y here if you have a TSC2005 based touchscreen.
 
 	  If unsure, say N.
 
-- 
2.1.4
