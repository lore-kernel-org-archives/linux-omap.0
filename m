From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: dts: dra7: Fix up unaligned access setting
 for PCIe EP
Date: Tue, 17 Jul 2018 15:25:50 +0530
Message-ID: <92691b59-1952-b00f-da5b-f308f94aa2b7@ti.com>
References: <20180627122919.23926-1-vigneshr@ti.com>
 <20180627122919.23926-5-vigneshr@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180627122919.23926-5-vigneshr@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vignesh R <vigneshr@ti.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 27 June 2018 05:59 PM, Vignesh R wrote:
> Bit positions of PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE and
> PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE in CTRL_CORE_SMA_SW_7 are
> incorrectly documented in the TRM. In fact, the bit positions are
> swapped. Update the DT bindings for PCIe EP to reflect the same.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>

Shouldn't this be sent to stable fixes?

Thanks
Kishon
> ---
>  arch/arm/boot/dts/dra7.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 7bfe7f28e3bd..27ad193e1a87 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -355,7 +355,7 @@
>  				ti,hwmods = "pcie1";
>  				phys = <&pcie1_phy>;
>  				phy-names = "pcie-phy0";
> -				ti,syscon-unaligned-access = <&scm_conf1 0x14 2>;
> +				ti,syscon-unaligned-access = <&scm_conf1 0x14 1>;
>  				status = "disabled";
>  			};
>  		};
> 
