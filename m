From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic transfers
Date: Fri, 07 Aug 2015 10:46:06 -0400
Message-ID: <55C4C4AE.9080004@hurleysoftware.com>
References: <1438936917-7254-1-git-send-email-bigeasy@linutronix.de> <20150807105546.GL7576@n2100.arm.linux.org.uk> <55C4A621.4050102@linutronix.de> <20150807131746.GM7576@n2100.arm.linux.org.uk> <55C4B130.5020409@linutronix.de> <20150807132551.GO7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150807132551.GO7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On 08/07/2015 09:25 AM, Russell King - ARM Linux wrote:
> On Fri, Aug 07, 2015 at 03:22:56PM +0200, Sebastian Andrzej Siewior wrote:

>> For TX-transfers, I would need to update the start-address so the
>> transfers begins where it stopped. However based on your concern I
>> can't really assume that the position reported by the HW is the correct
>> one.
> 
> Exactly - I don't believe that existing OMAP DMA hardware can ever support
> pausing a mem-to-device transfer without data loss as you have no idea
> how many bytes have been prefetched by the DMA, and therefore you have
> no idea how many bytes to unwind the hardware position.  It gets worse
> than that when you have to cross into the previous descriptor.  It's
> really not nice.
> 
> So, disallowing pause for mem-to-device is entirely reasonable given the
> data loss implications.
 
Thanks for adding your hard-won knowledge to this discussion, Russell.
This saves us a bunch of wasted effort trying to fix x_char with DMA
(and TCSANOW termios changes and throttling).

Regards,
Peter Hurley
