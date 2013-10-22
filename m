From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [RFCv3 7/7] ARM: dts: N900: Add SSI information
Date: Tue, 22 Oct 2013 14:48:45 +0200
Message-ID: <5266742D.9050604@baylibre.com>
References: <1381091235-18293-1-git-send-email-sre@debian.org> <1381091235-18293-8-git-send-email-sre@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1381091235-18293-8-git-send-email-sre@debian.org>
Sender: linux-doc-owner@vger.kernel.org
To: Sebastian Reichel <sre@debian.org>, Sebastian Reichel <sre@ring0.de>, Linus Walleij <linus.walleij@linaro.org>, Shubhrajyoti Datta <omaplinuxkernel@gmail.com>, Carlos Chinea <cch.devel@gmail.com>, Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Landley <rob@landley.net>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, =?UTF-8?B?J1BhbGkgUm9ow6FyJw==?= <pali.rohar@gmail.com>, =?UTF-8?B?J9CY0LI=?= =?UTF-8?B?0LDQudC70L4g0JTQuNC80LjRgtGA0L7Qsic=?= <freemangordon@abv.bg>, Joni Lapilainen <joni.lapilainen@gmail.com>
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

Thanks to Tony, I've just realized that I missed all your patches, that=
=20
for some reason ended-up in my junk folder :-(

That being said, I cannot apply any of your DTS patches! What base=20
branch are you using?

Could you repost all your pending DTS patches in one series rebased on=20
top of my for_3.13/dts?

Thanks,
Benoit

On 06/10/2013 22:27, Sebastian Reichel wrote:
> Add SSI device tree data for OMAP3 and Nokia N900.
>
> Signed-off-by: Sebastian Reichel <sre@debian.org>
> ---
>   arch/arm/boot/dts/omap3-n900.dts | 12 ++++++++++
>   arch/arm/boot/dts/omap3.dtsi     | 47 +++++++++++++++++++++++++++++=
+++++++++++
>   2 files changed, 59 insertions(+)
>
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/oma=
p3-n900.dts
> index 0582356..0fbb77e 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -186,6 +186,18 @@
>   	power =3D <50>;
>   };
>
> +&ssi_port1 {
> +	ti,ssi-cawake-gpio =3D <&gpio5 23 GPIO_ACTIVE_HIGH>; /* 151 */
> +
> +	ssi-char {
> +		compatible =3D "ssi-char";
> +	};
> +};
> +
> +&ssi_port2 {
> +	status =3D "disabled";
> +};
> +
>   &uart1 {
>   	pinctrl-names =3D "default";
>   	pinctrl-0 =3D <&uart1_pins>;
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.d=
tsi
> index 7d95cda..9f60b82 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -532,5 +532,52 @@
>   			num-eps =3D <16>;
>   			ram-bits =3D <12>;
>   		};
> +
> +		ssi: ssi-controller@48058000 {
> +			compatible =3D "ti,omap3-ssi";
> +			ti,hwmods =3D "ssi";
> +
> +			reg =3D <0x48058000 0x1000>,
> +			      <0x48059000 0x1000>;
> +			reg-names =3D "sys",
> +				    "gdd";
> +
> +			interrupts =3D <71>;
> +			interrupt-names =3D "gdd_mpu";
> +
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges;
> +
> +			ssi_port1: ssi-port@0 {
> +				compatible =3D "ti,omap3-ssi-port";
> +
> +				reg =3D <0x4805a000 0x800>,
> +				      <0x4805a800 0x800>;
> +				reg-names =3D "tx",
> +					    "rx";
> +
> +				interrupt-parent =3D <&intc>;
> +				interrupts =3D <67>,
> +					     <68>;
> +				interrupt-names =3D "mpu_irq0",
> +						  "mpu_irq1";
> +			};
> +
> +			ssi_port2: ssi-port@1 {
> +				compatible =3D "ti,omap3-ssi-port";
> +
> +				reg =3D <0x4805b000 0x800>,
> +				      <0x4805b800 0x800>;
> +				reg-names =3D "tx",
> +					    "rx";
> +
> +				interrupt-parent =3D <&intc>;
> +				interrupts =3D <69>,
> +					     <70>;
> +				interrupt-names =3D "mpu_irq0",
> +						  "mpu_irq1";
> +			};
> +		};
>   	};
>   };
>


--=20
Beno=C3=AEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
