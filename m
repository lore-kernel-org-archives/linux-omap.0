From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 7/7] ARM: dts: Enable emmc on hp t410
Date: Fri, 4 Dec 2015 11:20:57 +0200
Message-ID: <56615AF9.5000208@ti.com>
References: <1449192335-10137-1-git-send-email-tony@atomide.com>
 <1449192335-10137-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449192335-10137-8-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 12/04/2015 03:25 AM, Tony Lindgren wrote:
> There's a 2GB emmc on hp t410 that's wired to the sd_2 interface.
> Note that we also need to configure the evtmux using edma_xbar for
> edma channels.
> =

> Signed-off-by: Tony Lindgren <tony@atomide.com>

One question inlined for the mmc3, other than that:
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  arch/arm/boot/dts/dm8148-t410.dts | 35 +++++++++++++++++++++++++++++++++=
++
>  1 file changed, 35 insertions(+)
> =

> diff --git a/arch/arm/boot/dts/dm8148-t410.dts b/arch/arm/boot/dts/dm8148=
-t410.dts
> index 79838dd..d1927a7 100644
> --- a/arch/arm/boot/dts/dm8148-t410.dts
> +++ b/arch/arm/boot/dts/dm8148-t410.dts
> @@ -15,6 +15,13 @@
>  		device_type =3D "memory";
>  		reg =3D <0x80000000 0x40000000>;	/* 1 GB */
>  	};
> +
> +	vmmcsd_fixed: fixedregulator@0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vmmcsd_fixed";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +	};
>  };
>  =

>  &cpsw_emac0 {
> @@ -26,3 +33,31 @@
>  	phy_id =3D <&davinci_mdio>, <1>;
>  	phy-mode =3D "rgmii";
>  };
> +
> +&mmc3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&sd2_pins>;
> +	vmmc-supply =3D <&vmmcsd_fixed>;
> +	bus-width =3D <8>;
> +	dmas =3D <&edma_xbar 8 0 1	/* use SDTXEVT1 instead of MCASP0TX */
> +		&edma_xbar 9 0 2>;	/* use SDRXEVT1 instead of MCASP0RX */
> +	dma-names =3D "tx", "rx";

Do you happened to know how the audio is connected on the board?
The DM814x-EVM seams to be using McASP2 with aic3106 so it is possible that=
 HP
copied the design from there...

> +};
> +
> +&pincntl {
> +	sd2_pins: pinmux_sd2_pins {
> +		pinctrl-single,pins =3D <
> +			DM814X_IOPAD(0x09c0, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[7] */
> +			DM814X_IOPAD(0x09c4, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[6] */
> +			DM814X_IOPAD(0x09c8, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[5] */
> +			DM814X_IOPAD(0x09cc, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[4] */
> +			DM814X_IOPAD(0x09d0, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[3] */
> +			DM814X_IOPAD(0x09d4, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[2] */
> +			DM814X_IOPAD(0x09d8, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[1] */
> +			DM814X_IOPAD(0x09dc, PIN_INPUT_PULLUP | 0x1)	/* SD2_DAT[0] */
> +			DM814X_IOPAD(0x09e0, PIN_INPUT | 0x1)		/* SD2_CLK */
> +			DM814X_IOPAD(0x09f4, PIN_INPUT_PULLUP | 0x2)	/* SD2_CMD */
> +			DM814X_IOPAD(0x0920, PIN_INPUT | 40)	/* SD2_SDCD */
> +			>;
> +	};
> +};
> =



-- =

P=E9ter
