From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCHv2 03/16] Documentation: dt: add OMAP iommu bindings
Date: Mon, 24 Feb 2014 13:57:17 +0100
Message-ID: <530B41AD.2030608@epfl.ch>
References: <1392315347-32967-1-git-send-email-s-anna@ti.com> <1392315347-32967-4-git-send-email-s-anna@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:56695 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752210AbaBXM5W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Feb 2014 07:57:22 -0500
In-Reply-To: <1392315347-32967-4-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, iommu@lists.linux-foundation.org, devicetree@vger.kernel.org
Cc: Suman Anna <s-anna@ti.com>, Joerg Roedel <joro@8bytes.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi,

On 02/13/2014 07:15 PM, Suman Anna wrote:
> From: Florian Vaussard <florian.vaussard@epfl.ch>
> 
> This patch adds the iommu bindings for all OMAP2+ SoCs. Apart from
> the standard bindings used by OMAP peripherals, this patch uses a
> 'dma-window' (already used by Tegra SMMU) and adds two OMAP custom
> bindings - 'ti,#tlb-entries' and 'ti,iommu-bus-err-back'.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
> [s-anna@ti.com: split bindings document, add dra7 and bus error back]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
>  .../devicetree/bindings/iommu/ti,omap-iommu.txt    | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> 
> diff --git a/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> new file mode 100644
> index 0000000..116492d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iommu/ti,omap-iommu.txt
> @@ -0,0 +1,28 @@
> +OMAP2+ IOMMU
> +
> +Required properties:
> +- compatible : Should be one of,
> +		"ti,omap2-iommu" for OMAP2/OMAP3 IOMMU instances
> +		"ti,omap4-iommu" for OMAP4/OMAP5 IOMMU instances
> +		"ti,dra7-iommu" for DRA7xx IOMMU instances
> +- ti,hwmods  : Name of the hwmod associated with the IOMMU instance
> +- reg        : Address space for the configuration registers
> +- interrupts : Interrupt specifier for the IOMMU instance
> +- dma-window : IOVA start address and length
> +
> +Optional properties:
> +- ti,#tlb-entries : Number of entries in the translation look-aside buffer.
> +                    Should be either 8 or 32 (default: 32)
> +- ti,iommu-bus-err-back : Indicates the IOMMU instance supports throwing
> +		          back a bus error response on MMU faults.
> +
> +Example:
> +	/* OMAP3 ISP MMU */
> +	mmu_isp: mmu@480bd400 {
> +		compatible = "ti,omap2-iommu";
> +		reg = <0x480bd400 0x80>;
> +		interrupts = <24>;
> +		ti,hwmods = "mmu_isp";
> +		ti,#tlb-entries = <8>;
> +		dma-window = <0 0xfffff000>;
> +	};
> 

Any comments on this binding?

Regards,
Florian

