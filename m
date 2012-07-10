From: Rajendra Nayak <rnayak-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v1 10/11] arm/dts: omap: Add usb_otg and glue data
Date: Tue, 10 Jul 2012 11:57:05 +0530
Message-ID: <4FFBCB39.1010809@ti.com>
References: <1340884267-28908-1-git-send-email-kishon@ti.com>
 <1340884267-28908-11-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1340884267-28908-11-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Cc: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thursday 28 June 2012 05:21 PM, Kishon Vijay Abraham I wrote:
> Add usb otg data node in omap4/omap3 device tree file. Also update
> the node with board specific setting in omapx-<board>.dts file.
>
> Signed-off-by: Kishon Vijay Abraham I<kishon-l0cyMroinI0@public.gmane.org>
> ---
>   arch/arm/boot/dts/omap3-beagle.dts |    6 ++++++
>   arch/arm/boot/dts/omap3-evm.dts    |    6 ++++++
>   arch/arm/boot/dts/omap3.dtsi       |    8 ++++++++
>   arch/arm/boot/dts/omap4-panda.dts  |    6 ++++++
>   arch/arm/boot/dts/omap4-sdp.dts    |    6 ++++++
>   arch/arm/boot/dts/omap4.dtsi       |    8 ++++++++
>   6 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
> index 5b4506c..f3d7076 100644
> --- a/arch/arm/boot/dts/omap3-beagle.dts
> +++ b/arch/arm/boot/dts/omap3-beagle.dts
> @@ -67,3 +67,9 @@
>   &mmc3 {
>   	status = "disable";
>   };
> +
> +&usb_otg_hs {
> +	interface_type =<0>;
> +	mode =<3>;
> +	power =<50>;
> +};
> diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
> index 2eee16e..8963b3d 100644
> --- a/arch/arm/boot/dts/omap3-evm.dts
> +++ b/arch/arm/boot/dts/omap3-evm.dts
> @@ -18,3 +18,9 @@
>   		reg =<0x80000000 0x10000000>; /* 256 MB */
>   	};
>   };
> +
> +&usb_otg_hs {
> +	interface_type =<0>;
> +	mode =<3>;
> +	power =<50>;
> +};
> diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
> index 99474fa..2f565d6 100644
> --- a/arch/arm/boot/dts/omap3.dtsi
> +++ b/arch/arm/boot/dts/omap3.dtsi
> @@ -215,5 +215,13 @@
>   			compatible = "ti,omap3-hsmmc";
>   			ti,hwmods = "mmc3";
>   		};
> +
> +		usb_otg_hs: usb_otg_hs@4a0ab000 {
> +			compatible = "ti,musb-omap2430";

this compatible doesn't seem right in omap3.dtsi. Same with
the below entry in omap4.dtsi.
See other IP blocks which are reused across OMAP2/3/4 on
how the compatible for those are handled.

> +			ti,hwmods = "usb_otg_hs";
> +			multipoint =<1>;
> +			num_eps =<16>;
> +			ram_bits =<12>;
> +		};
>   	};
>   };
> diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
> index 1efe0c5..0825fa7 100644
> --- a/arch/arm/boot/dts/omap4-panda.dts
> +++ b/arch/arm/boot/dts/omap4-panda.dts
> @@ -89,3 +89,9 @@
>   	ti,non-removable;
>   	bus-width =<4>;
>   };
> +
> +&usb_otg_hs {
> +	interface_type =<1>;
> +	mode =<3>;
> +	power =<50>;
> +};
> diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
> index d08c4d1..5244d51 100644
> --- a/arch/arm/boot/dts/omap4-sdp.dts
> +++ b/arch/arm/boot/dts/omap4-sdp.dts
> @@ -158,3 +158,9 @@
>   	bus-width =<4>;
>   	ti,non-removable;
>   };
> +
> +&usb_otg_hs {
> +	interface_type =<1>;
> +	mode =<3>;
> +	power =<50>;
> +};
> diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
> index 4d2dcc1..bc7b3c3 100644
> --- a/arch/arm/boot/dts/omap4.dtsi
> +++ b/arch/arm/boot/dts/omap4.dtsi
> @@ -285,5 +285,13 @@
>   				<0x4a002300 0x1>;
>   			};
>   		};
> +
> +		usb_otg_hs: usb_otg_hs@4a0ab000 {
> +			compatible = "ti,musb-omap2430";
> +			ti,hwmods = "usb_otg_hs";
> +			multipoint =<1>;
> +			num_eps =<16>;
> +			ram_bits =<12>;
> +		};
>   	};
>   };
