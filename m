From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 6/7] ARM: dts: dra7: Add USB related nodes
Date: Wed, 7 May 2014 11:45:40 +0300
Message-ID: <5369F2B4.6030603@ti.com>
References: <1399283686-6127-1-git-send-email-rogerq@ti.com> <1399283686-6127-7-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399283686-6127-7-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kishon-l0cyMroinI0@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org
Cc: george.cherian-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Tony,

This patch will need to be updated for IRQ crossbar changes.

I will send a revised version of just this patch based on crossbar chan=
ges [1]

[1] - http://article.gmane.org/gmane.linux.documentation/23293

cheers,
-roger

On 05/05/2014 12:54 PM, Roger Quadros wrote:
> Add nodes for the Super Speed USB controllers, omap-control-usb,
> USB2 PHY and USB3 PHY devices.
>=20
> Remove ocp2scp1 address space from hwmod data as it is
> now provided via device tree.
>=20
> CC: Beno=C3=AEt Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> Reviewed-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/dra7.dtsi               | 149 ++++++++++++++++++++=
++++++++++
>  arch/arm/mach-omap2/omap_hwmod_7xx_data.c |  10 --
>  2 files changed, 149 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dts=
i
> index 149b550..4535e54 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -789,6 +789,155 @@
>  			dma-names =3D "tx0", "rx0";
>  			status =3D "disabled";
>  		};
> +
> +		omap_control_usb2phy1: control-phy@4a002300 {
> +			compatible =3D "ti,control-phy-usb2";
> +			reg =3D <0x4a002300 0x4>;
> +			reg-names =3D "power";
> +		};
> +
> +		omap_control_usb3phy1: control-phy@4a002370 {
> +			compatible =3D "ti,control-phy-pipe3";
> +			reg =3D <0x4a002370 0x4>;
> +			reg-names =3D "power";
> +		};
> +
> +		omap_control_usb2phy2: control-phy@0x4a002e74 {
> +			compatible =3D "ti,control-phy-usb2-dra7";
> +			reg =3D <0x4a002e74 0x4>;
> +			reg-names =3D "power";
> +		};
> +
> +		/* OCP2SCP1 */
> +		ocp2scp@4a080000 {
> +			compatible =3D "ti,omap-ocp2scp";
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			ranges;
> +			reg =3D <0x4a080000 0x20>;
> +			ti,hwmods =3D "ocp2scp1";
> +
> +			usb2_phy1: phy@4a084000 {
> +				compatible =3D "ti,omap-usb2";
> +				reg =3D <0x4a084000 0x400>;
> +				ctrl-module =3D <&omap_control_usb2phy1>;
> +				clocks =3D <&usb_phy1_always_on_clk32k>,
> +					 <&usb_otg_ss1_refclk960m>;
> +				clock-names =3D	"wkupclk",
> +						"refclk";
> +				#phy-cells =3D <0>;
> +			};
> +
> +			usb2_phy2: phy@4a085000 {
> +				compatible =3D "ti,omap-usb2";
> +				reg =3D <0x4a085000 0x400>;
> +				ctrl-module =3D <&omap_control_usb2phy2>;
> +				clocks =3D <&usb_phy2_always_on_clk32k>,
> +					 <&usb_otg_ss2_refclk960m>;
> +				clock-names =3D	"wkupclk",
> +						"refclk";
> +				#phy-cells =3D <0>;
> +			};
> +
> +			usb3_phy1: phy@4a084400 {
> +				compatible =3D "ti,omap-usb3";
> +				reg =3D <0x4a084400 0x80>,
> +				      <0x4a084800 0x64>,
> +				      <0x4a084c00 0x40>;
> +				reg-names =3D "phy_rx", "phy_tx", "pll_ctrl";
> +				ctrl-module =3D <&omap_control_usb3phy1>;
> +				clocks =3D <&usb_phy3_always_on_clk32k>,
> +					 <&sys_clkin1>,
> +					 <&usb_otg_ss1_refclk960m>;
> +				clock-names =3D	"wkupclk",
> +						"sysclk",
> +						"refclk";
> +				#phy-cells =3D <0>;
> +			};
> +		};
> +
> +		omap_dwc3_1@48880000 {
> +			compatible =3D "ti,dwc3";
> +			ti,hwmods =3D "usb_otg_ss1";
> +			reg =3D <0x48880000 0x10000>;
> +			interrupts =3D <0 77 4>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			utmi-mode =3D <2>;
> +			ranges;
> +			usb1: usb@48890000 {
> +				compatible =3D "snps,dwc3";
> +				reg =3D <0x48890000 0x17000>;
> +				interrupts =3D <0 76 4>;
> +				phys =3D <&usb2_phy1>, <&usb3_phy1>;
> +				phy-names =3D "usb2-phy", "usb3-phy";
> +				tx-fifo-resize;
> +				maximum-speed =3D "super-speed";
> +				dr_mode =3D "otg";
> +			};
> +		};
> +
> +		omap_dwc3_2@488c0000 {
> +			compatible =3D "ti,dwc3";
> +			ti,hwmods =3D "usb_otg_ss2";
> +			reg =3D <0x488c0000 0x10000>;
> +			interrupts =3D <0 92 4>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			utmi-mode =3D <2>;
> +			ranges;
> +			usb2: usb@488d0000 {
> +				compatible =3D "snps,dwc3";
> +				reg =3D <0x488d0000 0x17000>;
> +				interrupts =3D <0 78 4>;
> +				phys =3D <&usb2_phy2>;
> +				phy-names =3D "usb2-phy";
> +				tx-fifo-resize;
> +				maximum-speed =3D "high-speed";
> +				dr_mode =3D "otg";
> +			};
> +		};
> +
> +		/* IRQ for DWC3_3 and DWC3_4 need IRQ crossbar */
> +		omap_dwc3_3@48900000 {
> +			compatible =3D "ti,dwc3";
> +			ti,hwmods =3D "usb_otg_ss3";
> +			reg =3D <0x48900000 0x10000>;
> +		/*	interrupts =3D <0 TBD 4>; */
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			utmi-mode =3D <2>;
> +			ranges;
> +			status =3D "disabled";
> +			usb3: usb@48910000 {
> +				compatible =3D "snps,dwc3";
> +				reg =3D <0x48910000 0x17000>;
> +		/*		interrupts =3D <0 93 4>; */
> +				tx-fifo-resize;
> +				maximum-speed =3D "high-speed";
> +				dr_mode =3D "otg";
> +			};
> +		};
> +
> +		omap_dwc3_4@48940000 {
> +			compatible =3D "ti,dwc3";
> +			ti,hwmods =3D "usb_otg_ss4";
> +			reg =3D <0x48940000 0x10000>;
> +		/*	interrupts =3D <0 TBD 4>; */
> +			#address-cells =3D <1>;
> +			#size-cells =3D <1>;
> +			utmi-mode =3D <2>;
> +			ranges;
> +			status =3D "disabled";
> +			usb4: usb@48950000 {
> +				compatible =3D "snps,dwc3";
> +				reg =3D <0x48950000 0x17000>;
> +		/*		interrupts =3D <0 TBD 4>; */
> +				tx-fifo-resize;
> +				maximum-speed =3D "high-speed";
> +				dr_mode =3D "otg";
> +			};
> +		};
>  	};
>  };
> =20
> diff --git a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c b/arch/arm/mac=
h-omap2/omap_hwmod_7xx_data.c
> index 067d322..d6f9709 100644
> --- a/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> +++ b/arch/arm/mach-omap2/omap_hwmod_7xx_data.c
> @@ -2330,21 +2330,11 @@ static struct omap_hwmod_ocp_if dra7xx_l4_cfg=
__mpu =3D {
>  	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
> =20
> -static struct omap_hwmod_addr_space dra7xx_ocp2scp1_addrs[] =3D {
> -	{
> -		.pa_start	=3D 0x4a080000,
> -		.pa_end		=3D 0x4a08001f,
> -		.flags		=3D ADDR_TYPE_RT
> -	},
> -	{ }
> -};
> -
>  /* l4_cfg -> ocp2scp1 */
>  static struct omap_hwmod_ocp_if dra7xx_l4_cfg__ocp2scp1 =3D {
>  	.master		=3D &dra7xx_l4_cfg_hwmod,
>  	.slave		=3D &dra7xx_ocp2scp1_hwmod,
>  	.clk		=3D "l4_root_clk_div",
> -	.addr		=3D dra7xx_ocp2scp1_addrs,
>  	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
>  };
> =20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
