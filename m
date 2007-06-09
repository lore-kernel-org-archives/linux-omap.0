From: Vivien Chappelier <vivien.chappelier@free.fr>
Subject: [PATCH 8/12] MMC fixes for OMAP730.
Date: Sat, 09 Jun 2007 19:31:53 +0200
Message-ID: <466AE409.7010502@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This patch fixes the MMC register definitions for OMAP730. It also fixes an
incorrect error reporting from the controller when sending the
SD_SEND_RELATIVE_ADDR command during SD card initialization.

Signed-off-by: Vivien Chappelier <vivien.chappelier@free.fr>

---
 drivers/mmc/host/omap.c |   56 
+++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 383bd54..6904cad 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -39,6 +39,33 @@
 #include <asm/arch/tps65010.h>
 #include <asm/arch/board-sx1.h>
 
+#ifdef CONFIG_ARCH_OMAP730
+#define    OMAP_MMC_REG_CMD    0x00
+#define    OMAP_MMC_REG_ARGL    0x02
+#define    OMAP_MMC_REG_ARGH    0x04
+#define    OMAP_MMC_REG_CON    0x06
+#define    OMAP_MMC_REG_STAT    0x08
+#define    OMAP_MMC_REG_IE        0x0a
+#define    OMAP_MMC_REG_CTO    0x0c
+#define    OMAP_MMC_REG_DTO    0x0e
+#define    OMAP_MMC_REG_DATA    0x10
+#define    OMAP_MMC_REG_BLEN    0x12
+#define    OMAP_MMC_REG_NBLK    0x14
+#define    OMAP_MMC_REG_BUF    0x16
+#define    OMAP_MMC_REG_SDIO    0x1a
+#define    OMAP_MMC_REG_REV    0x1e
+#define    OMAP_MMC_REG_RSP0    0x20
+#define    OMAP_MMC_REG_RSP1    0x22
+#define    OMAP_MMC_REG_RSP2    0x24
+#define    OMAP_MMC_REG_RSP3    0x26
+#define    OMAP_MMC_REG_RSP4    0x28
+#define    OMAP_MMC_REG_RSP5    0x2a
+#define    OMAP_MMC_REG_RSP6    0x2c
+#define    OMAP_MMC_REG_RSP7    0x2e
+#define    OMAP_MMC_REG_IOSR    0x30
+#define    OMAP_MMC_REG_SYSC    0x32
+#define    OMAP_MMC_REG_SYSS    0x34
+#else
 #define    OMAP_MMC_REG_CMD    0x00
 #define    OMAP_MMC_REG_ARGL    0x04
 #define    OMAP_MMC_REG_ARGH    0x08
@@ -64,6 +91,7 @@
 #define    OMAP_MMC_REG_IOSR    0x60
 #define    OMAP_MMC_REG_SYSC    0x64
 #define    OMAP_MMC_REG_SYSS    0x68
+#endif
 
 #define    OMAP_MMC_STAT_CARD_ERR        (1 << 14)
 #define    OMAP_MMC_STAT_CARD_IRQ        (1 << 13)
@@ -524,19 +552,33 @@ static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
         }
 
         if (status & OMAP_MMC_STAT_CARD_ERR) {
-            if (host->cmd && host->cmd->opcode == MMC_STOP_TRANSMISSION) {
+            if (host->cmd) {
                 u32 response = OMAP_MMC_READ(host, RSP6)
                     | (OMAP_MMC_READ(host, RSP7) << 16);
+
+                switch (host->cmd->opcode) {
                 /* STOP sometimes sets must-ignore bits */
-                if (!(response & (R1_CC_ERROR
-                                | R1_ILLEGAL_COMMAND
-                                | R1_COM_CRC_ERROR))) {
-                    end_command = 1;
-                    continue;
+                case MMC_STOP_TRANSMISSION:
+                    if (!(response & (R1_CC_ERROR |
+                              R1_ILLEGAL_COMMAND |
+                              R1_COM_CRC_ERROR))) {
+                        end_command = 1;
+                        continue;
+                    }
+                    break;
+                case MMC_SET_RELATIVE_ADDR:
+                    if (!(response & (R1_WP_ERASE_SKIP |
+                              R1_CARD_ECC_DISABLED |
+                              R1_ERASE_RESET))) {
+                        end_command = 1;
+                        continue;
+                    }
+                    break;
                 }
             }
 
-            dev_dbg(mmc_dev(host->mmc), "card status error (CMD%d)\n",
+            dev_dbg(mmc_dev(host->mmc),
+                "card status error (CMD%d)\n",
                 host->cmd->opcode);
             if (host->cmd) {
                 host->cmd->error = MMC_ERR_FAILED;
-- 
1.5.1.3
