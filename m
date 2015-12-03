From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 3/4] dmaengine: core: Introduce new, universal API to request a channel
Date: Thu, 03 Dec 2015 16:32:12 +0100
Message-ID: <6922343.04ZpTXZq7O@wuerfel>
References: <1449153192-9082-1-git-send-email-peter.ujfalusi@ti.com> <1449153192-9082-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449153192-9082-4-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Thursday 03 December 2015 16:33:11 Peter Ujfalusi wrote:
> +
> +/**
> + * dma_request_chan - try to allocate an exclusive slave channel
> + * @dev:       pointer to client device structure
> + * @name:      slave channel name
> + *
> + * Returns pointer to appropriate DMA channel on success or an error pointer.
> + */
> +struct dma_chan *dma_request_chan(struct device *dev, const char *name)
> +{
> +       struct dma_device *d, *_d;
> +       struct dma_chan *chan = NULL;
> +
> +       /* If device-tree is present get slave info from here */
> +       if (dev->of_node)
> +               chan = of_dma_request_slave_channel(dev->of_node, name);
> +
> +       /* If device was enumerated by ACPI get slave info from here */
> +       if (has_acpi_companion(dev) && !chan)
> +               chan = acpi_dma_request_slave_chan_by_name(dev, name);

I just noticed that you are creating this as a new interface, rather than
changing dma_request_slave_channel_reason() and making the old interface
a static inline wrapper. What is the reasoning behind that?

I think if we make both interfaces do the same thing, it's easier
to do the migration.

> +       if (chan) {
> +               /* Valid channel found */
> +               if (!IS_ERR(chan) || PTR_ERR(chan) == -EPROBE_DEFER)
> +                       return chan;
> +
> +               pr_warn("%s: %s DMA request failed, falling back to legacy\n",
> +                       __func__, dev->of_node ? "OF" : "ACPI");
> +       }

Maybe print the error code as well?

	Arnd
