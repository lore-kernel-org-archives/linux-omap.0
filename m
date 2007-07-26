From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC 1/2] MMC/SD Controller driver for OMAP2430
Date: Thu, 26 Jul 2007 10:42:01 +0100
Message-ID: <20070726094201.GB27453@flint.arm.linux.org.uk>
References: <9C23CDD79DA20A479D4615857B2E2C47016A3480@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
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
To: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Cc: linux-omap-open-source@linux.omap.com, linux-arm-kernel@lists.arm.linux.org.uk, Pierre Ossman <drzeus@drzeus.cx>
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 25, 2007 at 07:17:06PM -0500, Syed Mohammed, Khasim wrote:
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +#include <linux/timer.h>
> +#include <linux/i2c.h>

I don't see any i2c stuff in this file.

> +#include <linux/clk.h>
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/sd.h>
> +#include <linux/mmc/core.h>
> +#include <linux/mmc/card.h>

Are you sure you need to include all these linux/mmc includes?  Remove all
that are not appropriate.

> +#include <asm/io.h>

Should be linux/io.h

> +#include <asm/irq.h>

Are you sure this is required?

> +#include <asm/dma.h>

And this?

> +#include <asm/mach-types.h>

I don't think this is required.

> +#include <asm/hardware.h>
> +#include <asm/arch/board.h>
> +#include <asm/arch/mmc.h>
> +#include <asm/arch/cpu.h>
> +#include <asm/semaphore.h>

You should be using mutexes instead of semaphores.

> +
> +#ifdef CONFIG_PM
> +#include <linux/notifier.h>
> +#include <linux/pm.h>
> +#endif

These are redundant.

