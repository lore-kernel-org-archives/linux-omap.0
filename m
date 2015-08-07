From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] dma: omap-dma: add support for pause of non-cyclic
 transfers
Date: Fri, 7 Aug 2015 18:42:17 +0100
Message-ID: <20150807174217.GV7576@n2100.arm.linux.org.uk>
References: <55C47DE1.9020902@ti.com>
 <55C48A1E.3070007@linutronix.de>
 <20150807132241.GN7576@n2100.arm.linux.org.uk>
 <55C4B5AE.10309@linutronix.de>
 <20150807135727.GP7576@n2100.arm.linux.org.uk>
 <55C4CA00.3060206@hurleysoftware.com>
 <20150807152939.GQ7576@n2100.arm.linux.org.uk>
 <55C4D243.4080305@linutronix.de>
 <20150807163921.GU7576@n2100.arm.linux.org.uk>
 <55C4E988.8090605@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <55C4E988.8090605@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Greg KH <gregkh@linuxfoundation.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 07, 2015 at 01:23:20PM -0400, Peter Hurley wrote:
> The omap-serial driver which doesn't use dma is still the preferred
> stable driver for omap, for the moment.
> 
> One of the main features of the 8250_omap integration was the addition
> of dma support. Without it, 8250_omap is ttyO in ttyS clothing.

Correct.  omap-serial used to have broken DMA support, and I had a
series of patches fixing it.  Unfortunately, despite TI asking me to
work on this, TI went ahead and removed the DMA support behind my
back, which totally screwed my patch series after I merged some of
its pre-requists.  It was then decided that DMA support was no longer
an important feature, so I dropped the patch set.

So, I'm well aware of the issues here, and the problems of using the
OMAP sDMA with the UARTs.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
