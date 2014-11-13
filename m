From: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Subject: Re: [PATCH 11/13] arm: dts: dra7: add DMA properties for UART
Date: Thu, 13 Nov 2014 19:34:09 +0100
Message-ID: <5464F9A1.9080901@linutronix.de>
References: <20141104170233.GB24112@csclub.uwaterloo.ca> <5459079D.7080703@linutronix.de> <20141104172117.GC24112@csclub.uwaterloo.ca> <20141104183315.GD24112@csclub.uwaterloo.ca> <20141104210315.GF24112@csclub.uwaterloo.ca> <20141105011506.GG24112@csclub.uwaterloo.ca> <5459DBB7.1090702@linutronix.de> <20141105153307.GN24110@csclub.uwaterloo.ca> <20141105162024.GH24112@csclub.uwaterloo.ca> <545A50BB.2020307@linutronix.de> <20141105194323.GI24112@csclub.uwaterloo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141105194323.GI24112-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lennart Sorensen <lsorense-1wCw9BSqJbv44Nm34jS7GywD8/FfD2ys@public.gmane.org>
Cc: linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On 11/05/2014 08:43 PM, Lennart Sorensen wrote:
> I managed to get something dma related on uart3.  But it isn't happy:
> 
> [   95.577401] DMA misaligned error with device 53
> repeated many times.
> 
> I wonder if the dma support isn't quite working for the omap572x yet in
> this tree (ti's 3.12.y tree), or maybe it is picky and the driver still
> needs a bit of work.

misaligned dma? I haven't seen any alignment requirement for SDMA/EDMA
and I haven't seen this error on beagle board, am335x-evm or dra7-evm.

> I have had no issues on uart7 and 8 without dma.

So basically what you are saying is that DMA (no matter which channel)
gives you this error and without DMA it works fine?

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
