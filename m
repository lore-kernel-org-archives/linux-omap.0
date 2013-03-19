From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 3/4] drm/omap: Make fixed resolution panels work
Date: Tue, 19 Mar 2013 15:25:15 +0200
Message-ID: <5148673B.4020504@ti.com>
References: <1362493070-17706-1-git-send-email-archit@ti.com> <1363093583-28285-1-git-send-email-archit@ti.com> <513F3658.3000300@ti.com> <513F3DE5.2090903@ti.com> <513F4154.5040904@ti.com> <514809A1.9050108@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigA9662C138E67DE832BBA3302"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51398 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752651Ab3CSNZT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Mar 2013 09:25:19 -0400
In-Reply-To: <514809A1.9050108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: robdclark@gmail.com, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

--------------enigA9662C138E67DE832BBA3302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-19 08:45, Archit Taneja wrote:

> I was trying to come up with a macro which could add default ops to the=

> omap_dss_driver. It isn't straight forward as I thought, because you
> need to choose either the default op, or the panel driver's op if it
> exists. For example, I can't create a macro which adds an op for
> get_timings() to all panel drivers, the panel drivers which already thi=
s
> op defined will have 2 instances of get_timings() in the omap_dss_drive=
r
> struct.

Yep, I noticed the same a few days ago.

> I have been looking around in the kernel to see how undeclared ops in a=

> struct are generally dealt with. Till now, I've noticed that the code
> which uses this ops takes the responsibility to check whether they are
> NULL or not.
>=20
> The easiest way would be to have these default funcs inlined in a
> header, and every panel driver's omap_dss_driver struct fills in the
> default op. This way we can make the driver ops const. Do you have any
> idea of a macro which could do the same as above, and leads to less
> addition of code?

Why would they need to be inlined?

Another option would be to create global funcs that are used to call the
ops. So instead of:

dssdev->dssdrv->foo(dssdev)

the user would call this function:

int dss_foo(struct omap_dss_device *dssdev)
{
	if (dssdev->dssdrv->foo =3D=3D NULL)
		return 0; /* or error, depending on case */
	return dssdev->dssdrv->foo(dssdev);
}

But that'd require adding a bunch of functions, and changing all the
callers.

I think the safest way to fix this for now is to add the checks into
omapdrm as you do in your original patch. If we go for some other route,
I fear that omapfb/omap_vout could be affected, as it could presume that
an op being NULL or non-NULL means something. If we change the ops to be
always non-NULL, we should go over the uses of those ops to verify they
work correctly.

 Tomi



--------------enigA9662C138E67DE832BBA3302
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRSGc7AAoJEPo9qoy8lh71twAP/1hnPsbaQn+ue06TirzaMr6N
VX3FfVOC0GLTQLzHZsMSiJ8uw0YCtHWL7H/ZXZSmiuu3xg8ytxSpfdEFwtiyCjKs
ZCaqsGD6e2aL3FP33NxLFKQi3JHs16ptpbO+GAUm7iaO+GkySxL3Nm492fTDVA97
gXBU4eIusA/cyEbP6shWIMBq0WUzHLE0n6ml/9jec3muGa005ENCSxf3c+UB+3h0
d7eQnSbqCyOd/UoyPeMr0RbehrSUe8TJkLhWdQh1649SZgudXU7MtD/v2xlIo3ep
3TSmAIricxdNKDFJzLL+5RcgXhbzFhQHQea97lfGZO8pEhi3JlSY+wFjO8F94lzd
PsJ9MaKEysBPb3fr50v8dPFEn72EFGRat7SoKzfRzfLULaZusRTU3JCDmKSSwVEC
bb0a5DtcRa4dI2fZPJCVCN5SvC4poDZyA3VG6QVpYxHl1kgN3MXA2TEuriHcPQJF
Hh4mJ3+tA0gJl5vXm+Q9ZcboyFMvIwVmt4hjLcDj9k98L+wguSmB/HtKx93KJ6NV
cLzlAINPGYN3D0ad43+UgidAEc8PsMr3GpFzdBLOSB30E0ObC2Qfwj6FZ+qmIaKK
BcP6To2YqO6iIZLOdK6f5e1icyMzBIVaNpHC/13LueS7aBQZopDe68eqxDIhLz//
6ePv6ob9SCahvF/tt0ft
=xB9s
-----END PGP SIGNATURE-----

--------------enigA9662C138E67DE832BBA3302--
