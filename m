From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH v2] input: touchscreen: edt-ft5x06: fix driver autoprobing
Date: Tue, 18 Nov 2014 13:37:19 -0600
Message-ID: <20141118193719.GO6179@saruman>
References: <20141118192112.GM6179@saruman>
 <1416338862-8240-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="96dIhm/ZjrNld+BP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37355 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023AbaKRThA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2014 14:37:00 -0500
Content-Disposition: inline
In-Reply-To: <1416338862-8240-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-input@vger.kernel.org, stable@vger.kernel.org

--96dIhm/ZjrNld+BP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 18, 2014 at 01:27:42PM -0600, Felipe Balbi wrote:
> Because with OF we can pass more specific
> compatible flags (such as edt-ft5306) instead
> of generic edt-ft5x06, when i2c-core's
> of_i2c_register_devices() tries to request_module(),
> it'll request it with a non-existent specific module
> alias.
>=20
> In order to have this driver autoprobing again, we
> just need to add missing MODULE_ALIAS() entries to
> edt-ft5x06 driver.
>=20
> Thanks to Dmitry for noticing that it actually should
> autoprobe even with of_device_id.
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: <linux-input@vger.kernel.org>
> Cc: <stable@vger.kernel.org> # v3.15+
> Fixes: dac90dc2 (Input: edt-ft5x06 - add DT support)
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---


btw, with this, patches 7 through 10 can be ignored.

--=20
balbi

--96dIhm/ZjrNld+BP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUa5/vAAoJEIaOsuA1yqRETV0P/iEZkya5pkQdzZKRfhpofYXw
7PAUPldzO7vDuTEbWCHmhLG5Xb5LLDhbcR7nrvojnNUOI73ymVvdNHPDzuTQSdmn
YgQlAZK8IQ++v2/DKSSzIxxcNqQpomRTuOncxKGznErlX7NcVBAsfzi4apxcqADu
uMdZVLFw3rAVbGILNzJK3UC8DY6pPyRcYyLYs6SoVStzJiQxfj8fRq0JqSdbF61r
XQXPSSHe3n+SXjNuXkcAAad83yf+yFB4dR7Yg13NrxIivXwW4RUt0lSdfLSk8qqy
i9yTPGb15f7GLEVZzDvv2N1qfBzbePw9aBB4KdTsPvFD7uEOFb+uSdS+Hz7xdzu6
jSOY2lLqs0vQpj8ipK98SEC3OpwZp9lf6LjQTrDrwWPZt39IpllfkSzZ8mGdGEeR
GGn8lwbzYydT0hJUqgG1ePblEGnro7dSXSDBD9M/f0BMGTxeQXzCRUEfRCvLNgPb
Xz034iwWl6t5TZAhjBAZo2kr4V2f7ZXiCiFhlQWxFrKH0wd88aY8JGWhI/q6VFMV
+6rwuwlbcwuRlTGrujGA8n32axYMLoBINKyNMTrDW6zIyjyKY4D5U0906s6RFSvQ
oa7rq9W6ppBfkC5OLNgz5AY/XC0bsIk4WDBIJCeiItsc98D541yxAcyZmMPPcnDf
nibqqtPrX8Z7+YQdENIF
=p2nF
-----END PGP SIGNATURE-----

--96dIhm/ZjrNld+BP--
