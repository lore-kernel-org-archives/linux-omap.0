From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH 3/6] net: cpsw: Add control-module macid driver
Date: Fri, 14 Feb 2014 10:32:54 +0100
Message-ID: <20140214093254.GN31787@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
 <1387385242-1161-4-git-send-email-mpa@pengutronix.de>
 <20140213194431.GF17650@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33902 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751374AbaBNJdD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Feb 2014 04:33:03 -0500
Content-Disposition: inline
In-Reply-To: <20140213194431.GF17650@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de

Hi,

On Thu, Feb 13, 2014 at 08:44:31PM +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Dec 18, 2013 at 05:47:19PM +0100, Markus Pargmann wrote:
> > This driver extracts the hardware macid from the control module of
> > am335x processors. It exports a function cpsw_ctrl_macid_read for c=
psw
> > to get the macid from within the processor.
> >=20
> > This driver is not used, unless it is defined in DT and referenced =
by a
> > cpsw slave with a phandle.
> >=20
> > Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
> > ---
> >  .../devicetree/bindings/net/cpsw-ctrl-macid.txt    |  31 +++++
> >  drivers/net/ethernet/ti/Kconfig                    |   8 ++
> >  drivers/net/ethernet/ti/Makefile                   |   1 +
> >  drivers/net/ethernet/ti/cpsw-ctrl-macid.c          | 138 +++++++++=
++++++++++++
> >  4 files changed, 178 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/cpsw-ctrl=
-macid.txt
> >  create mode 100644 drivers/net/ethernet/ti/cpsw-ctrl-macid.c
> >=20
> > diff --git a/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.=
txt b/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
> > new file mode 100644
> > index 0000000..abff2af
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/cpsw-ctrl-macid.txt
> > @@ -0,0 +1,31 @@
> > +TI CPSW ctrl macid Devicetree bindings
> > +--------------------------------------
> > +
> > +Required properties:
> > + - compatible		: Should be "ti,am3352-cpsw-ctrl-macid"
> > + - reg			: physical base address and size of the cpsw
> > +			  registers map
> > + - reg-names		: names of the register map given in "reg" node
> > + - #ti,cpsw-ctrl-macid	: Should be <1>
> #ti,mac-address-ctrl-cells?

Sounds better, will fix.

>=20
> > +
> > +When used from cpsw, "ti,mac-address-ctrl" should be a phandle to =
this device
> > +node with one argument, 0 or 1 to select the macid 0 or 1.
> > +
> > +Examples:
> > +
> > +	cpsw_ctrl_macid: cpsw-ctrl-macid@44e10630 {
> > +		compatible =3D "ti,am3352-cpsw-ctrl-macid";
> > +		#ti,mac-address-ctrl-cells =3D <1>;
> > +		reg =3D <0x44e10630 0x16>;
> s/0x16/0x10/

Thanks, that's a bug, obviously we only have 4, not 5.5 registers.

>=20
> > +		reg-names =3D "ctrl-macid";
> > +	};
> > +
> > +Used in cpsw slave nodes like this:
> > +
> > +	cpsw_emac0: slave@4a100200 {
> > +		ti,mac-address-ctrl =3D <&cpsw_ctrl_macid 0>;
> > +	};
> > +
> > +	cpsw_emac1: slave@4a100300 {
> > +		ti,mac-address-ctrl =3D <&cpsw_ctrl_macid 1>;
> > +	};
> > diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet=
/ti/Kconfig
> > index 53150c2..24819ef 100644
> > --- a/drivers/net/ethernet/ti/Kconfig
> > +++ b/drivers/net/ethernet/ti/Kconfig
> > @@ -56,12 +56,20 @@ config TI_CPSW_PHY_SEL
> >  	  This driver supports configuring of the phy mode connected to
> >  	  the CPSW.
> > =20
> > +config TI_CPSW_CTRL_MACID
> > +	boolean "TI CPSW internal MACID support"
> > +	depends on TI_CPSW
> > +	---help---
> > +	  This driver supports reading the hardcoded MACID from am33xx
> > +	  processors control module.
> > +
> Would it be nicer to put this after the TI_CPSW definition. (Think
> $(make config).)

I inserted TI_CPSW_CTRL_MACID here because the other TI_CPSW specific
subdriver (TI_CPSW_PHY_SEL) was above TI_CPSW. But I could change this.

>=20
> >  config TI_CPSW
> >  	tristate "TI CPSW Switch Support"
> >  	depends on ARM && (ARCH_DAVINCI || SOC_AM33XX)
> >  	select TI_DAVINCI_CPDMA
> >  	select TI_DAVINCI_MDIO
> >  	select TI_CPSW_PHY_SEL
> > +	select TI_CPSW_CTRL_MACID
> If TI_CPSW selects TI_CPSW_CTRL_MACID the latter doesn't need to depe=
nd
> on the former. So this optin is user visible but never
> user-(de)selectable. I'd say drop the Kconfig symbol and just add
> cpsw-ctrl-macid.o to ti_cpsw-y in the Makefile (or really make it
> optional).

As this is closely related to the cpsw driver, I think it's better to
make it non-optional and include it in the Makefile.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
