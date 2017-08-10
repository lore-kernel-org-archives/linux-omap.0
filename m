From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/3] ARM: dts: am335x-evm: am437xx: dra7xx: Enable NAND
 DMA prefetch by default
Date: Thu, 10 Aug 2017 09:57:14 -0700
Message-ID: <20170810165713.GL8569@atomide.com>
References: <20170726021552.19880-1-fcooper@ti.com>
 <2fd38d80-16ce-8548-0f8a-38eaf820f87e@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2fd38d80-16ce-8548-0f8a-38eaf820f87e@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Franklin S Cooper Jr <fcooper@ti.com>, bcousson@baylibre.com, robh+dt@kernel.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [170808 03:04]:
> On 26/07/17 05:15, Franklin S Cooper Jr wrote:
> > Enable NAND DMA prefetch by default for AM335x, AM437x and DRA7x evms that
> > include NAND.
> > 
> > The below commit went into additional details regarding performance numbers
> > seen between the two modes.
> > 
> > commit aa7abd312c11 ("mtd: nand: omap2: Support parsing dma channel information from DT")
> > 
> > Franklin S Cooper Jr (3):
> >   ARM: dts: am335x-evm: Enable NAND dma prefetch by default
> >   ARM: dts: am437xx: Enable NAND dma prefetch by default
> >   ARM: dts: dra7xx: Enable NAND dma prefetch by default
> 
> For all patches,
> 
> Acked-by: Roger Quadros <rogerq@ti.com>

Applying all three into omap-for-v4.14/dt thanks.

Tony
