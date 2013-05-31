From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH v1] ARM: dts: omap4-panda: Update the twl6040 gpio to
 macro definition
Date: Fri, 31 May 2013 18:12:56 +0200
Message-ID: <51A8CC08.6090305@epfl.ch>
References: <1370015122-26792-1-git-send-email-dmurphy@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:50668 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753627Ab3EaQNB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 31 May 2013 12:13:01 -0400
In-Reply-To: <1370015122-26792-1-git-send-email-dmurphy@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dan Murphy <dmurphy@ti.com>
Cc: b-cousson@ti.com, tony@atomide.com, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello Dan,

On 05/31/2013 05:45 PM, Dan Murphy wrote:
> Update the dt property ti,audpwron-gpio to use the
> gpio macro definition for GPIO_ACTIVE_HIGH.
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   arch/arm/boot/dts/omap4-panda-common.dtsi |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index 800fa4e..00cbaa5 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -190,7 +190,7 @@
>   		/* IRQ# = 119 */
>   		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>; /* IRQ_SYS_2N cascaded to gic */
>   		interrupt-parent = <&gic>;
> -		ti,audpwron-gpio = <&gpio4 31 0>;  /* gpio line 127 */
> +		ti,audpwron-gpio = <&gpio4 31 GPIO_ACTIVE_HIGH>;  /* gpio line 127 */
>
>   		vio-supply = <&v1v8>;
>   		v2v1-supply = <&v2v1>;
>

I missed it during the conversion, thank you.

Reviewed-by: Florian Vaussard <florian.vaussard@epfl.ch>
