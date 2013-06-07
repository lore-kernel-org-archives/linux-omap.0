From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 19/32] OMAPDSS: add videomode conversion support
Date: Fri, 7 Jun 2013 11:35:43 +0300
Message-ID: <51B19B5F.2060005@ti.com>
References: <1369906493-27538-1-git-send-email-tomi.valkeinen@ti.com> <1369906493-27538-20-git-send-email-tomi.valkeinen@ti.com> <51B18687.6000602@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2WUSNPNVHBDFDKBPAGWFC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48398 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab3FGIfq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jun 2013 04:35:46 -0400
In-Reply-To: <51B18687.6000602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org

------enig2WUSNPNVHBDFDKBPAGWFC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 07/06/13 10:06, Archit Taneja wrote:
> On Thursday 30 May 2013 03:04 PM, Tomi Valkeinen wrote:
>> Add helper functions to convert between omapdss specific video timings=

>> and the common videomode.
>>
>> Eventually omapdss will be changed to use only the common video timing=
s,
>> and these helper functions will make the transition easier.
>=20
> So we now use omap_video_timings, videomode, drm_display_mode, and
> fb_var_screeninfo, fun! :)

Yes, although videomode is only used when passing videomode from the
board file. I wanted to make that right from the start.
omap_video_timings is still used everywhere else in omapdss.

 Tomi



------enig2WUSNPNVHBDFDKBPAGWFC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRsZtfAAoJEPo9qoy8lh71kdcP/jxLI7ca+PRDX7F49xdEC2Iw
KnhEVubvxqMffNJ2F2+sNYbXH6VVNNj2zyD4xLh9uI8XXoYjHWH5LFkOcaE2Mdk9
uNbuVbVlETN4RupeWr7ZVyYVGNkONFCLYIrdcuu0isLWLredDeyX19+kLTr7Cinc
o3LVgQCrigwwpQcnoexe03XmJMxhbEexd1ecbkpnEaNnO+9QcmIJ832xVmEoCcQH
a3wU/5rzjqojLYNXA3FEJF8CrE9j/biPjDXvKbBYFZ0EoI7Ja3gJDhgGkdqb5l2o
EAF+7gXUY+4oxbWg0eWagUtFu7JkX7K7JoKTr10+3rUQkrX6LTa0tU5remCR8EDc
KnOOUb9NHqa7PvatsnA1dTk8IFEUYHd4Wo2isjJ0Mvx8ZJztBOCzfMweIxtu47/H
bXs78zmi2j8m6RHEXvswSPqYHhhyl/nhh4PWiJMhdpTTmOEAD9s2osI08y+8rZRp
O5/5Afd30ileVKinNC38KUTaT+8ks+l9VBGox81FsOmmNo9DzH7BEwNKVRthtYtC
Z0OkK7N8xYkQSvYIoWJ/I1+PbtdGK6LtuPjZxscHxliKdDfmBUSYfe2kLEoBLrvH
pziD5ak6CIRKvjTI20AhMYoNAaXy1toEvOOzfefd3ce6Ji6nOHVCaFWAcEAlac9J
wFrszTsrSWpqhiVfrrU6
=qPyR
-----END PGP SIGNATURE-----

------enig2WUSNPNVHBDFDKBPAGWFC--
