From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH 1/2]  McBSP DMA support for  34xx
Date: Thu, 28 Aug 2008 13:10:37 +0300
Message-ID: <20080828101037.GH7354@gandalf.research.nokia.com>
References: <51857.192.168.10.89.1219911960.squirrel@dbdmail.itg.ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:48244 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbYH1KK4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Aug 2008 06:10:56 -0400
Content-Disposition: inline
In-Reply-To: <51857.192.168.10.89.1219911960.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext chandra shekhar <x0044955@ti.com>
Cc: linux-omap@vger.kernel.org

On Thu, Aug 28, 2008 at 01:56:00PM +0530, ext chandra shekhar wrote:
> This patch supports DMA chaining mode and one time configuration for entire
> transfer to improve performance.
> Signed-off-by: chandra shekhar <x0044955@ti.com>
> ---
>  arch/arm/mach-omap2/mcbsp.c       |  702 +++++++++++++++++++++++++++++++++++++-
>  arch/arm/plat-omap/mcbsp.c        |   19 -
>  include/asm-arm/arch-omap/mcbsp.h |  127 +++++-
>  3 files changed, 811 insertions(+), 37 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/mach-omap2/mcbsp.c	2008-08-26
> 19:13:47.000000000 +0530
> +++ linux-omap-2.6/arch/arm/mach-omap2/mcbsp.c	2008-08-26 19:56:39.000000000 +0530
> @@ -16,6 +16,8 @@
>  #include <linux/err.h>
>  #include <linux/io.h>
>  #include <linux/platform_device.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> 
>  #include <asm/arch/dma.h>
>  #include <asm/arch/mux.h>
> @@ -91,7 +93,7 @@
>  	},
>  	{
>  		.clk = {
> -			.name		= "mcbsp_clk",
> +			.name 		= "mcbsp_clk",
			     ^ you added whitespace there.
>  			.id		= 3,
>  			.enable		= omap_mcbsp_clk_enable,
>  			.disable	= omap_mcbsp_clk_disable,
> @@ -99,7 +101,7 @@
>  	},
>  	{
>  		.clk = {
> -			.name		= "mcbsp_clk",
> +			.name 		= "mcbsp_clk",
			     ^ you added whitespace there.
>  			.id		= 4,
>  			.enable		= omap_mcbsp_clk_enable,
>  			.disable	= omap_mcbsp_clk_disable,
> @@ -107,7 +109,7 @@
>  	},
>  	{
>  		.clk = {
> -			.name		= "mcbsp_clk",
> +			.name 		= "mcbsp_clk",
			     ^ you added whitespace there.
>  			.id		= 5,
>  			.enable		= omap_mcbsp_clk_enable,
>  			.disable	= omap_mcbsp_clk_disable,
> @@ -139,11 +141,700 @@
>  {
>  	if (cpu_is_omap2420() && (id == OMAP_MCBSP2))
>  		omap2_mcbsp2_mux_setup();
> +	else
> +		omap2_mcbsp_reset(id);
>  }
> 
> +static void omap2_mcbsp_free(unsigned int id)
> +{
> +	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
> +
> +	if (!cpu_is_omap2420()) {
> +		if (mcbsp->dma_rx_lch != -1) {
> +			omap_free_dma_chain(mcbsp->dma_rx_lch);
> +			 mcbsp->dma_rx_lch = -1;
			^ extra space here
> +		}
> +
> +		if (mcbsp->dma_tx_lch != -1) {
> +			omap_free_dma_chain(mcbsp->dma_tx_lch);
> +			mcbsp->dma_tx_lch = -1;
> +		}
> +	}
> +	return;

this return is not needed.

> +}

put a blank line between function declarations

> +void omap2_mcbsp_config(unsigned int id,
> +			 const struct omap_mcbsp_reg_cfg *config)

			don't use space for identation.
> +{
> +	struct omap_mcbsp *mcbsp;
> +	u32 io_base;

a blank line after variable declarations and before the funtion body
wouldn't hurt.

> +	mcbsp = id_to_mcbsp_ptr(id);
> +	io_base = mcbsp->io_base;
> +	OMAP_MCBSP_WRITE(io_base, XCCR, config->xccr);
> +	OMAP_MCBSP_WRITE(io_base, RCCR, config->rccr);
> +}

add blank line here

>  static struct omap_mcbsp_ops omap2_mcbsp_ops = {
>  	.request	= omap2_mcbsp_request,
> +	.free 		= omap2_mcbsp_free,
	     ^ whitespace
> +	.config		= omap2_mcbsp_config,
>  };

add a blank line

> +static void omap2_mcbsp_rx_dma_callback(int lch, u16 ch_status, void *data)
> +{
> +	struct omap_mcbsp *mcbsp_dma_rx = data;
> +	u32 io_base;
> +	io_base = mcbsp_dma_rx->io_base;
> +
> +	/* If we are at the last transfer, Shut down the reciever */
> +	if ((mcbsp_dma_rx->auto_reset & OMAP_MCBSP_AUTO_RRST)
> +		&& (omap_dma_chain_status(mcbsp_dma_rx->dma_rx_lch) ==
> +						 OMAP_DMA_CHAIN_INACTIVE))
> +		OMAP_MCBSP_WRITE(io_base, SPCR1,
> +			OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
> +
> +	if (mcbsp_dma_rx->rx_callback != NULL)
> +		mcbsp_dma_rx->rx_callback(ch_status, mcbsp_dma_rx->rx_cb_arg);
> +
> +}
> +
> +static void omap2_mcbsp_tx_dma_callback(int lch, u16 ch_status, void *data)
> +{
> +	struct omap_mcbsp *mcbsp_dma_tx = data;
> +	u32 io_base;
> +	io_base = mcbsp_dma_tx->io_base;
> +
> +	/* If we are at the last transfer, Shut down the Transmitter */
> +	if ((mcbsp_dma_tx->auto_reset & OMAP_MCBSP_AUTO_XRST)
> +		&& (omap_dma_chain_status(mcbsp_dma_tx->dma_tx_lch) ==
> +						 OMAP_DMA_CHAIN_INACTIVE))
> +		OMAP_MCBSP_WRITE(io_base, SPCR2,
> +			OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
> +
> +	if (mcbsp_dma_tx->tx_callback != NULL)
> +		mcbsp_dma_tx->tx_callback(ch_status, mcbsp_dma_tx->tx_cb_arg);
> +}
> +
> +/*
> + * Enable/Disable the sample rate generator
> + * id		: McBSP interface ID
> + * state	: Enable/Disable

please follow the kernel-doc style:

/**
 * omap2_mcbsp_set_srg_fsg - enable/disable sample rate generator
 *
 * @id: mcbsp interface id
 * @state: enable/disable
 *
 */

> + */
> +void omap2_mcbsp_set_srg_fsg(unsigned int id, u8 state)
> +{
> +	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
> +	u32 io_base;
> +
> +	io_base = mcbsp->io_base;
> +
> +	if (state == OMAP_MCBSP_DISABLE_FSG_SRG) {
> +		OMAP_MCBSP_WRITE(io_base, SPCR2,
> +			OMAP_MCBSP_READ(io_base, SPCR2) & (~GRST));
> +		OMAP_MCBSP_WRITE(io_base, SPCR2,
> +			OMAP_MCBSP_READ(io_base, SPCR2) & (~FRST));
> +	} else {
> +		OMAP_MCBSP_WRITE(io_base, SPCR2,
> +			OMAP_MCBSP_READ(io_base, SPCR2) | GRST);
> +		OMAP_MCBSP_WRITE(io_base, SPCR2,
> +			OMAP_MCBSP_READ(io_base, SPCR2) | FRST);
> +	}
> +	return;
> +}
> +
> +/*
> + * Stop transmitting data on a McBSP interface
> + * id		: McBSP interface ID
> + */

follow kernel-doc style

> +int omap2_mcbsp_stop_datatx(unsigned int id)
> +{
> +	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
> +	u32 io_base;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +
> +	io_base = mcbsp->io_base;
> +
> +	if (mcbsp->dma_tx_lch != -1) {
> +		if (omap_stop_dma_chain_transfers(mcbsp->dma_tx_lch) != 0)
> +			return -EINVAL;
> +	}

add a blank line here.

> +	mcbsp->tx_dma_chain_state = 0;
> +	OMAP_MCBSP_WRITE(io_base, SPCR2,
> +		OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
> +
> +	if (!mcbsp->rx_dma_chain_state)
> +		omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_DISABLE_FSG_SRG);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_stop_datatx);
> +
> +/*
> + * Stop receving data on a McBSP interface
> + * id		: McBSP interface ID
> + */

follow kernel-doc style

> +int omap2_mcbsp_stop_datarx(u32 id)
> +{
> +	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
> +	u32 io_base;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +
> +	io_base = mcbsp->io_base;
> +
> +	if (mcbsp->dma_rx_lch != -1) {
> +		if (omap_stop_dma_chain_transfers(mcbsp->dma_rx_lch) != 0)
> +			return -EINVAL;
> +	}

add a blank line here

> +	OMAP_MCBSP_WRITE(io_base, SPCR1,
> +		OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
> +
> +	mcbsp->rx_dma_chain_state = 0;
> +	if (!mcbsp->tx_dma_chain_state)
> +		omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_DISABLE_FSG_SRG);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_stop_datarx);
> +
> +/*
> + * Interface Reset
> + * id	: McBSP interface ID
> + * Resets the McBSP interface
> + */

follow kernel-doc style

> +int omap2_mcbsp_reset(unsigned int id)
> +{
> +	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
> +	u32 io_base;
> +	int counter = 0;
> +	int wait_for_reset = 10000;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +
> +	io_base = mcbsp->io_base;
> +
> +	OMAP_MCBSP_WRITE(io_base, SYSCON,
> +		OMAP_MCBSP_READ(io_base, SYSCON) | (SOFTRST));
> +
> +	while (OMAP_MCBSP_READ(io_base, SYSCON) & SOFTRST) {
> +		if (!in_interrupt()) {
> +			set_current_state(TASK_INTERRUPTIBLE);
> +			schedule_timeout(10);
> +		}
> +		if (counter++ > wait_for_reset) {
> +			printk(KERN_ERR "mcbsp[%d] Reset timeout\n", id);
> +			return -ETIMEDOUT;
> +		}
> +	}

add a blank line before return statements

> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_reset);
> +
> +/*
> + * Get the element index and frame index of transmitter
> + * id		: McBSP interface ID
> + * ei		: element index
> + * fi		: frame index
> + */

follow kernel-doc style

> +int omap2_mcbsp_transmitter_index(int id, int *ei, int *fi)
> +{
> +	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
> +	int eix = 0, fix = 0;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +
> +	if ((!ei) || (!fi)) {

	too many ()

> +		printk(KERN_ERR	"OMAP_McBSP: Invalid ei and fi params \n");
> +		goto txinx_err;
> +	}
> +
> +	if (mcbsp->dma_tx_lch == -1) {
> +		printk(KERN_ERR "OMAP_McBSP: Transmitter not started\n");
> +		goto txinx_err;
> +	}
> +
> +	if (omap_get_dma_chain_index
> +		(mcbsp->dma_tx_lch, &eix, &fix) != 0) {

	fits in one line

> +		printk(KERN_ERR "OMAP_McBSP: Getting chain index failed\n");
> +		goto txinx_err;
> +	}
> +
> +	*ei = eix;
> +	*fi = fix;
> +
> +	return 0;
> +
> +txinx_err:
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_transmitter_index);
> +
> +/*
> + * Get the element index and frame index of receiver
> + * id	: McBSP interface ID
> + * ei		: element index
> + * fi		: frame index
> + */

follow kernel-doc style

> +int omap2_mcbsp_receiver_index(int id, int *ei, int *fi)
> +{
> +	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
> +	int eix = 0, fix = 0;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +
> +	if ((!ei) || (!fi)) {

	too many ()

> +		printk(KERN_ERR	"OMAP_McBSP: Invalid ei and fi params x\n");
> +		goto rxinx_err;
> +	}
> +
> +	/* Check if chain exists */
> +	if (mcbsp->dma_rx_lch == -1) {
> +		printk(KERN_ERR "OMAP_McBSP: Receiver not started\n");
> +		goto rxinx_err;
> +	}
> +
> +	/* Get dma_chain_index */
> +	if (omap_get_dma_chain_index
> +		(mcbsp->dma_rx_lch, &eix, &fix) != 0) {

	fits in one line

> +		printk(KERN_ERR "OMAP_McBSP: Getting chain index failed\n");
> +		goto rxinx_err;
> +	}
> +
> +	*ei = eix;
> +	*fi = fix;
> +	return 0;
> +
> +rxinx_err:
> +	return -EINVAL;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_receiver_index);
> +
> +/*
> + * Basic Reset Transmitter
> + * id		: McBSP interface number
> + * state	: Disable (0)/ Enable (1) the transmitter
> + */

kdoc style

> +int omap2_mcbsp_set_xrst(unsigned int id, u8 state)
> +{
> +	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
> +	u32 io_base;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +	io_base = mcbsp->io_base;
> +
> +	if (state == OMAP_MCBSP_XRST_DISABLE)
> +		OMAP_MCBSP_WRITE(io_base, SPCR2,
> +		      OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
> +	else
> +		OMAP_MCBSP_WRITE(io_base, SPCR2,
> +			OMAP_MCBSP_READ(io_base, SPCR2) | XRST);
> +	udelay(10);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_set_xrst);
> +
> +/*
> + * Reset Receiver
> + * id		: McBSP interface number
> + * state	: Disable (0)/ Enable (1) the receiver
> + */

kdoc style

> +int omap2_mcbsp_set_rrst(unsigned int id, u8 state)
> +{
> +	struct omap_mcbsp *mcbsp = mcbsp_ptr[id];
> +	u32 io_base;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +	io_base = mcbsp->io_base;
> +
> +	if (state == OMAP_MCBSP_RRST_DISABLE)
> +		OMAP_MCBSP_WRITE(io_base, SPCR1,
> +			OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
> +	else
> +		OMAP_MCBSP_WRITE(io_base, SPCR1,
> +		      OMAP_MCBSP_READ(io_base, SPCR1) | RRST);
> +	udelay(10);

add a blank line before return

> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_set_rrst);
> +
> +/*
> + * Configure the receiver parameters
> + * id		: McBSP Interface ID
> + * rp		: DMA Receive parameters
> + */

kdoc

> +int omap2_mcbsp_dma_recv_params(unsigned int id,
> +			struct omap_mcbsp_dma_transfer_params *rp)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	u32 io_base;
> +	int err, chain_id = -1;
> +	struct omap_dma_channel_params rx_params;
> +	u32  dt = 0;

use reversed christmas tree here:

+	struct omap_dma_channel_params rx_params;
+	struct omap_mcbsp *mcbsp;
+	int err, chain_id = -1;
+	u32 io_base;
+	u32  dt = 0;

> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +
> +	mcbsp = id_to_mcbsp_ptr(id);
> +	io_base = mcbsp->io_base;
> +	dt = rp->word_length1;
> +
> +	if (dt == OMAP_MCBSP_WORD_8)
> +		rx_params.data_type = OMAP_DMA_DATA_TYPE_S8;
> +	else if (dt == OMAP_MCBSP_WORD_16)
> +		rx_params.data_type = OMAP_DMA_DATA_TYPE_S16;
> +	else if (dt == OMAP_MCBSP_WORD_32)
> +		rx_params.data_type = OMAP_DMA_DATA_TYPE_S32;
> +	else
> +		return -EINVAL;
> +
> +	rx_params.read_prio = DMA_CH_PRIO_HIGH;
> +	rx_params.write_prio = DMA_CH_PRIO_HIGH;
> +	rx_params.sync_mode = OMAP_DMA_SYNC_ELEMENT;
> +	rx_params.src_fi = 0;
> +	rx_params.trigger = mcbsp->dma_rx_sync;
> +	rx_params.src_or_dst_synch = 0x01;
> +	rx_params.src_amode = OMAP_DMA_AMODE_CONSTANT;
> +	rx_params.src_ei = 0x0;
> +	/* Indexing is always in bytes - so multiply with dt */
> +
> +	dt = (rx_params.data_type == OMAP_DMA_DATA_TYPE_S8) ? 1 :
> +		(rx_params.data_type == OMAP_DMA_DATA_TYPE_S16) ? 2 : 4;
> +
> +	/* SKIP_FIRST and SKIP_SECOND- skip alternate data in 24 bit mono */
> +	if (rp->skip_alt == OMAP_MCBSP_SKIP_SECOND) {
> +		rx_params.dst_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
> +		rx_params.dst_ei = (1);
> +		rx_params.dst_fi = (1) + ((-1) * dt);
> +	} else if (rp->skip_alt == OMAP_MCBSP_SKIP_FIRST) {
> +		rx_params.dst_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
> +		rx_params.dst_ei = 1 + (-2) * dt;
> +		rx_params.dst_fi = 1 + (2) * dt;
> +	} else {
> +		rx_params.dst_amode = OMAP_DMA_AMODE_POST_INC;
> +		rx_params.dst_ei = 0;
> +		rx_params.dst_fi = 0;
> +	}
> +
> +	mcbsp->rxskip_alt = rp->skip_alt;
> +	mcbsp->auto_reset &= ~OMAP_MCBSP_AUTO_RRST;
> +	mcbsp->auto_reset |=	(rp->auto_reset & OMAP_MCBSP_AUTO_RRST);

			why this tab ??

> +
> +	mcbsp->rx_word_length = rx_params.data_type << 0x1;
> +	if (rx_params.data_type == 0)
> +		mcbsp->rx_word_length = 1;
> +
> +	mcbsp->rx_callback = rp->callback;
> +	/* request for a chain of dma channels for data reception */
> +	if (mcbsp->dma_rx_lch == -1) {
> +		err = omap_request_dma_chain(id, "McBSP RX",
> +					 omap2_mcbsp_rx_dma_callback, &chain_id,
> +					 2, OMAP_DMA_DYNAMIC_CHAIN, rx_params);
					no spaces for identation

> +		if (err < 0) {
> +			printk(KERN_ERR "Receive path configuration failed \n");
> +			return -EINVAL;
> +		}
> +		mcbsp->dma_rx_lch = chain_id;
> +		mcbsp->rx_dma_chain_state = 0;
> +	} else {
> +		/* DMA params already set, modify the same!! */
> +		err = omap_modify_dma_chain_params(mcbsp->dma_rx_lch,
> +								 rx_params);
						no spaces for identation
> +		if (err < 0)
> +			return -EINVAL;

		where's the omap_free_dma_chain() ??

> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_dma_recv_params);
> +
> +/*
> + * Configure the transmitter parameters
> + * id		: McBSP Interface ID
> + * tp		: DMA Transfer parameters
> + */

follow kdoc

> +

no need for extra line here

> +int omap2_mcbsp_dma_trans_params(unsigned int id,
> +			struct omap_mcbsp_dma_transfer_params *tp)
> +{
> +	struct omap_mcbsp *mcbsp;
> +
> +	struct omap_dma_channel_params tx_params;
> +	int err = 0, chain_id = -1;
> +	u32 io_base;
> +	u32 dt = 0;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +
> +	mcbsp = id_to_mcbsp_ptr(id);
> +	io_base = mcbsp->io_base;
> +
> +	dt = tp->word_length1;
> +	if ((dt != OMAP_MCBSP_WORD_8) && (dt != OMAP_MCBSP_WORD_16)
> +						 && (dt != OMAP_MCBSP_WORD_32))
> +		return -EINVAL;
> +	if (dt == OMAP_MCBSP_WORD_8)
> +		tx_params.data_type = OMAP_DMA_DATA_TYPE_S8;
> +	else if (dt == OMAP_MCBSP_WORD_16)
> +		tx_params.data_type = OMAP_DMA_DATA_TYPE_S16;
> +	else if (dt == OMAP_MCBSP_WORD_32)
> +		tx_params.data_type = OMAP_DMA_DATA_TYPE_S32;
> +	else
> +		return -EINVAL;
> +
> +	tx_params.read_prio = DMA_CH_PRIO_HIGH;
> +	tx_params.write_prio = DMA_CH_PRIO_HIGH;
> +	tx_params.sync_mode = OMAP_DMA_SYNC_ELEMENT;
> +	tx_params.dst_fi = 0;
> +	tx_params.trigger = mcbsp->dma_tx_sync;
> +	tx_params.src_or_dst_synch = 0;
> +	tx_params.dst_amode = OMAP_DMA_AMODE_CONSTANT;
> +	tx_params.dst_ei = 0;
> +	/* Indexing is always in bytes - so multiply with dt */
> +	mcbsp->tx_word_length = tx_params.data_type << 0x1;
> +
> +	if (tx_params.data_type == 0)
> +		mcbsp->tx_word_length = 1;
> +	dt = mcbsp->tx_word_length;
> +
> +	/* SKIP_FIRST and SKIP_SECOND- skip alternate data in 24 bit mono */
> +	if (tp->skip_alt == OMAP_MCBSP_SKIP_SECOND) {
> +		tx_params.src_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
> +		tx_params.src_ei = (1);
> +		tx_params.src_fi = (1) + ((-1) * dt);
> +	} else if (tp->skip_alt == OMAP_MCBSP_SKIP_FIRST) {
> +		tx_params.src_amode = OMAP_DMA_AMODE_DOUBLE_IDX;
> +		tx_params.src_ei = 1 + (-2) * dt;
> +		tx_params.src_fi = 1 + (2) * dt;
> +	} else {
> +		tx_params.src_amode = OMAP_DMA_AMODE_POST_INC;
> +		tx_params.src_ei = 0;
> +		tx_params.src_fi = 0;
> +	}
> +
> +	mcbsp->txskip_alt = tp->skip_alt;
> +	mcbsp->auto_reset &= ~OMAP_MCBSP_AUTO_XRST;
> +	mcbsp->auto_reset |=
> +		(tp->auto_reset & OMAP_MCBSP_AUTO_XRST);
> +	mcbsp->tx_callback = tp->callback;
> +
> +	/* Based on Rjust we can do double indexing DMA params configuration */
> +	if (mcbsp->dma_tx_lch == -1) {
> +		err = omap_request_dma_chain(id, "McBSP TX",
> +					 omap2_mcbsp_tx_dma_callback, &chain_id,
> +					 2, OMAP_DMA_DYNAMIC_CHAIN, tx_params);
> +		if (err < 0) {
> +			printk(KERN_ERR
> +				"Transmit path configuration failed \n");
> +			return -EINVAL;
> +		}
> +		mcbsp->tx_dma_chain_state = 0;
> +	mcbsp->dma_tx_lch = chain_id;

	fix this identation

> +	} else {
> +		/* DMA params already set, modify the same!! */
> +		err = omap_modify_dma_chain_params(mcbsp->dma_tx_lch,
> +								 tx_params);
> +		if (err < 0)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_dma_trans_params);
> +
> +/*
> + * Start receving data on a McBSP interface
> + * id			: McBSP interface ID
> + * cbdata		: User data to be returned with callback
> + * buf_start_addr	: The destination address [physical address]
> + * buf_size		: Buffer size
> + */

kdoc

> +

trailing extra line

> +int omap2_mcbsp_receive_data(unsigned int id, void *cbdata,
> +			     dma_addr_t buf_start_addr, u32 buf_size)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	u32 io_base;
> +	int enable_rx = 0;
> +	int e_count = 0;
> +	int f_count = 0;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}
> +
> +	mcbsp = id_to_mcbsp_ptr(id);
> +
> +	io_base = mcbsp->io_base;
> +
> +	mcbsp->rx_cb_arg = cbdata;
> +
> +	/* Auto RRST handling logic - disable the Reciever before 1st dma */
> +	if ((mcbsp->auto_reset & OMAP_MCBSP_AUTO_RRST) &&
> +		(omap_dma_chain_status(mcbsp->dma_rx_lch)
> +				== OMAP_DMA_CHAIN_INACTIVE)) {
> +		OMAP_MCBSP_WRITE(io_base, SPCR1,
> +			OMAP_MCBSP_READ(io_base, SPCR1) & (~RRST));
> +		enable_rx = 1;
> +	}
> +
> +	/*
> +	 * for skip_first and second, we need to set e_count =2,
> +	 * and f_count = number of frames = number of elements/e_count
> +	 */
> +	e_count = (buf_size / mcbsp->rx_word_length);
> +
> +	if (mcbsp->rxskip_alt != OMAP_MCBSP_SKIP_NONE) {
> +		/*
> +		 * since the number of frames = total number of elements/element
> +		 * count, However, with double indexing for data transfers,
> +		 * double the number of elements need to be transmitted
> +		 */
> +		f_count = e_count;
> +		e_count = 2;
> +	} else {
> +		f_count = 1;
> +	}
> +	/*
> +	 * If the DMA is to be configured to skip the first byte, we need
> +	 * to jump backwards, so we need to move one chunk forward and
> +	 * ask dma if we dont want the client driver knowing abt this.
> +	 */
> +	if (mcbsp->rxskip_alt == OMAP_MCBSP_SKIP_FIRST)
> +		buf_start_addr += mcbsp->rx_word_length;
> +
> +	if (omap_dma_chain_a_transfer(mcbsp->dma_rx_lch,
> +			mcbsp->phy_base + OMAP_MCBSP_REG_DRR, buf_start_addr,
> +			e_count, f_count, mcbsp) < 0) {
> +		printk(KERN_ERR " Buffer chaining failed \n");
> +		return -EINVAL;
> +	}
> +	if (mcbsp->rx_dma_chain_state == 0) {
> +		if (mcbsp->interface_mode == OMAP_MCBSP_MASTER)
> +			omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_ENABLE_FSG_SRG);
> +
> +		if (omap_start_dma_chain_transfers(mcbsp->dma_rx_lch) < 0)
> +			return -EINVAL;
> +		mcbsp->rx_dma_chain_state = 1;
> +	}
> +	/* Auto RRST handling logic - Enable the Reciever after 1st dma */
> +	if (enable_rx &&
> +		(omap_dma_chain_status(mcbsp->dma_rx_lch)
> +				== OMAP_DMA_CHAIN_ACTIVE))
> +		OMAP_MCBSP_WRITE(io_base, SPCR1,
> +			OMAP_MCBSP_READ(io_base, SPCR1) | RRST);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_receive_data);
> +
> +/*
> + * Start transmitting data through a McBSP interface
> + * id			: McBSP interface ID
> + * cbdata		: User data to be returned with callback
> + * buf_start_addr	: The source address [This should be physical address]
> + * buf_size		: Buffer size
> + */

kdoc

> +int omap2_mcbsp_send_data(unsigned int id, void *cbdata,
> +			  dma_addr_t buf_start_addr, u32 buf_size)
> +{
> +	struct omap_mcbsp *mcbsp;
> +	u32 io_base;
> +	u8 enable_tx = 0;
> +	int e_count = 0;
> +	int f_count = 0;
> +
> +	if (!omap_mcbsp_check_valid_id(id)) {
> +		printk(KERN_ERR "%s: Invalid id (%d)\n", __func__, id + 1);
> +		return -ENODEV;
> +	}

add an extra line here

> +	mcbsp = id_to_mcbsp_ptr(id);
> +
> +	io_base = mcbsp->io_base;
> +
> +	mcbsp->tx_cb_arg = cbdata;
> +
> +	/* Auto RRST handling logic - disable the Reciever before 1st dma */
> +	if ((mcbsp->auto_reset & OMAP_MCBSP_AUTO_XRST) &&
> +			(omap_dma_chain_status(mcbsp->dma_tx_lch)
> +				== OMAP_DMA_CHAIN_INACTIVE)) {
> +		OMAP_MCBSP_WRITE(io_base, SPCR2,
> +			OMAP_MCBSP_READ(io_base, SPCR2) & (~XRST));
> +		enable_tx = 1;
> +	}
> +	/*
> +	 * for skip_first and second, we need to set e_count =2, and
> +	 * f_count = number of frames = number of elements/e_count
> +	 */
> +	e_count = (buf_size / mcbsp->tx_word_length);
> +	if (mcbsp->txskip_alt != OMAP_MCBSP_SKIP_NONE) {
> +		/*
> +		 * number of frames = total number of elements/element count,
> +		 * However, with double indexing for data transfers, double I
> +		 * the number of elements need to be transmitted
> +		 */
> +		f_count = e_count;
> +		e_count = 2;
> +	} else {
> +		f_count = 1;
> +	}
> +
> +	/*
> +	 * If the DMA is to be configured to skip the first byte, we need
> +	 * to jump backwards, so we need to move one chunk forward and ask
> +	 * dma if we dont want the client driver knowing abt this.
> +	 */
> +	if (mcbsp->txskip_alt == OMAP_MCBSP_SKIP_FIRST)
> +		buf_start_addr += mcbsp->tx_word_length;
> +
> +	if (omap_dma_chain_a_transfer(mcbsp->dma_tx_lch,
> +		buf_start_addr,	mcbsp->phy_base + OMAP_MCBSP_REG_DXR,
> +		e_count, f_count, mcbsp) < 0)
> +			return -EINVAL;
> +
> +	if (mcbsp->tx_dma_chain_state == 0) {
> +		if (mcbsp->interface_mode == OMAP_MCBSP_MASTER)
> +			omap2_mcbsp_set_srg_fsg(id, OMAP_MCBSP_ENABLE_FSG_SRG);
> +
> +		if (omap_start_dma_chain_transfers(mcbsp->dma_tx_lch) < 0)
> +			return -EINVAL;
> +		mcbsp->tx_dma_chain_state = 1;
> +	}
> +
> +	/* Auto XRST handling logic - Enable the Reciever after 1st dma */
> +	if (enable_tx &&
> +		(omap_dma_chain_status(mcbsp->dma_tx_lch)
> +		== OMAP_DMA_CHAIN_ACTIVE))
> +		OMAP_MCBSP_WRITE(io_base, SPCR2,
> +			OMAP_MCBSP_READ(io_base, SPCR2) | XRST);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(omap2_mcbsp_send_data);
> 
>  #ifdef CONFIG_ARCH_OMAP24XX
>  static struct omap_mcbsp_platform_data omap24xx_mcbsp_pdata[] = {
> @@ -176,6 +867,7 @@
>  static struct omap_mcbsp_platform_data omap34xx_mcbsp_pdata[] = {
>  	{
>  		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP1_BASE),
> +		.phy_base	= OMAP34XX_MCBSP1_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP1_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP1_TX,
>  		.rx_irq		= INT_24XX_MCBSP1_IRQ_RX,
> @@ -185,6 +877,7 @@
>  	},
>  	{
>  		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP2_BASE),
> +		.phy_base	= OMAP34XX_MCBSP2_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP2_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP2_TX,
>  		.rx_irq		= INT_24XX_MCBSP2_IRQ_RX,
> @@ -194,6 +887,7 @@
>  	},
>  	{
>  		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP3_BASE),
> +		.phy_base	= OMAP34XX_MCBSP3_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP3_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP3_TX,
>  		.ops		= &omap2_mcbsp_ops,
> @@ -201,6 +895,7 @@
>  	},
>  	{
>  		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP4_BASE),
> +		.phy_base	= OMAP34XX_MCBSP4_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP4_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP4_TX,
>  		.ops		= &omap2_mcbsp_ops,
> @@ -208,6 +903,7 @@
>  	},
>  	{
>  		.virt_base	= OMAP2_IO_ADDRESS(OMAP34XX_MCBSP5_BASE),
> +		.phy_base	= OMAP34XX_MCBSP5_BASE,
>  		.dma_rx_sync	= OMAP24XX_DMA_MCBSP5_RX,
>  		.dma_tx_sync	= OMAP24XX_DMA_MCBSP5_TX,
>  		.ops		= &omap2_mcbsp_ops,
> Index: linux-omap-2.6/arch/arm/plat-omap/mcbsp.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/mcbsp.c	2008-08-26
> 19:13:47.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/mcbsp.c	2008-08-26 19:55:24.000000000 +0530
> @@ -23,6 +23,7 @@
>  #include <linux/clk.h>
>  #include <linux/delay.h>
>  #include <linux/io.h>
> +#include <linux/irq.h>
> 
>  #include <asm/arch/dma.h>
>  #include <asm/arch/mcbsp.h>
> @@ -46,14 +47,6 @@
>  		return __raw_readl(io_base + reg);
>  }
> 
> -#define OMAP_MCBSP_READ(base, reg) \
> -			omap_mcbsp_read(base, OMAP_MCBSP_REG_##reg)
> -#define OMAP_MCBSP_WRITE(base, reg, val) \
> -			omap_mcbsp_write(base, OMAP_MCBSP_REG_##reg, val)
> -
> -#define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
> -#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
> -
>  static void omap_mcbsp_dump_reg(u8 id)
>  {
>  	struct omap_mcbsp *mcbsp = id_to_mcbsp_ptr(id);
> @@ -173,6 +166,11 @@
>  	OMAP_MCBSP_WRITE(io_base, MCR2, config->mcr2);
>  	OMAP_MCBSP_WRITE(io_base, MCR1, config->mcr1);
>  	OMAP_MCBSP_WRITE(io_base, PCR0, config->pcr0);
> +	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> +		if (mcbsp->pdata->ops->config)
> +			mcbsp->pdata->ops->config(id, config);
> +	}
> +
>  }
>  EXPORT_SYMBOL(omap_mcbsp_config);
> 
> @@ -218,11 +216,11 @@
>  	}
>  	mcbsp = id_to_mcbsp_ptr(id);
> 
> +	clk_enable(mcbsp->clk);
> +
>  	if (mcbsp->pdata && mcbsp->pdata->ops && mcbsp->pdata->ops->request)
>  		mcbsp->pdata->ops->request(id);
> 
> -	clk_enable(mcbsp->clk);
> -
>  	spin_lock(&mcbsp->lock);
>  	if (!mcbsp->free) {
>  		dev_err(mcbsp->dev, "McBSP%d is currently in use\n",
> @@ -893,6 +891,7 @@
>  	mcbsp->dma_rx_lch = -1;
> 
>  	mcbsp->io_base = pdata->virt_base;
> +	mcbsp->phy_base = pdata->phy_base;
>  	/* Default I/O is IRQ based */
>  	mcbsp->io_type = OMAP_MCBSP_IRQ_IO;
>  	mcbsp->tx_irq = pdata->tx_irq;
> Index: linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h
> ===================================================================
> --- linux-omap-2.6.orig/include/asm-arm/arch-omap/mcbsp.h	2008-08-26
> 19:13:47.000000000 +0530
> +++ linux-omap-2.6/include/asm-arm/arch-omap/mcbsp.h	2008-08-26
> 19:55:42.000000000 +0530
> @@ -239,31 +239,58 @@
>  /********************** McBSP SYSCONFIG bit definitions ********************/
>  #define SOFTRST			0x0002
> 
> +/********************** MACRO DEFINITIONS *********************************/
> +
> +/* McBSP interface operating mode */
> +#define OMAP_MCBSP_MASTER			1
> +#define OMAP_MCBSP_SLAVE			0
> +
> +#define OMAP_MCBSP_AUTO_RST_NONE		(0x0)
> +#define OMAP_MCBSP_AUTO_RRST			(0x1<<1)
> +#define OMAP_MCBSP_AUTO_XRST			(0x1<<2)
> +
> +/* SRG ENABLE/DISABLE state */
> +#define OMAP_MCBSP_ENABLE_FSG_SRG		1
> +#define OMAP_MCBSP_DISABLE_FSG_SRG		0
> +/* mono to mono mode*/
> +#define OMAP_MCBSP_SKIP_NONE			(0x0)
> +/* mono to stereo mode */
> +#define OMAP_MCBSP_SKIP_FIRST			(0x1<<1)
> +#define OMAP_MCBSP_SKIP_SECOND			(0x1<<2)
> +/* RRST STATE */
> +#define OMAP_MCBSP_RRST_DISABLE			0
> +#define OMAP_MCBSP_RRST_ENABLE			1
> +/*XRST STATE */
> +#define OMAP_MCBSP_XRST_DISABLE			0
> +#define OMAP_MCBSP_XRST_ENABLE			1
> +
>  /* we don't do multichannel for now */
>  struct omap_mcbsp_reg_cfg {
> -	u16 spcr2;
> -	u16 spcr1;
> -	u16 rcr2;
> -	u16 rcr1;
> -	u16 xcr2;
> -	u16 xcr1;
> -	u16 srgr2;
> -	u16 srgr1;
> -	u16 mcr2;
> -	u16 mcr1;
> -	u16 pcr0;
> -	u16 rcerc;
> -	u16 rcerd;
> -	u16 xcerc;
> -	u16 xcerd;
> -	u16 rcere;
> -	u16 rcerf;
> -	u16 xcere;
> -	u16 xcerf;
> -	u16 rcerg;
> -	u16 rcerh;
> -	u16 xcerg;
> -	u16 xcerh;
> +	u32 spcr2;
> +	u32 spcr1;
> +	u32 rcr2;
> +	u32 rcr1;
> +	u32 xcr2;
> +	u32 xcr1;
> +	u32 srgr2;
> +	u32 srgr1;
> +	u32 mcr2;
> +	u32 mcr1;
> +	u32 pcr0;
> +	u32 rcerc;
> +	u32 rcerd;
> +	u32 xcerc;
> +	u32 xcerd;
> +	u32 rcere;
> +	u32 rcerf;
> +	u32 xcere;
> +	u32 xcerf;
> +	u32 rcerg;
> +	u32 rcerh;
> +	u32 xcerg;
> +	u32 xcerh;
> +	u32 xccr;
> +	u32 rccr;
>  };
> 
>  typedef enum {
> @@ -277,6 +304,7 @@
>  typedef int __bitwise omap_mcbsp_io_type_t;
>  #define OMAP_MCBSP_IRQ_IO ((__force omap_mcbsp_io_type_t) 1)
>  #define OMAP_MCBSP_POLL_IO ((__force omap_mcbsp_io_type_t) 2)
> +typedef void (*omap_mcbsp_dma_cb) (u32 ch_status, void *arg);
> 
>  typedef enum {
>  	OMAP_MCBSP_WORD_8 = 0,
> @@ -319,14 +347,28 @@
>  	omap_mcbsp_word_length		word_length;
>  };
> 
> +struct omap_mcbsp_dma_transfer_params {
> +	/* Skip the alternate element use fro stereo mode */
> +	u8 skip_alt;
> +	/* Automagically handle Transfer [XR]RST? */
> +	u8   auto_reset;
> +	/* callback function executed for every tx/rx completion */
> +	omap_mcbsp_dma_cb callback;
> +	/* word length of data */
> +	u32 word_length1;

this is difficult to read, add extra line after each variable:

+	/* Skip the alternate element use fro stereo mode */
+	u8 skip_alt;
+
+	/* Automagically handle Transfer [XR]RST? */
+	u8   auto_reset;
+
+	/* callback function executed for every tx/rx completion */
+	omap_mcbsp_dma_cb callback;
+
+	/* word length of data */
+	u32 word_length1;


> +

this is unnecessary

> +};
> +
>  /* Platform specific configuration */
>  struct omap_mcbsp_ops {
>  	void (*request)(unsigned int);
>  	void (*free)(unsigned int);
> +	void (*config)(unsigned int,  const struct omap_mcbsp_reg_cfg *config);
				 isn't one space enough ?
>  };
> 
>  struct omap_mcbsp_platform_data {
>  	u32 virt_base;
> +	u32 phy_base;
>  	u8 dma_rx_sync, dma_tx_sync;
>  	u16 rx_irq, tx_irq;
>  	struct omap_mcbsp_ops *ops;
> @@ -362,10 +404,32 @@
>  	spinlock_t lock;
>  	struct omap_mcbsp_platform_data *pdata;
>  	struct clk *clk;
> +	u32 phy_base;
> +	u8  auto_reset;	/* Auto Reset */
> +	u8  txskip_alt;	/* Tx skip flags */
> +	u8  rxskip_alt;	/* Rx skip flags */
> +	void  *rx_cb_arg;
> +	void  *tx_cb_arg;
> +	omap_mcbsp_dma_cb  rx_callback;
> +	omap_mcbsp_dma_cb  tx_callback;
> +	int  rx_dma_chain_state;
> +	int  tx_dma_chain_state;
> +	int  interface_mode; /* Master / Slave */

	one space only for all above. And make it reverse christmas tree

>  };
>  extern struct omap_mcbsp **mcbsp_ptr;
>  extern int omap_mcbsp_count;
> 
> +#define omap_mcbsp_check_valid_id(id)	(id < omap_mcbsp_count)
> +#define id_to_mcbsp_ptr(id)		mcbsp_ptr[id];
				how about aligning with the above one ?

> @@ -382,7 +446,6 @@
>  int omap_mcbsp_spi_master_xmit_word_poll(unsigned int id, u32 word);
>  int omap_mcbsp_spi_master_recv_word_poll(unsigned int id, u32 * word);
> 
> -

unnecessary change

> +int omap2_mcbsp_stop_datatx(unsigned int id);
> +int omap2_mcbsp_stop_datarx(u32 id);
> +int omap2_mcbsp_reset(unsigned int id);
> +int omap2_mcbsp_transmitter_index(int id, int *ei, int *fi);
> +int omap2_mcbsp_receiver_index(int id, int *ei, int *fi);
> +int omap2_mcbsp_set_xrst(unsigned int id, u8 state);
> +int omap2_mcbsp_set_rrst(unsigned int id, u8 state);
> +int omap2_mcbsp_dma_recv_params(unsigned int id,
> +			struct	omap_mcbsp_dma_transfer_params *rp);
				space, not tab. ditto below

-- 
balbi
