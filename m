From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/2] dmaengine: ti-dma-crossbar: Support for eDMA
Date: Thu, 2 Jul 2015 21:26:14 +0530
Message-ID: <20150702155614.GV3246@localhost>
References: <1433769762-31827-1-git-send-email-peter.ujfalusi@ti.com>
 <5593DFF6.4090100@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5593DFF6.4090100@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jul 01, 2015 at 03:41:26PM +0300, Peter Ujfalusi wrote:
> Hi,
> 
> On 06/08/2015 04:22 PM, Peter Ujfalusi wrote:
> > Hi,
> > 
> > Changes since v01:
> > - Drop change in compatible for the crossbar driver and do the configuration
> >   based on the DT structure.
> > 
> > The ti-dma-crossbar driver in it's current form can work when it is used with
> > sDMA (omap-dma). On DRA7x class of devices we have both sDMA and eDMA available.
> > The sDMA driver expects to get the DMA request line with offset 1. The eDMA
> > stack does not need the offset.
> > The crosbbar itself is identical for sDMA and eDMA.
> > At probe time the driver will do a match to figure out which dma engine it is
> > connected to and based on that information it will configure the offset needed
> > by the DMA driver.
> 
> Gentle ping, it has been almost a month ago this series has been sent.
Sorry I seem to have missed this series. I relooked at this and it looks
fine. I will apply it once rc1 is out. If it needs rebase please resend

-- 
~Vinod
