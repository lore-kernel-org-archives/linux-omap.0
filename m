From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 01/16] ARM: OMAP2 Provide function to enable/disable uart clocks
Date: Tue, 19 Aug 2008 17:40:13 +0100
Message-ID: <20080819164013.GA17034@flint.arm.linux.org.uk>
References: <1212803277-18007-1-git-send-email-tony@atomide.com> <1212803277-18007-2-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:36631 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753373AbYHSQk2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 12:40:28 -0400
Content-Disposition: inline
In-Reply-To: <1212803277-18007-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Jouni Hogander <jouni.hogander@nokia.com>

On Fri, Jun 06, 2008 at 06:47:42PM -0700, Tony Lindgren wrote:
> This patch adds common function to enable/disable omap2/3 uart
> clocks. Enabled uarts are passed by bootloader in atags and clocks for
> these enabled uarts are touched.

In some ways, this patch is a good thing, in others it's outrageous.

> -static struct clk * uart1_ick = NULL;
> -static struct clk * uart1_fck = NULL;
> -static struct clk * uart2_ick = NULL;
> -static struct clk * uart2_fck = NULL;
> -static struct clk * uart3_ick = NULL;
> -static struct clk * uart3_fck = NULL;
> +static struct clk *uart_ick[OMAP_MAX_NR_PORTS];
> +static struct clk *uart_fck[OMAP_MAX_NR_PORTS];
>  
>  static struct plat_serial8250_port serial_platform_data[] = {
>  	{
> -		.membase	= (char *)IO_ADDRESS(OMAP_UART1_BASE),
> +		.membase	= (__force void __iomem *)IO_ADDRESS(OMAP_UART1_BASE),

__force in drivers is a big no no, immediate patch rejection.  Drivers
do not use __force.

The reason for adding __iomem is to pick up where people are doing
stupid things with pointers, and __force is added in _private_ code
(eg, functions supporting IO, mapping functions, etc) to provide a
way of saying "this is part of the infrastructure and its permitted
to do this conversion."

The correct place for that cast, in its entirety, is inside the
IO_ADDRESS macro.

> @@ -71,7 +67,7 @@ static inline void serial_write_reg(struct plat_serial8250_port *p, int offset,
>  				    int value)
>  {
>  	offset <<= p->regshift;
> -	__raw_writeb(value, (unsigned long)(p->membase + offset));
> +	__raw_writeb(value, p->membase + offset);

Good.

> @@ -87,10 +83,27 @@ static inline void __init omap_serial_reset(struct plat_serial8250_port *p)
>  	serial_write_reg(p, UART_OMAP_SYSC, (0x02 << 3) | (1 << 2) | (1 << 0));
>  }
>  
> -void __init omap_serial_init()
> +void omap_serial_enable_clocks(int enable)
> +{
> +	int i;
> +	for (i = 0; i < OMAP_MAX_NR_PORTS; i++) {
> +		if (uart_ick[i] && uart_fck[i]) {
> +			if (enable) {
> +				clk_enable(uart_ick[i]);
> +				clk_enable(uart_fck[i]);
> +			} else {
> +				clk_disable(uart_ick[i]);
> +				clk_disable(uart_fck[i]);
> +			}
> +		}
> +	}
> +}

Urgh.  Why enable all clocks?  I thought OMAP was about being as lean
and mean as possible as far as power management goes, so why enable
everything and disable everything?

Looking at the omapzoom tree, this function isn't even referenced by
another part of the kernel, so maybe this function is just cruft?

> +		sprintf(name, "uart%d_ick", i+1);
> +		uart_ick[i] = clk_get(NULL, name);
> +		if (IS_ERR(uart_ick[i])) {
> +			printk(KERN_ERR "Could not get uart%d_ick\n", i+1);
> +			uart_ick[i] = NULL;
> +		} else
> +			clk_enable(uart_ick[i]);
> +
> +		sprintf(name, "uart%d_fck", i+1);
> +		uart_fck[i] = clk_get(NULL, name);
> +		if (IS_ERR(uart_fck[i])) {
> +			printk(KERN_ERR "Could not get uart%d_fck\n", i+1);
> +			uart_fck[i] = NULL;
> +		} else
> +			clk_enable(uart_fck[i]);

Definitely an improvement, but still some way to go yet... but not a
reason not to get this in (once the above issues have been resolved.)
