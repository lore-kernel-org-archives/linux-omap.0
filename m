From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH v8 00/18] 8250-core based serial driver for OMAP + DMA
Date: Mon, 8 Sep 2014 20:25:03 +0200
Message-ID: <20140908182503.GA4686@ci00147.xsens-tech.local>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
 <20140908144616.GA22315@ci00147.xsens-tech.local>
 <20140908151501.GA22584@linutronix.de>
 <20140908163313.GA25724@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140908163313.GA25724@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 08, 2014 at 06:33:13PM +0200, Sebastian Andrzej Siewior wrote:
> * Sebastian Andrzej Siewior | 2014-09-08 17:15:01 [+0200]:
> 
> >* Frans Klaver | 2014-09-08 16:46:18 [+0200]:
> >
> >>- ncurses based applications (vi, less) don't play nice for me on the
> >>  console with this series. less doesn't show me anything. vi doesn't
> >>  return to console properly.
> >
> >Can you give a test case 
> 
> Okay. less. My am335x-evm freezes after a while for no obvious reason.
> The data that hits the RX fifo is still received but the TX won't do
> anything. The DMA request is pending, the FIFO level is @64 bytes and
> the UART doesn't make any progress.
> On beagle-board I see what you described: less on a file and nothing
> happens.

Exactly that, yes.

Frans
