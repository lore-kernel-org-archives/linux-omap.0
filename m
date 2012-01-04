From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v2 07/10] arm/dts: omap4-panda: Add twl6030 and i2c EEPROM
Date: Wed, 4 Jan 2012 11:14:30 -0700
Message-ID: <20120104181430.GN15503@ponder.secretlab.ca>
References: <1323439361-1647-1-git-send-email-b-cousson@ti.com>
 <1323439361-1647-8-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1323439361-1647-8-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Dec 09, 2011 at 03:02:38PM +0100, Benoit Cousson wrote:
> Update pandaboard dts file with required clock frequencies
> for the i2c client devices existing on pandaboard.
> 
> Add the twl6030 node in i2c1 controller.
> 
> This is the minimal support needed to boot OMAP4 boards
> without any crash.
> The support for all the features included in this MFD will be
> added later.
> 
> Add a generic i2c EEPROM entry.
> 
> Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Acked-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> ---
>  arch/arm/boot/dts/omap4-panda.dts |   45 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index 9755ad5..b66bcd6 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -18,3 +18,48 @@
>  		reg = <0x80000000 0x40000000>; /* 1 GB */
>  	};
>  };
> +
> +&i2c1 {
> +	clock-frequency = <400000>;
> +
> +	/*
> +	 * Integrated Power Management Chip
> +	 * http://www.ti.com/lit/ds/symlink/twl6030.pdf
> +	 */
> +	twl@48 {
> +		compatible = "ti,twl6030";
> +		reg = <0x48>;
> +		/* SPI = 0, IRQ# = 7, 4 = active high level-sensitive */
> +		interrupts = <0 7 4>; /* IRQ_SYS_1N cascaded to gic */
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		interrupt-parent = <&gic>;
> +
> +		/* twl is a MFD, so it will contain a bunch of sub-ips */
> +		rtc {
> +			compatible = "ti,twl4030-rtc";
> +			interrupts = <11>;
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	clock-frequency = <400000>;
> +};
> +
> +&i2c3 {
> +	clock-frequency = <100000>;
> +
> +	/*
> +	 * Display monitor features are burnt in their EEPROM as EDID data.
> +	 * The EEPROM is connected as I2C slave device.
> +	 */
> +	eeprom@50 {
> +		compatible = "ti,eeprom";
> +		reg = <0x50>;
> +	};
> +};
> +
> +&i2c4 {
> +	clock-frequency = <400000>;
> +};
> -- 
> 1.7.0.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
