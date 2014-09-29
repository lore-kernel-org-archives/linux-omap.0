From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH 09/16] tty: serial: 8250_dma: Add a TX trigger workaround
 for AM33xx
Date: Mon, 29 Sep 2014 12:30:43 +0200
Message-ID: <20140929103042.GA31111@ci00147.xsens-tech.local>
References: <20140912094010.GE28458@ci00147.xsens-tech.local>
 <5412C21A.8020203@linutronix.de>
 <20140912102816.GF28458@ci00147.xsens-tech.local>
 <541716DC.9020904@linutronix.de>
 <20140917102812.GA20438@ci00147.xsens-tech.local>
 <20140921204100.GA10111@linutronix.de>
 <20140922092853.GH20438@ci00147.xsens-tech.local>
 <20140925151403.GH19396@linutronix.de>
 <20140929085042.GA13952@ci00147.xsens-tech.local>
 <20140929095440.GB13142@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140929095440.GB13142@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Peter Hurley <peter@hurleysoftware.com>, tony@atomide.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, balbi@ti.com, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alan Cox <alan@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 29, 2014 at 11:54:40AM +0200, Sebastian Andrzej Siewior wrote:
> There is a patch named "ARM: edma: unconditionally ack the error
> interrupt". I have the feeling that this is not really required once we
> delay set_termios. I couldn't reproduce the bug with beagleblack with my
> usual test case.

I think so too. I didn't need it either.


> For your "too much work for irq" problem: Could you add trace_printk()
> in tx/rx dma start/complete, and irq routine? The interresting part is
> what is the irq routine doing once entered. It might be a condition that
> is ignored at first and "acked" later while serving another event. Or it
> is really doing something and this is more or less "legal".

I'll have a look at that.

> 
> >Thanks,
> >Frans
> 
> Sebastian
