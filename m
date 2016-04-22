From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [PATCH V2 13/14] dt-bindings: arm-gic: Add documentation for
 Tegra210 AGIC
Date: Fri, 22 Apr 2016 10:48:36 +0100
Message-ID: <5719F374.6080403@arm.com>
References: <1461150237-15580-1-git-send-email-jonathanh@nvidia.com>
 <1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461150237-15580-14-git-send-email-jonathanh@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>
Cc: Kevin Hilman <khilman@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Lars-Peter Clausen <lars@metafoo.de>, Linus Walleij <linus.walleij@linaro.org>, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 20/04/16 12:03, Jon Hunter wrote:
> The Tegra AGIC interrupt controller is compatible with the ARM GIC-400
> interrupt controller. The Tegra AGIC requires two clocks, namely the
> "ape" (functional) and "apb2ape" (interface) clocks, to operate. Add
> the compatible string and clock information for the AGIC to the GIC
> device-tree binding documentation.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> 
> I am not sure if it will be popular to add Tegra specific clock names
> to the GIC DT docs. However, in that case, then possibly the only
> alternative is to move the Tegra AGIC driver into its own file and
> expose the GIC APIs for it to use. Then we could add our own DT doc
> for the Tegra AGIC as well (based upon the ARM GIC).

Mark, Rob: any input on this? That would work for me, but I'd like an
ack from one of you.

Thanks,

	M.

> 
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
> 


-- 
Jazz is not dead. It just smells funny...
