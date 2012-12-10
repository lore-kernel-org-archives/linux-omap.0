From: Lokesh Vutla <lokeshvutla@ti.com>
Subject: [PATCH 7/9] memory: emif: disable phy_fast_dll_lock
Date: Mon, 10 Dec 2012 12:39:16 +0530
Message-ID: <1355123358-5273-8-git-send-email-lokeshvutla@ti.com>
References: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50093 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab2LJHJb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Dec 2012 02:09:31 -0500
In-Reply-To: <1355123358-5273-1-git-send-email-lokeshvutla@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, santosh.shilimkar@ti.com, gregkh@linuxfoundation.org, b-cousson@ti.com, lokeshvutla@ti.com, Nishanth Menon <nm@ti.com>

From: Nishanth Menon <nm@ti.com>

As per OMAP5 TRM, phy_fast_dll_lock is meant for simulations only.
'0' is supposed to be used for normal operations. So, use 0.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 drivers/memory/emif.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/emif.h b/drivers/memory/emif.h
index bfe08ba..574fdfb 100644
--- a/drivers/memory/emif.h
+++ b/drivers/memory/emif.h
@@ -82,7 +82,7 @@
 #define EMIF_DLL_SLAVE_DLY_CTRL_100_MHZ_AND_LESS_ATTILAPHY 0xFF
 
 /* DDR_PHY_CTRL_1 values for EMIF4D5 INTELLIPHY combination */
-#define EMIF_DDR_PHY_CTRL_1_BASE_VAL_INTELLIPHY		0x0E084200
+#define EMIF_DDR_PHY_CTRL_1_BASE_VAL_INTELLIPHY		0x0E084000
 #define EMIF_PHY_TOTAL_READ_LATENCY_INTELLIPHY_PS	10000
 
 /* TEMP_ALERT_CONFIG - corresponding to temp gradient 5 C/s */
-- 
1.7.9.5

