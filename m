From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH v2 5/9] am33xx: dts: Fix AES interrupt number
Date: Fri, 04 Oct 2013 16:19:48 +0200
Message-ID: <524ECE84.6030902@baylibre.com>
References: <1380553986-15910-1-git-send-email-joelf@ti.com> <1380553986-15910-6-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1380553986-15910-6-git-send-email-joelf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Russell King <linux@arm.linux.org.uk>, "open list:OMAP DEVICE TREE..." <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 30/09/2013 17:13, Joel Fernandes wrote:
> Signed-off-by: Joel Fernandes <joelf@ti.com>

Even if this is obvious, a small changelog is always recommended.


Thanks,
Benoit

> ---
>   arch/arm/boot/dts/am33xx.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 0daa1b2..d7be90a 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -724,7 +724,7 @@
>   			compatible = "ti,omap4-aes";
>   			ti,hwmods = "aes";
>   			reg = <0x53500000 0xa0>;
> -			interrupts = <102>;
> +			interrupts = <103>;
>   			dmas = <&edma 6
>   				&edma 5>;
>   			dma-names = "tx", "rx";
>

