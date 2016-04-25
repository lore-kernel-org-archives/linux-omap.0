From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 3/7] ARM: dts: am437x/am33xx/da850: Add new ECAP and
 EPWM bindings
Date: Mon, 25 Apr 2016 08:03:08 -0500
Message-ID: <20160425130308.GA7802@rob-hp-laptop>
References: <1461343238-29274-1-git-send-email-fcooper@ti.com>
 <1461343238-29274-4-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461343238-29274-4-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: thierry.reding@gmail.com, tony@atomide.com, paul@pwsan.com, t-kristo@ti.com, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, vigneshr@ti.com, nsekhar@ti.com
List-Id: linux-omap@vger.kernel.org

On Fri, Apr 22, 2016 at 11:40:34AM -0500, Franklin S Cooper Jr wrote:
> Switch to a new ECAP and EPWM bindings that doesn't depend on hwmod to
> provide the various required clocks.
> 
> For AM437 and AM335x, add the required clocks explicitly to DT. The
> hwmod entries for ECAP and EPWM will be removed and this will prevent
> anything from breaking.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  .../devicetree/bindings/pwm/pwm-tiecap.txt         | 12 +++--
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       | 12 +++--
>  arch/arm/boot/dts/am33xx.dtsi                      | 30 +++++++++---
>  arch/arm/boot/dts/am4372.dtsi                      | 54 ++++++++++++++++++----
>  arch/arm/boot/dts/da850.dtsi                       | 15 ++++--
>  5 files changed, 95 insertions(+), 28 deletions(-)

[...]

> diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
> index 12fcde4..e858460 100644
> --- a/arch/arm/boot/dts/am4372.dtsi
> +++ b/arch/arm/boot/dts/am4372.dtsi
> @@ -672,18 +672,26 @@
>  			status = "disabled";
>  
>  			ecap0: ecap@48300100 {
> -				compatible = "ti,am4372-ecap","ti,am33xx-ecap";
> +				compatible = "ti,am4372-ecap",

This doesn't appear to be documented.

> +					     "ti,am3352-ecap",
> +					     "ti,am33xx-ecap";
>  				#pwm-cells = <3>;
>  				reg = <0x48300100 0x80>;
>  				ti,hwmods = "ecap0";
> +				clocks = <&l4ls_gclk>;
> +				clock-names = "fck";
>  				status = "disabled";
>  			};
>  
>  			ehrpwm0: pwm@48300200 {
> -				compatible = "ti,am4372-ehrpwm","ti,am33xx-ehrpwm";
> +				compatible = "ti,am4372-ehrpwm",

ditto.

> +					     "ti,am3352-ehrpwm",
> +					     "ti,am33xx-ehrpwm";
>  				#pwm-cells = <3>;
>  				reg = <0x48300200 0x80>;
>  				ti,hwmods = "ehrpwm0";
> +				clocks = <&ehrpwm0_tbclk>, <&l4ls_gclk>;
> +				clock-names = "tbclk", "fck";
>  				status = "disabled";
>  			};
>  		};
