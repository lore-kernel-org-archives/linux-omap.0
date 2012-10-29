From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 19/20] OMAPDSS: DISPC: remove dssdev depependency from
 error handler
Date: Mon, 29 Oct 2012 10:04:44 +0200
Message-ID: <508E389C.8080503@ti.com>
References: <1351070951-18616-1-git-send-email-tomi.valkeinen@ti.com> <1351070951-18616-20-git-send-email-tomi.valkeinen@ti.com> <508E2C48.6020008@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig0FA6F76D9D2E2B0A11B3B3CC"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49924 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757817Ab2J2IEq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Oct 2012 04:04:46 -0400
In-Reply-To: <508E2C48.6020008@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Archit Taneja <archit@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

--------------enig0FA6F76D9D2E2B0A11B3B3CC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2012-10-29 09:12, Archit Taneja wrote:
> Hi,
>=20
> On Wednesday 24 October 2012 02:59 PM, Tomi Valkeinen wrote:
>> The dispc error handler tries to "fix" issues by disabling and enablin=
g
>> panel. This is problematic, as we're trying to remove the dependency
>> from omapdss to the omap_dss_devices. It's also racy, and doesn't real=
ly
>> fix anything.
>>
>> This patch removes the use of omap_dss_device from the error handler,
>> and just disables and enables the associated overlay manager. This
>> should produce similar results as the previous solution, without using=

>> dssdev.
>=20
> Calling APPLY functions from the DISPC driver seems a bit incorrect.
> Instead of disabling/enabling the panel, can't we disable/enable the
> manger by just using DISPC funcs?

I agree, but if we don't call apply functions, we're bypassing the
locks/etc from apply, and we could end up messing up what apply.c thinks
is going on.

With my omapdss+omapdrm compatibility patch series I'm moving the error
handler to the apply mechanism, so it becomes a bit saner.

 Tomi



--------------enig0FA6F76D9D2E2B0A11B3B3CC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBAgAGBQJQjjicAAoJEPo9qoy8lh71vmQP/ivS9gaEM2TmYg2zBM0GUUgW
a2I/1g4mUaoNXwMCXYPMN7KOKUSzBwk8YLmbITbk3j7C0vbBOLDLRfg+kiDuOA/S
j+f9hfHaK3aQe9vCDr+XbFsDI75/LAASJbfK7E2PQYstDEwWFvJXlV21Bbi3V8Z9
DQZTNPWkaRvMOvOHLlnU+bzMWYzg1swXOBuy9nOm3qIIFbS33Vt00NvUmba4cboi
xSbJeTvh0qzN4QxRL56mH416+lyWYliargc1YrLNj3hjaE9hqBRLbIRRhfL6ObOQ
NK8grecs5n52kUJyD7NixlyDGd0pmvAdfznyjaOgWyFmnHP0HYF/CxIPAan/pPdp
2Tc1tJ5mUdRHp11LIRxSmQ/OwEKMvaH4j7LlzqalXEZGsEdIQ+YkUfKn2SOAG/UY
2jiRIoDmHN9OE0bXXFGBhwOo4u0CTXS3buaTCnTvRk0hgqPDLVEF62pHNsOBnxnH
9mn+Ws0KnKdcGHVIFHoh+cseYRQDkcvIwXBXFtNTs/8pLSMf7S2+xUa1OvqlMjR2
M87xyUgJFRO4/PIo3t/qRx/SLwDB/tDp/xcDiJSLhqVpLOXK4ZRf/u5BhtcCbLRa
JIgwUG8ne7M9hAJJtaAEpbKH4M2XDacQV9x7hS38b46QOxC+mPdLoEzBJKoJVGGs
bORkCUkbviKpqX9glbMU
=lOfa
-----END PGP SIGNATURE-----

--------------enig0FA6F76D9D2E2B0A11B3B3CC--
