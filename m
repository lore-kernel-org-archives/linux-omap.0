From: Adrian Hunter <ext-adrian.hunter@nokia.com>
Subject: [PATCH 3/3] ARM: OMAP: add missing parenthesis in hsmmc defines
Date: Thu, 16 Oct 2008 16:37:27 +0300
Message-ID: <48F74397.1080706@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65484 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037AbYJPNbZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Oct 2008 09:31:25 -0400
Received: from esebh105.NOE.Nokia.com (esebh105.ntc.nokia.com [172.21.138.211])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m9GDV9sA004630
	for <linux-omap@vger.kernel.org>; Thu, 16 Oct 2008 16:31:22 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap Mailing List <linux-omap@vger.kernel.org>

And tidy a couple more defines.

Signed-off-by: Adrian Hunter <ext-adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 942f68d..3ba24be 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -51,30 +51,30 @@
 #define OMAP_HSMMC_ISE		0x0138
 #define OMAP_HSMMC_CAPA		0x0140
 
-#define VS18			(1<<26)
-#define VS30			(1<<25)
-#define SDVS18			(0x5<<9)
-#define SDVS30			(0x6<<9)
+#define VS18			(1 << 26)
+#define VS30			(1 << 25)
+#define SDVS18			(0x5 << 9)
+#define SDVS30			(0x6 << 9)
 #define SDVSCLR			0xFFFFF1FF
 #define SDVSDET			0x00000400
 #define AUTOIDLE		0x1
-#define SDBP			(1<<8)
+#define SDBP			(1 << 8)
 #define DTO			0xe
 #define ICE			0x1
 #define ICS			0x2
-#define CEN			(1<<2)
+#define CEN			(1 << 2)
 #define CLKD_MASK		0x0000FFC0
 #define CLKD_SHIFT		6
 #define DTO_MASK		0x000F0000
 #define DTO_SHIFT		16
 #define INT_EN_MASK		0x307F0033
-#define INIT_STREAM		(1<<1)
-#define DP_SELECT		(1<<21)
-#define DDIR			(1<<4)
+#define INIT_STREAM		(1 << 1)
+#define DP_SELECT		(1 << 21)
+#define DDIR			(1 << 4)
 #define DMA_EN			0x1
-#define MSBS			1<<5
-#define BCE			1<<1
-#define FOUR_BIT		1 << 1
+#define MSBS			(1 << 5)
+#define BCE			(1 << 1)
+#define FOUR_BIT		(1 << 1)
 #define CC			0x1
 #define TC			0x02
 #define OD			0x1
-- 
1.5.4.3
