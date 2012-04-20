From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/7] UART: OMAP: Cut the clock in the error cases
Date: Fri, 20 Apr 2012 06:46:13 -0700
Message-ID: <8762cuqzx6.fsf@ti.com>
References: <1334588821-5224-1-git-send-email-shubhrajyoti@ti.com>
	<1334588821-5224-3-git-send-email-shubhrajyoti@ti.com>
	<87bomprjic.fsf@ti.com> <4F8E62D2.9080206@ti.com>
	<87bompp2bk.fsf@ti.com> <4F8EDA24.5020209@ti.com>
	<CAM=Q2cvRs2z7sf1ZeU-tMAZLgjPSM5V2fABLyj7087drThf44A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog125.obsmtp.com ([74.125.149.153]:56381 "EHLO
	na3sys009aog125.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754028Ab2DTNqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Apr 2012 09:46:15 -0400
Received: by pbcxa12 with SMTP id xa12so1299139pbc.37
        for <linux-omap@vger.kernel.org>; Fri, 20 Apr 2012 06:46:13 -0700 (PDT)
In-Reply-To: <CAM=Q2cvRs2z7sf1ZeU-tMAZLgjPSM5V2fABLyj7087drThf44A@mail.gmail.com>
	(Shubhrajyoti Datta's message of "Fri, 20 Apr 2012 18:50:25 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Cc: Shubhrajyoti <shubhrajyoti@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, "Govindraj.R" <govindraj.raja@ti.com>

Shubhrajyoti Datta <omaplinuxkernel@gmail.com> writes:

> On Wed, Apr 18, 2012 at 8:43 PM, Shubhrajyoti <shubhrajyoti@ti.com> wrote:
>>>
>>> Kevin
>> Yes agree completely. Will describe that in the changelog.
>> --
> Does the following changelog look ok?

A little better, but still doesn't explain things so that someone who is
not intimately familar with the driver can understand the auto-suspend
version is needed in the one case.

Possibly explaining in more detail what would happen if the normal put
is used here instead of the autosuspend version might help.

Kevin

> From 37fdc2d40c9b2b19b8c5a9a4b8f7dd547d420f55 Mon Sep 17 00:00:00 2001
> From: Shubhrajyoti D <shubhrajyoti@ti.com>
> Date: Wed, 4 Apr 2012 16:32:37 +0530
> Subject: [PATCH] UART: OMAP: call pm_runtime_put/autosuspend in the error cases
>
> In the error cases the runtime_put call is missed. This patch intends to fix the
> same. In case dma request fails, we fall back to the nondma mode so after
> enabling the threshold call put_autosuspend.
>
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
>  			return;
>  		}
>  	}
> @@ -1029,8 +1031,10 @@ static int serial_omap_poll_get_char(struct
> uart_port *port)
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
