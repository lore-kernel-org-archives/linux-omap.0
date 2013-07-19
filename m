From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v6 1/2] ARM: dts: twl: Add GPADC data to device tree
Date: Fri, 19 Jul 2013 18:39:19 +0400
Message-ID: <51E94F97.40002@cogentembedded.com>
References: <1374226039-16943-1-git-send-email-oleksandr.kozaruk@ti.com> <1374226039-16943-2-git-send-email-oleksandr.kozaruk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:45925 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760494Ab3GSOjR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jul 2013 10:39:17 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so3490542lbh.38
        for <linux-omap@vger.kernel.org>; Fri, 19 Jul 2013 07:39:13 -0700 (PDT)
In-Reply-To: <1374226039-16943-2-git-send-email-oleksandr.kozaruk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
Cc: tony@atomide.com, benoit.cousson@linaro.org, rnayak@ti.com, peter.ujfalusi@ti.com, kishon@ti.com, jic23@cam.ac.uk, grant.likely@linaro.org, rob.herring@calxeda.com, lars@metafoo.de, sameo@linux.intel.com, ch.naveen@samsung.com, poeschel@lemonage.de, milo.kim@ti.com, balajitk@ti.com, gg@slimlogic.co.uk, linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello.

On 19-07-2013 13:27, Oleksandr Kozaruk wrote:

> GPADC is the general purpose ADC present on twl6030.
> The dt data is interrupt used to trigger end of ADC
> conversion.

> Signed-off-by: Oleksandr Kozaruk <oleksandr.kozaruk@ti.com>
> ---
>   arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
> index 2e3bd31..d7d4c28 100644
> --- a/arch/arm/boot/dts/twl6030.dtsi
> +++ b/arch/arm/boot/dts/twl6030.dtsi
> @@ -103,4 +103,10 @@
>   		compatible = "ti,twl6030-pwmled";
>   		#pwm-cells = <2>;
>   	};
> +
> +	adc: gpadc {

    Read my lips: the node should be called just "adc", not "gpadc".

WBR, Sergei

