From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [RFC 2/3] misc: Add w2sg0004 (gps receiver) power control driver
Date: Wed, 7 Jun 2017 09:34:59 +0200
Message-ID: <20170607073459.qg4giwqdajtmpy4n@lenoch>
References: <cover.1495363443.git.hns@goldelico.com>
 <24579fa76fbf454526fddabe0b20070e46d488ba.1495363443.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23990601AbdFGHe7yGR7i (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 2 others); Wed, 7 Jun 2017 09:34:59 +0200
Content-Disposition: inline
In-Reply-To: <24579fa76fbf454526fddabe0b20070e46d488ba.1495363443.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-2?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, Thierry Reding <treding@nvidia.com>, Jonathan Cameron <jic23@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

Dear Nikolaus,

On Sun, May 21, 2017 at 12:44:03PM +0200, H. Nikolaus Schaller wrote:
> Add driver for Wi2Wi W2SG0004/84 GPS module connected through uart.
> 
> Use serdev API hooks to monitor and forward the UART traffic to /dev/BTn
> and turn on/off the module. It also detects if the module is turned on (sends data)
> but should be off, e.g. if it was already turned on during boot or power-on-reset.
> 
> Additionally, rfkill block/unblock can be used to control an external LNA
> (and power down the module if not needed).
> 
> The driver concept is based on code developed by NeilBrown <neilb@suse.de>
> but simplified and adapted to use the new serdev API introduced in 4.11.
[snip]
> diff --git a/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> new file mode 100644
> index 000000000000..b7125c7a598c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/wi2wi,w2sg0004.txt
> @@ -0,0 +1,20 @@
> +Wi2Wi GPS module connected through UART
> +
> +Should be a subnode of the SoC UART it is connected to (serdev).
> +
> +Required properties:
> +- compatible:	wi2wi,w2sg0004 or wi2wi,w2sg0084
> +- on-off-gpio:	the GPIO that controls the module's on-off toggle input
> +
> +Optional properties:
> +- lna-suppy:	an (optional) LNA regulator that is enabled together with the GPS receiver
> +
> +Example:
> +
> +&uart2 {
> +	gps: w2sg0004 {
> +		compatible = "wi2wi,w2sg0004";
> +		lna-supply = <&vsim>;   /* LNA regulator */
> +		on-off-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;    /* GPIO_145: trigger for turning on/off w2sg0004 */
> +        };
> +};

Here it seems is nothing specific to GPS receiver in this driver and
basically UART connected GSM modules could benefit from such functionality
too - as they need power supply, had reset and ignition pin and often
status pin. See for example:
http://simcom.ee/documents/SIM5300E/SIM5300E_Hardware_Design_V1.08.pdf
page 14 or
http://www.robotshop.com/media/files/pdf/datasheet-gsm-tc35.pdf
page 19 for block diagrams.
So I wonder if you would accept making this driver a bit more generic
to cover also GSM modems use case.

Best regards,
	ladis