> +
> +/* OMAP HSMMC Host Controller Registers */
> +#define OMAP_HSMMC_SYSCONFIG	0x0010
> +#define OMAP_HSMMC_CON		0x002C
> +#define OMAP_HSMMC_BLK		0x0104
> +#define OMAP_HSMMC_ARG		0x0108
> +#define OMAP_HSMMC_CMD		0x010C
> +#define OMAP_HSMMC_RSP10	0x0110
> +#define OMAP_HSMMC_RSP32	0x0114
> +#define OMAP_HSMMC_RSP54	0x0118
> +#define OMAP_HSMMC_RSP76	0x011C
> +#define OMAP_HSMMC_DATA		0x0120
> +#define OMAP_HSMMC_HCTL		0x0128
> +#define OMAP_HSMMC_SYSCTL	0x012C
> +#define OMAP_HSMMC_STAT		0x0130
> +#define OMAP_HSMMC_IE		0x0134
> +#define OMAP_HSMMC_ISE		0x0138
> +#define OMAP_HSMMC_CAPA		0x0140
> +
> +#define VS18			(1<<26)
> +#define VS30			(1<<25)
> +#define SDVS18			(0x5<<9)
> +#define SDVS30			(0x6<<9)
> +#define SDVSCLR			0xFFFFF1FF
> +#define SDVSDET			0x00000400
> +#define AUTOIDLE		0x1
> +#define SDBP			(1<<8)
> +#define DTO			0xe
> +#define ICE			0x1
> +#define ICS			0x2
> +#define CEN			(1<<2)
> +#define CLKD_MASK		0x0000FFC0
> +#define INT_EN_MASK		0x307F0033
> +#define INIT_STREAM		(1<<1)
> +#define DP_SELECT		(1<<21)
> +#define DDIR			(1<<4)
> +#define DMA_EN			0x1
> +#define MSBS			1<<5
> +#define BCE			1<<1
> +#define FOUR_BIT		1 << 1
> +#define CC			0x1
> +#define TC			0x02
> +#define OD			0x1
> +#define ERR			(1 << 15)
> +#define CMD_TIMEOUT		(1 << 16)
> +#define DATA_TIMEOUT		(1 << 20)
> +#define CMD_CRC			(1 << 17)
> +#define DATA_CRC		(1 << 21)
> +#define CARD_ERR		(1 << 28)
> +#define STAT_CLEAR		0xFFFFFFFF
> +#define INIT_STREAM_CMD		0x00000000
> +
> +#define OMAP_MMC1_DEVID		1
> +#define OMAP_MMC2_DEVID		2
> +#define OMAP_MMC_DATADIR_NONE	0
> +#define OMAP_MMC_DATADIR_READ	1
> +#define OMAP_MMC_DATADIR_WRITE	2
> +#define MMC1_ACTIVE_OVERWRITE	(1<<31)
> +#define MMC_TIMEOUT_MS		20
> +#define OMAP_MMC_MASTER_CLOCK	96000000
> +#define DRIVER_NAME		"mmci-omap"
> +#define mmc_slot(host)		(host->pdata->slots[host->slot_id])
> +
> +/*
> + * MMC Host controller read/write API's
> + */
> +#define OMAP_HSMMC_READ(base, reg)	\
> +	__raw_readl((base) + OMAP_HSMMC_##reg)
> +
> +#define OMAP_HSMMC_WRITE(base, reg, val) \
> +	__raw_writel((val), (base) + OMAP_HSMMC_##reg)
> +
> +struct mmc_omap_host {
> +	struct	device		*dev;
> +	struct	mmc_host	*mmc;
> +	struct	mmc_request	*mrq;
> +	struct	mmc_command	*cmd;
> +	struct	mmc_data	*data;
> +	struct	resource	*mem_res;

Is this really required?  It seems to only get written/read in the probe
function.

> +	struct	clk		*fclk, *iclk, *dbclk;
> +	struct	semaphore	sem;
> +	struct	work_struct	mmc_carddetect_work;
> +	void	__iomem		*base;
> +	void			*mapbase;

mapbase has the wrong type.  It should be resource_size_t, and then all
the casts you have for this can be eliminated.

> +	unsigned int		id;
> +	unsigned int		dma_len;
> +	unsigned int		dma_dir;
> +	unsigned char		bus_mode;
> +	unsigned char		datadir;
> +	u32			*buffer;
> +	u32			bytesleft;
> +	int			suspended;
> +	int			irq;
> +	int			carddetect;
> +	int			use_dma, dma_ch;
> +	int			initstr;
> +	int			slot_id;

No range checking for this variable.  If pdev->id = 0, then this becomes
-1.  Since it's used as an index into arrays... also is it sensible to
pass back to the supporting platform code the platform device ID minus 1 ?
Sounds like a potential cause of confusion to me.

> +
> +	struct	omap_mmc_platform_data	*pdata;
> +};
> +
> +/*
> + * Stop clock to the card
> + */
> +static void omap_mmc_stop_clock(struct mmc_omap_host *host)
> +{
> +	OMAP_HSMMC_WRITE(host->base, SYSCTL,
> +		OMAP_HSMMC_READ(host->base, SYSCTL) & ~CEN);
> +	if ((OMAP_HSMMC_READ(host->base, SYSCTL) & CEN) != 0x0)
> +		dev_dbg(mmc_dev(host->mmc), "MMC Clock is not stoped");
> +}
> +
> +/*
> + * Send init stream sequence to card
> + * before sending IDLE command
> + */
> +static void send_init_stream(struct mmc_omap_host *host)
> +{
> +	int reg = 0;
> +	typeof(jiffies) timeout;

Absolutely not.  Use "unsigned long".

> +
> +	disable_irq(host->irq);
> +	OMAP_HSMMC_WRITE(host->base, CON,
> +		OMAP_HSMMC_READ(host->base, CON) | INIT_STREAM);
> +	OMAP_HSMMC_WRITE(host->base, CMD, INIT_STREAM_CMD);
> +
> +	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> +	while ((reg != CC) && time_before(jiffies, timeout)) {
> +		reg = OMAP_HSMMC_READ(host->base, STAT) & CC;
> +	}
> +
> +	OMAP_HSMMC_WRITE(host->base, CON,
> +		OMAP_HSMMC_READ(host->base, CON) & ~INIT_STREAM);
> +	enable_irq(host->irq);
> +}
> +
> +/*
> + * Configure the Responce type
> + */
> +static void
> +mmc_omap_start_command(struct mmc_omap_host *host, struct mmc_command *cmd)
> +{
> +	int  cmdreg = 0, resptype = 0, cmdtype = 0;
> +
> +	dev_dbg(mmc_dev(host->mmc), "%s: CMD%d, argument 0x%08x\n",
> +			mmc_hostname(host->mmc), cmd->opcode, cmd->arg);
> +	host->cmd = cmd;
> +
> +	/*
> +	 * Clear status bits and enable interrupts
> +	 */
> +	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> +	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> +
> +	switch (mmc_resp_type(cmd)) {
> +	case MMC_RSP_R1:
> +	case MMC_RSP_R3:
> +	case MMC_RSP_R1B:
> +		/* resp 1, 1b, 3 */
> +		resptype = 2;
> +		break;
> +	case MMC_RSP_R2:
> +		resptype = 1;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	cmdreg = (cmd->opcode << 24) | (resptype << 16) | (cmdtype << 22);
> +	OMAP_HSMMC_WRITE(host->base, HCTL,
> +			OMAP_HSMMC_READ(host->base,HCTL) & ~FOUR_BIT);
> +
> +	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_4)
> +		OMAP_HSMMC_WRITE(host->base, HCTL,
> +				OMAP_HSMMC_READ(host->base, HCTL)
> +						| FOUR_BIT);
> +	else if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_1)
> +		OMAP_HSMMC_WRITE(host->base, HCTL,
> +				OMAP_HSMMC_READ(host->base, HCTL)
> +						& ~FOUR_BIT);
> +
> +	if (cmd->opcode == MMC_READ_SINGLE_BLOCK ||
> +			cmd->opcode == MMC_READ_MULTIPLE_BLOCK ||
> +			cmd->opcode == SD_APP_SEND_SCR	||
> +			((cmd->opcode == MMC_SEND_EXT_CSD) && cmd->arg == 0))
> +		cmdreg |= DP_SELECT | DDIR | MSBS | BCE;
> +
> +	else if (cmd->opcode == MMC_WRITE_BLOCK ||
> +			cmd->opcode == MMC_WRITE_MULTIPLE_BLOCK) {
> +		cmdreg |= DP_SELECT | MSBS | BCE;
> +		cmdreg &= ~(DDIR);
> +	}
> +
> +	if (host->use_dma)
> +		cmdreg |= DMA_EN;
> +
> +	if (cmd->opcode == MMC_GO_IDLE_STATE || cmd->opcode == MMC_SEND_OP_COND
> +		|| cmd->opcode == MMC_ALL_SEND_CID)
> +		OMAP_HSMMC_WRITE(host->base, CON,
> +				OMAP_HSMMC_READ(host->base, CON) | OD);

"OD" meaning "open drain" ?  If so, the set_ios() method is passed the
information to tell you when open drain mode should be selected.  Use
that, don't try to work it out from the commands you're passed.  They
may not be what you think they are.  (eg, they may be an application
command.)

> +
> +	if (cmd->opcode == MMC_GO_IDLE_STATE)
> +		if (host->initstr == 0) {
> +			send_init_stream(host);
> +			host->initstr = 1;
> +		}

Ditto.  Isn't the sending of the initialisation sequence caused by moving
from MMC_POWER_OFF to another power state?  That's irrespective of the
command being issued.

> +
> +	OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
> +	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
> +}
> +
> +/*
> + * Notify the transder complete to MMC core
> + */
> +static void
> +mmc_omap_xfer_done(struct mmc_omap_host *host, struct mmc_data *data)
> +{
> +	host->data = NULL;
> +
> +	if (host->use_dma && host->dma_ch != -1) {
> +		dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len,
> +			host->dma_dir);
> +	}
> +
> +	host->datadir = OMAP_MMC_DATADIR_NONE;
> +
> +	if (data->error == MMC_ERR_NONE)
> +		data->bytes_xfered += data->blocks * (data->blksz);
> +
> +	if (!data->stop) {
> +		host->mrq = NULL;
> +		mmc_request_done(host->mmc, data->mrq);
> +		return;
> +	}
> +	mmc_omap_start_command(host, data->stop);
> +}
> +
> +/*
> + * Notify the core about command completion
> + */
> +static void
> +mmc_omap_cmd_done(struct mmc_omap_host *host, struct mmc_command *cmd)
> +{
> +	host->cmd = NULL;
> +
> +	if (cmd->flags & MMC_RSP_PRESENT) {
> +		if (cmd->flags & MMC_RSP_136) {
> +			/* response type 2 */
> +			cmd->resp[3] = OMAP_HSMMC_READ(host->base, RSP10);
> +			cmd->resp[2] = OMAP_HSMMC_READ(host->base, RSP32);
> +			cmd->resp[1] = OMAP_HSMMC_READ(host->base, RSP54);
> +			cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP76);
> +		} else {
> +			/* response types 1, 1b, 3, 4, 5, 6 */
> +			cmd->resp[0] = OMAP_HSMMC_READ(host->base, RSP10);
> +		}
> +	}
> +	if (host->data == NULL || cmd->error != MMC_ERR_NONE) {
> +		dev_dbg(mmc_dev(host->mmc), "%s: End request, err %x\n",
> +				mmc_hostname(host->mmc), cmd->error);
> +		host->mrq = NULL;
> +		mmc_request_done(host->mmc, cmd->mrq);
> +	}
> +}
> +
> +/*
> + * DMA clean up for command errors
> + */
> +static void mmc_dma_cleanup(struct mmc_omap_host *host)
> +{
> +	host->data->error |= MMC_ERR_TIMEOUT;
> +
> +	if (host->use_dma && host->dma_ch != -1) {
> +		dma_unmap_sg(mmc_dev(host->mmc), host->data->sg, host->dma_len,
> +			host->dma_dir);
> +		omap_free_dma(host->dma_ch);
> +		host->dma_ch = -1;
> +		up(&host->sem);
> +	}
> +	host->data = NULL;
> +	host->datadir = OMAP_MMC_DATADIR_NONE;
> +}
> +
> +/*
> + * MMC controller IRQ handler
> + */
> +static irqreturn_t mmc_omap_irq(int irq, void *dev_id)
> +{
> +	struct mmc_omap_host *host = (struct mmc_omap_host *)dev_id;

Cast not required.

> +	int end_cmd = 0, end_trans = 0, status;
> +	typeof(jiffies) timeout;

Same complaint as the other.  Use real types.

> +
> +	if (host->cmd == NULL && host->data == NULL) {
> +		OMAP_HSMMC_WRITE(host->base, STAT,
> +				OMAP_HSMMC_READ(host->base, STAT));
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (host->cmd) {
> +		if (host->cmd->opcode == MMC_SELECT_CARD
> +			|| host->cmd->opcode == MMC_SWITCH) {

Same concerns as before.  You don't know whether the opcode is one of
those commands or an application command.

> +			timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> +			while (time_before(jiffies, timeout)) {
> +				if ((OMAP_HSMMC_READ(host->base, STAT)
> +					& CC) == CC)
> +					break;
> +			}
> +		}
> +	}
> +
> +	status = OMAP_HSMMC_READ(host->base, STAT);
> +	dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", status);
> +
> +	if (status & (ERR)) {

What horrible style.  If "ERR" expands to an expression and requires
parens the parens go in the _definition_ not at every use.  Get rid
of these parens.  Ditto for all cases below as well.

> +		if (status & (CMD_TIMEOUT) ||
> +			status & (CMD_CRC)) {
> +			if (host->cmd) {
> +				if (status & (CMD_TIMEOUT))
> +					host->cmd->error |= MMC_ERR_TIMEOUT;
> +				else
> +					host->cmd->error |= MMC_ERR_BADCRC;
> +				end_cmd = 1;
> +			}
> +			if (host->data)
> +				mmc_dma_cleanup(host);
> +		}
> +		if (status & (DATA_TIMEOUT) ||
> +			status & (DATA_CRC)) {
> +			if (host->data) {
> +				if (status & (DATA_TIMEOUT))
> +					mmc_dma_cleanup(host);
> +				else
> +					host->data->error |= MMC_ERR_BADCRC;
> +				end_trans = 1;
> +			}
> +		}
> +		if (status & CARD_ERR) {
> +			if (host->cmd) {
> +				host->cmd->error |= MMC_ERR_FAILED;
> +				end_cmd = 1;
> +			}
> +			if (host->data) {
> +				host->data->error |= MMC_ERR_FAILED;
> +				end_trans = 1;
> +			}
> +		}
> +	}
> +
> +	OMAP_HSMMC_WRITE(host->base, STAT, status);
> +	if (end_cmd || (status & CC))
> +		mmc_omap_cmd_done(host, host->cmd);
> +
> +	if (end_trans || (status & TC))
> +		if (host->mmc->mode == MMC_MODE_MMC
> +			|| host->mmc->mode == MMC_MODE_SD)

Why are you prodding around in the lower levels?  That's a layering
violation.

> +			mmc_omap_xfer_done(host, host->data);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * Swith MMC operating voltage
> + */
> +static int omap_mmc_switch_opcond(struct mmc_omap_host *host, int vdd)
> +{
> +	u32 reg_val = 0;
> +	int ret = 0;
> +
> +	/* Disable the clocks */
> +	clk_disable(host->fclk);
> +	clk_disable(host->iclk);
> +	clk_disable(host->dbclk);
> +
> +	/* Turn the power off */
> +	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 0, 0);
> +	if (ret != 0)
> +		goto err;
> +
> +	/* Turn the power ON with given VDD 1.8 or 3.0v */
> +	ret = mmc_slot(host).set_power(host->dev, host->slot_id, 1, vdd);
> +	if (ret != 0)
> +		goto err;
> +
> +	clk_enable(host->fclk);
> +	clk_enable(host->iclk);
> +	clk_enable(host->dbclk);
> +
> +	OMAP_HSMMC_WRITE(host->base, HCTL,
> +			OMAP_HSMMC_READ(host->base, HCTL) & SDVSCLR);
> +	reg_val = OMAP_HSMMC_READ(host->base, HCTL);
> +
> +	if (((1 << vdd) == MMC_VDD_33_34) || ((1 << vdd) == MMC_VDD_33_34)) {
> +		host->initstr = 0;
> +		reg_val |= SDVS30;
> +	}

Use the transition away from MMC_POWER_OFF for triggering the initstr.  Don't
think that "oh well we'll always apply 3.3V first.

Also, Are you expecting 'vdd' to change during the evaluation of this if
condition?  I don't think it will.

> +	if ((1 << vdd) == MMC_VDD_165_195)
> +		reg_val |= SDVS18;
> +
> +	OMAP_HSMMC_WRITE(host->base, HCTL, reg_val);
> +
> +	OMAP_HSMMC_WRITE(host->base, HCTL,
> +			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
> +
> +	return 0;
> +err:
> +	dev_dbg(mmc_dev(host->mmc), "Unable to switch operating voltage \n");
> +	return -1;
> +}
> +
> +/*
> + * Work Item to notify the core about card insertion/removal
> + */
> +static void mmc_omap_detect(struct work_struct *work)
> +{
> +	u16 vdd = 0;
> +	struct mmc_omap_host *host = container_of(work, struct mmc_omap_host,
> +						mmc_carddetect_work);
> +
> +	if (host->carddetect) {
> +		if (!(OMAP_HSMMC_READ(host->base, HCTL)	& SDVSDET)) {
> +			vdd = fls(host->mmc->ocr_avail) - 1;
> +			if (omap_mmc_switch_opcond(host, vdd) != 0)
> +				host->mmc->ios.vdd = vdd;

Please explain what this is doing.  I think it's duplicating what the MMC
layer is doing.

> +			mmc_detect_change(host->mmc, (HZ * 200) / 1000);
> +		}
> +	} else {
> +		mmc_detect_change(host->mmc, (HZ * 50) / 1000);
> +	}
> +}
> +
> +/*
> + * ISR for handling card insertion and removal
> + */
> +void omap_mmc_notify_card_detect(struct device *dev, int slot, int detected)
> +{
> +	struct mmc_omap_host *host = dev_get_drvdata(dev);
> +
> +	host->carddetect = detected;
> +	schedule_work(&host->mmc_carddetect_work);
> +}
> +
> +/*
> + * DMA call back function
> + */
> +static void mmc_omap_dma_cb(int lch, u16 ch_status, void *data)
> +{
> +	struct mmc_omap_host *host = (struct mmc_omap_host *)data;

Case not required.

> +
> +	if (ch_status & (1 << 11))
> +		dev_dbg(mmc_dev(host->mmc), "MISALIGNED_ADRS_ERR\n");

Magic constant, use a define.

> +
> +	if (host->dma_ch < 0)
> +		return;
> +
> +	omap_free_dma(host->dma_ch);
> +	host->dma_ch = -1;
> +	up(&host->sem);
> +}
> +
> +/*
> + * Configure dma src and destination parameters
> + */
> +static int mmc_omap_config_dma_param(int sync_dir, struct mmc_omap_host *host,
> +				     struct mmc_data *data)
> +{
> +	if (sync_dir == 0) {
> +		omap_set_dma_dest_params(host->dma_ch, 0,
> +			OMAP_DMA_AMODE_CONSTANT,
> +			(dma_addr_t) (host-> mapbase + OMAP_HSMMC_DATA), 0, 0);
> +		omap_set_dma_src_params(host->dma_ch, 0,
> +			OMAP_DMA_AMODE_POST_INC,
> +			    sg_dma_address(&data-> sg[0]), 0, 0);
> +	} else {
> +		omap_set_dma_src_params(host->dma_ch, 0,
> +			OMAP_DMA_AMODE_CONSTANT,
> +			(dma_addr_t) (host->mapbase +OMAP_HSMMC_DATA), 0, 0);
> +		omap_set_dma_dest_params(host->dma_ch, 0,
> +			OMAP_DMA_AMODE_POST_INC,
> +				sg_dma_address(&data->sg[0]), 0, 0);
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Rotine to configure and start DMA for the MMC card
> + */
> +static int
> +mmc_omap_start_dma_transfer(struct mmc_omap_host *host, struct mmc_request *req)
> +{
> +	int sync_dev, sync_dir = 0;
> +	int dma_ch = 0, ret = 0;
> +	struct mmc_data *data = req->data;
> +
> +	/*
> +	 * If for some reason the DMA transfer is still active,
> +	 * we wait for timeout period and free the dma
> +	 */
> +	if (host->dma_ch != -1) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(100);

This looks quite buggy.  If it's interruptible, someone can send it a
signal and cause the timeout to terminate early.

> +		if (down_trylock(&host->sem)) {
> +			omap_free_dma(host->dma_ch);
> +			host->dma_ch = -1;
> +			up(&host->sem);
> +			return 1;
> +		}
> +	} else {
> +		if (down_trylock(&host->sem)) {
> +			BUG();

Really?  No recovery possible from this condition?

> +		}
> +	}
> +	if (!(data->flags & MMC_DATA_WRITE)) {
> +		host->dma_dir = DMA_FROM_DEVICE;
> +		if (host->id == OMAP_MMC1_DEVID)
> +			sync_dev = OMAP24XX_DMA_MMC1_RX;
> +		else
> +			sync_dev = OMAP24XX_DMA_MMC2_RX;
> +	} else {
> +		host->dma_dir = DMA_TO_DEVICE;
> +		if (host->id == OMAP_MMC1_DEVID)
> +			sync_dev = OMAP24XX_DMA_MMC1_TX;
> +		else
> +			sync_dev = OMAP24XX_DMA_MMC2_TX;
> +	}
> +
> +	ret = omap_request_dma(sync_dev, "MMC/SD", mmc_omap_dma_cb,
> +							host, &dma_ch);
> +	if (ret != 0) {
> +		dev_dbg(mmc_dev(host->mmc),
> +			"%s: omap_request_dma() failed with %d\n",
> +			mmc_hostname(host->mmc), ret);
> +		return ret;
> +	}
> +
> +	host->dma_len = dma_map_sg(mmc_dev(host->mmc), data->sg,
> +					data->sg_len, host->dma_dir);
> +	host->dma_ch = dma_ch;
> +
> +	if (!(data->flags & MMC_DATA_WRITE))
> +		mmc_omap_config_dma_param(1, host, data);
> +	else
> +		mmc_omap_config_dma_param(0, host, data);
> +
> +	omap_set_dma_transfer_params(dma_ch, OMAP_DMA_DATA_TYPE_S32,
> +		(data->blksz / 4), data->blocks, OMAP_DMA_SYNC_FRAME,
> +							sync_dev, sync_dir);
> +	omap_start_dma(dma_ch);
> +	return 0;
> +}
> +
> +/*
> + * Configure block leangth for MMC/SD cards and intiate the transfer.
> + */
> +static int
> +mmc_omap_prepare_data(struct mmc_omap_host *host, struct mmc_request *req)
> +{
> +	int ret = 0;
> +	host->data = req->data;
> +
> +	if (req->data == NULL) {
> +		host->datadir = OMAP_MMC_DATADIR_NONE;
> +		OMAP_HSMMC_WRITE(host->base, BLK, 0);
> +		return 0;
> +	}
> +
> +	OMAP_HSMMC_WRITE(host->base, BLK, (req->data->blksz)
> +					| (req->data->blocks << 16) );
> +
> +	host->datadir = (req->data-> flags & MMC_DATA_WRITE) ?
> +			OMAP_MMC_DATADIR_WRITE : OMAP_MMC_DATADIR_READ;
> +
> +	if (host->use_dma) {
> +		ret = mmc_omap_start_dma_transfer(host, req);
> +		if (ret != 0) {
> +			dev_dbg(mmc_dev(host->mmc), "MMC start dma failure\n");
> +			return ret;
> +		} else {
> +			host->buffer = NULL;
> +			host->bytesleft = 0;
> +		}
> +	} else {
> +		host->buffer =	(u32 *) (page_address(req->data->sg->page) +
> +							req->data->sg->offset);

host->buffer seems to only be written.  Does it serve any purpose?

> +		host->bytesleft = req->data->blocks * (req->data->blksz);

Ditto.

> +		host->dma_ch = -1;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Request function. for read/write operation
> + */
> +static void omap_mmc_request(struct mmc_host *mmc, struct mmc_request *req)
> +{
> +	struct mmc_omap_host *host = mmc_priv(mmc);
> +
> +	WARN_ON(host->mrq != NULL);
> +	host->mrq = req;
> +
> +	/* Reset MMC Controller's Data FSM */
> +	if (req->cmd->opcode == MMC_GO_IDLE_STATE) {
> +		OMAP_HSMMC_WRITE(host->base, SYSCTL,
> +				OMAP_HSMMC_READ(host->base, SYSCTL) | 1 << 26);
> +		while (OMAP_HSMMC_READ(host->base, SYSCTL) & (1 << 26)) ;
> +	}

Yuck.

> +
> +	if (req->cmd->opcode == SD_APP_SEND_SCR
> +		|| req->cmd->opcode == MMC_SEND_EXT_CSD)
> +		mmc->ios.bus_width = MMC_BUS_WIDTH_1;

No.

> +
> +	if (mmc_omap_prepare_data(host, req))
> +		dev_dbg(mmc_dev(host->mmc),
> +			"MMC host %s failed to initiate data transfer\n",
> +			mmc_hostname(host->mmc));
> +	mmc_omap_start_command(host, req->cmd);
> +}
> +
> +
> +/*
> + * Configuring clock values.
> + */
> +/* Routine to configure clock values. Exposed API to core */
> +static void omap_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> +{
> +	struct mmc_omap_host *host = mmc_priv(mmc);
> +	u16 dsor = 0;
> +	unsigned long regval;
> +	typeof(jiffies) timeout;

No.

> +
> +	switch (ios->power_mode) {
> +	case MMC_POWER_OFF:
> +		mmc_slot(host).set_power(host->dev,host->slot_id, 0, 0);
> +		break;
> +	case MMC_POWER_UP:
> +		mmc_slot(host).set_power(host->dev,host->slot_id, 1, ios->vdd);
> +		break;
> +	}
> +
> +	if (host->id == OMAP_MMC1_DEVID) {
> +		if ((OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET) &&
> +				((ios->vdd == 7) || (ios->vdd == 8))) {
> +				/* vdd is 1.8v */
> +				if (omap_mmc_switch_opcond(host, ios->vdd) != 0)
> +					dev_dbg(mmc_dev(host->mmc),
> +						"Switch operation failed\n");
> +				host->initstr = 0;
> +		}

What's this?

> +	}
> +
> +	if (ios->clock) {
> +		dsor = OMAP_MMC_MASTER_CLOCK / ios->clock;
> +		if (dsor < 1)
> +			dsor = 1;
> +
> +		if (OMAP_MMC_MASTER_CLOCK / dsor > ios->clock)
> +			dsor++;
> +
> +		if (dsor > 250)
> +			dsor = 250;
> +	}
> +
> +	omap_mmc_stop_clock(host);
> +	regval = OMAP_HSMMC_READ(host->base, SYSCTL);
> +	regval = regval & ~(CLKD_MASK);
> +	regval = regval | (dsor << 6) | (DTO << 16);
> +	OMAP_HSMMC_WRITE(host->base, SYSCTL, regval);
> +	OMAP_HSMMC_WRITE(host->base, SYSCTL,
> +			OMAP_HSMMC_READ(host->base, SYSCTL) | ICE);
> +
> +	/* Wait till the ICS bit is set */
> +	timeout = jiffies + msecs_to_jiffies(MMC_TIMEOUT_MS);
> +	while ((OMAP_HSMMC_READ(host->base, SYSCTL) & ICS) != 0x2
> +		&& time_before(jiffies, timeout)) ;

can this be converted to msleep, thereby releasing the CPU for other
work?

> +
> +	OMAP_HSMMC_WRITE(host->base, SYSCTL,
> +			OMAP_HSMMC_READ(host->base, SYSCTL) | CEN);
> +}
> +
> +static struct mmc_host_ops mmc_omap_ops = {
> +	.request = omap_mmc_request,
> +	.set_ios = omap_mmc_set_ios,
> +};
> +
> +static int __init omap_mmc_probe(struct platform_device *pdev)
> +{
> +	struct omap_mmc_platform_data *pdata = pdev->dev.platform_data;
> +	struct mmc_host *mmc;
> +	struct mmc_omap_host *host = NULL;
> +	struct resource *res;
> +	int ret = 0, irq;
> +
> +	if (pdata == NULL) {
> +		dev_err(&pdev->dev, "Platform Data is missing\n");
> +		return -ENXIO;
> +	}
> +
> +	if (pdata->nr_slots == 0) {
> +		dev_err(&pdev->dev, "No Slots\n");
> +		return -ENXIO;
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	irq = platform_get_irq(pdev, 0);
> +	if (res == NULL || irq < 0)
> +		return -ENXIO;
> +
> +	res = request_mem_region(res->start, res->end - res->start + 1,
> +							pdev->name);
> +	if (res == NULL)
> +		return -EBUSY;
> +
> +	mmc = mmc_alloc_host(sizeof(struct mmc_omap_host), &pdev->dev);
> +	if (!mmc) {
> +		ret = -ENOMEM;
> +		goto err;
> +	}
> +
> +	host		= mmc_priv(mmc);
> +	host->mmc	= mmc;
> +	host->pdata	= pdata;
> +	host->use_dma	= 1;
> +	host->dma_ch	= -1;
> +	host->initstr	= 0;
> +	host->mem_res	= res;
> +	host->irq	= irq;
> +	host->id	= pdev->id;
> +	host->slot_id	= pdev->id - 1;
> +	host->mapbase	= (void *)host->mem_res->start;
> +	host->base	= (void __iomem *)IO_ADDRESS(host->mapbase);

Use ioremap, and get rid of that cast.

> +	mmc->ops	= &mmc_omap_ops;
> +	mmc->f_min	= 400000;
> +	mmc->f_max	= 52000000;
> +
> +	sema_init(&host->sem, 1);
> +
> +	host->iclk = clk_get(&pdev->dev, "mmchs_ick");
> +	if (IS_ERR(host->iclk)) {
> +		ret = PTR_ERR(host->iclk);
> +		host->iclk = NULL;
> +		goto err;
> +	}
> +	host->fclk = clk_get(&pdev->dev, "mmchs_fck");
> +	if (IS_ERR(host->fclk)) {
> +		ret = PTR_ERR(host->fclk);
> +		host->fclk = NULL;
> +		clk_put(host->iclk);
> +		goto err;
> +	}
> +	host->dbclk = clk_get(&pdev->dev, "mmchsdb_fck");
> +
> +	/*
> +	 * MMC can still work without debounce clock.
> +	 */
> +	if (IS_ERR(host->dbclk))
> +		dev_dbg(mmc_dev(host->mmc), "Failed to get debounce clock \n");
> +
> +	if (clk_enable(host->fclk) != 0) {
> +		goto err;
> +	}
> +	if (clk_enable(host->iclk) != 0) {
> +		clk_disable(host->fclk);
> +		clk_put(host->fclk);
> +		goto err;
> +	}
> +	if (clk_enable(host->dbclk) != 0)
> +		dev_dbg(mmc_dev(host->mmc), "Enabling debounce clk failed\n");

If we failed to get the debounce clock, we then try to enable it?  Isn't
calling these functions on a variable containing an error code going to
cause an oops?

> +
> +	omap_writel(omap_readl(CONTROL_DEVCONF1) | MMC1_ACTIVE_OVERWRITE,
> +						CONTROL_DEVCONF1);
> +	mmc->ocr_avail = mmc_slot(host).ocr_mask;
> +	mmc->caps |= MMC_CAP_MULTIWRITE | MMC_CAP_BYTEBLOCK;
> +	if (pdata->wire4)
> +		mmc->caps = MMC_CAP_4_BIT_DATA;

So if pdata->wire4 is set, we obliterate the previous capabilities?

> +
> +	OMAP_HSMMC_WRITE(host->base, HCTL,
> +			OMAP_HSMMC_READ(host->base, HCTL) | SDVS30);
> +
> +	OMAP_HSMMC_WRITE(host->base, CAPA,OMAP_HSMMC_READ(host->base,
> +							CAPA) | VS30 | VS18);
> +
> +	/* Set the controller to AUTO IDLE mode */
> +	OMAP_HSMMC_WRITE(host->base, SYSCONFIG,
> +			OMAP_HSMMC_READ(host->base, SYSCONFIG) | AUTOIDLE);
> +
> +	/* Set SD bus power bit */
> +	OMAP_HSMMC_WRITE(host->base, HCTL,
> +			OMAP_HSMMC_READ(host->base, HCTL) | SDBP);
> +
> +	/* Request IRQ for MMC operations */
> +	ret = request_irq(host->irq, mmc_omap_irq, 0, pdev->name, host);
> +	if (ret) {
> +		dev_dbg(mmc_dev(host->mmc), "Unable to grab HSMMC IRQ");
> +		goto irq_err;
> +	}
> +
> +	INIT_WORK(&host->mmc_carddetect_work, mmc_omap_detect);
> +	if(pdata->init != NULL) {

Space character after "if" and before "(".

> +		if (pdata->init(&pdev->dev) != 0) {
> +			free_irq(host->irq, host);
> +			goto irq_err;
> +		}
> +	}
> +
> +	OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> +	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> +
> +	platform_set_drvdata(pdev, host);
> +	mmc_add_host(mmc);
> +
> +	return 0;
> +
> +err:
> +	dev_dbg(mmc_dev(host->mmc), "Probe Fail\n");
> +	if (host)
> +		mmc_free_host(mmc);
> +	return ret;
> +
> +irq_err:
> +	dev_dbg(mmc_dev(host->mmc), "Unable to configure MMC IRQs");
> +	clk_disable(host->fclk);
> +	clk_disable(host->iclk);
> +	clk_disable(host->dbclk);

Problems here if dbclk was not available.  Ditto for all other uses.

> +
> +	clk_put(host->fclk);
> +	clk_put(host->iclk);
> +	clk_put(host->dbclk);
> +
> +	if (host)
> +		mmc_free_host(mmc);
> +	return ret;
> +}
> +
> +static int omap_mmc_remove(struct platform_device *pdev)
> +{
> +	struct mmc_omap_host *host = platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +	if (host) {
> +		host->pdata->cleanup(&pdev->dev);
> +		free_irq(host->irq, host);
> +		flush_scheduled_work();
> +
> +		clk_disable(host->fclk);
> +		clk_disable(host->iclk);
> +		clk_disable(host->dbclk);
> +		clk_put(host->fclk);
> +		clk_put(host->iclk);
> +		clk_put(host->dbclk);
> +
> +		mmc_free_host(host->mmc);
> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int omap_mmc_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	int ret = 0;
> +	struct mmc_omap_host *host = platform_get_drvdata(pdev);
> +
> +	if (host && host->suspended)
> +		return 0;
> +
> +	if (host) {
> +		ret = mmc_suspend_host(host->mmc, state);
> +		if (ret == 0) {
> +			host->suspended = 1;
> +
> +		OMAP_HSMMC_WRITE(host->base, ISE, 0);
> +		OMAP_HSMMC_WRITE(host->base, IE, 0);
> +
> +		ret = host->pdata->suspend(&pdev->dev, host->slot_id);
> +		if (ret)
> +			dev_dbg(mmc_dev(host->mmc),
> +				"Unable to handle MMC board level suspend\n");
> +
> +		if (!(OMAP_HSMMC_READ(host->base, HCTL) & SDVSDET)) {
> +			OMAP_HSMMC_WRITE(host->base,HCTL,
> +					OMAP_HSMMC_READ(host->base, HCTL)
> +					& SDVSCLR);
> +			OMAP_HSMMC_WRITE(host->base,HCTL,
> +					OMAP_HSMMC_READ(host->base, HCTL)
> +					|SDVS30);
> +			OMAP_HSMMC_WRITE(host->base,HCTL,
> +					OMAP_HSMMC_READ(host->base, HCTL)
> +					| SDBP);
> +		}
> +		clk_disable(host->fclk);
> +		clk_disable(host->iclk);
> +		clk_disable(host->dbclk);
> +
> +		if (host->id == OMAP_MMC1_DEVID) {
> +			omap_writel(omap_readl(CONTROL_DEVCONF1)
> +					& ~MMC1_ACTIVE_OVERWRITE,
> +					CONTROL_DEVCONF1);
> +		}
> +
> +		/* Power off slot power */
> +		ret = mmc_slot(host).set_power(host->dev,host->slot_id, 0, 0);

Isn't this something done by the mmc layer?

> +		if (ret != 0)
> +			dev_dbg(mmc_dev(host->mmc), "Unable to disable power to MMC\n");
> +			host->initstr = 0;
> +		}
> +	}
> +	return ret;
> +}
> +
> +/* Routine to resume the MMC device */
> +static int omap_mmc_resume(struct platform_device *pdev)
> +{
> +	int ret = 0;
> +	struct mmc_omap_host *host = platform_get_drvdata(pdev);
> +
> +	if (host && !host->suspended)
> +		return 0;
> +
> +	if (host) {
> +		if (host->id == OMAP_MMC1_DEVID) {
> +			omap_writel(omap_readl(CONTROL_DEVCONF1)
> +						| MMC1_ACTIVE_OVERWRITE,
> +						CONTROL_DEVCONF1);
> +		}
> +
> +		mmc_slot(host).set_power(host->dev, host->slot_id, 1,
> +							host->mmc->ios.vdd);
> +		if (ret != 0) {
> +			dev_dbg(mmc_dev(host->mmc), "Enabling power failed\n");
> +			return ret;
> +		}

Isn't this something done by the mmc layer?

> +
> +		if (clk_enable(host->fclk) != 0)
> +			goto clk_en_err;
> +
> +		if (clk_enable(host->iclk) != 0) {
> +			clk_disable(host->fclk);
> +			clk_put(host->fclk);
> +			goto clk_en_err;
> +		}
> +
> +		if (clk_enable(host->dbclk) != 0)
> +			dev_dbg(mmc_dev(host->mmc),
> +					"Enabling debounce clk failed\n");
> +
> +		ret = host->pdata->resume(&pdev->dev, host->slot_id);
> +		if (ret)
> +			dev_dbg(mmc_dev(host->mmc),
> +					"Unmask interrupt failed\n");
> +
> +		/* Notify the core to resume the host */
> +		ret = mmc_resume_host(host->mmc);
> +		if (ret == 0)
> +			host->suspended = 0;
> +		msleep_interruptible(1);
> +	}
> +
> +	return ret;
> +
> +clk_en_err:
> +	dev_dbg(mmc_dev(host->mmc),
> +		"Failed to enable MMC clocks during resume\n");
> +	return -1;

"-1" is not a valid error code do not use it. Use the constants in errno.h
Never ever ever ever think that "-1" can be used as an error code in liu
of using a constant from errno.h

> +}
> +
> +#else
> +#define omap_mmc_suspend	NULL
> +#define omap_mmc_resume		NULL
> +#endif
> +
> +static struct platform_driver omap_mmc_driver = {
> +	.probe	= omap_mmc_probe,
> +	.remove	= omap_mmc_remove,
> +	.suspend= omap_mmc_suspend,
> +	.resume	= omap_mmc_resume,
> +	.driver	= {
> +		   .name = DRIVER_NAME,
> +	},
> +};
> +
> +static int __init omap_mmc_init(void)
> +{
> +	/* Register the MMC driver */
> +	if (platform_driver_register(&omap_mmc_driver)) {
> +		printk(KERN_ERR ": Failed to register MMC driver\n");
> +		return -ENODEV;

Propagate the error code from platform_driver_register.

> +	}
> +	return 0;
> +}
> +
> +static void __exit omap_mmc_cleanup(void)
> +{
> +	/* Unregister MMC driver */
> +	platform_driver_unregister(&omap_mmc_driver);
> +}
> +
> +module_init(omap_mmc_init);
> +module_exit(omap_mmc_cleanup);
> +
> +MODULE_DESCRIPTION("OMAP High Speed Multimedia Card driver");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS(DRIVER_NAME);
> +MODULE_AUTHOR("Texas Instruments Inc");
> 
> -------------------------------------------------------------------
> List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
> FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
> Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
