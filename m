From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 0/7] ARM: dts: dra7: Enable x2 lane mode support
Date: Wed, 7 Mar 2018 12:08:24 +0000
Message-ID: <20180307120824.GC15139@e107981-ln.cambridge.arm.com>
References: <20171219093133.16565-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, bcousson@baylibre.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Tue, Dec 19, 2017 at 03:01:26PM +0530, Kishon Vijay Abraham I wrote:
> Add properties to enable PCIe x2 lane mode since all dra7
> based SoCs support x2 lane mode.
> 
> However only dra76-evm has a slot which can support x2 lane
> cards. Hence only enable x2 lane mode in dra76-evm.
> (am571x-idk can support x2 lane mode but that makes usb port
> not functional so not including the patch to enable
> x2 mode in am571x-idk)
> 
> Also included in this series is patch to enable PCIe configs
> (both host and device) in omap2plus_defconfig and
> multi_v7_defconfig
> 
> In order to get x2 mode working [1] is required.
> 
> However by keeping the older compatible, this series won't
> break functionality if this series is merged before [1]
> 
> [1] -> https://lkml.org/lkml/2017/12/19/175
> 
> Kishon Vijay Abraham I (7):
>   ARM: dts: dra7: Add properties to enable PCIe x2 lane mode
>   ARM: dts: DRA74x: Use PCIe compatible specific to dra74
>   ARM: dts: DRA72x: Use PCIe compatible specific to dra72
>   ARM: dts: dra76-evm: Enable x2 PCIe lanes
>   ARM: dts: dra7: Remove deprecated PCI compatible string
>   ARM: omap2plus_defconfig: Enable CONFIG_PCI_DRA7XX (Host & Device
>     modes)
>   ARM: multi_v7_defconfig: Enable CONFIG_PCI_DRA7XX (Host & Device
>     modes)
> 
>  arch/arm/boot/dts/dra7.dtsi          |  9 +++++----
>  arch/arm/boot/dts/dra72x.dtsi        | 12 ++++++++++++
>  arch/arm/boot/dts/dra74x.dtsi        | 12 ++++++++++++
>  arch/arm/boot/dts/dra76-evm.dts      | 16 ++++++++++++++++
>  arch/arm/configs/multi_v7_defconfig  |  6 ++++++
>  arch/arm/configs/omap2plus_defconfig |  8 ++++++++
>  6 files changed, 59 insertions(+), 4 deletions(-)

Hi Kishon,

I would like to ask you please what are your expectations with this
series, which tree these changes are going to be queued through ?

Please let me know, thanks.

Lorenzo
