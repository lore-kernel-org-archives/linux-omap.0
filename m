From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: OMAP: Configuring CONTROL_DEVCONF0 register via DT with pinctrl
Date: Fri, 27 Jul 2012 12:43:17 +0300
Message-ID: <501262B5.1080004@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:38043 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750836Ab2G0Jmk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 27 Jul 2012 05:42:40 -0400
Received: by obbuo13 with SMTP id uo13so4682332obb.33
        for <linux-omap@vger.kernel.org>; Fri, 27 Jul 2012 02:42:39 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>

Hello,

I need to find a solution to control 2 bits in CONTROL_DEVCONF0 on OMAP=
2/3 for
McBSP1 CLKR/FSR signal routing.
In boards using McBSP1 we might need to change bit 3 and 4 based on the=
 audio
setup (how the board has been wired).

So far I have come up with the following idea to handle to but not real=
ly sure
if it is the correct way (I have taken the idea from the arm/dts: Add A=
M33XX
basic pinctrl support series).

In .dtsi file of the SoC:

control_devconf0: pinmux@48002274 {
	compatible =3D "pinctrl-single";
	reg =3D <0x48002274 4>;	/* Single register */
	#address-cells =3D <1>;
	#size-cells =3D <0>;
	pinctrl-single,register-width =3D <32>;
	pinctrl-single,function-mask =3D <0x5F>;
};

In the .dts file of the board which needs to change the CLKR/FSR config=
uration:

&control_devconf0 {
	pinctrl-names =3D "default";
	pinctrl-0 =3D <&mcbsp1_pins>;

	mcbsp1_pins: pinmux_mcbsp1_pins {
		pinctrl-single,pins =3D <0x00 0x18>; /* CLKR/FSR from CLKX/FSX
						    * pin */
	};

};

Thanks for the help,
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
