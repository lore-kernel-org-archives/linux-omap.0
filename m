From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 5/9] dmaengine/ARM: omap-dma: Fix the DMAengine compile
 test on non OMAP configs
Date: Wed, 21 Sep 2016 09:23:26 +0530
Message-ID: <20160921035326.GF2609@localhost>
References: <20160916083324.29133-1-peter.ujfalusi@ti.com>
 <20160916083324.29133-6-peter.ujfalusi@ti.com>
 <20160921035131.GD2609@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160921035131.GD2609@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, arnd@arndb.de, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com
List-Id: linux-omap@vger.kernel.org

On Wed, Sep 21, 2016 at 09:21:32AM +0530, Vinod Koul wrote:
> On Fri, Sep 16, 2016 at 11:33:20AM +0300, Peter Ujfalusi wrote:
> > The DMAengine driver for omap-dma use three function calls from the
> > plat-omap legacy driver. When the DMAengine driver is built when ARCH_OMAP
> > is not set, the compilation will fail due to missing symbols.
> > Add empty inline functions to allow the DMAengine driver to be compiled
> > with COMPILE_TEST.
> 
> Peter,
> 
> This should be before you enable COMPILE_TEST otherwise build will break!

Ah never mind, you have three drivers in this series so I think this is fine
before the omap one :)

-- 
~Vinod
