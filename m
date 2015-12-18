From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 0/5] mtd: nand: Fix support for NAND DMA prefetch
Date: Fri, 18 Dec 2015 10:04:34 -0800
Message-ID: <20151218180434.GJ10460@google.com>
References: <1444930648-19313-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444930648-19313-1-git-send-email-fcooper-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rogerq-l0cyMroinI0@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 15, 2015 at 12:37:23PM -0500, Franklin S Cooper Jr wrote:
> NAND DMA prefetch has been broken for awhile and seems to have only
> worked for SDMA based devices
> 
> This patchset fixes DMA prefetch to work on both EDMA and SDMA devices
> 
> Test on:
> am335x gp evm
> am437x gp evm
> am37x gp evm
> 
> This patchset depends on Roger Quadros recent v4 GPMC/NAND patchset
> https://github.com/rogerq/linux.git
> branch: for-v4.4/gpmc-v4

In what way does this depend on the other series? Can any of this be
taken without it? If not, then perhaps it'd be good if Roger can roll
this into his series? Just throwing out ideas. If you want to wait on
Roger's series, that's fine.

FWIW, the MTD stuff all looks OK to me:

Acked-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

> Franklin S Cooper Jr (5):
>   mtd: nand: omap2: Support parsing dma channel information from DT
>   mtd: nand: omap2: Start dma request before enabling prefetch
>   mtd: nand: omap2: Fix high memory dma prefetch transfer
>   ARM: dts: am437x/am33xx/omap/dm816x: Add gpmc dma channel
>   ARM: OMAP2+: Update GPMC and NAND DT binding documentation
> 
>  .../bindings/memory-controllers/omap-gpmc.txt      |  7 +++++-
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  2 ++
>  arch/arm/boot/dts/am33xx.dtsi                      |  2 ++
>  arch/arm/boot/dts/am4372.dtsi                      |  2 ++
>  arch/arm/boot/dts/dm816x.dtsi                      |  2 ++
>  arch/arm/boot/dts/omap3.dtsi                       |  2 ++
>  arch/arm/boot/dts/omap4.dtsi                       |  2 ++
>  arch/arm/boot/dts/omap5.dtsi                       |  2 ++
>  drivers/mtd/nand/omap2.c                           | 27 +++++++++-------------
>  9 files changed, 31 insertions(+), 17 deletions(-)
> 
> -- 
> 2.6.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
