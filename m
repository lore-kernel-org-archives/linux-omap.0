From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 5/5] ARM: dts: AM33XX: Add default pinctrl binding for
 UART0 device
Date: Thu, 28 Mar 2013 05:17:14 +0000
Message-ID: <79CD15C6BA57404B839C016229A409A83EC3B9B3@DBDE01.ent.ti.com>
References: <1364389156-8273-1-git-send-email-hvaibhav@ti.com>
 <896a1261daec485db6be66630bc4019a@DFLE51.ent.ti.com>
 <20130327133242.GJ18335@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48576 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013Ab3C1FR2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 01:17:28 -0400
In-Reply-To: <20130327133242.GJ18335@beef>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Porter, Matt" <mporter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "Cousson, Benoit" <b-cousson@ti.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>


> -----Original Message-----
> From: Matt Porter [mailto:ohiomdp@gmail.com] On Behalf Of Porter, Mat=
t
> Sent: Wednesday, March 27, 2013 7:03 PM
> To: Hiremath, Vaibhav
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> Cousson, Benoit; devicetree-discuss@lists.ozlabs.org
> Subject: Re: [PATCH 5/5] ARM: dts: AM33XX: Add default pinctrl bindin=
g
> for UART0 device
>=20
> On Wed, Mar 27, 2013 at 12:59:16PM +0000, Vaibhav Hiremath wrote:
> > Add pin control binding for UART0 device nodes in all
> > board specific DT files.
> >
> > Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> > Cc: Benoit Cousson <b-cousson@ti.com>
>=20
> Except for trivial comments below I'll add my
>=20
> Acked-by: Matt Porter <mporter@ti.com>
>=20
> > ---
> >  arch/arm/boot/dts/am335x-bone.dts  |   10 ++++++++++
> >  arch/arm/boot/dts/am335x-evm.dts   |   10 ++++++++++
> >  arch/arm/boot/dts/am335x-evmsk.dts |   10 ++++++++++
> >  3 files changed, 30 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/am335x-bone.dts
> b/arch/arm/boot/dts/am335x-bone.dts
> > index 1d623e4..3c4c66f 100644
> > --- a/arch/arm/boot/dts/am335x-bone.dts
> > +++ b/arch/arm/boot/dts/am335x-bone.dts
> > @@ -43,10 +43,20 @@
> >  				0x18c 0x30	/* i2c0_scl.i2c0_scl PULLUP |
> INPUTENABLE | MODE0 */
> >  			>;
> >  		};
> > +
> > +		uart0_pins: pinmux_uart0_pins {
> > +			pinctrl-single,pins =3D <
> > +				0x170 0x30	/* uart0_rxd.uart0_rxd PULLUP |
> INPUTENABLE | MODE0 */
> > +				0x174 0x00	/* uart0_txd.uart0_txd PULLDOWN |
> MODE0 */
> > +			>;
> > +		};
> >  	};
> >
> >  	ocp {
> >  		uart1: serial@44e09000 {
> > +			pinctrl-names =3D "default";
> > +			pinctrl-0 =3D <&uart0_pins>;
> > +
>=20
> Please change this to be uart0 so it all matches.
>=20
Yes, you are right, this also can be changed now.
I tested it with changed uart numbering and it is working.

I didn=92t touch uart, as I recall earlier discussion of
Having 1-based uart numbering and also it is being documented
In DT for hwmod -

ti,hwmods : Must be "uart<n>", n being the instance number (1-based)


I will change it and submit the next version with your acked-by.

Thanks,
Vaibhav
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
