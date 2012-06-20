From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH] ARM: OMAP2+: serial: Change MAX_HSUART_PORTS to 6
Date: Wed, 20 Jun 2012 14:19:29 +0530
Message-ID: <1340182169-3840-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:51427 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab2FTItt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jun 2012 04:49:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, AnilKumar Ch <anilkumar@ti.com>

Extends the maximum number of UART ports to 6 from 4 because AM335X
device have six UART ports.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 1a52725..71eca9c 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -54,7 +54,7 @@
 
 #define OMAP_UART_DMA_CH_FREE	-1
 
-#define OMAP_MAX_HSUART_PORTS	4
+#define OMAP_MAX_HSUART_PORTS	6
 
 #define MSR_SAVE_FLAGS		UART_MSR_ANY_DELTA
 
-- 
1.7.9.5

