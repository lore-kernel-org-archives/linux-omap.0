From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] drm/omap: use omapdss low level API
Date: Mon, 19 Nov 2012 10:10:46 +0200
Message-ID: <50A9E986.7050302@ti.com>
References: <1353024058-11504-1-git-send-email-robdclark@gmail.com> <20121116121928.GA20226@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigBD658C003F4BA9E084330182"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47487 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829Ab2KSIK7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 19 Nov 2012 03:10:59 -0500
In-Reply-To: <20121116121928.GA20226@kroah.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org, patches@linaro.org, linux-omap@vger.kernel.org

--------------enigBD658C003F4BA9E084330182
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-11-16 14:19, Greg KH wrote:
> On Thu, Nov 15, 2012 at 06:00:58PM -0600, Rob Clark wrote:
>> This patch changes the omapdrm KMS to bypass the omapdss "compat"
>> layer and use the core omapdss API directly.  This solves some layerin=
g
>> issues that would cause unpin confusion vs GO bit status, because we
>> would not know whether a particular pageflip or overlay update has hit=

>> the screen or not.  Now instead we explicitly manage the GO bits in
>> dispc and handle the vblank/framedone interrupts ourself so that we
>> always know which buffers are being scanned out at any given time, and=

>> so on.
>>
>> As an added bonus, we no longer leave the last overlay buffer pinned
>> when the display is disabled, and have been able to add the previously=

>> missing vblank event handling.
>>
>> Signed-off-by: Rob Clark <robdclark@gmail.com>
>> ---
>> Note: this patch applies on top of staging-next plus the "OMAPDSS:
>> create compat layer" patch series:
>>
>> http://comments.gmane.org/gmane.linux.ports.arm.omap/89435
>=20
> Hm, I can't take that patch set in staging-next, so how should this go
> in?

I wonder, could the omapdrm part go in for -rc2? It's "only" a driver in
staging. I think that would be the easiest way. Perhaps it'd be even
possible to split the patch into two, of which the first half would not
depend on omapdss, but would prepare omapdrm for the change, thus making
the patch for -rc2 smaller.

Otherwise it's more tricky... Either wait for 3.9, or get omapdss,
omapfb and omapdrm merged via the same tree. But which that would be?
omapdss and omapfb usually go through fbdev tree. I don't know what its
maintainer thinks of merging drm driver. And if the omapdrm depends on
new drm changes, I guess fbdev is out of the question.

 Tomi



--------------enigBD658C003F4BA9E084330182
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQqemNAAoJEPo9qoy8lh71MfIP/i8LVaU46sW3l7iOcTTlCKMq
gJBMtiwou/CG6cPnQDswpfGBJDdCRFZ4R9mgTfcCC22A5gJ6UiYZv0FjKNilQUXL
ocNCMQFxFXKvdxAPh8z8TUkEBXb3NKFTJIG0TYWnRJ2EiZ8RqbfLvfnhntNrF5zy
H2oM9ARTuMJjlqp5LnEoT/pHDuuyxzLrsN6gYAY8GtTAO0I54MZneprOPtvkjFWT
LIVxD8UJHtmOf8lIzuivJbrJRMnshhS1kfJ+RiMRDfUYJE85AbUB2UhaSY9uTVzQ
f9Lw1ar7/Aeght0Ir/O7ndf38hQ80rRngqRk0ZX/hjQUOd/9gqDoQNeyTAMTg1jJ
xAso5czEB8IHpjRA+7cOqpH+LNaw6ZcuUE1qde7hVfBBTPAZRmpDLHTb9x6ddcXq
4WYabGHlu8ycMh8BtpPRrCNZ15a1Sc7K4KwSmQAf2S2ueFTlkKNzTA+AiW31mNqh
wTVd+x5rYNlibQxXv1Uw2TywNGsqpBbZIwHpWCtveF0t/7/CaVYOARGP01DwbnOb
w0uj6DCXUOhGN6pFc82F1yKlYUcgeXHoAErOvNZte25Dd3TsUD1aA4rj9YglcXKj
nWhb9+H5LunHkuLkHAlZMv2ni7agR9h+o47eFVTp/3d4U3mb+X9UvulrRABSspP3
6g+Y79I4vQ8NFzNeKpb7
=gsSo
-----END PGP SIGNATURE-----

--------------enigBD658C003F4BA9E084330182--
