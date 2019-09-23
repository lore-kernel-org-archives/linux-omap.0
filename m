From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] DTS: ARM: gta04: introduce legacy spi-cs-high to make
 display work again
Date: Mon, 23 Sep 2019 10:34:41 -0700
Message-ID: <20190923173441.GV5610@atomide.com>
References: <c031340840daba810bb2a612c35eea7fab307e56.1568995874.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c031340840daba810bb2a612c35eea7fab307e56.1568995874.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org, linus.walleij@linaro.org, stable@vger.kernel.org, linux-spi@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com
List-Id: linux-omap@vger.kernel.org

* H. Nikolaus Schaller <hns@goldelico.com> [190920 09:12]:
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
> 
> This was not a problem until gpiolib changed the interpretation of
> GPIO_ACTIVE_HIGH and missing spi-cs-high.
> 
> The effect is that the missing spi-cs-high is now interpreted as CS being
> low (despite GPIO_ACTIVE_HIGH) which turns off the SPI interface when the
> panel is to be programmed by the panel driver.
> 
> Therefore, we have to add the redundant and legacy spi-cs-high property
> to properly activate CS.

Thanks applying into fixes.

Tony
