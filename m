From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] dmaengine: omap-dma: Enable burst and data pack for SG
Date: Sat, 1 Oct 2016 11:35:45 +0530
Message-ID: <20161001060544.GD2467@localhost>
References: <20160916105315.28320-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160916105315.28320-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, linux@armlinux.org.uk, misael.lopez@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 16, 2016 at 01:53:15PM +0300, Peter Ujfalusi wrote:
> From: Misael Lopez Cruz <misael.lopez@ti.com>
> 
> Enable the burst and data pack modes for the scatter-gather
> in order to improve the throughput of the data transfers.
> 
> The improvement has been verified with MMC HS200 mode in
> the DRA72 EVM using the iozone tool to compare the read
> throughput (in kB/s) with and without burst/pack for
> different reclens (in kB).
> 
>                               With
>     reclen    Baseline   sDMA burst/pack
>     ------    --------   ---------------
>        64       46568         50820
>       128       57564         63413
>       256       65634         74937
>       512       72427         83483
>      1024       74563         84504
>      2048       76265         86079
>      4096       78045         87335
>      8192       78989         88154
>     16384       81265         91034

Applied, thanks

-- 
~Vinod
