From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH 1/9] omap4: dts: Add node for AES
Date: Thu, 26 Sep 2013 11:41:31 +0200
Message-ID: <5244014B.1090502@baylibre.com>
References: <1380146469-29496-1-git-send-email-joelf@ti.com> <1380146469-29496-2-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:54538 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab3IZJlf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Sep 2013 05:41:35 -0400
Received: by mail-bk0-f49.google.com with SMTP id r7so310687bkg.22
        for <linux-omap@vger.kernel.org>; Thu, 26 Sep 2013 02:41:34 -0700 (PDT)
In-Reply-To: <1380146469-29496-2-git-send-email-joelf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@secretlab.ca>, Jason Kridner <jkridner@beagleboard.org>, Koen Kooi <koen@beagleboard.org>, Devicetree Discuss <devicetree@vger.kernel.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>

On 26/09/2013 00:01, Joel Fernandes wrote:
> OMAP4 has an AES module that uses the omap-aes crypto driver.
> Add DT entries for the same.
>
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
>   arch/arm/boot/dts/omap4.dtsi | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 45708e1..4267a74 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -663,5 +663,15 @@
>   			ram-bits = <12>;
>   			ti,has-mailbox;
>   		};
> +
> +		aes: aes@4B501000 {
> +			compatible = "ti,omap4-aes";
> +			ti,hwmods = "aes";
> +			reg = <0x4B501000 0xa0>;

Nit: Please use lower case for hexa value.

> +			interrupt-parent = <&gic>;

You don't have to add the interrupt-parent, it is already set by default 
at the root of the tree.

We did not add it for most nodes. Some are still there becasue I missed 
them during the review :-)

> +			interrupts = <0 85 0x4>;

For interrupt, you should use the macros now for better readability.

  +			interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;

Regards,
Benoit

> +			dmas = <&sdma 111>, <&sdma 110>;
> +			dma-names = "tx", "rx";
> +		};
>   	};
>   };
>

