From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC 3/7] dt: bindings: Add nokia-bluetooth
Date: Tue, 16 Aug 2016 08:51:55 -0500
Message-ID: <20160816135155.GA20948@rob-hp-laptop>
References: <1471058078-5579-1-git-send-email-sre@kernel.org>
 <1471058078-5579-4-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471058078-5579-4-git-send-email-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, Marcel Holtmann <marcel@holtmann.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Ville Tervo <ville.tervo@iki.fi>, Filip =?utf-8?Q?Matijevi=C4=87?= <filip.matijevic.pz@gmail.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, ivo.g.dimitrov.75@gmail.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Sat, Aug 13, 2016 at 05:14:34AM +0200, Sebastian Reichel wrote:
> ---
>  .../devicetree/bindings/net/nokia-bluetooth.txt    | 43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
> new file mode 100644
> index 000000000000..a0fceabb4cce
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
> @@ -0,0 +1,43 @@
> +Nokia bluetooth UART devices
> +------
> +
> +Some vendors have custom versions of their chips, that can be found in Nokia
> +devices. These chips are controlled differently, than the non-Nokia version,
> +so a different binding is required. All chips listed here implement the Nokia
> +H4+ protocol.
> +
> +Required properties:
> +
> +  - compatible: should be one of the following:
> +	* "nokia,brcm,bcm2048"
> +	* "nokia,ti,wl1271-bluetooth"

Perhaps these should be 2 separate strings. Something like 
'"nokia,n900-bt", "brcm,bcm2048"'. However, if they are in no way 
compatible with the default version from the vendors, then just a single 
string is fine, but it doesn't need to be aligned to the vendor 
compatible string. So just "nokia,n900-bcm2048" or similar is fine.

> +  - reset-gpios:		Should specify the gpio for bluetooth reset
> +  - host-wakeup-gpios:		Should specify the gpio for host wakeup

Should be interrupt instead?

> +  - bluetooth-wakeup-gpios:	Should specify the gpio for bluetooth wakeup

State direction and active state for gpios.

> +  - clock-names:		Should be "sysclk"
> +  - clocks:			Should contain a clock phandle for system clock
> +
> +Example:
> +
> +/ {
> +	/* controlled (enabled/disabled) directly by wl1271 */
> +	vctcxo: vctcxo {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <38400000>;
> +	};
> +};
> +
> +&uart2 {

I want to see a common serial device binding doc before accepting any 
device bindings. It's not going to say much initially other than devices 
are child nodes of uarts. Perhaps something on baudrate settings.

> +	bluetooth {
> +		compatible = "nokia,ti,wl1271-bluetooth";
> +
> +		reset-gpios = <&gpio1 26 GPIO_ACTIVE_HIGH>; /* 26 */
> +		host-wakeup-gpios = <&gpio4 5 GPIO_ACTIVE_HIGH>; /* 101 */
> +		bluetooth-wakeup-gpios = <&gpio2 5 GPIO_ACTIVE_HIGH>; /* 37 */
> +
> +		clocks = <&vctcxo>;
> +		clock-names = "sysclk";
> +	};
> +
> +};
> -- 
> 2.8.1
> 
