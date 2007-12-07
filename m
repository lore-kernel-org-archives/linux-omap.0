From: "Madhusudhan Chikkature Rajashekar" <madhu.cr@ti.com>
Subject: RE: [RFC 1/2] MMC/SD Controller driver for OMAP2430
Date: Fri, 7 Dec 2007 18:57:05 +0530
Message-ID: <003201c838d4$dde47be0$fe8818ac@ent.ti.com>
References: <9C23CDD79DA20A479D4615857B2E2C47016A3480@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <9C23CDD79DA20A479D4615857B2E2C47016A3480@dlee13.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap-open-source@linux.omap.com, 'Pierre Ossman' <drzeus@drzeus.cx>
Cc: linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi All,

In response to the RFC posted by Khasim to support MMC/SD controller on OMAP2430, I am reposting the patches after fixing the
comments provided
by Russell King and Pierre Ossman. This patch also works for OMAP3430.

The following type of cards were tested.
- MMC/SD cards, SDHC card, MMCmobile card(at 1.8V).
- Hot plug of the cards.

TBD
- Multi-slot support.

FYI,
Below are the archive links to the comments provided by Russell King and Pierre Ossman.

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2007-July/041172.html
http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2007-August/041312.html

http://lists.arm.linux.org.uk/pipermail/linux-arm-kernel/2007-August/041313.html
This one had only two comments to change the usage of mdelay to msleep in the mmc board file. I have done the same and not reposting
that again
on arm linux kernel mailing list. 

Note: I am only posting the controller driver patch to arm linux kernel mailing list. Rest of the supporting omap patches will be
posted on linux omap list.

Kindly let me know if there are any further issues. I would be glad to work on it.

Thanks,
Madhu



-----Original Message-----
From: linux-omap-open-source-bounces@linux.omap.com [mailto:linux-omap-open-source-bounces@linux.omap.com] On Behalf Of Syed
Mohammed, Khasim
Sent: Thursday, July 26, 2007 5:47 AM
To: linux-arm-kernel@lists.arm.linux.org.uk; Pierre Ossman; linux-omap-open-source@linux.omap.com
Subject: [RFC 1/2] MMC/SD Controller driver for OMAP2430

Hello:

I am hereby presenting MMC/SD controller driver for OMAP 2430. It has been validated for SD/MMC (3v) cards on 2430 (ES 2.1) SDP
V4.0.

TBD:
 - Multi-slot support
 - Card detection is untested.
 - 1.8v cards are not tested.

It would be very kind of you to review this code and pass your comments.

FYI, I have posted complete series (other patches specific to OMAP tree) on linux-omap mailing list. 

Thanks & Regards,
Khasim

=============================================================================

