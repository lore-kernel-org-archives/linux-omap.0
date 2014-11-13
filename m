From: "Lennart Sorensen" <lsorense@csclub.uwaterloo.ca>
Subject: Re: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
Date: Thu, 13 Nov 2014 17:08:23 -0500
Message-ID: <20141113220823.GK24112@csclub.uwaterloo.ca>
References: <20141104172117.GC24112@csclub.uwaterloo.ca>
 <20141104183315.GD24112@csclub.uwaterloo.ca>
 <20141104210315.GF24112@csclub.uwaterloo.ca>
 <20141105011506.GG24112@csclub.uwaterloo.ca>
 <5459DBB7.1090702@linutronix.de>
 <20141105153307.GN24110@csclub.uwaterloo.ca>
 <20141105162024.GH24112@csclub.uwaterloo.ca>
 <545A50BB.2020307@linutronix.de>
 <20141105194323.GI24112@csclub.uwaterloo.ca>
 <5464F9A1.9080901@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5464F9A1.9080901@linutronix.de>
Sender: linux-serial-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, balbi@ti.com, gregkh@linuxfoundation.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 13, 2014 at 07:34:09PM +0100, Sebastian Andrzej Siewior wrote:
> misaligned dma? I haven't seen any alignment requirement for SDMA/EDMA
> and I haven't seen this error on beagle board, am335x-evm or dra7-evm.

Well I am using the am5728, so it should be the same as the dra7-evm.

> So basically what you are saying is that DMA (no matter which channel)
> gives you this error and without DMA it works fine?

Yes.

I am trying to get the 3.14 kernel tree going, just as soon as I figure
out which config setting makes the timer probe not crash (it works
with the default config that enables every omap ever made, but I want
a cleaner build than that).

-- 
Len Sorensen
