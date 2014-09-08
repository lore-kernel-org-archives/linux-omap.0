From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v8 00/18] 8250-core based serial driver for OMAP + DMA
Date: Mon, 8 Sep 2014 10:40:21 -0700
Message-ID: <20140908174020.GI3238@atomide.com>
References: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409943773-7874-1-git-send-email-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

* Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140905 12:03]:
> This is my complete queue fo the omap serial driver based on the 8250 core
> code. I played with it on beagle bone, am335x-evm and dra7xx including DMA.
> The runtime-pm pieces look now bug-compatible with the omap-serial driver.
> Besides the runtime-om improvement I also fixed a few corner cases for the
> TX-DMA problem. The DMA fixes (in edma and omap-dma) were dropped and the
> problem has been in 8250-dma via patch #13.
> 
> The whole queue is available at
>   git://git.breakpoint.cc/bigeasy/linux.git uart_v8

Gave the above branch a quick try, but it again does not idle for
my omap3 test cases. It seems that now the cm_idlest1_core sdma
bit is blocking deeper idle states. Is that the correct branch
to use?

Regards,

Tony
