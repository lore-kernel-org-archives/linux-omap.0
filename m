From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 2/7] dmaengine: omap-dma: Complete the cookie first on
 transfer completion
Date: Sun, 24 Jul 2016 13:09:22 +0530
Message-ID: <20160724073922.GE9681@localhost>
References: <20160714124242.7579-1-peter.ujfalusi@ti.com>
 <20160714124242.7579-3-peter.ujfalusi@ti.com>
 <20160718103409.GH5783@n2100.arm.linux.org.uk>
 <923b54d6-c7fc-66c2-1c20-d8d74ebed912@ti.com>
 <20160719162004.GK5783@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160719162004.GK5783@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Tue, Jul 19, 2016 at 05:20:04PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 19, 2016 at 03:35:18PM +0300, Peter Ujfalusi wrote:
> > On 07/18/16 13:34, Russell King - ARM Linux wrote:
> > > On Thu, Jul 14, 2016 at 03:42:37PM +0300, Peter Ujfalusi wrote:
> > >> Before looking for the next descriptor to start, complete the just finished
> > >> cookie.
> > > 
> > > This change will reduce performance as we no longer have an overlap
> > > between the next request starting to be dealt with in the hardware
> > > vs the previous request being completed.
> > 
> > vchan_cookie_complete() will only mark the cookie completed, adds the vd to
> > the desc_completed list (it was deleted from desc_issued list when it was
> > started by omap_dma_start_desc) and schedule the tasklet to deal with the real
> > completion later.
> > Marking the just finished descriptor/cookie done first then looking for
> > possible descriptors in the queue to start feels like a better sequence.
> 
> I deliberately arranged the code in the original order so that the next
> transfer was started on the hardware with the least amount of work by
> the CPU.  Yes, there may not be much in it, but everything you mention
> above adds to the number of CPU cycles that need to be executed before
> the next transfer can be started.

Yes that is really the right thing to do. Ideally people would want to
minimize the delay and submit the next one as soon as possible, but people
have been lazy on this and few other aspects :)

-- 
~Vinod
