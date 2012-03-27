From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V2 2/3] OMAPDSS: DISPC: Handle synclost errors in OMAP3
Date: Tue, 27 Mar 2012 14:10:16 +0300
Message-ID: <1332846616.1867.132.camel@deskari>
References: <1332323516-9050-1-git-send-email-cmahapatra@ti.com>
	 <1332845034.1867.116.camel@deskari>
	 <CAF0AtAsfE4xjiLOcvmPB4KCJn4QjN+PumJWQEM3m6ZziK4zhVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-b29zKXlcNtTikIrhsNgb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:39026 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753481Ab2C0LKU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 27 Mar 2012 07:10:20 -0400
Received: by mail-lpp01m010-f51.google.com with SMTP id p9so4420511laa.10
        for <linux-omap@vger.kernel.org>; Tue, 27 Mar 2012 04:10:19 -0700 (PDT)
In-Reply-To: <CAF0AtAsfE4xjiLOcvmPB4KCJn4QjN+PumJWQEM3m6ZziK4zhVw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mahapatra, Chandrabhanu" <cmahapatra@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-fbdev@vger.kernel.org


--=-b29zKXlcNtTikIrhsNgb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-03-27 at 16:31 +0530, Mahapatra, Chandrabhanu wrote:
> On Tue, Mar 27, 2012 at 4:13 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> w=
rote:
> > Hi,
> >
> > On Wed, 2012-03-21 at 15:21 +0530, Chandrabhanu Mahapatra wrote:
> >> In OMAP3 DISPC video overlays suffer from some undocumented horizontal=
 position
> >> and timing related limitations leading to SYNCLOST errors. Whenever th=
e image
> >> window is moved towards the right of the screen SYNCLOST errors become
> >> frequent. Checks have been implemented to see that DISPC driver reject=
s
> >> configuration exceeding above limitations.
> >>
> >> This code was successfully tested on OMAP3. This code is written based=
 on code
> >> written by Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com> in Linux =
OMAP kernel. Ville
> >> Syrj=C3=A4l=C3=A4 <ville.syrjala@nokia.com> had added checks for video=
 overlay horizontal
> >> timing and DISPC horizontal blanking length limitations.
> >>
> >> Signed-off-by: Chandrabhanu Mahapatra <cmahapatra@ti.com>
> >> ---
> >>  drivers/video/omap2/dss/dispc.c |   97 +++++++++++++++++++++++++++++-=
---------
> >>  1 files changed, 72 insertions(+), 25 deletions(-)
> >
> > The patch seems to be using dos line endings... Where did they come
> > from? The two others are fine. I think git am removed the dos line
> > endings, so it's fine.
> >
>=20
> How did you find these errors? scripts/checkpatch.pl still returns me not=
hing.

Well I just saved the email and ran checkpatch. Could be a problem in
gmail or my end too, but I've never seen it happen before.

 Tomi


--=-b29zKXlcNtTikIrhsNgb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPcaAYAAoJEPo9qoy8lh71ItcQAJZsx9MNaEFUxhZ28S3q2igo
rvmjT7NexftMFKbVJmHAaqCCYnGqkWO1UKpqvkTRKu+AmbVYWKgia2hMjwwWZeNC
5Ep1c763MxDdPwcfEEcXxTrJzy5uBia0C6GTqtQZRJuNU4JruXJAR+RleHfAIjGH
b8VCmATGeF/bT7/cCKjuVtjBIf+Cehz8CItfKwUiCkeJLwT1U9kqjGKrJDPbcIQj
5x1LwPWEwpn0gvqcKcCSwleM446jKeREBQlwmYHJNr+BlqWiAx98Bc1AceTXD6fw
MwUVG0jWuTJbbJDEPmyA6u2gFy2aUYksdxF8w0MIKiA00WnKPs8OHgwG/sHz0SSW
brIL8N3frkgllPCkF2kY5dpzAbuSZa6MkTzsG6bd+Km1nlYHpqug5lXrYZb7GK/6
LBS7hXAC2/NLjj3vMBKU+iJD6pcKe+lSHltXeBHXdA79Mf3DbpOsADZStF9O5/Cg
Yjx0y4xNoO+tpB8pwwXkBG1PQ5vqUjmEC9n6YzjZilVHMY3Ue05DiC4QHV7M1wg1
bAM9a/YPDVPnhbo9eY1SUn8sii8jjuzSTHmybtlAAZz7m8fydJc3sevd2Unt7u7T
qD8mw9b0721GE/V41VIMXS+xFAFvOSFQXLCP1ACXy+NsDhebnp9l3IK/JnPGNm1r
GbbAokSxj7FHrevP82RR
=q6jG
-----END PGP SIGNATURE-----

--=-b29zKXlcNtTikIrhsNgb--

