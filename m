From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] [FIX] dmaengine: virt-dma: Free descriptor after
 callback
Date: Tue, 22 Apr 2014 21:44:24 +0530
Message-ID: <20140422161424.GZ32284@intel.com>
References: <1397782610-7370-1-git-send-email-joelf@ti.com>
 <20140418085019.GN27282@n2100.arm.linux.org.uk>
 <5351542A.5080307@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5351542A.5080307@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, Dan Williams <dan.j.williams@intel.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 18, 2014 at 11:34:50AM -0500, Joel Fernandes wrote:
> On 04/18/2014 03:50 AM, Russell King - ARM Linux wrote:
> > On Thu, Apr 17, 2014 at 07:56:50PM -0500, Joel Fernandes wrote:
> >> Free the vd (virt descriptor) after the callback is called.  In EDMA driver
> >> atleast which uses virt-dma, we make use of the desc during the callback and if
> >> its dangerously freed before the callback is called. I also noticed this in
> >> omap-dma dmaengine driver.
> > 
> > You've missed the vital bit of information: why do you make use of the
> > descriptor afterwards?  You shouldn't.  omap-dma doesn't either.
> > 
> > Once clients submit their request to DMA engine, they must not hold any
> > kind of reference to the descriptor other than the cookie.
> > 
> 
> Sorry, I confused edma/omap-dma callbacks for virt dma callbacks.
> 
> Anyway, I think there is still a chance in edma that we refer to the
> echan->edesc pointer later on after virt-dma calls the free (in
> edma_execute), so I'll just NULL that out to be safe and submit a patch.

Yes, that would be the right way :)

While looking at this, I see it is not called out specfically in documentation, will update
that as well

-- 
~Vinod
