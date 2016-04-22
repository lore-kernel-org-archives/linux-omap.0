From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Fri, 22 Apr 2016 11:00:52 +0100
Message-ID: <20160422100052.GA10606@leverpostej>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Apr 20, 2016 at 12:03:56PM +0100, Jon Hunter wrote:
> The Tegra AGIC interrupt controller is compatible with the ARM GIC-400
> interrupt controller.

The cover letter says it _is_ a GIC-400, just used in a slightly unusual
manner (i.e. not directly connected to CPUs).

> The Tegra AGIC requires two clocks, namely the
> "ape" (functional) and "apb2ape" (interface) clocks, to operate. Add
> the compatible string and clock information for the AGIC to the GIC
> device-tree binding documentation.

The GIC-400 spec only describes "CLK" (which is what I imagine "ape" is.
There isn't an APB clock described, and the manual seems to show GIC-400
directly connected to AXI rather than APB, so that doesn't seem to even
be the usual "apb_pclk".

Is there some wrapper logic around a GIC-400 to giove it an APB
interface? Or am I misudnerstanding the spec?

> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> I am not sure if it will be popular to add Tegra specific clock names
> to the GIC DT docs. However, in that case, then possibly the only
> alternative is to move the Tegra AGIC driver into its own file and
> expose the GIC APIs for it to use. Then we could add our own DT doc
> for the Tegra AGIC as well (based upon the ARM GIC).

The clock-names don't seem right to me, as they sound like provide names
or global clock line names rather than consumer-side names ("clk" and
"apb_pclk").

I'm also not certain about the compatible string; if this really is a
GIC-400 then I would at least expect "arm,gic-400" as a fallback.

Thanks,
Mark.

>  Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
> index 793c20ff8fcc..6f34267f1438 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/arm,gic.txt
> @@ -21,6 +21,7 @@ Main node required properties:
>  	"arm,pl390"
>  	"arm,tc11mp-gic"
>  	"brcm,brahma-b15-gic"
> +	"nvidia,tegra210-agic"
>  	"qcom,msm-8660-qgic"
>  	"qcom,msm-qgic2"
>  - interrupt-controller : Identifies the node as an interrupt controller
> @@ -70,6 +71,7 @@ Optional
>  	"PERIPHCLK", "PERIPHCLKEN" (for "arm,cortex-a9-gic")
>  	"clk" (for "arm,gic-400")
>  	"gclk" (for "arm,pl390")
> +	"ape" and "apb2ape" (for "nvidia,tegra,agic")
>  
>  - power-domains : A phandle and PM domain specifier as defined by bindings of
>  		  the power controller specified by phandle, used when the GIC
> -- 
> 2.1.4
> 
