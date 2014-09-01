From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 15/15] tty: serial: 8250: omap: add dma support
Date: Mon, 01 Sep 2014 19:47:53 +0200
Message-ID: <5404B149.6010400@linutronix.de>
References: <20140815210211.GD9239@atomide.com> <53F5AF0D.5060409@linutronix.de> <20140821184416.GF10066@atomide.com> <53FE3779.5090908@linutronix.de> <20140827202313.GF16006@atomide.com> <20140828082348.GA5413@linutronix.de> <20140828164645.GG16006@atomide.com> <53FF84DF.7080406@linutronix.de> <20140828225454.GM16006@atomide.com> <540048B4.7010807@linutronix.de> <20140829161221.GO16006@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140829161221.GO16006@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: balbi@ti.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Paul Walmsley <paul@pwsan.com>
List-Id: linux-omap@vger.kernel.org

On 08/29/2014 06:12 PM, Tony Lindgren wrote:
> Looks like the paste bug is there for sure, doing off idle and pasting
> 240 characters to the console can hang the UART RX after few attempts,
> and pasting 16 charactes won't show up at all if the system is idling.
> So you may want to play with that too a bit :)

One character wakes it up. After that you can send 16, 64 and you see
them. Right away. No delay.

If you send "a lot" data in one-go it takes approx 152 characters until
the first one is displayed properly at 115200,8N1. That is approx 13ms.
Could it take that long to get up and be ready?

Comparing it with serial-omap I see the same thing: I takes approx the
same amount of data until the first one is displayed. After a lot of
"long" writes which wake the chip up from idle I manage to freeze both,
the serial-omap driver and mine driver.

One thing that is probably a dumb idea is that printk in
omap_8250_mdr1_errataset().
Would it be possible that when I hit a printk in the resume path that I
may deadlock and box will freeze?

> 
> Regards,
> 
> Tony
> 

Sebastian
