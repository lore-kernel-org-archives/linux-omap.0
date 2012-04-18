From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/7] UART: OMAP: Cut the clock in the error cases
Date: Tue, 17 Apr 2012 17:06:19 -0700
Message-ID: <87bomprjic.fsf@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
	<1334588821-5224-3-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:56648 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752408Ab2DRAG3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Apr 2012 20:06:29 -0400
Received: by pbcum15 with SMTP id um15so8625710pbc.34
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 17:06:23 -0700 (PDT)
In-Reply-To: <1334588821-5224-3-git-send-email-shubhrajyoti@ti.com>
	(Shubhrajyoti D.'s message of "Mon, 16 Apr 2012 20:36:56 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> In the error cases the clock cut is missed. This patch intends to fix the
> same.

Please change the references to 'cut clocks' in subject/changelog here
(and in other patches) to use runtime suspend instead.   First, runtime PM
calls do more than cut clocks, but they only do so when
usecounting/autosuspend timeouts permit.


> Cc: stable@vger.kernel.org

Please hold off on Cc'ing stable until your patches are reviewed and accepted.

> Cc: Govindraj.R <govindraj.raja@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/tty/serial/omap-serial.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index fe099bb..10e80bb 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -319,6 +319,8 @@ static void serial_omap_start_tx(struct uart_port *port)
>  
>  		if (ret < 0) {
>  			serial_omap_enable_ier_thri(up);
> +			pm_runtime_mark_last_busy(&up->pdev->dev);
> +			pm_runtime_put_autosuspend(&up->pdev->dev);

Why the autosuspend version here?

Kevin

>  			return;
>  		}
>  	}
> @@ -1029,8 +1031,10 @@ static int serial_omap_poll_get_char(struct uart_port *port)
>  
>  	pm_runtime_get_sync(&up->pdev->dev);
>  	status = serial_in(up, UART_LSR);
> -	if (!(status & UART_LSR_DR))
> +	if (!(status & UART_LSR_DR)) {
> +		pm_runtime_put(&up->pdev->dev);
>  		return NO_POLL_CHAR;
> +	}
>  
>  	status = serial_in(up, UART_RX);
>  	pm_runtime_put(&up->pdev->dev);
