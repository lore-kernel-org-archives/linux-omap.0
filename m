From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 03/18] tty: serial: 8250_core: allow to set ->throttle /
 ->unthrottle callbacks
Date: Mon, 8 Sep 2014 16:33:29 -0700
Message-ID: <20140908233329.GA32144@kroah.com>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
 <1409943773-7874-4-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409943773-7874-4-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 05, 2014 at 09:02:38PM +0200, Sebastian Andrzej Siewior wrote:
> The OMAP UART provides support for HW assisted flow control. What is
> missing is the support to throttle / unthrottle callbacks which are used
> by the omap-serial driver at the moment.
> This patch adds the callbacks. It should be safe to add them since they
> are only invoked from the serial_core (uart_throttle()) if the feature
> flags are set.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Due to other recent changes, this patch fails to apply :(

I've applied your first two, can you respin the rest and resend as a new
series?

thanks,

greg k-h
