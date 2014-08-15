From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v7] 8250-core based serial driver for OMAP + DMA
Date: Fri, 15 Aug 2014 21:14:00 +0200
Message-ID: <53EE5BF8.3010007@linutronix.de>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de> <20140815181704.GH17769@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140815181704.GH17769@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On 08/15/2014 08:17 PM, Lennart Sorensen wrote:

> Are you saying that with the new driver you have to respond to the RX
> irq faster than before to avoid overflows?  It is not quite clear.

Yes. The irq fires 46 bytes giving you 16 bytes buffer before overflow
vs 63 bytes buffer the old one had.

> I do think 40000 interrupts to handle 40000 bytes of date does seem a
> tad inefficient, so dropping to 854 looks a lot nicer.  Was the omap
> driver not using the fifo trigger levels at all?

It configured the trigger levels to 1 for RX and 16 for TX.

Sebastian
