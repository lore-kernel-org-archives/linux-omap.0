From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH V2 1/2] ARM: dts: OMAP2+: Add SDMA Audio
	IPs bindings
Date: Mon, 11 Mar 2013 15:19:22 +0100
Message-ID: <513DE7EA.4080805@ti.com>
References: <1362988223-22455-1-git-send-email-s-guiriec@ti.com>
 <1362988223-22455-2-git-send-email-s-guiriec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1362988223-22455-2-git-send-email-s-guiriec@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <s-guiriec@ti.com>
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-omap@vger.kernel.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: linux-omap@vger.kernel.org

On 03/11/2013 08:50 AM, Sebastien Guiriec wrote:
> Populate DMA client information for McBSP DMIC and McPDM periperhal on
> OMAP2+ devices.

Looks good to me:
Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
> ---
>  arch/arm/boot/dts/omap2420.dtsi |    6 ++++++
>  arch/arm/boot/dts/omap2430.dtsi |   15 +++++++++++++++
>  arch/arm/boot/dts/omap3.dtsi    |   15 +++++++++++++++
>  arch/arm/boot/dts/omap4.dtsi    |   17 +++++++++++++++++
>  arch/arm/boot/dts/omap5.dtsi    |   14 ++++++++++++++
>  5 files changed, 67 insertions(+)
> =

> diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420=
.dtsi
> index af65609..45930f2 100644
> --- a/arch/arm/boot/dts/omap2420.dtsi
> +++ b/arch/arm/boot/dts/omap2420.dtsi
> @@ -37,6 +37,9 @@
>  				     <60>; /* RX interrupt */
>  			interrupt-names =3D "tx", "rx";
>  			ti,hwmods =3D "mcbsp1";
> +			dmas =3D <&sdma 31>,
> +			       <&sdma 32>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp2: mcbsp@48076000 {
> @@ -47,6 +50,9 @@
>  				     <63>; /* RX interrupt */
>  			interrupt-names =3D "tx", "rx";
>  			ti,hwmods =3D "mcbsp2";
> +			dmas =3D <&sdma 33>,
> +			       <&sdma 34>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		timer1: timer@48028000 {
> diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430=
.dtsi
> index c392445..cfe7ed9 100644
> --- a/arch/arm/boot/dts/omap2430.dtsi
> +++ b/arch/arm/boot/dts/omap2430.dtsi
> @@ -40,6 +40,9 @@
>  			interrupt-names =3D "common", "tx", "rx", "rx_overflow";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp1";
> +			dmas =3D <&sdma 31>,
> +			       <&sdma 32>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp2: mcbsp@48076000 {
> @@ -52,6 +55,9 @@
>  			interrupt-names =3D "common", "tx", "rx";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp2";
> +			dmas =3D <&sdma 33>,
> +			       <&sdma 34>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp3: mcbsp@4808c000 {
> @@ -64,6 +70,9 @@
>  			interrupt-names =3D "common", "tx", "rx";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp3";
> +			dmas =3D <&sdma 17>,
> +			       <&sdma 18>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp4: mcbsp@4808e000 {
> @@ -76,6 +85,9 @@
>  			interrupt-names =3D "common", "tx", "rx";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp4";
> +			dmas =3D <&sdma 19>,
> +			       <&sdma 20>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp5: mcbsp@48096000 {
> @@ -88,6 +100,9 @@
>  			interrupt-names =3D "common", "tx", "rx";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp5";
> +			dmas =3D <&sdma 21>,
> +			       <&sdma 22>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		timer1: timer@49018000 {
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 4e7acb6..f901404 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -289,6 +289,9 @@
>  			interrupt-names =3D "common", "tx", "rx";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp1";
> +			dmas =3D <&sdma 31>,
> +			       <&sdma 32>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp2: mcbsp@49022000 {
> @@ -303,6 +306,9 @@
>  			interrupt-names =3D "common", "tx", "rx", "sidetone";
>  			ti,buffer-size =3D <1280>;
>  			ti,hwmods =3D "mcbsp2", "mcbsp2_sidetone";
> +			dmas =3D <&sdma 33>,
> +			       <&sdma 34>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp3: mcbsp@49024000 {
> @@ -317,6 +323,9 @@
>  			interrupt-names =3D "common", "tx", "rx", "sidetone";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp3", "mcbsp3_sidetone";
> +			dmas =3D <&sdma 17>,
> +			       <&sdma 18>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp4: mcbsp@49026000 {
> @@ -329,6 +338,9 @@
>  			interrupt-names =3D "common", "tx", "rx";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp4";
> +			dmas =3D <&sdma 19>,
> +			       <&sdma 20>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp5: mcbsp@48096000 {
> @@ -341,6 +353,9 @@
>  			interrupt-names =3D "common", "tx", "rx";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp5";
> +			dmas =3D <&sdma 21>,
> +			       <&sdma 22>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		timer1: timer@48318000 {
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 827f6f3..413c683 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -388,6 +388,9 @@
>  			reg-names =3D "mpu", "dma";
>  			interrupts =3D <0 112 0x4>;
>  			ti,hwmods =3D "mcpdm";
> +			dmas =3D <&sdma 65>,
> +			       <&sdma 66>;
> +			dma-names =3D "up_link", "dn_link";
>  		};
>  =

>  		dmic: dmic@4012e000 {
> @@ -397,6 +400,8 @@
>  			reg-names =3D "mpu", "dma";
>  			interrupts =3D <0 114 0x4>;
>  			ti,hwmods =3D "dmic";
> +			dmas =3D <&sdma 67>;
> +			dma-names =3D "up_link";
>  		};
>  =

>  		mcbsp1: mcbsp@40122000 {
> @@ -408,6 +413,9 @@
>  			interrupt-names =3D "common";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp1";
> +			dmas =3D <&sdma 33>,
> +			       <&sdma 34>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp2: mcbsp@40124000 {
> @@ -419,6 +427,9 @@
>  			interrupt-names =3D "common";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp2";
> +			dmas =3D <&sdma 17>,
> +			       <&sdma 18>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp3: mcbsp@40126000 {
> @@ -430,6 +441,9 @@
>  			interrupt-names =3D "common";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp3";
> +			dmas =3D <&sdma 19>,
> +			       <&sdma 20>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp4: mcbsp@48096000 {
> @@ -440,6 +454,9 @@
>  			interrupt-names =3D "common";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp4";
> +			dmas =3D <&sdma 31>,
> +			       <&sdma 32>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		keypad: keypad@4a31c000 {
> diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
> index 39b8d76..5aa6086 100644
> --- a/arch/arm/boot/dts/omap5.dtsi
> +++ b/arch/arm/boot/dts/omap5.dtsi
> @@ -364,6 +364,9 @@
>  			reg-names =3D "mpu", "dma";
>  			interrupts =3D <0 112 0x4>;
>  			ti,hwmods =3D "mcpdm";
> +			dmas =3D <&sdma 65>,
> +			       <&sdma 66>;
> +			dma-names =3D "up_link", "dn_link";
>  		};
>  =

>  		dmic: dmic@4012e000 {
> @@ -373,6 +376,8 @@
>  			reg-names =3D "mpu", "dma";
>  			interrupts =3D <0 114 0x4>;
>  			ti,hwmods =3D "dmic";
> +			dmas =3D <&sdma 67>;
> +			dma-names =3D "up_link";
>  		};
>  =

>  		mcbsp1: mcbsp@40122000 {
> @@ -384,6 +389,9 @@
>  			interrupt-names =3D "common";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp1";
> +			dmas =3D <&sdma 33>,
> +			       <&sdma 34>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp2: mcbsp@40124000 {
> @@ -395,6 +403,9 @@
>  			interrupt-names =3D "common";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp2";
> +			dmas =3D <&sdma 17>,
> +			       <&sdma 18>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		mcbsp3: mcbsp@40126000 {
> @@ -406,6 +417,9 @@
>  			interrupt-names =3D "common";
>  			ti,buffer-size =3D <128>;
>  			ti,hwmods =3D "mcbsp3";
> +			dmas =3D <&sdma 19>,
> +			       <&sdma 20>;
> +			dma-names =3D "tx", "rx";
>  		};
>  =

>  		timer1: timer@4ae18000 {
> =



-- =

P=E9ter
