From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [RFC 00/17] OMAPDSS: Change way of passing timings from panel
 driver to interface
Date: Wed, 08 Aug 2012 11:13:00 +0300
Message-ID: <1344413580.4932.5.camel@deskari>
References: <1343817088-29645-1-git-send-email-archit@ti.com>
	   <1344349948.7216.82.camel@lappyti> <502201B7.9030205@ti.com>
	  <1344407158.17575.21.camel@lappyti> <50220B94.5040303@ti.com>
	 <1344410835.17575.54.camel@lappyti> <50221C4D.8000503@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Gv9mcFQJgn0afrTj1C0/"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog138.obsmtp.com ([74.125.149.19]:48338 "EHLO
	na3sys009aog138.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757856Ab2HHINJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Aug 2012 04:13:09 -0400
Received: by lahd3 with SMTP id d3so221712lah.28
        for <linux-omap@vger.kernel.org>; Wed, 08 Aug 2012 01:13:06 -0700 (PDT)
In-Reply-To: <50221C4D.8000503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, sumit.semwal@ti.com, rob@ti.com


--=-Gv9mcFQJgn0afrTj1C0/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-08 at 13:29 +0530, Archit Taneja wrote:

> Okay, one thing which I want to align on is that most of these functions=
=20
> don't really do the actual configurations. That is, they'll just update=
=20
> the private data, and the actual configuration will only happen on enable=
.
>=20
> We would want set_timings() op to have a direct impact. But we wouldn't=
=20
> want the same for setting the data lines, that could be clubbed with=20
> other configurations at enable. That's okay, right?

I'm not sure we want/need set_timings to have direct impact. Changing
the timings on the fly has some problems, like the output size changing
to smaller than the overlays, and we perhaps may need to adjust the
clock dividers (dispc's, DSI PLL's or PRCM's).

It feels just much easier and safer to require that the mgr is disabled
when these changes are made. And as far as I can see, there shouldn't be
any need to change the timings via the shadow registers, as quickly as
possible and during vblank...

This makes me also think that if the output related settings can only be
changed when the output is off, the apply mechanism is not really needed
at all for these. Not that it causes any harm, but just a point I
realized.

 Tomi


--=-Gv9mcFQJgn0afrTj1C0/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQIh+MAAoJEPo9qoy8lh71ErAQALEu/gSVKgSCnifBX6HpXq6N
1L81jnqDe4OXXneT4bDPR1jI6cvHYkoa49XFRB0hHFP9vSPG3vKfCDzFIc0Uypsa
kbp77hT6jXIQ1hYqDnLOj//PbyKqGKmmjr1xnQR8M86oAIrRDnP6SPsD5FdrMBSS
zZmHH8MUV8juZxxQMpbS4xlrGyVdyd6D1NS1J+ctQmrweicEOyoBAF/sHJWmiutV
SzRL/bC4cDMakR/Ukd1LY7l7800445KXRyBqWmHfjHTbgSI/YIVUawyTJrwZI5UI
1DwY6FdWfWZblPOwTTMUcYO+lTWQ2XreQ6DmHyPnxD2u1AuC4TJdyoQChHhhuucN
0DgWJtCQGrTUU1TCoyOdEQCmG9nc6+vtn0zdv04Pp1b/kZJJB2F/1SAYAjUe+mAP
YM1MH24yALeT/+3lYCRu5nWBGtOj9+z/jrMIpl1ftcdR0AgZzfoyXDJh3Vux35xc
5T83KkMSLrOStg8sLCPzn2e03QP3SuX/sO70vKO9xd9sGNohERyEdYdYihAy7ivY
QxFZqk8R1GvH6RGNq+hsfr9MjvQ0XeKhWMJsqtQmSFyuz2CDRLWjsYXo8/T6cWvt
2Lm9A3PeeHV+RCmuVRdfckPxgZ/tbMz+diS25cQx21jAbu631zn6rUe27OY6nOIt
utCTzTBae/nnYu82yTRp
=pAb9
-----END PGP SIGNATURE-----

--=-Gv9mcFQJgn0afrTj1C0/--

