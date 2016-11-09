From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/4] Documentation: pinctrl: palmas: Add
 ti,palmas-powerhold-override property definition
Date: Wed, 9 Nov 2016 16:10:16 +0000
Message-ID: <20161109161016.GI13127@dell>
References: <1477559414-12520-1-git-send-email-j-keerthy@ti.com>
 <1477559414-12520-2-git-send-email-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1477559414-12520-2-git-send-email-j-keerthy@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Keerthy <j-keerthy@ti.com>
Cc: tony@atomide.com, robh+dt@kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, nm@ti.com, t-kristo@ti.com
List-Id: linux-omap@vger.kernel.org

On Thu, 27 Oct 2016, Keerthy wrote:

> GPIO7 is configured in POWERHOLD mode which has higher priority
> over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
> bit is turned off. This property enables driver to over ride the
> POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
> scenarios.
> 
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt | 9 +++++++++
>  1 file changed, 9 insertions(+)

This requires a DT Ack.

> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
> index caf297b..c28d4eb8 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-palmas.txt
> @@ -35,6 +35,15 @@ Optional properties:
>  - ti,palmas-enable-dvfs2: Enable DVFS2. Configure pins for DVFS2 mode.
>  	Selection primary or secondary function associated to GPADC_START
>  	and SYSEN2 pin/pad for DVFS2 interface
> +- ti,palmas-override-powerhold: This is applicable for PMICs for which
> +	GPIO7 is configured in POWERHOLD mode which has higher priority
> +	over DEV_ON bit and keeps the PMIC supplies on even after the DEV_ON
> +	bit is turned off. This property enables driver to over ride the
> +	POWERHOLD value to GPIO7 so as to turn off the PMIC in power off
> +	scenarios. So for GPIO7 if ti,palmas-override-powerhold is set
> +	then the GPIO_7 field should never be muxed to anything else.
> +	It should be set to POWERHOLD by default and only in case of
> +	power off scenarios the driver will over ride the mux value.
>  
>  This binding uses the following generic properties as defined in
>  pinctrl-bindings.txt:

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
