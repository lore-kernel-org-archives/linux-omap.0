From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 3/4] ARM: dts: OMAP4: Add IOMMU nodes
Date: Wed, 26 Feb 2014 22:05:17 +0100
Message-ID: <5025565.C2g8cq3k2V@avalon>
References: <1392315776-33197-1-git-send-email-s-anna@ti.com> <1392315776-33197-4-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:46031 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbaBZVD6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Feb 2014 16:03:58 -0500
In-Reply-To: <1392315776-33197-4-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Suman Anna <s-anna@ti.com>
Cc: Benoit Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Florian Vaussard <florian.vaussard@epfl.ch>, devicetree@vger.kernel.org, iommu@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Suman,

Thank you for the patch.

On Thursday 13 February 2014 12:22:55 Suman Anna wrote:
> From: Florian Vaussard <florian.vaussard@epfl.ch>
> 
> Add the IOMMU nodes for the DSP and IPU subsystems. The external
> address space for DSP starts at 0x20000000 in OMAP4 compared to
> 0x11000000 in OMAP3, and the addresses beyond 0xE0000000 are
> private address space for the Cortex-M3 cores in the IPU subsystem.
> The MMU within the IPU sub-system also supports a bus error back
> capability, not available on the DSP MMU.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> [s-anna@ti.com: dma-window updates and bus error back addition]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  arch/arm/boot/dts/omap4.dtsi | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index d3f8a6e..1885f90 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -461,6 +461,23 @@
>  			dma-names = "tx", "rx";
>  		};
> 
> +		mmu_dsp: mmu@4a066000 {
> +			compatible = "ti,omap4-iommu";
> +			reg = <0x4a066000 0xff>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods = "mmu_dsp";
> +			dma-window = <0x20000000 0xdffff000>;
> +		};
> +
> +		mmu_ipu: mmu@55082000 {
> +			compatible = "ti,omap4-iommu";
> +			reg = <0x55082000 0xff>;
> +			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
> +			ti,hwmods = "mmu_ipu";
> +			dma-window = <0 0xdffff000>;

I'm not too familiar with the M3 MPU in the OMAP4, but doesn't its memory map 
also include other reserved regions, such as 0x55040000- 0x5505ffff to access 
the ISS ?

> +			ti,iommu-bus-err-back;
> +		};
> +
>  		wdt2: wdt@4a314000 {
>  			compatible = "ti,omap4-wdt", "ti,omap3-wdt";
>  			reg = <0x4a314000 0x80>;

-- 
Regards,

Laurent Pinchart

