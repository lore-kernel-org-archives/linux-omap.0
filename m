From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 2/3] ARM: dts: sti: Add st-dwc3 devicetree bindings
 documentation
Date: Mon, 7 Jul 2014 12:00:55 +0100
Message-ID: <20140707110055.GF6407@lee--X1>
References: <1404541530-27856-1-git-send-email-peter.griffin@linaro.org>
 <1404541530-27856-3-git-send-email-peter.griffin@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404541530-27856-3-git-send-email-peter.griffin@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, devicetree@vger.kernel.org, balbi@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, peppe.cavallaro@st.com
List-Id: linux-omap@vger.kernel.org

Subject is wrong, this has nothing to do with ARM.  Should be USB.

On Sat, 05 Jul 2014, Peter Griffin wrote:
> This patch documents the device tree documentation required for
> the ST usb3 controller glue layer found in STiH407 devices.
>=20
> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/dwc3-st.txt | 58 +++++++++++++=
++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-st.txt
>=20
> diff --git a/Documentation/devicetree/bindings/usb/dwc3-st.txt b/Docu=
mentation/devicetree/bindings/usb/dwc3-st.txt
> new file mode 100644
> index 0000000..befd964
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/dwc3-st.txt
> @@ -0,0 +1,58 @@
> +ST DWC3 glue logic
> +
> +This file documents the parameters for the dwc3-st driver.

Does this line really add anything to do the document, considering the
name and location of the file and the title above?

> +This driver provides the glue logic to use the dwc3 on STiH407 based=
 platforms.

s/This driver/The DWC2 driver/

> +Required properties:
> + - compatible	: must be "st,stih407-dwc3"
> + - reg		: glue logic base address and USB syscfg ctrl register offse=
t
> + - reg-names	: should be "reg-glue" and "syscfg-reg"

Any reason why you have reg-* and *-reg?  If  you have to put 'reg' in
the name, it's usually appended, rather than prefixed.

> + - st,syscon	: should be phandle to system configuration node which
> +		  encompasses the glue registers
> + - resets	: phandle pointing to the system powerdown controller
> +See: Documentation/devicetree/bindings/reset/st,sti-powerdown.txt
> +See: Documentation/devicetree/bindings/reset/reset.txt
> +
> + - #address-cells, #size-cells : should be '1' if the device has sub=
-nodes
> +                                 with 'reg' property
> +
> + - pinctl-names	: A pinctrl state named "default" must be defined
> +See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
> +
> + - pinctrl-0	: Pin control group
> +See: Documentation/devicetree/bindings/pinctrl/pinctrl-binding.txt
> +
> + - ranges	: allows valid 1:1 translation between child's address spa=
ce and
> +		  parent's address space
> +
> +Optional properties:
> + - st,dwc3-drd-device: to program the HC as "device" (static setup)

This will require a DT Ack.

> +Sub-nodes:
> +The dwc3 core should be added as subnode to ST DWC3 glue as shown in=
 the
> +example below. The DT binding details of dwc3 can be found in:
> +Documentation/devicetree/bindings/usb/dwc3.txt
> +
> +Example:
> +
> +st_dwc3: dwc3@8f94000 {
> +	status		=3D "disabled";

Probably not good to disable the node in the example.

> +	compatible	=3D "st,stih407-dwc3";
> +	reg		=3D <0x08f94000 0x1000>, <0x110 0x4>;
> +	reg-names	=3D "reg-glue", "syscfg-reg";
> +	st,syscfg	=3D <&syscfg_core>;
> +	resets          =3D <&powerdown STIH407_USB3_POWERDOWN>;
> +	#address-cells	=3D <1>;
> +	#size-cells	=3D <1>;
> +	pinctrl-names	=3D "default";
> +	pinctrl-0	=3D <&pinctrl_usb3>;
> +	ranges;
> +
> +	dwc3: dwc3@9900000 {
> +		compatible	=3D "synopsys,dwc3";
> +		reg		=3D <0x09900000 0x100000>;
> +		interrupts	=3D  <GIC_SPI 155 IRQ_TYPE_NONE>;
> +
> +		usb-phy =3D <&usb2_phy>, <&usb3_phy>;
> +	};
> +};

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
