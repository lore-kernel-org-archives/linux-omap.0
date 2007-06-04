From: "andrzej zaborowski" <balrogg@gmail.com>
Subject: SD response type 6 vs. 1
Date: Mon, 4 Jun 2007 17:41:50 +0200
Message-ID: <fb249edb0706040841m222daab2xc7a4833e7b1c96cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>, Pierre Ossman <drzeus-list@drzeus.cx>
List-Id: linux-omap@vger.kernel.org

Hi,
  Linux has the same values for MMC_RSP_R1 and MMC_RSP_R6 thus making
the two response formats indistinguishable for mmc/sd hosts. Hardware
like my OMAP310 needs to know exactly whether to expect an R1 or R6
format, otherwise CMD3 fails.

Sure it would be nice if it didn't care, but nevertheless, it's not a
hardware bug - the two formats are specified separately in SD specs
because they *are* different. So the hardware has full right to know
the right response type. Rather it's a hack to rely on R1 and R6
having the same size, like Linux does now. It would also be a hack to
allow the CMD3 to fail with CRC error and ignore the error, like
omap.c did before, because it makes an assumption that's not in the
OMAP specs.

The following is an ugly fix. It's ugly because host code should be
agnostic to opcodes, as mentioned by Pierre Ossman.
I believe this was already submitted by Carlos Aguiar and rejected by
Pierre, which resulted in leaving the driver broken on some boards.
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -22,6 +22,7 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/mmc/mmc.h>
+#include <linux/mmc/sd.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 #include <linux/clk.h>
@@ -211,6 +221,9 @@ mmc_omap_start_command(struct mmc_omap_host *host,
struct mmc_command *cmd)
        case MMC_RSP_R1B:
                /* resp 1, 1b, 6, 7 */
                resptype = 1;
+               if (mmc_card_sd(host->mmc->card) &&
+                               cmd->opcode == SD_SEND_RELATIVE_ADDR)
+                       resptype = 6;
                break;
        case MMC_RSP_R2:
                resptype = 2;
----8<---------------------------------

A more correct and more intrusive fix would look like this:
diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
--- a/include/linux/mmc/core.h
+++ b/include/linux/mmc/core.h
@@ -25,11 +25,12 @@ struct mmc_command {
 #define MMC_RSP_CRC    (1 << 2)                /* expect valid crc */
 #define MMC_RSP_BUSY   (1 << 3)                /* card may send busy */
 #define MMC_RSP_OPCODE (1 << 4)                /* response contains opcode */
-#define MMC_CMD_MASK   (3 << 5)                /* command type */
-#define MMC_CMD_AC     (0 << 5)
-#define MMC_CMD_ADTC   (1 << 5)
-#define MMC_CMD_BC     (2 << 5)
-#define MMC_CMD_BCR    (3 << 5)
+#define MMC_RSP_RCA    (1 << 5)                /* response contains an rca */
+#define MMC_CMD_MASK   (3 << 6)                /* command type */
+#define MMC_CMD_AC     (0 << 6)
+#define MMC_CMD_ADTC   (1 << 6)
+#define MMC_CMD_BC     (2 << 6)
+#define MMC_CMD_BCR    (3 << 6)

 /*
  * These are the response types, and correspond to valid bit
@@ -41,10 +42,10 @@ struct mmc_command {
 #define MMC_RSP_R1B
(MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
 #define MMC_RSP_R2     (MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC)
 #define MMC_RSP_R3     (MMC_RSP_PRESENT)
-#define MMC_RSP_R6     (MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)
+#define MMC_RSP_R6     (MMC_RSP_PRESENT|MMC_RSP_RCA)
 #define MMC_RSP_R7     (MMC_RSP_PRESENT|MMC_RSP_CRC|MMC_RSP_OPCODE)

-#define mmc_resp_type(cmd)     ((cmd)->flags &
(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE))
+#define mmc_resp_type(cmd)     ((cmd)->flags &
(MMC_RSP_PRESENT|MMC_RSP_136|MMC_RSP_CRC|MMC_RSP_BUSY|MMC_RSP_OPCODE|MMC_RSP_RCA))

 /*
  * These are the command types.
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -206,6 +206,9 @@ static int au1xmmc_send_command(struct
au1xmmc_host *host, int wait,
        case MMC_RSP_R3:
                mmccmd |= SD_CMD_RT_3;
                break;
+       case MMC_RSP_R6:
+               mmccmd |= SD_CMD_RT_6;
+               break;
        default:
                printk(KERN_INFO "au1xmmc: unhandled response type %02x\n",
                        mmc_resp_type(cmd));
diff --git a/drivers/mmc/host/imxmmc.c b/drivers/mmc/host/imxmmc.c
--- a/drivers/mmc/host/imxmmc.c
+++ b/drivers/mmc/host/imxmmc.c
@@ -350,6 +350,9 @@ static void imxmci_start_cmd(struct imxmci_host
*host, struct mmc_command *cmd,
        case MMC_RSP_R3: /* short */
                cmdat |= CMD_DAT_CONT_RESPONSE_FORMAT_R3;
                break;
+       case MMC_RSP_R6: /* short RCA */
+               cmdat |= CMD_DAT_CONT_RESPONSE_FORMAT_R6;
+               break;
        default:
                break;
        }
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -209,7 +219,7 @@ mmc_omap_start_command(struct mmc_omap_host *host,
struct mmc_command *cmd)
                break;
        case MMC_RSP_R1:
        case MMC_RSP_R1B:
