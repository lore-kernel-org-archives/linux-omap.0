From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 1/3] tty: serial: 8250_omap: do not use RX DMA if pause
 is not supported
Date: Tue, 11 Aug 2015 15:27:28 +0530
Message-ID: <20150811095728.GV11789@localhost>
References: <1438977619-15488-1-git-send-email-bigeasy@linutronix.de>
 <1438977619-15488-2-git-send-email-bigeasy@linutronix.de>
 <55C54D49.3090406@hurleysoftware.com>
 <20150808090343.GY7576@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150808090343.GY7576@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, john.ogness@linutronix.de, Peter Ujfalusi <peter.ujfalusi@ti.com>
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 08, 2015 at 10:03:43AM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 07, 2015 at 08:28:57PM -0400, Peter Hurley wrote:
> > Even dma_get_slave_caps() returns _true_ for cmd_pause support; ok, that
> > interface is pointless.
> 
> How about reporting that as a bug then, because if you look back in the
> git history, as you are fully capable of, you will find that the slave
> capability stuff went in _after_ omap-dma, and *many* DMA engine drivers
> have not been updated.  Here, let me do _your_ work for you:
> 
> commit cb8cea513c80db1dfe2dce468d2d0772005bb9a1
> Author: Maxime Ripard <maxime.ripard@free-electrons.com>
> Date:   Mon Nov 17 14:42:04 2014 +0100
> 
>     dmaengine: Create a generic dma_slave_caps callback
> 
> commit 2dcdf570936168d488acf90be9b04a3d32dafce7
> Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Date:   Fri Sep 14 15:05:45 2012 +0300
> 
>     dmaengine: omap: Add support for pause/resume in cyclic dma mode
> 
> Oh look, omap-dma pre-dates the creation of dma_slave_caps by over two
> years!
> 
> However, it's *not* as trivial as you think: the dma_slave_caps() call
> has no knowledge whether a channel will be used in cyclic mode or not,
> or which direction it will be used.  So, it really _can't_ report
> whether pause mode is supported or not.  So actually, this is something
> that can't be fixed trivially, and was a detail missed when the slave
> caps was reviewed (I probably missed the review or missed the point.)

The API queries the capabilities for a channel. So a channel has been
allocated. BUT it would not imply the direction as that is descriptor based,
so should we query the capabilities for a descriptor and use those in
clients ?

Also the current dma_slave_caps() has been moved to framework and reports
based on driver callbacks.
Now we have a hardware which supports pause for one direction only so we
should model it bit differently

Thoughts... ??

-- 
~Vinod
