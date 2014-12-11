From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 2/7] arm: omap: devicetree: add new properties for
 OMAP devices
Date: Thu, 11 Dec 2014 08:21:59 -0600
Message-ID: <20141211142159.GD20762@saruman>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-3-git-send-email-balbi@ti.com>
 <54882967.60302@ti.com>
 <20141210150049.GD4602@saruman>
 <20141211004627.GB5585@earth.universe>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRE3mIcgqKzpedwo"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:43344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754406AbaLKOWb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Dec 2014 09:22:31 -0500
Content-Disposition: inline
In-Reply-To: <20141211004627.GB5585@earth.universe>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Felipe Balbi <balbi@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

--BRE3mIcgqKzpedwo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Dec 11, 2014 at 01:46:28AM +0100, Sebastian Reichel wrote:
> On Wed, Dec 10, 2014 at 09:00:49AM -0600, Felipe Balbi wrote:
> > On Wed, Dec 10, 2014 at 04:37:19PM +0530, Lokesh Vutla wrote:
> > > On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> > > > In order to get rid of some more hwmod data, we
> > > > introduce a few extra properties to OMAP DT
> > > > data in order to be able to pass the needed
> > > > information through DT.
> > > >=20
> > > > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/omap/omap.txt | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/=
Documentation/devicetree/bindings/arm/omap/omap.txt
> > > > index 4f6a82c..c6b9515 100644
> > > > --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> > > > +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > > > @@ -23,6 +23,13 @@ Optional properties:
> > > >    during suspend.
> > > >  - ti,no-reset-on-init: When present, the module should not be rese=
t at init
> > > >  - ti,no-idle-on-init: When present, the module should not be idled=
 at init
> > > > +- ti,rev_offs: IP block revision register offset (defaults to 0)
> > > > +- ti,sysc_offs: OCP_SYSCONFIG register offset (defaults to 0)
> > > > +- ti,syss_offs: OCP_SYSSTATUS register offset (defaults to 0)
> > > > +- ti,srst_udelay: Delay needed after a softreset in usecs (default=
s to 0)
> > > > +- ti,idlemodes: Slave and Master supported idling modes
> > > > +- ti,clockact: default value of clock activity bits (defaults to 0)
> > > > +- ti,sysc_type: OCP_SYSCONFIG type. Valid types are 1, 2 or 3 (def=
aults to 1)
> > > Once if all the hwmod data comes to dt it will be very dufficult to s=
ee all the data
> > > together. Can we separate out hwmod class data like clocks data is se=
parated out into different node
> > > or something of the sort like below?
> > >=20
> > > 	ti, hwmod_class {
> > > 		ti,class_name =3D <>;
> >=20
> > this can be done, but I don't want to pass a class name. It's anyways
> > just the hwmod name without the digits. For those which are not, I would
> > rather change the class name to match.
>=20
> I did some initial thinking on this some weeks ago, too (and then
> was short of time, so I did not continue). My suggestion for the
> binding would be:
>=20
> * OCP_SYSCONFIG (power-management of IP-Cores connected to OMAP processor=
s)
>=20
> Each IP-Core connected to the bus of OMAP processors has
> three registers, which specify the IP-Core's version, its
> status and setup of PM features.
>=20
> Required Properties:
> - ti,prcm-type: must be one of the following:
>    1 for OMAP2+ register style,
>    2 for OMAP4+ register style,
>    3 for AM33xx register style
> - reg: offset to revision, config and status registers
>        relative to module base address
>=20
> Optional Properties:
> - ti,idlemodes:                bit field of flags (SIDLE)
>    PRCM_IDLE_FORCE               (1 << 0)
>    PRCM_IDLE_NO                  (1 << 1)
>    PRCM_IDLE_SMART               (1 << 2)
>    PRCM_IDLE_SMART_WKUP          (1 << 3)
> - ti,standbymodes:             bit field of flags (MIDLE)
>    PRCM_STANDBY_FORCE            (1 << 0)
>    PRCM_STANDBY_NO               (1 << 1)
>    PRCM_STANDBY_SMART            (1 << 2)
>    PRCM_STANDBY_SMART_WKUP       (1 << 3)
> - ti,sysc-has-autoidle:        config register has AUTOIDLE bit
> - ti,sysc-has-softreset:       config register has SOFTRESET bit
> - ti,sysc-has-enawakeup:       config register has ENAWAKEUP bit
> - ti,sysc-has-emufree:         config register has EMUFREE bit
> - ti,sysc-has-clock-activity:  config register has CLOCKACTIVITY bit
> - ti,sysc-has-dma-disable:     config register has DMADISABLE bit
> - ti,sysc-has-reset-status:    config register has RESETDONE bit
> - ti,syss-has-reset-status:    status register has RESETDONE bit

I thought about having boolean flags like this but after talking to Tony
we agreed that it would just increase the amount of string parsing
during early initialization. Besides, why have two properties using an
integer bitfield and another huge number of boolean properties ?

> - ti,reset-delay-us:           reset delay in us
>=20
> Example:
>=20
> ocp {
> 	gpio1: gpio@48310000 {
> 		compatible =3D "ti,omap3-gpio";
>=20
> 		... /* IP-Core specific properties */
>=20
> 		ti,sysconfig {

this is what I'm still waiting for comments from Tony. I'm not convinced
we need this extra indentation level. It really brings nothing of value.

--=20
balbi

--BRE3mIcgqKzpedwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUiaiHAAoJEIaOsuA1yqRESocQAKWuOSha19GEHOg5S6G5xqsF
WUIHWg38y+IgxHwBcyuuNep5GREzqF6sxQAcKLjYeu6kyohlWCgtaUdB+/FN6/OI
m/EzzwjvG41lPQ0Sw+wLSJZHooOeRHUnNOdyIlh5/DcpSP6vzIQulslP+lzHKKeX
7YToUvXI52C5AR+pQ5NeXdOTrgf4150/8g8InZ1vPvBS7zg4h0WGjTQUheZj66MR
MLoYQ3GxqBOcMtYQFOqQo0BgyWKOWpHpykJDAA7wMDHMhTOhQo2PUQpUJb721QyC
ngOcpivtrczUIUKs4u9cXMdoezvvBo2OmLZ1/urocJxTKHki60950Ovi6etpL7+y
8S6Dg2pmNRT2FQEe5BE8P/5dlR5bsl2Kd/bbDCA1lPbtDLKvQ1Syv2KbNq4+kMvL
XX8sPKdtx4a83x0jcEfQUmABjNQv35Epog28gg0l1Lh+YN2ZQZ20S8CJX8SOpspC
Uzc6N5IIFL13ghvmBHk8wQwJzarKb5RMvAJOWKB9sgDBIGGoRva+Xq7L119+AKLq
/JclwzwvzdIyRHZ9N6xNF1jGE/sXwqfxwEHqcUzvkOMzNFFLtxgrGIBJdVxDt1fU
fUa2ISQPgUhJwonuGlwG9nHl/DmsbNLnL1SUM+MB9UBvCm46S3yOgFZLcA3mBd1Y
AZD1IND561+M73wkwsgg
=5CVe
-----END PGP SIGNATURE-----

--BRE3mIcgqKzpedwo--
