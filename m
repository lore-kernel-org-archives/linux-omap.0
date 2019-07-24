From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] DTS: ARM: gta04: introduce legacy spi-cs-high to
 make display work again
Date: Wed, 24 Jul 2019 13:42:59 -0600
Message-ID: <20190724194259.GA25847@bogus>
References: <cover.1562597164.git.hns@goldelico.com>
 <8ae7cf816b22ef9cecee0d789fcf9e8a06495c39.1562597164.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8ae7cf816b22ef9cecee0d789fcf9e8a06495c39.1562597164.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, letux-kernel@openphoenux.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jul 08, 2019 at 04:46:05PM +0200, H. Nikolaus Schaller wrote:
> commit 6953c57ab172 "gpio: of: Handle SPI chipselect legacy bindings"
> 
> did introduce logic to centrally handle the legacy spi-cs-high property
> in combination with cs-gpios. This assumes that the polarity
> of the CS has to be inverted if spi-cs-high is missing, even
> and especially if non-legacy GPIO_ACTIVE_HIGH is specified.
> 
> The DTS for the GTA04 was orginally introduced under the assumption
> that there is no need for spi-cs-high if the gpio is defined with
> proper polarity GPIO_ACTIVE_HIGH.

Given that spi-cs-high is called legacy, that would imply that DT's 
should not have to use spi-cs-high.

> This was not a problem until gpiolib changed the interpretation of
> GPIO_ACTIVE_HIGH and missing spi-cs-high.

Then we should fix gpiolib...

> The effect is that the missing spi-cs-high is now interpreted as CS being
> low (despite GPIO_ACTIVE_HIGH) which turns off the SPI interface when the
> panel is to be programmed by the panel driver.
> 
> Therefore, we have to add the redundant and legacy spi-cs-high property
> to properly pass through the legacy handler.
> 
> Since this is nowhere documented in the bindings, we add some words of
> WARNING.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-bus.txt | 6 ++++++
>  arch/arm/boot/dts/omap3-gta04.dtsi                | 1 +
>  2 files changed, 7 insertions(+)
