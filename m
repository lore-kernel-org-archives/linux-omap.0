From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 3/3] OMAP: serial: Change device name: omap-hsuart -> omap_uart
Date: Mon, 6 Dec 2010 11:41:33 +0100
Message-ID: <1291632093-18799-4-git-send-email-b-cousson@ti.com>
References: <1291632093-18799-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33444 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200Ab0LFKmC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 6 Dec 2010 05:42:02 -0500
In-Reply-To: <1291632093-18799-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

The naming convention for omap_device is omap_XXX.

Rename the device and driver name in order to stick
to this naming convention.
Remove the hs prefix that is implicit for every OMAP uarts.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Acked-by: Govindraj Raja <govindraj.raja@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index c8dae02..cc71426 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -22,7 +22,7 @@
 
 #include <plat/mux.h>
 
-#define DRIVER_NAME	"omap-hsuart"
+#define DRIVER_NAME	"omap_uart"
 
 /*
  * Use tty device name as ttyO, [O -> OMAP]
-- 
1.7.0.4

