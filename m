From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH 06/15] tty: serial: 8250_dma: handle error on TX submit
Date: Mon, 18 Aug 2014 16:57:37 +0300
Message-ID: <20140818135737.GB32400@xps8300>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de>
 <1408124563-31541-7-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408124563-31541-7-git-send-email-bigeasy@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 15, 2014 at 07:42:34PM +0200, Sebastian Andrzej Siewior wrote:
> diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
> index b161eee..02e82dc 100644
> --- a/include/linux/serial_8250.h
> +++ b/include/linux/serial_8250.h
> @@ -85,6 +85,7 @@ struct uart_8250_port {
>  	unsigned char		mcr_force;	/* mask of forced bits */
>  	unsigned char		cur_iotype;	/* Running I/O type */
>  	unsigned char		rpm_tx_active;
> +	unsigned char		dma_tx_err;

Why not make this member of uart_8250_dma instead?

-- 
heikki
