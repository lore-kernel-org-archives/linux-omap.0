From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH] ARM: dts: am437x-gp-evm: Add support for buzzer
Date: Wed, 2 Aug 2017 15:00:49 +0530
Message-ID: <c135a805-868a-87fc-ce78-b4e49139211d@ti.com>
References: <1497935361-11019-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1497935361-11019-1-git-send-email-faiz_abbas@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, linux@armlinux.org.uk, linux-kernel@vger.kernel.org, robh+dt@kernel.org, bcousson@baylibre.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Tuesday 20 June 2017 10:39 AM, Faiz Abbas wrote:
> Add support for onboard gpio buzzer. It works using
> the gpio-beeper driver. Pinmux entries for GPIO
> controlling the buzzer are also added.

Gentle ping

Regards,
Faiz
> 
> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
> ---
>  arch/arm/boot/dts/am437x-gp-evm.dts | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
> index 397e98b..24cdf6d 100644
> --- a/arch/arm/boot/dts/am437x-gp-evm.dts
> +++ b/arch/arm/boot/dts/am437x-gp-evm.dts
> @@ -149,6 +149,13 @@
>  			system-clock-frequency = <12000000>;
>  		};
>  	};
> +
> +	beeper: beeper {
> +		compatible = "gpio-beeper";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&beeper_pins>;
> +		gpios = <&gpio4 12 GPIO_ACTIVE_HIGH>;
> +	};
>  };
>  
>  &am43xx_pinmux {
> @@ -510,6 +517,13 @@
>  			AM4372_IOPAD(0x974, PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* uart0_txd.uart0_txd */
>  		>;
>  	};
> +
> +	beeper_pins: beeper_pins {
> +		pinctrl-single,pins = <
> +			AM4372_IOPAD(0x9e0, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* cam1_field.gpio4_12 */
> +		>;
> +	};
> +
>  };
>  
>  &uart0 {
> 
