From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [RFC 2/2] usb: dwc3: Add Qualcomm DWC3 glue layer driver
Date: Tue, 06 Aug 2013 16:46:33 +0300
Message-ID: <1375796793.2027.20.camel@iivanov-dev.int.mm-sol.com>
References: <1375789991-30041-1-git-send-email-iivanov@mm-sol.com>
	 <1375789991-30041-3-git-send-email-iivanov@mm-sol.com>
	 <1375791698.12043.53.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1375791698.12043.53.camel@hornet>
Sender: linux-doc-owner@vger.kernel.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: "balbi@ti.com" <balbi@ti.com>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, Mark Rutland <Mark.Rutland@arm.com>, "swarren@wwwdotorg.org" <swarren@wwwdotorg.org>, "ian.campbell@citrix.com" <ian.campbell@citrix.com>, "rob@landley.net" <rob@landley.net>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Tue, 2013-08-06 at 13:21 +0100, Pawel Moll wrote:
> On Tue, 2013-08-06 at 12:53 +0100, Ivan T. Ivanov wrote:
> > From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> >=20
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
>=20
> The same comment as for the RFC 1/2 here...

Will fix this.

>=20
> >  .../devicetree/bindings/usb/msm-ssusb.txt          |   39 +++++
> >  drivers/usb/dwc3/Kconfig                           |    8 +
> >  drivers/usb/dwc3/Makefile                          |    1 +
> >  drivers/usb/dwc3/dwc3-msm.c                        |  175 ++++++++=
++++++++++++
> >  4 files changed, 223 insertions(+)
> >  create mode 100644 drivers/usb/dwc3/dwc3-msm.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/usb/msm-ssusb.txt b/=
Documentation/devicetree/bindings/usb/msm-ssusb.txt
> > index 550b496..313ae0d 100644
> > --- a/Documentation/devicetree/bindings/usb/msm-ssusb.txt
> > +++ b/Documentation/devicetree/bindings/usb/msm-ssusb.txt
> > @@ -22,6 +22,23 @@ Required "supply-name" examples are:
> >  	"v1p8" : 1.8v supply for SS-PHY
> >  	"vddcx" : vdd supply for SS-PHY digital circuit operation
> > =20
> > +Required properties :
> > +- compatible : should be "qcom,dwc-usb3-msm"
> > +- reg : offset and length of the register set in the memory map
> > +	offset and length of the TCSR register for routing USB
> > +	signals to either picoPHY0 or picoPHY1.
> > +- clocks =3D <&usb30_master_cxc>, <&sys_noc_usb3_axi_cxc>, <&usb30=
_sleep_cxc>, <&usb30_mock_utmi_cxc>;
> > +- clock-names =3D "core_clk", "iface_clk", "sleep_clk", "utmi_clk"=
;
> > +
> > +Optional properties :
> > +- gdsc-supply : phandle to the globally distributed switch control=
ler
> > +  regulator node to the USB controller.
> > +
> > +Sub nodes:
> > +- Sub node for "DWC3- USB3 controller".
> > +  This sub node is required property for device node. The properti=
es of this subnode
> > +  are specified in dwc3.txt.
>=20
> Ah, this answers one of my questions - DWC3 comes from Synopsys.

Yes, sorry.

>=20
> >  Example device nodes:
> > =20
> >  	dwc3_usb2: phy@f92f8800 {
> > @@ -47,3 +64,25 @@ Example device nodes:
> >  		vddcx-supply =3D <&supply>;
> >  		v1p8-supply =3D <&supply>;
> >  	};
> > +
> > +	usb@fd4ab000 {
> > +		compatible =3D "qcom,dwc-usb3-msm";
> > +		#address-cells =3D <1>;
> > +		#size-cells =3D <1>;
> > +		reg =3D <0xfd4ab000 0x4>;
> > +
> > +		clocks =3D <&usb30_master_cxc>, <&sys_noc_usb3_axi_cxc>, <&usb30=
_sleep_cxc>, <&usb30_mock_utmi_cxc>;
> > +		clock-names =3D "core_clk", "iface_clk", "sleep_clk", "utmi_clk"=
;
> > +
> > +		gdsc-supply =3D <&supply>;
> > +		ranges;
> > +
> > +		dwc3@f9200000 {
> > +			compatible =3D "snps,dwc3";
>=20
> Note that the Documentation/devicetree/bindings/usb/dwc3.txt is
> mentioning "synopsys,dwc3" (which is clearly in opposition to the
> vendor-prefixes.txt file) and this compatible value is used in the
> drivers/usb/dwc3/core.c and omap5.dtsi. Unless it has been already fi=
xed
> recently, could you take care of that?

Yes, it is fixed already. Patch is in linux-next=20
"usb: dwc3: core: switch to snps,dwc3"

>=20
> > +			reg =3D <0xf9200000 0xcd00>;
> > +			interrupts =3D <0 131 0>;
> > +			interrupt-names =3D "irq";
> > +			usb-phy =3D <&dwc3_usb2>, <&dwc3_usb3>;
> > +			tx-fifo-resize;
> > +		};
> > +	};
>=20
> And now I'm really confused... Maybe it's just lack of documentation.=
=2E.
>=20
> How does the "qcom,dwc-usb3-msm" relate to "qcom,dwc-usb3"?

Not sure from where you get this "qcom,dwc-usb3", but now I think
that "qcom,dwc-usb3" should be enough for compatible. =20

Thanks,=20
Ivan

>=20
> Pawe=C5=82


