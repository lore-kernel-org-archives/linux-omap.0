From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] serial: omap-serial: fix signess error
Date: Tue, 12 Oct 2010 11:39:36 -0700
Message-ID: <8739sb1cif.fsf@deeprootsystems.com>
References: <1286731715-17908-1-git-send-email-segooon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1286731715-17908-1-git-send-email-segooon@gmail.com> (Vasiliy
	Kulikov's message of "Sun, 10 Oct 2010 21:28:35 +0400")
Sender: linux-kernel-owner@vger.kernel.org
To: Vasiliy Kulikov <segooon@gmail.com>, Tony Lindgren <tony@atomide.com>
Cc: kernel-janitors@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>, Greg Kroah-Hartman <gregkh@suse.de>, Alan Cox <alan@linux.intel.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

[adding linux-omap list]

Vasiliy Kulikov <segooon@gmail.com> writes:

> "ret" is unsigned, so check for (ret < 0) made no sense.
> Made it signed.
>
> Signed-off-by: Vasiliy Kulikov <segooon@gmail.com>
> ---
>  I cannot compile this driver, so it is not tested.

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Since the original driver is being queued via the omap tree, we can
queue this one as well.

Tony, can you add this one to the 2.6.37 queue?

Thanks,

Kevin

>  drivers/serial/omap-serial.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/serial/omap-serial.c b/drivers/serial/omap-serial.c
> index 2ee1d32..14365f7 100644
> --- a/drivers/serial/omap-serial.c
> +++ b/drivers/serial/omap-serial.c
> @@ -1055,7 +1055,7 @@ static void serial_omap_rx_timeout(unsigned long uart_no)
>  {
>  	struct uart_omap_port *up = ui[uart_no];
>  	unsigned int curr_dma_pos, curr_transmitted_size;
> -	unsigned int ret = 0;
> +	int ret = 0;
>  
>  	curr_dma_pos = omap_get_dma_dst_pos(up->uart_dma.rx_dma_channel);
>  	if ((curr_dma_pos == up->uart_dma.prev_rx_dma_pos) ||
