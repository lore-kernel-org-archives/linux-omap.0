From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH 0/2] mtd: nand: omap2: Fix SDMA support for NAND DMA
 prefetch
Date: Fri, 22 Apr 2016 11:12:43 +0200
Message-ID: <20160422111243.68de7cb0@bbrezillon>
References: <1460752139-12742-1-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460752139-12742-1-git-send-email-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: dwmw2@infradead.org, computersforpeace@gmail.com, tony@atomide.com, rogerq@ti.com, linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 15 Apr 2016 15:28:57 -0500
Franklin S Cooper Jr <fcooper@ti.com> wrote:

> NAND DMA prefetch for SDMA based devices has been broken for awhile. This
> patchset fixes it so SOCs that use the SDMA can make use of the NAND
> DMA prefetch.
> 
> I've decided to split this patchset from the slightly larger patchset that
> included EDMA support. Adding EDMA support will be added in a later
> patchset.
> 
> Tested using the latest master on:
> am37 gp evm
> 
> Due to a silicon issue Dra7 SoCs are unable to use NAND DMA prefetch.

Applied, thanks.

Boris

> 
> Cooper Jr., Franklin (2):
>   mtd: nand: omap2: Start dma request before enabling prefetch
>   mtd: nand: omap2: Fix high memory dma prefetch transfer
> 
>  drivers/mtd/nand/omap2.c | 22 +++++++---------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
> 



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
