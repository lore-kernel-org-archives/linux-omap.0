From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v4] OMAPDSS: DISPC: Improvements to DIGIT sync signal
 selection
Date: Thu, 02 Aug 2012 10:48:27 +0300
Message-ID: <1343893707.2686.3.camel@deskari>
References: <1343825800-6971-1-git-send-email-ricardo.neri@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-CAQVFMLOul/cdHrAvQPx"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog127.obsmtp.com ([74.125.149.107]:44366 "EHLO
	na3sys009aog127.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751933Ab2HBHsz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 2 Aug 2012 03:48:55 -0400
Received: by lbol5 with SMTP id l5so850324lbo.20
        for <linux-omap@vger.kernel.org>; Thu, 02 Aug 2012 00:48:29 -0700 (PDT)
In-Reply-To: <1343825800-6971-1-git-send-email-ricardo.neri@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ricardo Neri <ricardo.neri@ti.com>
Cc: archit@ti.com, s-guiriec@ti.com, linux-omap@vger.kernel.org


--=-CAQVFMLOul/cdHrAvQPx
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-08-01 at 07:56 -0500, Ricardo Neri wrote:
> DSS code wrongly assumes that VENC is always available as source for the =
external
> sync signal for the display controller DIGIT channel. One cannot blindly =
write/read
> the value of DSS_CONTROL[15] as in certain processors (e.g., OMAP5) this =
operation
> may not be valid. If the the sync source is not read correctly, the calle=
rs of
> dss_get_hdmi_venc_clk_source might make wrong assumptions about, for inst=
ance,
> video timings.
>=20
> Logic is added to correctly get the sync signal based on the available di=
splays
> in the DIGIT channel. The source is set only if both VENC and HDMI are su=
pported.

Thanks, applied.

 Tomi


--=-CAQVFMLOul/cdHrAvQPx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJQGjDLAAoJEPo9qoy8lh71TiMP/3JjBabPlzD18vVngGP5v23f
lBBU8uYcnVseLDq7UE94IOfJDtHHtTqjbn6YCbb1PnW8xMuhE5NH2fkZ2QNWPyad
DcyGA/Ne0zB62mj1x3JjIJWS5LddCG4tvV+bNxK+sTXvOdq0HaDw63fG4sFr+OqJ
81A1HY2Jy00Hb1e7IQ3AzZWwncsdfexFyxzQmZhcv7/7F1xkQ2hgYSNjSflEHFkU
7LqIj7t42c89bRPdlUdEYI18Q444IuhSIHnuVBHy3IxR2qoLn5KAR1E4fdX2SpGZ
OKgBST1IaCzn36khWDre4QAOvlP3FmXZYi7f+oAyDnox6GTDxN8QHoSEIE0K7YIl
KpvFIhVrsxnLqArAbmYBwa9cSpg4GsalZ5+prkLDcKECneyJnZRCcfmw0lhkrn4a
SJB9TC+OS2h6/NxqOJr/M55yeCstmigiUW1dvOkA/nxkh8J8ARG3TzXWbS4mkqel
Z/uRLfYUReESFnRk1qW+iOh3teb+1GFNx/2rU+QCeE5W8OlYQIAoVipgymB5o14j
wW5PpC1XMfOwYUPpTCCH+3RFYu7uKm/ElwwsfnI+89ZijMuFj1wNEiWMmNnNSIqF
CEnuQxbaDo32nav7REaOH4tMOmpwa75hOw/Voh5mNhrHLwj9DAass4fCrmLTgoF8
8B7MF2gQKKFJ1gDDX3Hw
=ZPDP
-----END PGP SIGNATURE-----

--=-CAQVFMLOul/cdHrAvQPx--

