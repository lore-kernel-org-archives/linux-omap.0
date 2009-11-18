From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/1] omap: serial: fix non-empty uart fifo read abort
Date: Tue, 17 Nov 2009 16:30:39 -0800
Message-ID: <87iqd8fzdc.fsf@deeprootsystems.com>
References: <1258501151-30866-1-git-send-email-vikram.pandita@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.221.174]:45303 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105AbZKRAag (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Nov 2009 19:30:36 -0500
Received: by qyk4 with SMTP id 4so367114qyk.33
        for <linux-omap@vger.kernel.org>; Tue, 17 Nov 2009 16:30:42 -0800 (PST)
In-Reply-To: <1258501151-30866-1-git-send-email-vikram.pandita@ti.com> (Vikram Pandita's message of "Tue\, 17 Nov 2009 17\:39\:11 -0600")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vikram Pandita <vikram.pandita@ti.com>
Cc: linux-omap@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>

Vikram Pandita <vikram.pandita@ti.com> writes:

> OMAP3630 and OMAP4430 UART IP blocks have a restriction wrt RX FIFO.
> Empty RX fifo read causes an abort. OMAP1/2/3 do not have this restriction.
>
> Overrigt the default 8250 read handler: mem_serial_in()
> by a custom handler: serial_in_8250()
>
> serial_in_8250() makes sure that RX fifo is not read when empty,
> on omap4 and 3630 silicons only
>
> tested on zoom3(3630) board
>
> Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
> Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
> ---
> v1: initial implementation
> 	http://patchwork.kernel.org/patch/60785/
> 	http://patchwork.kernel.org/patch/60786/
>
> v2: incorporate review comments from Alan Cox
> 	http://patchwork.kernel.org/patch/60785/
> 	No 8250 driver change required now
>
>  arch/arm/mach-omap2/serial.c |   28 ++++++++++++++++++++++++++++
>  1 files changed, 28 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
> index 2e17b57..362cb82 100644
> --- a/arch/arm/mach-omap2/serial.c
> +++ b/arch/arm/mach-omap2/serial.c
> @@ -71,6 +71,30 @@ struct omap_uart_state {
>  
>  static LIST_HEAD(uart_list);
>  
> +static struct omap_uart_state omap_uart[];
> +static inline unsigned int serial_read_reg(struct plat_serial8250_port *, int);
> +
> +/*
> + * Overrigt the default 8250 read handler: mem_serial_in()
> + * Empty RX fifo read causes an abort on omap3630 and omap4
> + * This function makes sure that an empty rx fifo is not read on these silicons
> + * (OMAP1/2/3 are not affected)
> + */
> +static unsigned int serial_in_8250(struct uart_port *up, int offset)
> +{
> +	/* Do not read empty UART fifo on omap3630/44xx */
> +	if ((UART_RX == offset) &&
> +		(cpu_is_omap3630() || cpu_is_omap44xx())) {

Rather than the cpu_is_* here, why not just override the function 
for these platforms and leave the default for 34xx/35xx.

Kevin
