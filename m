From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 1/3] OMAPDSS: HDMI: HPD support in boardfile
Date: Tue, 10 Jan 2012 09:43:20 +0200
Message-ID: <1326181400.1939.42.camel@deskari>
References: <1325853877-6712-1-git-send-email-mythripk@ti.com>
	 <1325853877-6712-2-git-send-email-mythripk@ti.com>
	 <1326181045.1939.38.camel@deskari>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-glU5KHS9Z7rGU6+kzAPm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:56629 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751108Ab2AJHnZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 02:43:25 -0500
Received: by mail-lpp01m010-f44.google.com with SMTP id h2so2112987laa.31
        for <linux-omap@vger.kernel.org>; Mon, 09 Jan 2012 23:43:23 -0800 (PST)
In-Reply-To: <1326181045.1939.38.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mythripk@ti.com
Cc: linux-omap@vger.kernel.org


--=-glU5KHS9Z7rGU6+kzAPm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2012-01-10 at 09:37 +0200, Tomi Valkeinen wrote:

> I still think we should try to fix the bug at hand, not try to implement
> proper HPD support. Was there something wrong with the example patch I
> gave? (other than it needs some splitting up).

And one reason I'm saying we shouldn't try to implement HPD properly is
that with device tree the handling of the GPIOs will change, and if you
now make the driver handle the HPD in the generic hdmi layer, it may
well be that with dev tree it will change (I'm not sure yet how the
GPIOs will be managed there, but most likely they will be passed to the
IP driver).

So I think we should make the simplest possible implementation to handle
the PHY bug, inside the IP driver.

 Tomi


--=-glU5KHS9Z7rGU6+kzAPm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPC+wYAAoJEPo9qoy8lh71hGgQAIStklS+3SQ8VZWasEt91EIg
egOl0tRCehQU3majDYoK6wmc/106egcMU5+G+4dRrVF67AU6cbNWUpFdV4xSaAwD
Kpa7LwEw/r0oe2JbBmA9ljNnLmTZyqKf5aPbXN59uMRsDF2zUlkfM76NMEsyI2md
wq/qnG5815BxCpKiu45XKIaERsp/0Z0CRqN9So7fBV78wjflmE/xEByynMrRjFo8
NV1pwj+NVGnBVDvmeb9yiDpKLSALir7wGtcKjaG/S5oAjbKhKSZqbE5kg6/B338P
C103dyikJ/JW0udpD0WWcR5uUYMEysuBFslzCcgKoGhBSdXzAeZbFOCYkEDMRe2c
3yGB33GDi/K358NAim53ot8BtdODVsaWVyawkdrfcSBhiloG8cMfKDNn6O79fnbF
ultCfr7mb+UJEdde9UlbEt6nSH1b/H643vpR+tY7ugdngnnvJTDFIy50NLZ3yHxe
4x1s3sfj36CiubiF1OxeIEHt1w322EC2yGpoFTg6zM6sU7qv6vMEG/uiLUk2uxHC
oATYee29XSF8aDwUa2xt+hvrK6KGb05J4Mmlw6aDTtcji0EP1BPLwJVvvY7hH9pq
YAbqGfCRR3vd1hR77fBnr5MeII69OjhXMb+mnbwjxbd6E40gs9bXt6KhUo94GXah
3uuxUQ38fVkrdhMghPn9
=H0Mn
-----END PGP SIGNATURE-----

--=-glU5KHS9Z7rGU6+kzAPm--

