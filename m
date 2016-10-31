From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 4/4] ARM: dts: Add #pinctrl-cells for pinctrl-single
 instances
Date: Sun, 30 Oct 2016 22:06:13 -0500
Message-ID: <20161031030613.avo2qvv7aj5wr62o@rob-hp-laptop>
References: <20161025164538.453-1-tony@atomide.com>
 <20161025164538.453-5-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161025164538.453-5-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Nishanth Menon <nm@ti.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 25, 2016 at 09:45:38AM -0700, Tony Lindgren wrote:
> Drivers using pinctrl-single,pins have #pinctrl-cells = <1>, while
> pinctrl-single,bits need #pinctrl-cells = <2>.
> 
> Note that this patch can be optionally applied separately from the
> driver changes as the driver supports also the legacy binding without
> #pinctrl-cells.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt | 3 +++
>  arch/arm/boot/dts/am33xx.dtsi                                | 2 ++
>  arch/arm/boot/dts/am3517.dtsi                                | 1 +
>  arch/arm/boot/dts/am4372.dtsi                                | 1 +
>  arch/arm/boot/dts/da850.dtsi                                 | 1 +
>  arch/arm/boot/dts/dm814x.dtsi                                | 1 +
>  arch/arm/boot/dts/dm816x.dtsi                                | 2 ++
>  arch/arm/boot/dts/dra7.dtsi                                  | 1 +
>  arch/arm/boot/dts/hi3620.dtsi                                | 2 ++
>  arch/arm/boot/dts/keystone-k2g.dtsi                          | 1 +
>  arch/arm/boot/dts/keystone-k2l.dtsi                          | 1 +
>  arch/arm/boot/dts/omap2420.dtsi                              | 2 ++
>  arch/arm/boot/dts/omap2430.dtsi                              | 2 ++
>  arch/arm/boot/dts/omap3.dtsi                                 | 2 ++
>  arch/arm/boot/dts/omap34xx.dtsi                              | 1 +
>  arch/arm/boot/dts/omap36xx.dtsi                              | 1 +
>  arch/arm/boot/dts/omap4.dtsi                                 | 2 ++
>  arch/arm/boot/dts/omap5.dtsi                                 | 2 ++
>  arch/arm/boot/dts/pxa3xx.dtsi                                | 1 +
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi                    | 3 +++
>  20 files changed, 32 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
