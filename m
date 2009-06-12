From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/2] Serial: Define IRQ flags for 8250 driver
Date: Fri, 12 Jun 2009 09:47:03 -0700
Message-ID: <8763f1iem0.fsf@deeprootsystems.com>
References: <1244768030-23022-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f187.google.com ([209.85.222.187]:56442 "EHLO
	mail-pz0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbZFLQrF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Jun 2009 12:47:05 -0400
Received: by pzk17 with SMTP id 17so691201pzk.33
        for <linux-omap@vger.kernel.org>; Fri, 12 Jun 2009 09:47:06 -0700 (PDT)
In-Reply-To: <1244768030-23022-1-git-send-email-vikram.pandita@ti.com> (Vikram Pandita's message of "Thu\, 11 Jun 2009 19\:53\:50 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Vikram Pandita <vikram.pandita@ti.com> writes:

> Boards with serial irq High/Low/Rising/Falling IRQ requirement
> do not work today
>
> 8250 serial driver does not have provision to pass on IRQ flags
> from platform_device
>
> This is requred for OMAP Zoom2 board for which Serial IRQ trigger
> is IRQF_TRIGGER_HIGH
>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>

Acked-by: Kevin Hilman <khilman@deeprootsystems.com>

Tested and verified on zoom2.  This should to go linux-serial, and CC
LKML, linux-omap.

Before sending, I would update the subject/description slightly:

Subject: serial: 8250: add IRQ trigger support

Description:
There is currently no provision for passing IRQ trigger flags for
serial IRQs with triggering requirements (such as GPIO IRQs.)

This patch adds UPF_IRQ_TRIG_* flags which map on to IRQF_TRIGGER_*
flags.

> ---
>  drivers/serial/8250.c       |   10 ++++++++++
>  include/linux/serial_core.h |    4 ++++
>  2 files changed, 14 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
> index bab115e..8235ef5 100644
> --- a/drivers/serial/8250.c
> +++ b/drivers/serial/8250.c
> @@ -1641,6 +1641,16 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
>  	struct irq_info *i;
>  	int ret, irq_flags = up->port.flags & UPF_SHARE_IRQ ? IRQF_SHARED : 0;
>  
> +	/* Get IRQ Trigger Flag */
> +	if (up->port.flags & UPF_IRQ_TRIG_RISING)
> +		irq_flags |= IRQF_TRIGGER_RISING;
> +	else if (up->port.flags & UPF_IRQ_TRIG_FALLING)
> +		irq_flags |= IRQF_TRIGGER_FALLING;
> +	else if (up->port.flags & UPF_IRQ_TRIG_HIGH)
> +		irq_flags |= IRQF_TRIGGER_HIGH;
> +	else if (up->port.flags & UPF_IRQ_TRIG_LOW)
> +		irq_flags |= IRQF_TRIGGER_LOW;
> +
>  	mutex_lock(&hash_mutex);
>  
>  	h = &irq_lists[up->port.irq % NR_IRQ_HASH];
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 57a97e5..07591d5 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -296,7 +296,11 @@ struct uart_port {
>  #define UPF_SPD_WARP		((__force upf_t) (0x1010))
>  #define UPF_SKIP_TEST		((__force upf_t) (1 << 6))
>  #define UPF_AUTO_IRQ		((__force upf_t) (1 << 7))
> +#define UPF_IRQ_TRIG_RISING	((__force upf_t) (1 << 8))
> +#define UPF_IRQ_TRIG_FALLING	((__force upf_t) (1 << 9))
> +#define UPF_IRQ_TRIG_HIGH	((__force upf_t) (1 << 10))
>  #define UPF_HARDPPS_CD		((__force upf_t) (1 << 11))
> +#define UPF_IRQ_TRIG_LOW	((__force upf_t) (1 << 12))
>  #define UPF_LOW_LATENCY		((__force upf_t) (1 << 13))
>  #define UPF_BUGGY_UART		((__force upf_t) (1 << 14))
>  #define UPF_NO_TXEN_TEST	((__force upf_t) (1 << 15))
> -- 
> 1.6.0.3.613.g9f8f13
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
