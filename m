From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/7] ARM: dts: dra7: Enable x2 lane mode support
Date: Thu, 21 Dec 2017 07:13:58 -0800
Message-ID: <20171221151358.GQ3875@atomide.com>
References: <20171219093133.16565-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171219093133.16565-1-kishon@ti.com>
Sender: linux-pci-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: bcousson@baylibre.com, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

* Kishon Vijay Abraham I <kishon@ti.com> [171219 01:34]:
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

OK applying into omap-for-v4.16/dt and omap-for-v4.16/defconfig.

Thanks,

Tony
