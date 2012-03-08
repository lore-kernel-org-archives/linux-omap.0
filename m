From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 01/21] OMAPDSS: panel-dvi: add PD gpio handling
Date: Thu, 08 Mar 2012 09:54:23 +0200
Message-ID: <1331193263.2354.13.camel@deskari>
References: <1331124290-6285-1-git-send-email-tomi.valkeinen@ti.com>
	 <1331124290-6285-2-git-send-email-tomi.valkeinen@ti.com>
	 <4F579F1B.7040503@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-o21ZBaij88gCeLBAeRrJ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:47939 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752816Ab2CHHy1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 02:54:27 -0500
Received: by mail-lpp01m010-f52.google.com with SMTP id i5so193129lah.25
        for <linux-omap@vger.kernel.org>; Wed, 07 Mar 2012 23:54:25 -0800 (PST)
In-Reply-To: <4F579F1B.7040503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <a0393947@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org


--=-o21ZBaij88gCeLBAeRrJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-03-07 at 23:17 +0530, Archit Taneja wrote:
> Hi,
>=20
> On Wednesday 07 March 2012 06:14 PM, Tomi Valkeinen wrote:
> > The driver for the DVI framer should handle the power-down signal of th=
e
> > framer, instead of the current way of handling it in the board files.
>=20
> What does framer mean?

I don't know where the word has come, and I can't find it in the TFP410
documentation. I guess the idea with the word was that the chip
"frames", i.e. packetizes, the incoming parallel data to DVI.

But I think it's better to remove the use of the word to avoid any
confusion. I'll make the change.

> > +	if (gpio_is_valid(ddata->pd_gpio)) {
> > +		r =3D gpio_request_one(ddata->pd_gpio, GPIOF_OUT_INIT_LOW,
> > +				"tfp410 pd");
> > +		if (r) {
> > +			dev_err(&dssdev->dev, "Failed to request PD GPIO %d\n",
> > +					ddata->pd_gpio);
> > +			ddata->pd_gpio =3D -1;
>=20
> Is the power down gpio not a necessary thing? If it is, we should quit=
=20
> here itself, shouldn't we?

Hmm, yes, I think you are right.

 Tomi


--=-o21ZBaij88gCeLBAeRrJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJPWGWvAAoJEPo9qoy8lh71Lh0P/1iherSXXhdjSNSRXQJHrti2
T1jcU8LsaLnta0giug5HhuWQ04cjTSgWqHFgnF1ZTsJwlvXmnIwelfnPZlkl9NrK
swzdRMgz/Sp04WLyZGRhLmDmqOsxyZQNuutMUtU94t5o7R9wTVgFlghnQZKvHFF6
yUtLG21GMjqus/AvSQe8LHetX9IJ0g1q/E7Fo3YIFg7fIrdB1oe//M16u+5e9w3V
7mguqAbYzUAQhDh/UV4wi3DT2/B+WVGK0mQb/LvO2bQC9jsdcM60FOCAGaENiCMu
b+j8Jj20fir+vpGOX3QxFHsn3lruOor/hFUyH2lwjqo89LbGKwuccRJI9OUI2zRp
sKaBoXltJrAOnQ8iCa98T/xEOnEem1Kit/bwOB8tBSYKLcvvqFUpIehkfj/EFfyy
RqFnInBbjM+0x37rBznnW9II66CoAp8Z/IR4pHDZNIOSnKlMb1HHkLZDvY6VBz+E
gdPm7HdZtV563xh7Q+UIjWLz5u/++cd5V0hUMEnj/b3JlUf/w9LLBhIDDyzWmIaV
DZdhOZrxEEKY0a2AieM7rTx7MSap9MYOpeSRxAxQHd7R4BF0vjzTE4rcKigjxW2S
u+6/q6EwiUndFH4nx2pMJdZH3HEZ7W0FOHeGKhN0cJyDzzK0GMQOifsA694SmuT4
r0lf0i/1auOAgTC2b4c6
=6jS3
-----END PGP SIGNATURE-----

--=-o21ZBaij88gCeLBAeRrJ--

