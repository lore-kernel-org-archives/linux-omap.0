From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v6 09/16] OMAP2+: UART: Add runtime pm support for omap-serial driver
Date: Wed, 12 Oct 2011 17:06:43 -0700
Message-ID: <878voplppo.fsf@ti.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
	<1317380495-584-9-git-send-email-govindraj.raja@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Sender: linux-serial-owner@vger.kernel.org
To: "Govindraj.R" <govindraj.raja@ti.com>
Cc: linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

[...] 

> Use device_may_wakeup to check whether uart has wakeup capabilities
> and then enable uart runtime usage for the uart.

Curious about what happens when device_may_wakeup() is not set during
device init.

[...]

> @@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platform_device *pdev)
>  		up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
>  	}
>  
> +	pm_runtime_use_autosuspend(&pdev->dev);
> +	pm_runtime_set_autosuspend_delay(&pdev->dev,
> +			OMAP_UART_AUTOSUSPEND_DELAY);
> +
> +	pm_runtime_irq_safe(&pdev->dev);
> +	if (device_may_wakeup(&pdev->dev)) {
> +		pm_runtime_enable(&pdev->dev);

So if device_may_wakeup() is false, runtime PM is not enabled, then...

> +		pm_runtime_get_sync(&pdev->dev);

...this get doesn't happen, and the first register access causes a crash.

So either this get isn't needed, because there is no device access in
this path, or this path is broken and needs validation.

> +	}
> +
>  	ui[pdev->id] = up;
>  	serial_omap_add_console_port(up);
>  
> @@ -1312,6 +1380,7 @@ static int serial_omap_probe(struct platform_device *pdev)
>  	if (ret != 0)
>  		goto do_release_region;
>  
> +	pm_runtime_put(&pdev->dev);

...also, this put is not balanced with a corresponding get.

Kevin
