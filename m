From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Fix the port_window support
Date: Tue, 10 Jan 2017 11:08:45 +0530
Message-ID: <20170110053845.GX3573@localhost>
References: <20170109145052.26837-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170109145052.26837-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, tony@atomide.com, linux@armlinux.org.uk, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 09, 2017 at 04:50:52PM +0200, Peter Ujfalusi wrote:
> We do not yet have users of port_window. The following errors were found
> when converting the tusb6010_omap.c musb driver:
> 
> - The peripheral side must have SRC_/DST_PACKED disabled
> - when configuring the burst for the peripheral side the memory side
>   configuration were overwritten: d->csdp = ... -> d->csdp |= ...
> - The EI and FI were configured for the wrong sides of the transfers.
> 
> With these changes and the converted tus6010_omap.c I was able to verify
> that things are working as they expected to work.

Applied now to fixes

-- 
~Vinod
