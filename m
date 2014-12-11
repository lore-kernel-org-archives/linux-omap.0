From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC/PATCH 2/7] arm: omap: devicetree: add new properties for
 OMAP devices
Date: Thu, 11 Dec 2014 01:46:28 +0100
Message-ID: <20141211004627.GB5585@earth.universe>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-3-git-send-email-balbi@ti.com>
 <54882967.60302@ti.com>
 <20141210150049.GD4602@saruman>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50722 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932621AbaLKAqw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 10 Dec 2014 19:46:52 -0500
Content-Disposition: inline
In-Reply-To: <20141210150049.GD4602@saruman>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 10, 2014 at 09:00:49AM -0600, Felipe Balbi wrote:
> On Wed, Dec 10, 2014 at 04:37:19PM +0530, Lokesh Vutla wrote:
> > On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> > > In order to get rid of some more hwmod data, we
> > > introduce a few extra properties to OMAP DT
> > > data in order to be able to pass the needed
> > > information through DT.
> > >=20
> > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/omap/omap.txt | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Do=
cumentation/devicetree/bindings/arm/omap/omap.txt
> > > index 4f6a82c..c6b9515 100644
> > > --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> > > +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > > @@ -23,6 +23,13 @@ Optional properties:
> > >    during suspend.
> > >  - ti,no-reset-on-init: When present, the module should not be reset =
at init
> > >  - ti,no-idle-on-init: When present, the module should not be idled a=
t init
> > > +- ti,rev_offs: IP block revision register offset (defaults to 0)
> > > +- ti,sysc_offs: OCP_SYSCONFIG register offset (defaults to 0)
> > > +- ti,syss_offs: OCP_SYSSTATUS register offset (defaults to 0)
> > > +- ti,srst_udelay: Delay needed after a softreset in usecs (defaults =
to 0)
> > > +- ti,idlemodes: Slave and Master supported idling modes
> > > +- ti,clockact: default value of clock activity bits (defaults to 0)
> > > +- ti,sysc_type: OCP_SYSCONFIG type. Valid types are 1, 2 or 3 (defau=
lts to 1)
> > Once if all the hwmod data comes to dt it will be very dufficult to see=
 all the data
> > together. Can we separate out hwmod class data like clocks data is sepa=
rated out into different node
> > or something of the sort like below?
> >=20
> > 	ti, hwmod_class {
> > 		ti,class_name =3D <>;
>=20
> this can be done, but I don't want to pass a class name. It's anyways
> just the hwmod name without the digits. For those which are not, I would
> rather change the class name to match.

I did some initial thinking on this some weeks ago, too (and then
was short of time, so I did not continue). My suggestion for the
binding would be:

* OCP_SYSCONFIG (power-management of IP-Cores connected to OMAP processors)

Each IP-Core connected to the bus of OMAP processors has
three registers, which specify the IP-Core's version, its
status and setup of PM features.

Required Properties:
- ti,prcm-type: must be one of the following:
   1 for OMAP2+ register style,
   2 for OMAP4+ register style,
   3 for AM33xx register style
- reg: offset to revision, config and status registers
       relative to module base address

Optional Properties:
- ti,idlemodes:                bit field of flags (SIDLE)
   PRCM_IDLE_FORCE               (1 << 0)
   PRCM_IDLE_NO                  (1 << 1)
   PRCM_IDLE_SMART               (1 << 2)
   PRCM_IDLE_SMART_WKUP          (1 << 3)
- ti,standbymodes:             bit field of flags (MIDLE)
   PRCM_STANDBY_FORCE            (1 << 0)
   PRCM_STANDBY_NO               (1 << 1)
   PRCM_STANDBY_SMART            (1 << 2)
   PRCM_STANDBY_SMART_WKUP       (1 << 3)
- ti,sysc-has-autoidle:        config register has AUTOIDLE bit
- ti,sysc-has-softreset:       config register has SOFTRESET bit
- ti,sysc-has-enawakeup:       config register has ENAWAKEUP bit
- ti,sysc-has-emufree:         config register has EMUFREE bit
- ti,sysc-has-clock-activity:  config register has CLOCKACTIVITY bit
- ti,sysc-has-dma-disable:     config register has DMADISABLE bit
- ti,sysc-has-reset-status:    config register has RESETDONE bit
- ti,syss-has-reset-status:    status register has RESETDONE bit
- ti,reset-delay-us:           reset delay in us

Example:

ocp {
	gpio1: gpio@48310000 {
		compatible =3D "ti,omap3-gpio";

		... /* IP-Core specific properties */

		ti,sysconfig {
			ti,prcm-type =3D <1>;
			reg =3D <0x00>, <0x10>, <0x14>;
			ti,idlemodes =3D <(PRCM_IDLE_FORCE | PRCM_IDLE_NO | PRCM_IDLE_SMART)>;
			ti,sysc-has-enawakeup;
			ti,sysc-has-autoidle;
			ti,sysc-has-softreset;
			ti,syss-has-reset-status;
		};
	};
};

-- Sebastian

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUiOlgAAoJENju1/PIO/qaht8P/0cX/Wkme/S7xrq0xCI991J2
/GSu/pc0WZVOUhkoTUt7SNKr6WOYtiaQ752353va5cd10hvkLulv0P1DowCVYPqP
lGdUX8evt+cm2Vwl1xst6pJiyOymUtUossqaqw9ha+0Eed6XcYgCChbXikCgMx2g
F87kVgX+a3bLfVSzY5UFi5yeIEAl15U9GWVL3dzgnfBF+cry8OltcP6lc7Z91cPF
sCcr8CUR59DVV3O8YqkDtAtDT5eQ+f/mTWqrWYFEcqLEJJVmv6x/uKNv2lS66JUB
LlMaXHeyIiKjV01FrRiYaq/Fb0NqSHH92+2ScKxfIx7ZTuqbWzeRVZk5ZjOyXKdQ
sc+OooC7GsLB0NU/7zjCZ1+jMexscOFaqE47H/ru1h/ToV5gY2wrs1VDn7cZ4xBv
aavOQlYYzcRLXBBzbUu1T1dXub26s3ClYBpYqkQw2iYWWMgcqPqV4pWAMY+QFXra
8jNC1lAO7AiZyaImlsfRjuyFW7UPn9n+vBIwjyVpnN0s/OpDEt7T0qWQ7VQaNBCh
DPAvESUDz85clZf1mERORhVsPQMpSRb36VhbKBajm823o10q7fA8ewQZeKmyn+/A
+u/P2hpvmdWj91EHJaQQWqcnQKSiHpDGeykVxe4E8YV1iUg5iZt63SpW0nOXVUzz
CZw0FYKkcG1yZedDeHNp
=94ef
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
