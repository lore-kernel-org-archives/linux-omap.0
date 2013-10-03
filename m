From: Roger Quadros <rogerq@ti.com>
Subject: Re: [PATCH v3 05/10] ARM: dts: omap3-beagle: Use reset-gpios for
 hsusb2_reset
Date: Thu, 3 Oct 2013 13:34:37 +0300
Message-ID: <524D483D.9040907@ti.com>
References: <1380012836-29900-1-git-send-email-rogerq@ti.com>
 <1380012836-29900-6-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1380012836-29900-6-git-send-email-rogerq@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: bcousson@baylibre.com
Cc: devicetree@vger.kernel.org, tony@atomide.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, balbi@ti.com, broonie@kernel.org, p.zabel@pengutronix.de, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Benoit,

Could you please take the device tree related patches [5 to 10] in this series?
Thanks.

cheers,
-roger

On 09/24/2013 11:53 AM, Roger Quadros wrote:
> We no longer need to model the RESET line as a regulator since
> the USB phy-nop driver accepts "reset-gpios" property.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  arch/arm/boot/dts/omap3-beagle.dts |   13 +------------
>  1 files changed, 1 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index dfd8310..71bde47 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -44,17 +44,6 @@
>  		};
>  	};
>  
> -	/* HS USB Port 2 RESET */
> -	hsusb2_reset: hsusb2_reset_reg {
> -		compatible = "regulator-fixed";
> -		regulator-name = "hsusb2_reset";
> -		regulator-min-microvolt = <3300000>;
> -		regulator-max-microvolt = <3300000>;
> -		gpio = <&gpio5 19 0>;	/* gpio_147 */
> -		startup-delay-us = <70000>;
> -		enable-active-high;
> -	};
> -
>  	/* HS USB Port 2 Power */
>  	hsusb2_power: hsusb2_power_reg {
>  		compatible = "regulator-fixed";
> @@ -68,7 +57,7 @@
>  	/* HS USB Host PHY on PORT 2 */
>  	hsusb2_phy: hsusb2_phy {
>  		compatible = "usb-nop-xceiv";
> -		reset-supply = <&hsusb2_reset>;
> +		reset-gpios = <&gpio5 19 GPIO_ACTIVE_LOW>;	/* gpio_147 */
>  		vcc-supply = <&hsusb2_power>;
>  	};
>  
> 
