From: Felipe Balbi <balbi@ti.com>
Subject: Re: [RFC/PATCH 2/7] arm: omap: devicetree: add new properties for
 OMAP devices
Date: Wed, 10 Dec 2014 09:00:49 -0600
Message-ID: <20141210150049.GD4602@saruman>
References: <1418164072-19087-1-git-send-email-balbi@ti.com>
 <1418164072-19087-3-git-send-email-balbi@ti.com>
 <54882967.60302@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T7mxYSe680VjQnyC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:60333 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757171AbaLJPBR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Dec 2014 10:01:17 -0500
Content-Disposition: inline
In-Reply-To: <54882967.60302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Paul Walmsley <paul@pwsan.com>, Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org

--T7mxYSe680VjQnyC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 10, 2014 at 04:37:19PM +0530, Lokesh Vutla wrote:
> Hi Felipe,
>=20
> On Wednesday 10 December 2014 03:57 AM, Felipe Balbi wrote:
> > In order to get rid of some more hwmod data, we
> > introduce a few extra properties to OMAP DT
> > data in order to be able to pass the needed
> > information through DT.
> >=20
> > Signed-off-by: Felipe Balbi <balbi@ti.com>
> > ---
> >  Documentation/devicetree/bindings/arm/omap/omap.txt | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/arm/omap/omap.txt b/Docu=
mentation/devicetree/bindings/arm/omap/omap.txt
> > index 4f6a82c..c6b9515 100644
> > --- a/Documentation/devicetree/bindings/arm/omap/omap.txt
> > +++ b/Documentation/devicetree/bindings/arm/omap/omap.txt
> > @@ -23,6 +23,13 @@ Optional properties:
> >    during suspend.
> >  - ti,no-reset-on-init: When present, the module should not be reset at=
 init
> >  - ti,no-idle-on-init: When present, the module should not be idled at =
init
> > +- ti,rev_offs: IP block revision register offset (defaults to 0)
> > +- ti,sysc_offs: OCP_SYSCONFIG register offset (defaults to 0)
> > +- ti,syss_offs: OCP_SYSSTATUS register offset (defaults to 0)
> > +- ti,srst_udelay: Delay needed after a softreset in usecs (defaults to=
 0)
> > +- ti,idlemodes: Slave and Master supported idling modes
> > +- ti,clockact: default value of clock activity bits (defaults to 0)
> > +- ti,sysc_type: OCP_SYSCONFIG type. Valid types are 1, 2 or 3 (default=
s to 1)
> Once if all the hwmod data comes to dt it will be very dufficult to see a=
ll the data
> together. Can we separate out hwmod class data like clocks data is separa=
ted out into different node
> or something of the sort like below?
>=20
> 	ti, hwmod_class {
> 		ti,class_name =3D <>;

this can be done, but I don't want to pass a class name. It's anyways
just the hwmod name without the digits. For those which are not, I would
rather change the class name to match.

--=20
balbi

--T7mxYSe680VjQnyC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUiGAhAAoJEIaOsuA1yqREM48QAKuL33csR+O99dHxFfj+hLww
31sPi8FtFzK2My/YxGBRSoO+/SXpffouQT8e2mrosQnmiDRLVBQLT8yqy4o9dNV8
TpG34X1NLsXb/GWWf7cY2KxxnSkO9I7Gv4wm/NQJ3l6ZwBk1V8RlE9oFttWusYUW
5rH2eAwcGqM6z86KkQIVQB/rnoSwiDcIpmcgqahoZENJOeBQfFV1C6n4NMy0b4nm
hrPjm2DrAZtWAMyq0b7QX0u6NEpBoSBeMC3LmBerKU1OH/TVH0TI/A0K5ZtrZmmd
wzbh8RVs6+mfkZynwl9NFF/E1B7ywzS/RawYGI+oFouGg62oVV1+ebwZ7PxFMrMh
CXvyQK9rKuXAaMX0mM1PNn5rZcFxUTxLBGCXZLoyKha6eVtYTaOFOUT6UZKovVc+
rMsjBWg9ZbsiCaBF0qRlF5eSffDYZPiA0R760zQUZK9a4vkOVY7x0BNtVw/2Ikoz
uWWfYE9nsGEM0ojv6Ow7k41ljd1u/cBbozVjdCRjPFvnunwgA7upw6i8OHY8jQjy
2ZotRIPHj+YNV7yAfj1LJvT3y5SQl4N+RRN8lBXUFZc1WbVwnXSdMDOUq9CKsEkS
uEZV020vfqkSAw3YynJDqwTYS+7cC70oi81XXSwvCIEJMe9BuFTn2HynniAH9YT3
m7zKyBOdeTdix/+/GAU0
=CHQz
-----END PGP SIGNATURE-----

--T7mxYSe680VjQnyC--
