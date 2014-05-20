From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: Re: [PATCH 3/3] Doc/DT: Add binding doc for lgphilips,lb035q02.txt
Date: Tue, 20 May 2014 13:01:16 +0200
Message-ID: <537B35FC.8060602@epfl.ch>
References: <1400148637-17726-1-git-send-email-tomi.valkeinen@ti.com> <1400148637-17726-4-git-send-email-tomi.valkeinen@ti.com>
Reply-To: florian.vaussard@epfl.ch
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp5.epfl.ch ([128.178.224.8]:56003 "EHLO smtp5.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751974AbaETLID (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 20 May 2014 07:08:03 -0400
In-Reply-To: <1400148637-17726-4-git-send-email-tomi.valkeinen@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Archit Taneja <archit@ti.com>, devicetree@vger.kernel.org

Hi Tomi,

On 05/15/2014 12:10 PM, Tomi Valkeinen wrote:
> Add DT bindings documentation for LG.Philips LB035Q02 LCD panel.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: devicetree@vger.kernel.org
> ---
>  .../bindings/video/lgphilips,lb035q02.txt          | 33 ++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt
> 
> diff --git a/Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt b/Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt
> new file mode 100644
> index 000000000000..1a1e653e5407
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/lgphilips,lb035q02.txt
> @@ -0,0 +1,33 @@
> +LG.Philips LB035Q02 Panel
> +=========================
> +
> +Required properties:
> +- compatible: "lgphilips,lb035q02"
> +- enable-gpios: panel enable gpio
> +
> +Optional properties:
> +- label: a symbolic name for the panel
> +
> +Required nodes:
> +- Video port for DPI input
> +
> +Example
> +-------
> +
> +lcd-panel: panel@0 {
> +	compatible = "lgphilips,lb035q02";
> +	reg = <0>;
> +	spi-max-frequency = <100000>;
> +	spi-cpol;
> +	spi-cpha;
> +
> +	label = "lcd";
> +
> +	enable-gpios = <&gpio7 7 0>;
> +
> +	port {
> +		lcd_in: endpoint {
> +			remote-endpoint = <&dpi_out>;
> +		};
> +	};
> +};
> 

The lcd-panel should be a child node of a SPI controller. Maybe this
could be mentioned? Or the example could be more explicit, like:

&mcspi1 {
	lcd-panel: panel@0 {

....

	};
};

Regards,

Florian
