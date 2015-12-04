From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/7] ARM: dts: Update edma bindings on dm814x to use
 edma_xbar
Date: Fri, 4 Dec 2015 11:18:07 +0200
Message-ID: <56615A4F.3080207@ti.com>
References: <1449192335-10137-1-git-send-email-tony@atomide.com>
 <1449192335-10137-3-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449192335-10137-3-git-send-email-tony@atomide.com>
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
> The edma is the same as on am33xx, except it has four tptc
> instances. And we need the edma_xbar for at least mmc3, so
> let's use the edma_xbar and the new binding as suggested by
> Peter Ujfalusi <peter.ujfalusi@ti.com>.
> =

> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  arch/arm/boot/dts/dm814x.dtsi | 68 ++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 58 insertions(+), 10 deletions(-)
> =

> diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.dtsi
> index ca92346..9d81980e 100644
> --- a/arch/arm/boot/dts/dm814x.dtsi
> +++ b/arch/arm/boot/dts/dm814x.dtsi
> @@ -126,8 +126,8 @@
>  				interrupts =3D <65>;
>  				ti,spi-num-cs =3D <4>;
>  				ti,hwmods =3D "mcspi1";
> -				dmas =3D <&edma 16 &edma 17
> -					&edma 18 &edma 19>;
> +				dmas =3D <&edma 16 0 &edma 17 0
> +					&edma 18 0 &edma 19 0>;
>  				dma-names =3D "tx0", "rx0", "tx1", "rx1";
>  			};
>  =

> @@ -145,7 +145,7 @@
>  				reg =3D <0x20000 0x2000>;
>  				clock-frequency =3D <48000000>;
>  				interrupts =3D <72>;
> -				dmas =3D <&edma 26 &edma 27>;
> +				dmas =3D <&edma 26 0 &edma 27 0>;
>  				dma-names =3D "tx", "rx";
>  			};
>  =

> @@ -155,7 +155,7 @@
>  				reg =3D <0x22000 0x2000>;
>  				clock-frequency =3D <48000000>;
>  				interrupts =3D <73>;
> -				dmas =3D <&edma 28 &edma 29>;
> +				dmas =3D <&edma 28 0 &edma 29 0>;
>  				dma-names =3D "tx", "rx";
>  			};
>  =

> @@ -165,7 +165,7 @@
>  				reg =3D <0x24000 0x2000>;
>  				clock-frequency =3D <48000000>;
>  				interrupts =3D <74>;
> -				dmas =3D <&edma 30 &edma 31>;
> +				dmas =3D <&edma 30 0 &edma 31 0>;
>  				dma-names =3D "tx", "rx";
>  			};
>  =

> @@ -205,6 +205,14 @@
>  					};
>  				};
>  =

> +				edma_xbar: dma-router@f90 {
> +					compatible =3D "ti,am335x-edma-crossbar";
> +					reg =3D <0xf90 0x40>;
> +					#dma-cells =3D <3>;
> +					dma-requests =3D <32>;
> +					dma-masters =3D <&edma>;
> +				};
> +
>  				/*
>  				 * Note that silicon revision 2.1 and older
>  				 * require input enabled (bit 18 set) for all
> @@ -272,12 +280,52 @@
>  		};
>  =

>  		edma: edma@49000000 {
> -			compatible =3D "ti,edma3";
> -			ti,hwmods =3D "tpcc", "tptc0", "tptc1", "tptc2";
> -			reg =3D	<0x49000000 0x10000>,
> -				<0x44e10f90 0x40>;
> +			compatible =3D "ti,edma3-tpcc";
> +			ti,hwmods =3D "tpcc";
> +			reg =3D	<0x49000000 0x10000>;
> +			reg-names =3D "edma3_cc";
>  			interrupts =3D <12 13 14>;
> -			#dma-cells =3D <1>;
> +			interrupt-names =3D "edma3_ccint", "emda3_mperr",
> +					  "edma3_ccerrint";
> +			dma-requests =3D <64>;
> +			#dma-cells =3D <2>;
> +
> +			ti,tptcs =3D <&edma_tptc0 7>, <&edma_tptc1 5>,
> +				   <&edma_tptc2 3>, <&edma_tptc3 0>;
> +
> +			ti,edma-memcpy-channels =3D /bits/ 16 <20 21>;
> +		};
> +
> +		edma_tptc0: tptc@49800000 {
> +			compatible =3D "ti,edma3-tptc";
> +			ti,hwmods =3D "tptc0";
> +			reg =3D	<0x49800000 0x100000>;
> +			interrupts =3D <112>;
> +			interrupt-names =3D "edma3_tcerrint";
> +		};
> +
> +		edma_tptc1: tptc@49900000 {
> +			compatible =3D "ti,edma3-tptc";
> +			ti,hwmods =3D "tptc1";
> +			reg =3D	<0x49900000 0x100000>;
> +			interrupts =3D <113>;
> +			interrupt-names =3D "edma3_tcerrint";
> +		};
> +
> +		edma_tptc2: tptc@49a00000 {
> +			compatible =3D "ti,edma3-tptc";
> +			ti,hwmods =3D "tptc2";
> +			reg =3D	<0x49a00000 0x100000>;
> +			interrupts =3D <114>;
> +			interrupt-names =3D "edma3_tcerrint";
> +		};
> +
> +		edma_tptc3: tptc@49b00000 {
> +			compatible =3D "ti,edma3-tptc";
> +			ti,hwmods =3D "tptc3";
> +			reg =3D	<0x49b00000 0x100000>;
> +			interrupts =3D <115>;
> +			interrupt-names =3D "edma3_tcerrint";
>  		};
>  =

>  		/* See TRM "Table 1-318. L4HS Instance Summary" */
> =



-- =

P=E9ter
