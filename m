From: Luca Coelho <luca@coelho.fi>
Subject: Re: [PATCH 1/2] ARM: dts: Fix muxing and regulator for wl12xx on
 the SDIO bus for pandaboard
Date: Tue, 17 Sep 2013 09:26:54 +0300
Message-ID: <1379399214.4223.123.camel@porter.coelho.fi>
References: <20130913190811.24617.97699.stgit@localhost>
 <20130913190953.24617.46506.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20130913190953.24617.46506.stgit@localhost>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: devicetree-discuss@lists.ozlabs.org, Rajendra Nayak <rnayak@ti.com>, Benoit Cousson <bcousson@baylibre.com>, Paolo Pisati <p.pisati@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Tony,

Both patches look good to me, though I didn't have the time to retest
them.

--
Cheers,
Luca.

On Fri, 2013-09-13 at 12:09 -0700, Tony Lindgren wrote:
> Commit b42b9181 (ARM: OMAP2+: Remove board-omap4panda.c)
> removed legacy booting in favor of device tree based booting
> for pandaboard. That caused the WLAN to stop working as the
> related .dts entries fell through the cracks.
> 
> The legacy muxing was setting pulls for GPIO 48 and 49, so let's
> keep that behaviour for now to avoid further regressions for
> BT and FM. Also input logic was enabled for MMC CLK line, but
> I've verified that the input logic we don't need enabled for
> CLK line as it's not bidirectional.
> 
> Also, we want to use non-removable instead of ti,non-removable
> as the ti,non-removable also sets no_regulator_off_init which
> is really not what we want as then wl12xx won't get powered
> up and down which is needed for resetting it.
> 
> Note that looks like the WLAN interface fails to come up after
> a warm reset, but that most likely was also happening with
> the legacy booting and needs a separate fix.
> 
> Cc: Paolo Pisati <p.pisati@gmail.com>
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Cc: Rajendra Nayak <rnayak@ti.com>
> Cc: Luciano Coelho <luca@coelho.fi>
> Cc: devicetree-discuss@lists.ozlabs.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/boot/dts/omap4-panda-common.dtsi |   46 ++++++++++++++++++++++++++++-
>  1 file changed, 45 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda-common.dtsi b/arch/arm/boot/dts/omap4-panda-common.dtsi
> index faa95b5..814ab67 100644
> --- a/arch/arm/boot/dts/omap4-panda-common.dtsi
> +++ b/arch/arm/boot/dts/omap4-panda-common.dtsi
> @@ -107,6 +107,19 @@
>  	 */
>  		clock-frequency = <19200000>;
>  	};
> +
> +	/* regulator for wl12xx on sdio5 */
> +	wl12xx_vmmc: wl12xx_vmmc {
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wl12xx_gpio>;
> +		compatible = "regulator-fixed";
> +		regulator-name = "vwl1271";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +		gpio = <&gpio2 11 0>;
> +		startup-delay-us = <70000>;
> +		enable-active-high;
> +	};
>  };
>  
>  &omap4_pmx_wkup {
> @@ -235,6 +248,33 @@
>  			0x1c (PIN_OUTPUT | MUX_MODE3)	/* gpio_wk8 */
>  		>;
>  	};
> +
> +	/*
> +	 * wl12xx GPIO outputs for WLAN_EN, BT_EN, FM_EN, BT_WAKEUP
> +	 * REVISIT: Are the pull-ups needed for GPIO 48 and 49?
> +	 */
> +	wl12xx_gpio: pinmux_wl12xx_gpio {
> +		pinctrl-single,pins = <
> +			0x26 (PIN_OUTPUT | MUX_MODE3)		/* gpmc_a19.gpio_43 */
> +			0x2c (PIN_OUTPUT | MUX_MODE3)		/* gpmc_a22.gpio_46 */
> +			0x30 (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_a24.gpio_48 */
> +			0x32 (PIN_OUTPUT_PULLUP | MUX_MODE3)	/* gpmc_a25.gpio_49 */
> +		>;
> +	};
> +
> +	/* wl12xx GPIO inputs and SDIO pins */
> +	wl12xx_pins: pinmux_wl12xx_pins {
> +		pinctrl-single,pins = <
> +			0x38 (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs2.gpio_52 */
> +			0x3a (PIN_INPUT | MUX_MODE3)		/* gpmc_ncs3.gpio_53 */
> +			0x108 (PIN_OUTPUT | MUX_MODE0)		/* sdmmc5_clk.sdmmc5_clk */
> +			0x10a (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_cmd.sdmmc5_cmd */
> +			0x10c (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat0.sdmmc5_dat0 */
> +			0x10e (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat1.sdmmc5_dat1 */
> +			0x110 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat2.sdmmc5_dat2 */
> +			0x112 (PIN_INPUT_PULLUP | MUX_MODE0)	/* sdmmc5_dat3.sdmmc5_dat3 */
> +		>;
> +	};
>  };
>  
>  &i2c1 {
> @@ -314,8 +354,12 @@
>  };
>  
>  &mmc5 {
> -	ti,non-removable;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&wl12xx_pins>;
> +	vmmc-supply = <&wl12xx_vmmc>;
> +	non-removable;
>  	bus-width = <4>;
> +	cap-power-off-card;
>  };
>  
>  &emif1 {
> 
