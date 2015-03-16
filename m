From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH RESEND] serial: omap_serial: document missing properties
 and add an example
Date: Mon, 16 Mar 2015 15:13:38 -0700
Message-ID: <20150316221337.GP12397@atomide.com>
References: <1425654972-8044-1-git-send-email-mporter@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:37915 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754018AbbCPWS1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 16 Mar 2015 18:18:27 -0400
Content-Disposition: inline
In-Reply-To: <1425654972-8044-1-git-send-email-mporter@konsulko.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Matt Porter <mporter@konsulko.com>
Cc: Devicetree List <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

* Matt Porter <mporter@konsulko.com> [150306 07:16]:
> The omap_serial.txt binding documentation lacks a number of properties
> that are used in DTS files for platforms incorporating this peripheral.
> Fix this by documenting the missing required and optional fields and
> add an example.
> 
> Signed-off-by: Matt Porter <mporter@konsulko.com>

Applying the original version as they seem to be the same.

Regards,

Tony

> ---
>  .../devicetree/bindings/serial/omap_serial.txt       | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
> index 342eedd..54c2a15 100644
> --- a/Documentation/devicetree/bindings/serial/omap_serial.txt
> +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
> @@ -4,7 +4,27 @@ Required properties:
>  - compatible : should be "ti,omap2-uart" for OMAP2 controllers
>  - compatible : should be "ti,omap3-uart" for OMAP3 controllers
>  - compatible : should be "ti,omap4-uart" for OMAP4 controllers
> +- reg : address and length of the register space
> +- interrupts or interrupts-extended : Should contain the uart interrupt
> +                                      specifier or both the interrupt
> +                                      controller phandle and interrupt
> +                                      specifier.
>  - ti,hwmods : Must be "uart<n>", n being the instance number (1-based)
>  
>  Optional properties:
>  - clock-frequency : frequency of the clock input to the UART
> +- dmas : DMA specifier, consisting of a phandle to the DMA controller
> +         node and a DMA channel number.
> +- dma-names : "rx" for receive channel, "tx" for transmit channel.
> +
> +Example:
> +
> +                uart4: serial@49042000 {
> +                        compatible = "ti,omap3-uart";
> +                        reg = <0x49042000 0x400>;
> +                        interrupts = <80>;
> +                        dmas = <&sdma 81 &sdma 82>;
> +                        dma-names = "tx", "rx";
> +                        ti,hwmods = "uart4";
> +                        clock-frequency = <48000000>;
> +                };
> -- 
> 1.8.4
> 
