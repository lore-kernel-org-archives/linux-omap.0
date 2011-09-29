From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 12/13] arm/dts: omap3-beagle: Add twl4030 and i2c EEPROM
Date: Thu, 29 Sep 2011 12:25:29 -0500
Message-ID: <20110929172529.GE6800@ponder.secretlab.ca>
References: <1317055821-20652-1-git-send-email-b-cousson@ti.com>
	<1317055821-20652-13-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1317055821-20652-13-git-send-email-b-cousson-l0cyMroinI0@public.gmane.org>
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
Cc: khilman-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, "G, Manjunath Kondaiah" <manjugk-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 26, 2011 at 06:50:20PM +0200, Benoit Cousson wrote:
> Add required clock frequencies for the i2c client devices existing
> on beagle board.
> 
> Add the twl4030 basic description with only the twl_rtc module.
> 
> Add the EEPROM node.
> 
> Based on original patch from Manju:
> http://www.spinics.net/lists/linux-omap/msg55831.html
> 
> Signed-off-by: Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>
> Cc: G, Manjunath Kondaiah <manjugk-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/omap3-beagle.dts |   38 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 38 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 9486be6..a65f39d 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -27,3 +27,41 @@
>  		reg = <0x80000000 0x20000000>; /* 512 MB */
>  	};
>  };
> +
> +&i2c1 {
> +	clock-frequency = <2600000>;
> +
> +	/*
> +	 * Integrated Power Management Chip
> +	 */
> +	twl@48 {
> +		compatible = "ti,twl4030";
> +		reg = <0x48>;
> +		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		interrupt-parent = <&intc>;
> +
> +		twl_rtc {

Nit: use the generic names recommended practise for node names (in
this case, simply 'rtc' sounds appropriate, and don't use underscores
(it's not forbidden, just doesn't match the style.

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
> +	 * Display monitor features are burnt in the EEPROM
> +	 * as EDID data.
> +	 */
> +	eeprom@50 {
> +		compatible = "ti,eeprom";
> +		reg = <0x50>;
> +	};
> +};
> -- 
> 1.7.0.4
> 
