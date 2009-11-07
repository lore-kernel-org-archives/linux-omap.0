From: Kalle Valo <kalle.valo@iki.fi>
Subject: Re: [PATCH v2 2/2] omap: RX-51: enable tsc2005
Date: Sat, 07 Nov 2009 17:43:55 +0200
Message-ID: <87d43ufih0.fsf@purkki.valot.fi>
References: <1257340982-22814-1-git-send-email-aaro.koskinen@nokia.com>
	<1257340982-22814-2-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <1257340982-22814-2-git-send-email-aaro.koskinen@nokia.com> (Aaro Koskinen's message of "Wed\,  4 Nov 2009 15\:23\:02 +0200")
Sender: linux-input-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> Enable tsc2005 touchscreen driver on the RX-51 board.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>
> The patch is for 2.6.32-rc6.

[...]

> +static struct spi_board_info rx51_peripherals_spi_board_info[] = {
> +	[0] = {
> +		.modalias		= "tsc2005",
> +		.bus_num		= 1,
> +		.chip_select		= 0,
> +		.irq			= OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),
> +		.max_speed_hz		= 6000000,
> +		.controller_data	= &tsc2005_mcspi_config,
> +		.platform_data		= &tsc2005_config,
> +	},
> +};

I sent a wl1251 patch which adds spi_board_info and conflicts with
this patch:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg17604.html

How do we handle this?

-- 
Kalle Valo
