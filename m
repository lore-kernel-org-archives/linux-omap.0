From: "Govindraj.R" <govindraj.raja@ti.com>
Subject: [RFC PATCH] OMAP: UART: Enable tx wakeup bit in wer
Date: Tue, 24 Jan 2012 19:07:29 +0530
Message-ID: <1327412249-31575-1-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-serial@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>, Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Partha Basak <p-basak2@ti.com>
List-Id: linux-omap@vger.kernel.org

From: "Govindraj.R" <govindraj.raja@ti.com>

On omap3630 onwards uart wer reg has bit 7
for tx wakeup enable.

Without this bit set some uart sluggishness might be seen
while printing data on console, response is better when
enabling this bit.
Tested with Beagle XM (OMAP3630)

Cc: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
---
But on omap3430 the bit is not available.

 arch/arm/plat-omap/include/plat/omap-serial.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
index 9ff4444..0c22d8d 100644
--- a/arch/arm/plat-omap/include/plat/omap-serial.h
+++ b/arch/arm/plat-omap/include/plat/omap-serial.h
@@ -39,7 +39,7 @@
 /* WER = 0x7F
  * Enable module level wakeup in WER reg
  */
-#define OMAP_UART_WER_MOD_WKUP	0X7F
+#define OMAP_UART_WER_MOD_WKUP	0xFF
 
 /* Enable XON/XOFF flow control on output */
 #define OMAP_UART_SW_TX		0x04
-- 
1.7.5.4

