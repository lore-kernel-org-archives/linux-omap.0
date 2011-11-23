From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 41/65] OMAPDSS: APPLY: add missing uses of spinlock
Date: Wed, 23 Nov 2011 12:12:23 +0200
Message-ID: <1322043143.28917.33.camel@deskari>
References: <1321953724-6350-1-git-send-email-tomi.valkeinen@ti.com>
	 <1321953724-6350-42-git-send-email-tomi.valkeinen@ti.com>
	 <4ECCC332.4050608@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-Gp0/w26QbZtIc+V2JnvU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:54248 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751533Ab1KWKMd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Nov 2011 05:12:33 -0500
In-Reply-To: <4ECCC332.4050608@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, archit@ti.com


--=-Gp0/w26QbZtIc+V2JnvU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-11-23 at 15:26 +0530, Archit Taneja wrote:
> On Tuesday 22 November 2011 02:51 PM, Tomi Valkeinen wrote:

> >   int dss_mgr_set_device(struct omap_overlay_manager *mgr,
> > @@ -745,16 +762,28 @@ err:
> >   int dss_ovl_set_info(struct omap_overlay *ovl,
> >   		struct omap_overlay_info *info)
> >   {
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&data_lock, flags);
> > +
> >   	ovl->info =3D *info;
> >   	ovl->info_dirty =3D true;
> >
> > +	spin_unlock_irqrestore(&data_lock, flags);
> > +
> >   	return 0;
> >   }
> >
> >   void dss_ovl_get_info(struct omap_overlay *ovl,
> >   		struct omap_overlay_info *info)
> >   {
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&data_lock, flags);
> > +
> >   	*info =3D ovl->info;
> > +
> > +	spin_unlock_irqrestore(&data_lock, flags);
> >   }
>=20
> The get/set info functions for overlays and managers only modify the=20
> omap_overlay_info or manager_info structs, these aren't really a part of=
=20
> 'dss_data', they only become a part of dss_data only when we call=20
> mgr->apply().
>=20
> So, are we protecting these functions so that 2 users of the same=20
> overlay don't see incorrect info values?

True, at this point the data_lock is a bit vague, and is protecting also
the info fields in omap_overlay and omap_overlay_manager.

A lock is needed, though, as otherwise the info struct may be only
partial. E.g. somebody calls set_info, which is half way copying the
values, and somebody else calls apply or get_info.

In the next patches the infos will be moved into the dss_data, and then
using dss_lock spin lock makes more sense.

 Tomi


--=-Gp0/w26QbZtIc+V2JnvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJOzMcHAAoJEPo9qoy8lh71B3YP/A56TyVkP3QSmaCIg9wzQqCg
Z1/p1APU4PddFlL/M00dTSC+lH41Qpjsa4g4E+aTRCjST3ObwC14DoZw8t5+X2Bv
t2GMJGPpTUCXhsG/V3Ia+1G2IJeY0CZsvOeCbIlvRmUGD6euLvpVeEX+TjDrtTN5
cPDl4XV8b0y8KN5VmwtREz6QZ3x+ncMiRomRCQqrNbkAu+e+FmTce9TLb8moiiH0
+RbMWq+u7EP8DHGyv0sVxyWIb9Tk9Nj9PiBO1sA7bP2w2xKWu6nCphriZGOlo61s
KFJcNyb5TeZb1iJdcemNC+jN9b2so5wmGg4YQw8ugEUHJuI4ca0S9Lu/2vJQbUMK
x5PRGxGo/CTI798RF3BBxeLcmVBIgGsheSm9Hz1/brZFth9KMl3WK5ju4RbUisUt
y2K3rqlu+B4N/Wwroz7FC7+AIfkYxN6+zz0saruZaloGViBSAuxc7PctxDq2fkt4
RDSy3F6UBti/VmHaKEjhmgJcQs7LA+oFiQEmJD7/EsYQH0QO/8fk58kPx5PIwlxm
ktiXu5hTaJj7Z9gWGye5CM/Pkc9Z1y8IDPM6YbqO0K5HD0juY1EZ/3x+0+gQ+m2M
h9Kj+XI9BfnruWZ/YaLPwzo28YVM2EMzBDbc+1sjYmaTVGj5dNPXS0t9T4KXUwdK
8KClTUVEb/qWO0Zb++ap
=VsZe
-----END PGP SIGNATURE-----

--=-Gp0/w26QbZtIc+V2JnvU--

