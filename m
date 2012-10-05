From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH V4 0/5] OMAPDSS: Enable dynamic debug printing
Date: Fri, 05 Oct 2012 15:46:31 +0300
Message-ID: <1349441191.5836.8.camel@deskari>
References: <cover.1348826106.git.cmahapatra@ti.com>
	 <cover.1348914940.git.cmahapatra@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-W2DLWGsVSpYM3gE3DDwX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:35642 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752864Ab2JEMqg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Oct 2012 08:46:36 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so859333lag.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Oct 2012 05:46:33 -0700 (PDT)
In-Reply-To: <cover.1348914940.git.cmahapatra@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Chandrabhanu Mahapatra <cmahapatra@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-W2DLWGsVSpYM3gE3DDwX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2012-09-29 at 16:19 +0530, Chandrabhanu Mahapatra wrote:
> Hi everyone,
> this patch series aims at cleaning up of DSS of printk()'s enabled with
> dss_debug and replace them with generic dynamic debug printing.

Except for the missing debug print conversions in dsi.c this looks good.
Do you want me to apply the current series and you can send the dsi.c
patch later, or do you want to fix the dsi.c also before I apply?

 Tomi


--=-W2DLWGsVSpYM3gE3DDwX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQbtanAAoJEPo9qoy8lh71dDUQAIsavp10uUFApZSdw9cr5D65
uN3sQxSrunzfct1MxHW8dRjOsxaovKyf61Dt/Pl6e7sj9ZnKfehL6mR0q/IOjPjd
LoXn++N6Q3V1uoC/rOjSg24SZe+bKYHor5kiynPj2OQ2s5EbRWsRKY9FpA4ZFZ3e
mtMvPWNtrVBaErI7wQLGc97fkXlkgyuqByZ1RZU29oC62K7+gDx87XLNLfZ2CCgN
2jUXHSf4WiO+pPDfrh1DKtOudDpDIUncL9JyHTO2Og78BHGwhA0iedk8ViBtrqLw
ndIEJq+P47WKmCeyC/b3VHJeu7z7fp53kjeQx7AV9hSM6LkZckJ7BNPS2+vdWxV3
hzYY8Een/oYEbCt805IvpMPeCfGkib1Od0IZ5DOKsJixVwM2BWTGYi00fwqImy3X
MzWQi6OWgn4H3b5DTgYfRuYnAdvR2SbOZpelVvzbWnw9mdenAjtDTWRgv2PNOgS8
3RRkQlXddbcdNCsfZGFvEyACjlAR5VzPbmL9kATtOdyzKqMRVgTAKLkWyuWaaNSS
m+Db94/FG6lMCJdLqOXgzJ612xZP+FpiG3TEYJsIVLG47obLdifOUlmFrSmjcH2Y
r7niFbsrhEyHLjvUYC+RsG9VGQNQYKanxOiUfPtYAjidc9qLRzb5pLImtIGWBaY/
9SE/nghwCDYT+ms6yveP
=BZ4T
-----END PGP SIGNATURE-----

--=-W2DLWGsVSpYM3gE3DDwX--