-               /* resp 1, 1b, 6, 7 */
+               /* resp 1, 1b, 7 */
                resptype = 1;
                break;
        case MMC_RSP_R2:
@@ -218,6 +228,9 @@ mmc_omap_start_command(struct mmc_omap_host *host,
struct mmc_command *cmd)
        case MMC_RSP_R3:
                resptype = 3;
                break;
+       case MMC_RSP_R6:
+               resptype = 6;
+               break;
        default:
                dev_err(mmc_dev(host->mmc), "Invalid response type:
%04x\n", mmc_resp_type(cmd));
                break;
diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -170,7 +170,8 @@ static void pxamci_start_cmd(struct pxamci_host
*host, struct mmc_command *cmd,

 #define RSP_TYPE(x)    ((x) & ~(MMC_RSP_BUSY|MMC_RSP_OPCODE))
        switch (RSP_TYPE(mmc_resp_type(cmd))) {
-       case RSP_TYPE(MMC_RSP_R1): /* r1, r1b, r6, r7 */
+       case RSP_TYPE(MMC_RSP_R1): /* r1, r1b, r7 */
+       case RSP_TYPE(MMC_RSP_R6):
                cmdat |= CMDAT_RESP_SHORT;
                break;
        case RSP_TYPE(MMC_RSP_R3):
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -549,7 +549,7 @@ static void sdhci_send_command(struct sdhci_host
*host, struct mmc_command *cmd)

        if (cmd->flags & MMC_RSP_CRC)
                flags |= SDHCI_CMD_CRC;
-       if (cmd->flags & MMC_RSP_OPCODE)
+       if (cmd->flags & (MMC_RSP_OPCODE | MMC_RSP_RCA))
                flags |= SDHCI_CMD_INDEX;
        if (cmd->data)
                flags |= SDHCI_CMD_DATA;
diff --git a/drivers/mmc/host/tifm_sd.c b/drivers/mmc/host/tifm_sd.c
--- a/drivers/mmc/host/tifm_sd.c
+++ b/drivers/mmc/host/tifm_sd.c
@@ -345,6 +345,9 @@ static unsigned int tifm_sd_op_flags(struct
mmc_command *cmd)
        case MMC_RSP_R3:
                rc |= TIFM_MMCSD_RSP_R3;
                break;
+       case MMC_RSP_R6:
+               rc |= TIFM_MMCSD_RSP_R6;
+               break;
        default:
                BUG();
        }

What's the preferred way to resolve this?

Regards,
Andrzej
