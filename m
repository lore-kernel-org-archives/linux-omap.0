From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/7] dmaengine: of_dma: Support for DMA routers
Date: Thu, 26 Mar 2015 21:02:21 +0530
Message-ID: <20150326153221.GM32683@intel.com>
References: <1426080210-841-1-git-send-email-peter.ujfalusi@ti.com>
 <1426080210-841-2-git-send-email-peter.ujfalusi@ti.com>
 <20150326105018.GJ32683@intel.com>
 <5513F77A.4030005@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5513F77A.4030005@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: tony@atomide.com, linux@arm.linux.org.uk, grant.likely@linaro.org, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org, nm@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, Mar 26, 2015 at 02:11:38PM +0200, Peter Ujfalusi wrote:
> On 03/26/2015 12:50 PM, Vinod Koul wrote:
> > On Wed, Mar 11, 2015 at 03:23:24PM +0200, Peter Ujfalusi wrote:
> >> DMA routers are transparent devices used to mux DMA requests from
> >> peripherals to DMA controllers. They are used when the SoC integrates more
> >> devices with DMA requests then their controller can handle.
> >> DRA7x is one example of such SoC, where the sDMA can hanlde 128 DMA request
> >> lines, but in SoC level it has 205 DMA requests.
> >>
> >> The of_dma_router will be registered as of_dma_controller with special
> >> xlate function and additional parameters and the code will translate and
> >> requests a DMA channel from the real DMA controller.
> >> This way the router can be transparent for the system while remaining generic
> >> enough to be used in different environments.
> >>
> > Looks fine, was expecting a Documentation updates as well, but that can come
> > as follow up patch too
> 
> I have added the DT binding document since this series adds support for
> routers for platforms booting with DT:
> 
> Documentation/devicetree/bindings/dma/dma.txt | 28 ++++++++
I meant the update to Documnetation/dmanegine/ for routers :)

-- 
~Vinod
