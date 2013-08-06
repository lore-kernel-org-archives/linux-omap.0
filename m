From: Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC 2/2] usb: dwc3: Add Qualcomm DWC3 glue layer driver
Date: Tue, 06 Aug 2013 13:21:38 +0100
Message-ID: <1375791698.12043.53.camel@hornet>
References: <1375789991-30041-1-git-send-email-iivanov@mm-sol.com>
	 <1375789991-30041-3-git-send-email-iivanov@mm-sol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1375789991-30041-3-git-send-email-iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Cc: "balbi-l0cyMroinI0@public.gmane.org" <balbi-l0cyMroinI0@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <Mark.Rutland-5wv7dgnIgG8@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org" <ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org>, "rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org" <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2013-08-06 at 12:53 +0100, Ivan T. Ivanov wrote:
> From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
>=20
> Signed-off-by: Ivan T. Ivanov <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>

The same comment as for the RFC 1/2 here...

>  .../devicetree/bindings/usb/msm-ssusb.txt          |   39 +++++
>  drivers/usb/dwc3/Kconfig                           |    8 +
>  drivers/usb/dwc3/Makefile                          |    1 +
>  drivers/usb/dwc3/dwc3-msm.c                        |  175 ++++++++++=
++++++++++
>  4 files changed, 223 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-msm.c
>=20
> diff --git a/Documentation/devicetree/bindings/usb/msm-ssusb.txt b/Do=
cumentation/devicetree/bindings/usb/msm-ssusb.txt
> index 550b496..313ae0d 100644
> --- a/Documentation/devicetree/bindings/usb/msm-ssusb.txt
> +++ b/Documentation/devicetree/bindings/usb/msm-ssusb.txt
> @@ -22,6 +22,23 @@ Required "supply-name" examples are:
>  	"v1p8" : 1.8v supply for SS-PHY
>  	"vddcx" : vdd supply for SS-PHY digital circuit operation
> =20
> +Required properties :
> +- compatible : should be "qcom,dwc-usb3-msm"
> +- reg : offset and length of the register set in the memory map
> +	offset and length of the TCSR register for routing USB
> +	signals to either picoPHY0 or picoPHY1.
> +- clocks =3D <&usb30_master_cxc>, <&sys_noc_usb3_axi_cxc>, <&usb30_s=
leep_cxc>, <&usb30_mock_utmi_cxc>;
> +- clock-names =3D "core_clk", "iface_clk", "sleep_clk", "utmi_clk";
> +
> +Optional properties :
> +- gdsc-supply : phandle to the globally distributed switch controlle=
r
> +  regulator node to the USB controller.
> +
> +Sub nodes:
> +- Sub node for "DWC3- USB3 controller".
> +  This sub node is required property for device node. The properties=
 of this subnode
> +  are specified in dwc3.txt.

Ah, this answers one of my questions - DWC3 comes from Synopsys.

>  Example device nodes:
> =20
>  	dwc3_usb2: phy@f92f8800 {
> @@ -47,3 +64,25 @@ Example device nodes:
>  		vddcx-supply =3D <&supply>;
>  		v1p8-supply =3D <&supply>;
>  	};
> +
> +	usb@fd4ab000 {
> +		compatible =3D "qcom,dwc-usb3-msm";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		reg =3D <0xfd4ab000 0x4>;
> +
> +		clocks =3D <&usb30_master_cxc>, <&sys_noc_usb3_axi_cxc>, <&usb30_s=
leep_cxc>, <&usb30_mock_utmi_cxc>;
> +		clock-names =3D "core_clk", "iface_clk", "sleep_clk", "utmi_clk";
> +
> +		gdsc-supply =3D <&supply>;
> +		ranges;
> +
> +		dwc3@f9200000 {
> +			compatible =3D "snps,dwc3";

Note that the Documentation/devicetree/bindings/usb/dwc3.txt is
mentioning "synopsys,dwc3" (which is clearly in opposition to the
vendor-prefixes.txt file) and this compatible value is used in the
drivers/usb/dwc3/core.c and omap5.dtsi. Unless it has been already fixe=
d
recently, could you take care of that?

> +			reg =3D <0xf9200000 0xcd00>;
> +			interrupts =3D <0 131 0>;
> +			interrupt-names =3D "irq";
> +			usb-phy =3D <&dwc3_usb2>, <&dwc3_usb3>;
> +			tx-fifo-resize;
> +		};
> +	};

And now I'm really confused... Maybe it's just lack of documentation...

How does the "qcom,dwc-usb3-msm" relate to "qcom,dwc-usb3"?

Pawe=C5=82


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