diff -purN linux-omap/drivers/mmc/host/omap_hsmmc.c lin_for_mmc/drivers/mmc/host/omap_hsmmc.c
--- linux-omap/drivers/mmc/host/omap_hsmmc.c	1969-12-31 18:00:00.000000000 -0600
+++ lin_for_mmc/drivers/mmc/host/omap_hsmmc.c	2007-07-25 18:36:32.000000000 -0500
@@ -0,0 +1,1050 @@
+/*
+ * drivers/mmc/host/omap_hsmmc.c
+ *
+ * Driver for OMAP2430 MMC controller.
+ *
+ * Copyright (C) 2007 Texas Instruments.
+ *
+ * Authors:
+ *	Syed Mohammed Khasim	<x0khasim@ti.com>
+ *	Madhusudhan		<madhu.cr@ti.com>
+ *	Mohit Jalori		<mjalori@ti.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <linux/workqueue.h>
+#include <linux/timer.h>
+#include <linux/i2c.h>
+#include <linux/clk.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sd.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/card.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/dma.h>
+#include <asm/mach-types.h>
+#include <asm/hardware.h>
+#include <asm/arch/board.h>
+#include <asm/arch/mmc.h>
+#include <asm/arch/cpu.h>
+#include <asm/semaphore.h>
+
+#ifdef CONFIG_PM
+#include <linux/notifier.h>
+#include <linux/pm.h>
+#endif
+
+/* OMAP HSMMC Host Controller Registers */
+#define OMAP_HSMMC_SYSCONFIG	0x0010
+#define OMAP_HSMMC_CON		0x002C
+#define OMAP_HSMMC_BLK		0x0104
+#define OMAP_HSMMC_ARG		0x0108
+#define OMAP_HSMMC_CMD		0x010C
+#define OMAP_HSMMC_RSP10	0x0110
+#define OMAP_HSMMC_RSP32	0x0114
+#define OMAP_HSMMC_RSP54	0x0118
+#define OMAP_HSMMC_RSP76	0x011C
+#define OMAP_HSMMC_DATA		0x0120
+#define OMAP_HSMMC_HCTL		0x0128
+#define OMAP_HSMMC_SYSCTL	0x012C
+#define OMAP_HSMMC_STAT		0x0130
+#define OMAP_HSMMC_IE		0x0134
+#define OMAP_HSMMC_ISE		0x0138
+#define OMAP_HSMMC_CAPA		0x0140
+
+#define VS18			(1<<26)
+#define VS30			(1<<25)
+#define SDVS18			(0x5<<9)
+#define SDVS30			(0x6<<9)
+#define SDVSCLR			0xFFFFF1FF
+#define SDVSDET			0x00000400
+#define AUTOIDLE		0x1
+#define SDBP			(1<<8)
+#define DTO			0xe
+#define ICE			0x1
+#define ICS			0x2
+#define CEN			(1<<2)
+#define CLKD_MASK		0x0000FFC0
+#define INT_EN_MASK		0x307F0033
+#define INIT_STREAM		(1<<1)
+#define DP_SELECT		(1<<21)
+#define DDIR			(1<<4)
+#define DMA_EN			0x1
+#define MSBS			1<<5
+#define BCE			1<<1
+#define FOUR_BIT		1 << 1
+#define CC			0x1
+#define TC			0x02
+#define OD			0x1
+#define ERR			(1 << 15)
+#define CMD_TIMEOUT		(1 << 16)
+#define DATA_TIMEOUT		(1 << 20)
+#define CMD_CRC			(1 << 17)
+#define DATA_CRC		(1 << 21)
+#define CARD_ERR		(1 << 28)
+#define STAT_CLEAR		0xFFFFFFFF
+#define INIT_STREAM_CMD		0x00000000
+
+#define OMAP_MMC1_DEVID		1
+#define OMAP_MMC2_DEVID		2
+#define OMAP_MMC_DATADIR_NONE	0
+#define OMAP_MMC_DATADIR_READ	1
+#define OMAP_MMC_DATADIR_WRITE	2
+#define MMC1_ACTIVE_OVERWRITE	(1<<31)
+#define MMC_TIMEOUT_MS		20
+#define OMAP_MMC_MASTER_CLOCK	96000000
+#define DRIVER_NAME		"mmci-omap"
+#define mmc_slot(host)		(host->pdata->slots[host->slot_id])
+
+/*
+ * MMC Host controller read/write API's
+ */
+#define OMAP_HSMMC_READ(base, reg)	\
+	__raw_readl((base) + OMAP_HSMMC_##reg)
+
+#define OMAP_HSMMC_WRITE(base, reg, val) \
+	__raw_writel((val), (base) + OMAP_HSMMC_##reg)
+
+struct mmc_omap_host {
+	struct	device		*dev;
+	struct	mmc_host	*mmc;
+	struct	mmc_request	*mrq;
+	struct	mmc_command	*cmd;
+	struct	mmc_data	*data;
+	struct	resource	*mem_res;
+	struct	clk		*fclk, *iclk, *dbclk;
+	struct	semaphore	sem;
+	struct	work_struct	mmc_carddetect_work;
+	void	__iomem		*base;
+	void			*mapbase;
+	unsigned int		id;
+	unsigned int		dma_len;
+	unsigned int		dma_dir;
+	unsigned char		bus_mode;
+	unsigned char		datadir;
+	u32			*buffer;
+	u32			bytesleft;
+	int			suspended;
+	int			irq;
+	int			carddetect;
+	int			use_dma, dma_ch;
+	int			initstr;
+	int			slot_id;
+
+	struct	omap_mmc_platform_data	*pdata;
+};
+
+/*
+ * Stop clock to the card
+ */
+static void omap_mmc_stop_clock(struct mmc_omap_host *host)
+{
+	OMAP_HSMMC_WRITE(host->base, SYSCTL,
+		OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
+	if ((OMAP_HSMMC_READ(host->base, SYSCTL) & CEN) != 0x0)
+		dev_dbg(mmc_dev(host->mmc), "MMC Clock is not stoped");
+}
+
+/*
+ * Send init stream sequence to card
+ * before sending IDLE command
+ */
+static void send_init_stream(struct mmc_omap_host *host)
+{
+	int reg = 0;
+	typeof(jiffies) timeout;
+
+	disable_irq(host->irq);
+	OMAP_HSMMC_WRITE(host->base, CON,
+		OMAP_HSMMC_READ(host->base, CON) | INIT_STREAM);
+	OMAP_HSMMC_WRITE(host->base, CMD, INIT_STREAM_CMD);
+
+	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
+	while ((reg != CC) && time_before(jiffies, timeout)) {
+		reg = OMAP_HSMMC_READ(host->base, STAT) & CC;
+	}
+
+	OMAP_HSMMC_WRITE(host->base, CON,
+		OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);
+	enable_irq(host->irq);
+}
+
+/*
+ * Configure the Responce type
+ */
+static void
+mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
+{
+	int  cmdreg = 0, resptype = 0, cmdtype = 0;
+
+	dev_dbg(mmc_dev(host->mmc), "%s: CMD%d, argument 0x%08x\n",
+			mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
+	host->cmd = cmd;
+
+	/*
+	 * Clear status bits and enable interrupts
+	 */
+	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
+	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
+	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
+
+	switch (mmc_resp_type(cmd)) {
+	case MMC_RSP_R1:
+	case MMC_RSP_R3:
+	case MMC_RSP_R1B:
+		/* resp 1, 1b, 3 */
+		resptype = 2;
+		break;
+	case MMC_RSP_R2:
+		resptype = 1;
+		break;
+	default:
+		break;
+	}
+
+	cmdreg = (cmd->opcode << 24) | (resptype << 16) | (cmdtype << 22);
+	OMAP_HSMMC_WRITE(host->base, HCTL,
+			OMAP_HSMMC_READ(host->base,HCTL) & ~FOUR_BIT);
+
+	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4)
+		OMAP_HSMMC_WRITE(host->base, HCTL,
+				OMAP_HSMMC_READ(host->base, HCTL)
+						| FOUR_BIT);
+	else if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_1)
+		OMAP_HSMMC_WRITE(host->base, HCTL,
+				OMAP_HSMMC_READ(host->base, HCTL)
+						& ~FOUR_BIT);
+
+	if (cmd->opcode == MMC_READ_SINGLE_BLOCK ||
+			cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
+			cmd->opcode == SD_APP_SEND_SCR	||
+			((cmd->opcode == MMC_SEND_EXT_CSD) && cmd->arg == 0))
+		cmdreg |= DP_SELECT | DDIR | MSBS | BCE;
+
+	else if (cmd->opcode == MMC_WRITE_BLOCK ||
+			cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) {
+		cmdreg |= DP_SELECT | MSBS | BCE;
+		cmdreg &= ~(DDIR);
+	}
+
+	if (host->use_dma)
+		cmdreg |= DMA_EN;
+
+	if (cmd->opcode == MMC_GO_IDLE_STATE || cmd->opcode == MMC_SEND_OP_COND
+		|| cmd->opcode == MMC_ALL_SEND_CID)
+		OMAP_HSMMC_WRITE(host->base, CON,
+				OMAP_HSMMC_READ(host->base, CON) | OD);
+
+	if (cmd->opcode == MMC_GO_IDLE_STATE)
+		if (host->initstr == 0) {
+			send_init_stream(host);
+			host->initstr = 1;
+		}
+
+	OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
+	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
+}
+
+/*
+ * Notify the transder complete to MMC core
+ */
+static void
+mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
+{
+	host->data = NULL;
+
+	if (host->use_dma && host->dma_ch != -1) {
+		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
+			host->dma_dir);
+	}
+
+	host->datadir = OMAP_MMC_DATADIR_NONE;
+
+	if (data->error == MMC_ERR_NONE)
+		data->bytes_xfered += data->blocks * (data->blksz);
+
+	if (!data->stop) {
+		host->mrq = NULL;
+		mmc_request_done(host->mmc, data->mrq);
+		return;
+	}
+	mmc_omap_start_command(host, data->stop);
+}
+
+/*
+ * Notify the core about command completion
+ */
+static void
+mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
+{
+	host->cmd = NULL;
+
+	if (cmd->flags & MMC_RSP_PRESENT) {
+		if (cmd->flags & MMC_RSP_136) {
+			/* response type 2 */
+			cmd->resp[3] = OMAP_HSMMC_READ(host->base, RSP10);
+			cmd->resp[2] = OMAP_HSMMC_READ(host->base, RSP32);
+			cmd->resp[1] = OMAP_HSMMC_READ(host->base, RSP54);
+			cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP76);
+		} else {
+			/* response types 1, 1b, 3, 4, 5, 6 */
+			cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP10);
+		}
+	}
+	if (host->data == NULL || cmd->error != MMC_ERR_NONE) {
+		dev_dbg(mmc_dev(host->mmc), "%s: End request, err %x\n",
+				mmc_hostname(host->mmc), cmd->error);
+		host->mrq = NULL;
+		mmc_request_done(host->mmc, cmd->mrq);
+	}
+}
+
+/*
+ * DMA clean up for command errors
+ */
+static void mmc_dma_cleanup(struct mmc_omap_host *host)
+{
+	host->data->error |= MMC_ERR_TIMEOUT;
+
+	if (host->use_dma && host->dma_ch != -1) {
+		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
+			host->dma_dir);
+		omap_free_dma(host->dma_ch);
+		host->dma_ch = -1;
+		up(&host->sem);
+	}
+	host->data = NULL;
+	host->datadir = OMAP_MMC_DATADIR_NONE;
+}
+
+/*
+ * MMC controller IRQ handler
+ */
+static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
+{
+	struct mmc_omap_host *host = (struct mmc_omap_host *)dev_id;
+	int end_cmd = 0, end_trans = 0, status;
+	typeof(jiffies) timeout;
+
+	if (host->cmd == NULL && host->data == NULL) {
+		OMAP_HSMMC_WRITE(host->base, STAT,
+				OMAP_HSMMC_READ(host->base, STAT));
+		return IRQ_HANDLED;
+	}
+
+	if (host->cmd) {
+		if (host->cmd->opcode == MMC_SELECT_CARD
+			|| host->cmd->opcode == MMC_SWITCH) {
+			timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
+			while (time_before(jiffies, timeout)) {
+				if ((OMAP_HSMMC_READ(host->base, STAT)
+					& CC) == CC)
+					break;
+			}
+		}
+	}
+
+	status = OMAP_HSMMC_READ(host->base, STAT);
+	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
+
+	if (status & (ERR)) {
+		if (status & (CMD_TIMEOUT) ||
+			status & (CMD_CRC)) {
+			if (host->cmd) {
+				if (status & (CMD_TIMEOUT))
+					host->cmd->error |= MMC_ERR_TIMEOUT;
+				else
+					host->cmd->error |= MMC_ERR_BADCRC;
+				end_cmd = 1;
+			}
+			if (host->data)
+				mmc_dma_cleanup(host);
+		}
+		if (status & (DATA_TIMEOUT) ||
+			status & (DATA_CRC)) {
+			if (host->data) {
+				if (status & (DATA_TIMEOUT))
+					mmc_dma_cleanup(host);
+				else
+					host->data->error |= MMC_ERR_BADCRC;
+				end_trans = 1;
+			}
+		}
+		if (status & CARD_ERR) {
+			if (host->cmd) {
+				host->cmd->error |= MMC_ERR_FAILED;
+				end_cmd = 1;
+			}
+			if (host->data) {
+				host->data->error |= MMC_ERR_FAILED;
+				end_trans = 1;
+			}
+		}
+	}
+
+	OMAP_HSMMC_WRITE(host->base, STAT, status);
+	if (end_cmd || (status & CC))
+		mmc_omap_cmd_done(host, host->cmd);
+
+	if (end_trans || (status & TC))
+		if (host->mmc->mode == MMC_MODE_MMC
+			|| host->mmc->mode == MMC_MODE_SD)
+			mmc_omap_xfer_done(host, host->data);
+
+	return IRQ_HANDLED;
+}
+
+/*
+ * Swith MMC operating voltage
+ */
+static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
+{
+	u32 reg_val = 0;
+	int ret = 0;
+
+	/* Disable the clocks */
+	clk_disable(host->fclk);
+	clk_disable(host->iclk);
+	clk_disable(host->dbclk);
+
+	/* Turn the power off */
+	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
+	if (ret != 0)
+		goto err;
+
+	/* Turn the power ON with given VDD 1.8 or 3.0v */
+	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1, vdd);
+	if (ret != 0)
+		goto err;
+
+	clk_enable(host->fclk);
+	clk_enable(host->iclk);
+	clk_enable(host->dbclk);
+
+	OMAP_HSMMC_WRITE(host->base, HCTL,
+			OMAP_HSMMC_READ(host->base, HCTL) & SDVSCLR);
+	reg_val = OMAP_HSMMC_READ(host->base, HCTL);
+
+	if (((1 << vdd) == MMC_VDD_33_34) || ((1 << vdd) == MMC_VDD_33_34)) {
+		host->initstr = 0;
+		reg_val |= SDVS30;
+	}
+	if ((1 << vdd) == MMC_VDD_165_195)
+		reg_val |= SDVS18;
+
+	OMAP_HSMMC_WRITE(host->base, HCTL, reg_val);
+
+	OMAP_HSMMC_WRITE(host->base, HCTL,
+			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
+
+	return 0;
+err:
+	dev_dbg(mmc_dev(host->mmc), "Unable to switch operating voltage \n");
+	return -1;
+}
+
+/*
+ * Work Item to notify the core about card insertion/removal
+ */
+static void mmc_omap_detect(struct work_struct *work)
+{
+	u16 vdd = 0;
+	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
+						mmc_carddetect_work);
+
+	if (host->carddetect) {
+		if (!(OMAP_HSMMC_READ(host->base, HCTL)	& SDVSDET)) {
+			vdd = fls(host->mmc->ocr_avail) - 1;
+			if (omap_mmc_switch_opcond(host, vdd) != 0)
+				host->mmc->ios.vdd = vdd;
+			mmc_detect_change(host->mmc, (HZ * 200) / 1000);
+		}
+	} else {
+		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
+	}
+}
+
+/*
+ * ISR for handling card insertion and removal
+ */
+void omap_mmc_notify_card_detect(struct device *dev, int slot, int detected)
+{
+	struct mmc_omap_host *host = dev_get_drvdata(dev);
+
+	host->carddetect = detected;
+	schedule_work(&host->mmc_carddetect_work);
+}
+
+/*
+ * DMA call back function
+ */
+static void mmc_omap_dma_cb(int lch, u16 ch_status, void *data)
+{
+	struct mmc_omap_host *host = (struct mmc_omap_host *)data;
+
+	if (ch_status & (1 << 11))
+		dev_dbg(mmc_dev(host->mmc), "MISALIGNED_ADRS_ERR\n");
+
+	if (host->dma_ch < 0)
+		return;
+
+	omap_free_dma(host->dma_ch);
+	host->dma_ch = -1;
+	up(&host->sem);
+}
+
+/*
+ * Configure dma src and destination parameters
+ */
+static int mmc_omap_config_dma_param(int sync_dir, struct mmc_omap_host *host,
+				     struct mmc_data *data)
+{
+	if (sync_dir == 0) {
+		omap_set_dma_dest_params(host->dma_ch, 0,
+			OMAP_DMA_AMODE_CONSTANT,
+			(dma_addr_t) (host-> mapbase + OMAP_HSMMC_DATA), 0, 0);
+		omap_set_dma_src_params(host->dma_ch, 0,
+			OMAP_DMA_AMODE_POST_INC,
+			    sg_dma_address(&data-> sg[0]), 0, 0);
+	} else {
+		omap_set_dma_src_params(host->dma_ch, 0,
+			OMAP_DMA_AMODE_CONSTANT,
+			(dma_addr_t) (host->mapbase +OMAP_HSMMC_DATA), 0, 0);
+		omap_set_dma_dest_params(host->dma_ch, 0,
+			OMAP_DMA_AMODE_POST_INC,
+				sg_dma_address(&data->sg[0]), 0, 0);
+	}
+	return 0;
+}
+
+/*
+ * Rotine to configure and start DMA for the MMC card
+ */
+static int
+mmc_omap_start_dma_transfer(struct mmc_omap_host *host, struct mmc_request *req)
+{
+	int sync_dev, sync_dir = 0;
+	int dma_ch = 0, ret = 0;
+	struct mmc_data *data = req->data;
+
+	/*
+	 * If for some reason the DMA transfer is still active,
+	 * we wait for timeout period and free the dma
+	 */
+	if (host->dma_ch != -1) {
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(100);
+		if (down_trylock(&host->sem)) {
+			omap_free_dma(host->dma_ch);
+			host->dma_ch = -1;
+			up(&host->sem);
+			return 1;
+		}
+	} else {
+		if (down_trylock(&host->sem)) {
+			BUG();
+		}
+	}
+	if (!(data->flags & MMC_DATA_WRITE)) {
+		host->dma_dir = DMA_FROM_DEVICE;
+		if (host->id == OMAP_MMC1_DEVID)
+			sync_dev = OMAP24XX_DMA_MMC1_RX;
+		else
+			sync_dev = OMAP24XX_DMA_MMC2_RX;
+	} else {
+		host->dma_dir = DMA_TO_DEVICE;
+		if (host->id == OMAP_MMC1_DEVID)
+			sync_dev = OMAP24XX_DMA_MMC1_TX;
+		else
+			sync_dev = OMAP24XX_DMA_MMC2_TX;
+	}
+
+	ret = omap_request_dma(sync_dev, "MMC/SD", mmc_omap_dma_cb,
+							host, &dma_ch);
+	if (ret != 0) {
+		dev_dbg(mmc_dev(host->mmc),
+			"%s: omap_request_dma() failed with %d\n",
+			mmc_hostname(host->mmc), ret);
+		return ret;
+	}
+
+	host->dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
+					data->sg_len, host->dma_dir);
+	host->dma_ch = dma_ch;
+
+	if (!(data->flags & MMC_DATA_WRITE))
+		mmc_omap_config_dma_param(1, host, data);
+	else
+		mmc_omap_config_dma_param(0, host, data);
+
+	omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32,
+		(data->blksz / 4), data->blocks, OMAP_DMA_SYNC_FRAME,
+							sync_dev, sync_dir);
+	omap_start_dma(dma_ch);
+	return 0;
+}
+
+/*
+ * Configure block leangth for MMC/SD cards and intiate the transfer.
+ */
+static int
+mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
+{
+	int ret = 0;
+	host->data = req->data;
+
+	if (req->data == NULL) {
+		host->datadir = OMAP_MMC_DATADIR_NONE;
+		OMAP_HSMMC_WRITE(host->base, BLK, 0);
+		return 0;
+	}
+
+	OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
+					| (req->data->blocks << 16) );
+
+	host->datadir = (req->data-> flags & MMC_DATA_WRITE) ?
+			OMAP_MMC_DATADIR_WRITE : OMAP_MMC_DATADIR_READ;
+
+	if (host->use_dma) {
+		ret = mmc_omap_start_dma_transfer(host, req);
+		if (ret != 0) {
+			dev_dbg(mmc_dev(host->mmc), "MMC start dma failure\n");
+			return ret;
+		} else {
+			host->buffer = NULL;
+			host->bytesleft = 0;
+		}
+	} else {
+		host->buffer =	(u32 *) (page_address(req->data->sg->page) +
+							req->data->sg->offset);
+		host->bytesleft = req->data->blocks * (req->data->blksz);
+		host->dma_ch = -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Request function. for read/write operation
+ */
+static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
+{
+	struct mmc_omap_host *host = mmc_priv(mmc);
+
+	WARN_ON(host->mrq != NULL);
+	host->mrq = req;
+
+	/* Reset MMC Controller's Data FSM */
+	if (req->cmd->opcode == MMC_GO_IDLE_STATE) {
+		OMAP_HSMMC_WRITE(host->base, SYSCTL,
+				OMAP_HSMMC_READ(host->base, SYSCTL) | 1 << 26);
+		while (OMAP_HSMMC_READ(host->base, SYSCTL) & (1 << 26)) ;
+	}
+
+	if (req->cmd->opcode == SD_APP_SEND_SCR
+		|| req->cmd->opcode == MMC_SEND_EXT_CSD)
+		mmc->ios.bus_width = MMC_BUS_WIDTH_1;
+
+	if (mmc_omap_prepare_data(host, req))
+		dev_dbg(mmc_dev(host->mmc),
+			"MMC host %s failed to initiate data transfer\n",
+			mmc_hostname(host->mmc));
+	mmc_omap_start_command(host, req->cmd);
+}
+
+
+/*
+ * Configuring clock values.
+ */
+/* Routine to configure clock values. Exposed API to core */
+static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
+{
+	struct mmc_omap_host *host = mmc_priv(mmc);
+	u16 dsor = 0;
+	unsigned long regval;
+	typeof(jiffies) timeout;
+
+	switch (ios->power_mode) {
+	case MMC_POWER_OFF:
+		mmc_slot(host).set_power(host->dev,host->slot_id, 0, 0);
+		break;
+	case MMC_POWER_UP:
+		mmc_slot(host).set_power(host->dev,host->slot_id, 1, ios->vdd);
+		break;
+	}
+
+	if (host->id == OMAP_MMC1_DEVID) {
+		if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
+				((ios->vdd == 7) || (ios->vdd == 8))) {
+				/* vdd is 1.8v */
+				if (omap_mmc_switch_opcond(host, ios->vdd) != 0)
+					dev_dbg(mmc_dev(host->mmc),
+						"Switch operation failed\n");
+				host->initstr = 0;
+		}
+	}
+
+	if (ios->clock) {
+		dsor = OMAP_MMC_MASTER_CLOCK / ios->clock;
+		if (dsor < 1)
+			dsor = 1;
+
+		if (OMAP_MMC_MASTER_CLOCK / dsor > ios->clock)
+			dsor++;
+
+		if (dsor > 250)
+			dsor = 250;
+	}
+
+	omap_mmc_stop_clock(host);
+	regval = OMAP_HSMMC_READ(host->base, SYSCTL);
+	regval = regval & ~(CLKD_MASK);
+	regval = regval | (dsor << 6) | (DTO << 16);
+	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
+	OMAP_HSMMC_WRITE(host->base, SYSCTL,
+			OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
+
+	/* Wait till the ICS bit is set */
+	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
+	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & ICS) != 0x2
+		&& time_before(jiffies, timeout)) ;
+
+	OMAP_HSMMC_WRITE(host->base, SYSCTL,
+			OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
+}
+
+static struct mmc_host_ops mmc_omap_ops = {
+	.request = omap_mmc_request,
+	.set_ios = omap_mmc_set_ios,
+};
+
+static int __init omap_mmc_probe(struct platform_device *pdev)
+{
+	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
+	struct mmc_host *mmc;
+	struct mmc_omap_host *host = NULL;
+	struct resource *res;
+	int ret = 0, irq;
+
+	if (pdata == NULL) {
+		dev_err(&pdev->dev, "Platform Data is missing\n");
+		return -ENXIO;
+	}
+
+	if (pdata->nr_slots == 0) {
+		dev_err(&pdev->dev, "No Slots\n");
+		return -ENXIO;
+	}
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq = platform_get_irq(pdev, 0);
+	if (res == NULL || irq < 0)
+		return -ENXIO;
+
+	res = request_mem_region(res->start, res->end - res->start + 1,
+							pdev->name);
+	if (res == NULL)
+		return -EBUSY;
+
+	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), &pdev->dev);
+	if (!mmc) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	host		= mmc_priv(mmc);
+	host->mmc	= mmc;
+	host->pdata	= pdata;
+	host->use_dma	= 1;
+	host->dma_ch	= -1;
+	host->initstr	= 0;
+	host->mem_res	= res;
+	host->irq	= irq;
+	host->id	= pdev->id;
+	host->slot_id	= pdev->id - 1;
+	host->mapbase	= (void *)host->mem_res->start;
+	host->base	= (void __iomem *)IO_ADDRESS(host->mapbase);
+	mmc->ops	= &mmc_omap_ops;
+	mmc->f_min	= 400000;
+	mmc->f_max	= 52000000;
+
+	sema_init(&host->sem, 1);
+
+	host->iclk = clk_get(&pdev->dev, "mmchs_ick");
+	if (IS_ERR(host->iclk)) {
+		ret = PTR_ERR(host->iclk);
+		host->iclk = NULL;
+		goto err;
+	}
+	host->fclk = clk_get(&pdev->dev, "mmchs_fck");
+	if (IS_ERR(host->fclk)) {
+		ret = PTR_ERR(host->fclk);
+		host->fclk = NULL;
+		clk_put(host->iclk);
+		goto err;
+	}
+	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
+
+	/*
+	 * MMC can still work without debounce clock.
+	 */
+	if (IS_ERR(host->dbclk))
+		dev_dbg(mmc_dev(host->mmc), "Failed to get debounce clock \n");
+
+	if (clk_enable(host->fclk) != 0) {
+		goto err;
+	}
+	if (clk_enable(host->iclk) != 0) {
+		clk_disable(host->fclk);
+		clk_put(host->fclk);
+		goto err;
+	}
+	if (clk_enable(host->dbclk) != 0)
+		dev_dbg(mmc_dev(host->mmc), "Enabling debounce clk failed\n");
+
+	omap_writel(omap_readl(CONTROL_DEVCONF1) | MMC1_ACTIVE_OVERWRITE,
+						CONTROL_DEVCONF1);
+	mmc->ocr_avail = mmc_slot(host).ocr_mask;
+	mmc->caps |= MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK;
+	if (pdata->wire4)
+		mmc->caps = MMC_CAP_4_BIT_DATA;
+
+	OMAP_HSMMC_WRITE(host->base, HCTL,
+			OMAP_HSMMC_READ(host->base, HCTL) | SDVS30);
+
+	OMAP_HSMMC_WRITE(host->base, CAPA,OMAP_HSMMC_READ(host->base,
+							CAPA) | VS30 | VS18);
+
+	/* Set the controller to AUTO IDLE mode */
+	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
+			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
+
+	/* Set SD bus power bit */
+	OMAP_HSMMC_WRITE(host->base, HCTL,
+			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
+
+	/* Request IRQ for MMC operations */
+	ret = request_irq(host->irq, mmc_omap_irq, 0, pdev->name, host);
+	if (ret) {
+		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ");
+		goto irq_err;
+	}
+
+	INIT_WORK(&host->mmc_carddetect_work, mmc_omap_detect);
+	if(pdata->init != NULL) {
+		if (pdata->init(&pdev->dev) != 0) {
+			free_irq(host->irq, host);
+			goto irq_err;
+		}
+	}
+
+	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
+	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
+
+	platform_set_drvdata(pdev, host);
+	mmc_add_host(mmc);
+
+	return 0;
+
+err:
+	dev_dbg(mmc_dev(host->mmc), "Probe Fail\n");
+	if (host)
+		mmc_free_host(mmc);
+	return ret;
+
+irq_err:
+	dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs");
+	clk_disable(host->fclk);
+	clk_disable(host->iclk);
+	clk_disable(host->dbclk);
+
+	clk_put(host->fclk);
+	clk_put(host->iclk);
+	clk_put(host->dbclk);
+
+	if (host)
+		mmc_free_host(mmc);
+	return ret;
+}
+
+static int omap_mmc_remove(struct platform_device *pdev)
+{
+	struct mmc_omap_host *host = platform_get_drvdata(pdev);
+
+	platform_set_drvdata(pdev, NULL);
+	if (host) {
+		host->pdata->cleanup(&pdev->dev);
+		free_irq(host->irq, host);
+		flush_scheduled_work();
+
+		clk_disable(host->fclk);
+		clk_disable(host->iclk);
+		clk_disable(host->dbclk);
+		clk_put(host->fclk);
+		clk_put(host->iclk);
+		clk_put(host->dbclk);
+
+		mmc_free_host(host->mmc);
+	}
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	int ret = 0;
+	struct mmc_omap_host *host = platform_get_drvdata(pdev);
+
+	if (host && host->suspended)
+		return 0;
+
+	if (host) {
+		ret = mmc_suspend_host(host->mmc, state);
+		if (ret == 0) {
+			host->suspended = 1;
+
+		OMAP_HSMMC_WRITE(host->base, ISE, 0);
+		OMAP_HSMMC_WRITE(host->base, IE, 0);
+
+		ret = host->pdata->suspend(&pdev->dev, host->slot_id);
+		if (ret)
+			dev_dbg(mmc_dev(host->mmc),
+				"Unable to handle MMC board level suspend\n");
+
+		if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
+			OMAP_HSMMC_WRITE(host->base,HCTL,
+					OMAP_HSMMC_READ(host->base, HCTL)
+					& SDVSCLR);
+			OMAP_HSMMC_WRITE(host->base,HCTL,
+					OMAP_HSMMC_READ(host->base, HCTL)
+					|SDVS30);
+			OMAP_HSMMC_WRITE(host->base,HCTL,
+					OMAP_HSMMC_READ(host->base, HCTL)
+					| SDBP);
+		}
+		clk_disable(host->fclk);
+		clk_disable(host->iclk);
+		clk_disable(host->dbclk);
+
+		if (host->id == OMAP_MMC1_DEVID) {
+			omap_writel(omap_readl(CONTROL_DEVCONF1)
+					& ~MMC1_ACTIVE_OVERWRITE,
+					CONTROL_DEVCONF1);
+		}
+
+		/* Power off slot power */
+		ret = mmc_slot(host).set_power(host->dev,host->slot_id, 0, 0);
+		if (ret != 0)
+			dev_dbg(mmc_dev(host->mmc), "Unable to disable power to MMC\n");
+			host->initstr = 0;
+		}
+	}
+	return ret;
+}
+
+/* Routine to resume the MMC device */
+static int omap_mmc_resume(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct mmc_omap_host *host = platform_get_drvdata(pdev);
+
+	if (host && !host->suspended)
+		return 0;
+
+	if (host) {
+		if (host->id == OMAP_MMC1_DEVID) {
+			omap_writel(omap_readl(CONTROL_DEVCONF1)
+						| MMC1_ACTIVE_OVERWRITE,
+						CONTROL_DEVCONF1);
+		}
+
+		mmc_slot(host).set_power(host->dev, host->slot_id, 1,
+							host->mmc->ios.vdd);
+		if (ret != 0) {
+			dev_dbg(mmc_dev(host->mmc), "Enabling power failed\n");
+			return ret;
+		}
+
+		if (clk_enable(host->fclk) != 0)
+			goto clk_en_err;
+
+		if (clk_enable(host->iclk) != 0) {
+			clk_disable(host->fclk);
+			clk_put(host->fclk);
+			goto clk_en_err;
+		}
+
+		if (clk_enable(host->dbclk) != 0)
+			dev_dbg(mmc_dev(host->mmc),
+					"Enabling debounce clk failed\n");
+
+		ret = host->pdata->resume(&pdev->dev, host->slot_id);
+		if (ret)
+			dev_dbg(mmc_dev(host->mmc),
+					"Unmask interrupt failed\n");
+
+		/* Notify the core to resume the host */
+		ret = mmc_resume_host(host->mmc);
+		if (ret == 0)
+			host->suspended = 0;
+		msleep_interruptible(1);
+	}
+
+	return ret;
+
+clk_en_err:
+	dev_dbg(mmc_dev(host->mmc),
+		"Failed to enable MMC clocks during resume\n");
+	return -1;
+}
+
+#else
+#define omap_mmc_suspend	NULL
+#define omap_mmc_resume		NULL
+#endif
+
+static struct platform_driver omap_mmc_driver = {
+	.probe	= omap_mmc_probe,
+	.remove	= omap_mmc_remove,
+	.suspend= omap_mmc_suspend,
+	.resume	= omap_mmc_resume,
+	.driver	= {
+		   .name = DRIVER_NAME,
+	},
+};
+
+static int __init omap_mmc_init(void)
+{
+	/* Register the MMC driver */
+	if (platform_driver_register(&omap_mmc_driver)) {
+		printk(KERN_ERR ": Failed to register MMC driver\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static void __exit omap_mmc_cleanup(void)
+{
+	/* Unregister MMC driver */
+	platform_driver_unregister(&omap_mmc_driver);
+}
+
+module_init(omap_mmc_init);
+module_exit(omap_mmc_cleanup);
+
+MODULE_DESCRIPTION("OMAP High Speed Multimedia Card driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS(DRIVER_NAME);
+MODULE_AUTHOR("Texas Instruments Inc");
_______________________________________________
Linux-omap-open-source mailing list
Linux-omap-open-source@linux.omap.com
http://linux.omap.com/mailman/listinfo/linux-omap-open-source
