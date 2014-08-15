From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Fri, 15 Aug 2014 14:02:11 -0700
Message-ID: <20140815210211.GD9239@atomide.com>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-16-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17965 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063AbaHOVCU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Aug 2014 17:02:20 -0400
Content-Disposition: inline
In-Reply-To: <1408124563-31541-16-git-send-email-bigeasy@linutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140815 11:13]:
> +#ifdef CONFIG_SERIAL_8250_DMA
> +	if (pdev->dev.of_node) {
> +		/*
> +		 * Oh DMA support. If there are no DMA properties in the DT then
> +		 * we will fall back to a generic DMA channel which does not
> +		 * really work here. To ensure that we do not get a generic DMA
> +		 * channel assigned, we have the the_no_dma_filter_fn() here.
> +		 * To avoid "failed to request DMA" messages we check for DMA
> +		 * properties in DT.
> +		 */
> +		ret = of_property_count_strings(pdev->dev.of_node, "dma-names");
> +		if (ret == 2) {
> +			up.dma = &priv->omap8250_dma;
> +			priv->omap8250_dma.fn = the_no_dma_filter_fn;
> +			priv->omap8250_dma.rx_size = RX_TRIGGER;
> +			priv->omap8250_dma.rxconf.src_maxburst = RX_TRIGGER;
> +			priv->omap8250_dma.txconf.dst_maxburst = TX_TRIGGER;
> +
> +			if (of_machine_is_compatible("ti,am33xx"))
> +				up.bugs |= UART_BUG_DMATX;
> +		}
> +	}
> +#endif

Hmm I wonder if there's a more generic solution to this?

It would be also nice to be able to specify the use of DMA from
the board specific .dts file.

Also, with DMA enabled, looks like omap deeper idle states are
blocked as the DMA stays reserved. After I commented out the
DMA info for my console UART, PM started working.

Regards,

Tony
