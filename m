From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 2/2] OMAPDSS: APPLY: make ovl_enable/disable synchronous
Date: Wed, 29 Feb 2012 12:30:38 +0200
Message-ID: <1330511438.1934.95.camel@deskari>
References: <1330505302-8258-1-git-send-email-tomi.valkeinen@ti.com>
	 <1330505302-8258-3-git-send-email-tomi.valkeinen@ti.com>
	 <4F4DFA30.2040503@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-7N8ND14wMVwAyzXsUKH7"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog122.obsmtp.com ([74.125.149.147]:44951 "EHLO
	na3sys009aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757542Ab2B2Kan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Feb 2012 05:30:43 -0500
Received: by bkcik5 with SMTP id ik5so2708559bkc.5
        for <linux-omap@vger.kernel.org>; Wed, 29 Feb 2012 02:30:40 -0800 (PST)
In-Reply-To: <4F4DFA30.2040503@gmx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Rob Clark <rob@ti.com>


--=-7N8ND14wMVwAyzXsUKH7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-29 at 10:13 +0000, Florian Tobias Schandinat wrote:
> On 02/29/2012 08:48 AM, Tomi Valkeinen wrote:
> > ovl->enable/disable are meant to be synchronous so that they can handle
> > the configuration of fifo sizes. The current kernel doesn't configure
> > fifo sizes yet, and so the code doesn't need to block to function (from
> > omapdss driver's perspective).
> >=20
> > However, for the users of omapdss a non-blocking ovl->disable is
> > confusing, because they don't know when the memory area is not used
> > any more.
> >=20
> > Furthermore, when the fifo size configuration is added in the next merg=
e
> > window, the change from non-blocking to blocking could cause side
> > effects to the users of omapdss. So by making the functions block
> > already will keep them behaving in the same manner.
>=20
> Is there any difference to doing it now?
> I agree that this should be fixed but if we can't avoid breaking users I'=
d
> prefer to break them in a merge window not in late rc stage. Or did we in=
troduce
> these functions just in the last merge window?

Yes, these were introduced in the merge window. And I explicitly said
the functions are blocking so that they can perform their job. And just
to clarify, the functions already use a mutex, so in that sense they are
blocking. They just don't currently wait until the HW has finished with
the overlay.

The problem was raised by Rob Clark, who's writing the omapdrm driver,
as he doesn't have a way to ensure that the overlay has been truly
disabled and the memory is is no longer in use.

(I forgot to cc him for the patch, adding him now).

 Tomi


--=-7N8ND14wMVwAyzXsUKH7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPTf5OAAoJEPo9qoy8lh71JXYP/1lWAePzCUKU4l2VJFJhBmhr
yqDPVPLUHvVsNMqdwHalUyHLGzb7keYnJrkLHUcigGaITpO3tiB51VLDerAtkvgS
YM6xvrs9Ny1jDlDphYixvlQEJ8q33Q3bkTzQVRbPVdBpJJaIqOG/H5JLOWg/tEYc
z2MqDolC8QvyQMJsN/uxVKhQjCPZb73rWhNdOyib5bK0FKrniGlNHJWXAj6VlwR7
J7nbq5suAmNT3mD7AeimSMsMMSBlDc32eqn1fjiDF2OadnCIGP+zqqRGcGv/TBAR
+DOU86b0oYGBCnClPXh3lBjPCAYhUvTzKP3gDuWjx7NfBLe3uws/BFLSYsjJLhVj
+sWbG4G/MTwWnwVFprIc/8E+Djn9D1QbRpKCPZb7Yg2M+Eq4Tde8IG1/Y8qh7Pk5
HRr1LIc6NSgShcejIkj9PWZ6lFOJn3q122uKhHlE1pp+jf6TFdiQAa7yLvmwBTH9
Ha2Ku5khtU+FFBQ7rR3bP0bK5J3yNz6N+ClhnqQ9KhUlahLXDQAVHjmAiO2Nglxl
GpcJA+CpL7z2KZEhGAxc1OOySYIHWCZDFSDj/WHjA6FuLQOja+fLXof1AS+SX8or
64CjXL8SBJmYLN3sFm63EnWXSFTbIW/pEzHXuFnFkmozV8sZuXl+FDH3PPCHY4jN
u2yegW/r3VxF8kva5nh9
=ApKS
-----END PGP SIGNATURE-----

--=-7N8ND14wMVwAyzXsUKH7--

