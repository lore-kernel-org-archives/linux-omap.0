From: Benoit Cousson <bcousson@baylibre.com>
Subject: Re: [PATCH RFC] ARM/dts: am335x-boneblack: Add HDMI audio support
Date: Tue, 19 Nov 2013 14:02:50 +0100
Message-ID: <528B617A.4080102@baylibre.com>
References: <cover.1384863282.git.jsarha@ti.com> <18d71a32fb46d34197fd2e0ec5dc8ebc36371704.1384863282.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:46924 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752004Ab3KSNCz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Nov 2013 08:02:55 -0500
Received: by mail-ee0-f41.google.com with SMTP id t10so1986613eei.0
        for <linux-omap@vger.kernel.org>; Tue, 19 Nov 2013 05:02:52 -0800 (PST)
In-Reply-To: <18d71a32fb46d34197fd2e0ec5dc8ebc36371704.1384863282.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org

Hi Jyri,

A side question related to audio cape support on BBB. In the "official"=
=20
3.8.13 CircuitCo version the HDMI audio support was breaking the=20
audio-cape support due to some bad hacks in the mcasp driver.

Is this still the case with you series?

Thanks,
Benoit


On 19/11/2013 13:21, Jyri Sarha wrote:
> Adds mcasp0_pins, clk_mcasp0_fixed, clk_mcasp0, mcasp0, hdmi_audio,
> and sound nodes.
>
> Signed-off-by: Jyri Sarha <jsarha@ti.com>
> ---
>   arch/arm/boot/dts/am335x-boneblack.dts |   52 +++++++++++++++++++++=
+++++++++++
>   1 file changed, 52 insertions(+)
>
> diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/d=
ts/am335x-boneblack.dts
> index 6b71ad9..b5a2404 100644
> --- a/arch/arm/boot/dts/am335x-boneblack.dts
> +++ b/arch/arm/boot/dts/am335x-boneblack.dts
> @@ -60,12 +60,35 @@
>   			0x1b0 0x03      /* xdma_event_intr0, OMAP_MUX_MODE3 | AM33XX_PIN=
_OUTPUT */
>   		>;
>   	};
> +
> +	mcasp0_pins: mcasp0_pins {
> +		pinctrl-single,pins =3D <
> +			0x1ac (PIN_INPUT_PULLUP | MUX_MODE0) /* mcasp0_ahclkx.mcasp0_ahcl=
kx */
> +			0x19c (PIN_OUTPUT_PULLDOWN | MUX_MODE2) /* mcasp0_ahclkr.mcasp0_a=
xr2 */
> +			0x194 (PIN_OUTPUT_PULLUP | MUX_MODE0) /* mcasp0_fsx.mcasp0_fsx */
> +			0x190 (PIN_OUTPUT_PULLDOWN | MUX_MODE0)	/* mcasp0_aclkx.mcasp0_ac=
lkx */
> +			0x06c (PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpmc_a11.gpio1_27 */
> +		>;
> +	};
>   };
>
>   &lcdc {
>   	status =3D "okay";
>   };
>
> +&mcasp0	{
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mcasp0_pins>;
> +	status =3D "okay";
> +	op-mode =3D <0>;	/* MCASP_IIS_MODE */
> +	tdm-slots =3D <2>;
> +	serial-dir =3D <	/* 0: INACTIVE, 1: TX, 2: RX */
> +			0 0 1 0
> +		>;
> +	tx-num-evt =3D <1>;
> +	rx-num-evt =3D <1>;
> +};
> +
>   / {
>   	hdmi {
>   		compatible =3D "ti,tilcdc,slave";
> @@ -75,4 +98,33 @@
>   		pinctrl-1 =3D <&nxp_hdmi_bonelt_off_pins>;
>   		status =3D "okay";
>   	};
> +
> +	clk_mcasp0_fixed: clk_mcasp0_fixed {
> +		#clock-cells =3D <0>;
> +		compatible =3D "fixed-clock";
> +		clock-frequency =3D <24576000>;
> +	};
> +
> +	clk_mcasp0: clk_mcasp0 {
> +		#clock-cells =3D <0>;
> +		compatible =3D "gpio-clock";
> +		clocks =3D <&clk_mcasp0_fixed>;
> +		enable-gpios =3D <&gpio1 27 GPIO_ACTIVE_HIGH>; /* BeagleBone Black=
 Clk enable on GPIO1_27 */
> +	};
> +
> +	hdmi_audio: hdmi_audio@0 {
> +	       compatible =3D "linux,hdmi-audio";
> +	       status =3D "okay";
> +	};
> +
> +	sound {
> +		compatible =3D "ti,am33xx-beaglebone-black";
> +		ti,model =3D "TI BeagleBone Black";
> +		ti,audio-codec =3D <&hdmi_audio>;
> +		ti,mcasp-controller =3D <&mcasp0>;
> +		ti,audio-routing =3D
> +			"HDMI Out",	"TX";
> +		clocks =3D <&clk_mcasp0>;
> +		clock-names =3D "ti,codec-clock";
> +	};
>   };
>


--=20
Beno=EEt Cousson
BayLibre
Embedded Linux Technology Lab
www.baylibre.com
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
