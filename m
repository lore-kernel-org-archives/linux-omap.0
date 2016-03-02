From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 5/5] ARM: dts: DRA7: Add dt nodes for PWMSS
Date: Wed, 2 Mar 2016 12:26:34 -0600
Message-ID: <20160302182634.GA26055@rob-hp-laptop>
References: <1456439796-28546-1-git-send-email-fcooper@ti.com>
 <1456439796-28546-6-git-send-email-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1456439796-28546-6-git-send-email-fcooper@ti.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Franklin S Cooper Jr <fcooper@ti.com>
Cc: paul@pwsan.com, t-kristo@ti.com, tony@atomide.com, vigneshr@ti.com, linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Feb 25, 2016 at 04:36:36PM -0600, Franklin S Cooper Jr wrote:
> From: Vignesh R <vigneshr@ti.com>
> 
> Add PWMSS device tree nodes for DRA7 SoC family and add documentation
> for dt bindings.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
> Version 3 changes:
> None
> 
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  8 +++
>  .../devicetree/bindings/pwm/pwm-tipwmss.txt        | 17 +++++-
>  arch/arm/boot/dts/dra7.dtsi                        | 64 ++++++++++++++++++++++
>  3 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
> index 9c100b2..25d91ae 100644
> --- a/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
> +++ b/Documentation/devicetree/bindings/pwm/pwm-tiehrpwm.txt
> @@ -4,6 +4,7 @@ Required properties:
>  - compatible: Must be "ti,<soc>-ehrpwm".
>    for am33xx - compatible = "ti,am33xx-ehrpwm";
>    for da850  - compatible = "ti,da850-ehrpwm", "ti,am33xx-ehrpwm";
> +  for dra7xx - compatible = "ti,dra7xx-ehrpwm", "ti,am33xx-ehrpwm";

We're starting to push back on wildcards in compatible strings. I guess 
this is okay...

>  - #pwm-cells: should be 3. See pwm.txt in this directory for a description of
>    the cells format. The only third cell flag supported by this binding is
>    PWM_POLARITY_INVERTED.
> @@ -27,3 +28,10 @@ ehrpwm0: ehrpwm@0 { /* EHRPWM on da850 */
>  	#pwm-cells = <3>;
>  	reg = <0x300000 0x2000>;
>  };
> +
> +ehrpwm0: ehrpwm@0 { /* EHRPWM on dra7xx */

Should be pwm@48440200

> +	compatible = "ti,dra7xx-ehrpwm", "ti,am33xx-ehrpwm";
> +	#pwm-cells = <3>;
> +	reg = <0x48440200 0x80>;
> +	ti,hwmods = "ehrpwm0";
> +};
