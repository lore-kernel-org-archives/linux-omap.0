From: Frans Klaver <frans.klaver@xsens.com>
Subject: Re: [PATCH v8 00/18] 8250-core based serial driver for OMAP + DMA
Date: Mon, 8 Sep 2014 16:46:18 +0200
Message-ID: <20140908144616.GA22315@ci00147.xsens-tech.local>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, tony@atomide.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, balbi@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Sep 05, 2014 at 09:02:35PM +0200, Sebastian Andrzej Siewior wrote:
> This is my complete queue fo the omap serial driver based on the 8250 core
> code. I played with it on beagle bone, am335x-evm and dra7xx including DMA.
> The runtime-pm pieces look now bug-compatible with the omap-serial driver.
> Besides the runtime-om improvement I also fixed a few corner cases for the
> TX-DMA problem. The DMA fixes (in edma and omap-dma) were dropped and the
> problem has been in 8250-dma via patch #13.

Thanks for the respin. I've just tested the series a bit. Here's some
things I ran into.

- Basic console use is better than the previous series. It behaves
  pretty much like the omap-serial implementation.

- ncurses based applications (vi, less) don't play nice for me on the
  console with this series. less doesn't show me anything. vi doesn't
  return to console properly.

- I seem seem to get stuck in a "serial8250: too much work for irq%d"
  loop somewhat reliably. We have a rather demanding application with
  typically somewhere between 600 and 1000 byte packets being sent at
  240Hz (roughly somewhere between 1.5 and 2 Mb/s). We run at baudrate
  3500k. I get into this "too much work" thing already when running at
  300 bytes per packet.

I hope this is of some use to you. I'll do more testing later.

Thanks,
Frans
