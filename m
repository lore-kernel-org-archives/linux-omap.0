From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH 0/3] ARM: dts: am335x-evm: am437xx: dra7xx: Enable NAND
 DMA prefetch by default
Date: Tue, 8 Aug 2017 13:02:39 +0300
Message-ID: <2fd38d80-16ce-8548-0f8a-38eaf820f87e@ti.com>
References: <20170726021552.19880-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170726021552.19880-1-fcooper@ti.com>
Content-Language: en-GB
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Franklin S Cooper Jr <fcooper@ti.com>, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, linux@armlinux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 26/07/17 05:15, Franklin S Cooper Jr wrote:
> Enable NAND DMA prefetch by default for AM335x, AM437x and DRA7x evms that
> include NAND.
> 
> The below commit went into additional details regarding performance numbers
> seen between the two modes.
> 
> commit aa7abd312c11 ("mtd: nand: omap2: Support parsing dma channel information from DT")
> 
> Franklin S Cooper Jr (3):
>   ARM: dts: am335x-evm: Enable NAND dma prefetch by default
>   ARM: dts: am437xx: Enable NAND dma prefetch by default
>   ARM: dts: dra7xx: Enable NAND dma prefetch by default

For all patches,

Acked-by: Roger Quadros <rogerq@ti.com>

> 
>  arch/arm/boot/dts/am335x-evm.dts        | 1 +
>  arch/arm/boot/dts/am437x-gp-evm.dts     | 1 +
>  arch/arm/boot/dts/am43x-epos-evm.dts    | 1 +
>  arch/arm/boot/dts/dra7-evm.dts          | 1 +
>  arch/arm/boot/dts/dra72-evm-common.dtsi | 1 +
>  5 files changed, 5 insertions(+)
> 

-- 
cheers,
-roger
