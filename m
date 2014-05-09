From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] arm/dts: am335x-evmsk enable display and lcd panel support
Date: Fri, 9 May 2014 14:29:02 +0300
Message-ID: <536CBBFE.40508@ti.com>
References: <1398199063-3026-1-git-send-email-detheridge@ti.com> <20140506161001.GH18474@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="kFCCUXLXLxExcieBKb5FeLAn23RC7etUS"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47958 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753446AbaEIL3G (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 07:29:06 -0400
In-Reply-To: <20140506161001.GH18474@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Darren Etheridge <detheridge@ti.com>
Cc: bcousson@baylibre.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org

--kFCCUXLXLxExcieBKb5FeLAn23RC7etUS
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/05/14 19:10, Tony Lindgren wrote:
> * Darren Etheridge <detheridge@ti.com> [140422 13:39]:
>> Add the necessary nodes to enable the LCD controller and the
>> LCD panel that is attached to the Texas Instruments AM335x
>> EVMSK platform.  Also setup the necessary pin mux within the
>> DT file to drive the LCD connector and add the correct
>> pinmux settings for the lcd pins to be configured to when
>> the SoC goes into sleep state for the minimum power
>> consumption.
>>
>> For the sleep mode LCD pin settings, MUX_MODE7 is chosen as
>> this corresponds to switching the pins into input GPIO's with
>> an internal pulldown.  Which has been determined to offer the
>> lowest power solution vs leaving the pins configured in LCD
>> mode.
>=20
> Probably best that Tomi queues all the panel .dts changes into
> a separate immutable branch that I can merge too.

This is not for OMAP DSS, but for the LCDC used in beaglebone, so there
are no dependencies to any of my work.

 Tomi



--kFCCUXLXLxExcieBKb5FeLAn23RC7etUS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbLv+AAoJEPo9qoy8lh711mAP/225WkaqaAhrPKzc/LZlAvBj
5Eav97Ld57sKnBrfDtrI+D2u1lD45DyNL40qo8/ezZvxpczoisma3gvAfaOO+ces
bokNfxL/hhqu/MPeU6BXVGaqMc00+4rvgYV6/MZ0yblvJkw/9h7KoTQd5VEymm82
N9AlokPIf1oOKWBeiUXhdUB7Tcsrg48Y6vThMO60BXpuBIr2UvMcPZ31lAS4jYcY
aIjHncYO6+uqjbE0fZs9d+8eoOe9H1ml2XgX9g0nqjrWkKxbG+RK6mvzAgb3v/kq
2iG3ojFScco6trjSYc14Pi8UhglfV4cjzZpyA7yDiFPcaD5CHMy0MjswuaGxfdrr
FIIMmlD1cywNgWaBLGnMN7qj1uhBFrpEtfLOaYXi12rcgwxuGlmoTy34JBLy0ea5
fTWkr09iNflSwOiGIJV2xIKoUZeQV75ylmJv8r7EKdLbHy1jUOvtYK9FITFk9fCS
nKFkE3yG9gzRtj/+7x6xJ913NSlZv4bqvEZi4ikIcBDG6gCIIxg5zPHgGeCRTHNC
Zh1FFWSlKFx6ZG2Y648sYHpD6XozZEtUGlj3m2/KlElAdt/jNbq2ZwbzXRbV8qBB
SFZBET/j2SzETcqfirVK6j+m/d/zLpXDbOMayZTc1l/ad8q74RdIIaw3S3LojIFV
l6tMngQNvv9y/KuBKRnU
=Lwdj
-----END PGP SIGNATURE-----

--kFCCUXLXLxExcieBKb5FeLAn23RC7etUS--
