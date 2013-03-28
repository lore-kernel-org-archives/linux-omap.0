From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the display
 options
Date: Thu, 28 Mar 2013 19:02:08 +0200
Message-ID: <51547790.7010108@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com> <51546B2C.2030101@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig26CA1F6FE6837F1AEBA7985F"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41481 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755610Ab3C1RCN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 13:02:13 -0400
In-Reply-To: <51546B2C.2030101@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mike Rapoport <mike@compulab.co.il>

--------------enig26CA1F6FE6837F1AEBA7985F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-28 18:09, Igor Grinberg wrote:
> On 03/28/13 14:49, Tomi Valkeinen wrote:
>> Boards with multiple display options for the same video bus have all t=
he
>> possible linux display devices present at the same time. Only one of
>> those devices should be used at a time, as the video bus cannot be
>> shared.
>=20
> Yes, only one can be used at a time, but you can switch at runtime...

Yep. But the panel drivers need to know about this, and they cannot do
more or less anything in the driver probe function, which I think should
be the place to reserve resources and do initialization. With the
current model that would lead to multiple drivers trying to acquire the
same resources.

>> This model is hacky, and will be changed in the forthcoming DSS patche=
s
>> to a model where only one display device can be present on a single
>> video bus.
>=20
> What do you mean by "present"?
> Is it active? or registered? or compiled in?

I mean that only one device can be registered. Well, nothing strictly
prevents having multiple devices registered, but if the devices have
matching drivers, the drivers would acquire the same resources. Possibly
the same gpios, but at least the same video bus.

>> This patch creates Kconfig options to select which of the display
>> devices is present on the board. While this model is also somewhat
>> hacky, and prevents us from using a single kernel image for all the
>> display options, it allows us to make the DSS driver changes for DT
>> adaptation. And with DT, the information about display devices can be
>> passed from the bootloader, solving the mess.
>=20
> Hmmm, the fact that we cannot use the same binary for multiple displays=
=2E..
> This does not sound right and good at all...
> While we try to move to support multiple platforms in the same binary, =
we
> cannot support multiple displays? I agree that the multiplatform stuff =
is
> not really related, but you know what I mean...

Yes, I quite agree that this sucks =3D). There are a few reasons I chose
to try this approach:

- The whole multi-display feature is hacky

- DT support for DSS has been in development too long time. We really
need it, preferably yesterday. This change helps getting DT support ready=
=2E

- Common Display Framework won't (most likely) support this kind of
feature, as the feature itself is rather hacky, so this would anyway
disappear.

- DT support should solve this (except for runtime switching), and the
board files are on the way out (as far as I understand). So in that
sense this is temporary.

- Keeping this feature functional consumes considerable amount of
man-hours, which are in short supply.

I still feel quite bad about this, though. Any ideas how to manage this
better are appreciated.

> I bet there must be a much better solution for DT support.

Yes, I think I covered that in the last email. DT will solve the issue,
except for runtime switching, which is still open. I'm not sure how
these board specific drivers would be implemented.

 Tomi



--------------enig26CA1F6FE6837F1AEBA7985F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRVHeQAAoJEPo9qoy8lh71CsEP+wdXrjKADCr0V/+dGruR+kbY
3dqY9C0dj7JelrWxO3Ysk0e3v60fl8FolXRRnCMfExdwABe3arPC/aSGy8kw7WEZ
zKdfnmL8WXd30+aXrRegi4jKfQDUBW/6XasRgmovC3BFwrdARol2P0jVElehEOKC
AZ/bvejIyDuE8SKPaqIcBuHCNKOSgAmEqyF4KJ3WaE9NVW5I1cjLb7yGRyelI/63
oujq5UlxNBoI6hodasnJyq+Xxu5I+UDNsricz1MskeM1Ju1uKkMHIwxy0z0+CFOS
wanJi8OTQMAodmj/nbh7PB48+qlvL8h37J1/8fvfjdgt5pKPrZRQTDgwRqQBbl02
5yoNHtI28xuywv0A+Wd2CMltog5diJMx1ek8GBhYbbalz40e6RDjV2d1Vp5PVdLd
fvwOV7GZSlEqvFjX7pffABWoRfpsxn7xcqS7vML9OxV8EVW6R6EqkkbNLw+vbQ1W
o4eSkDBGNPcRGAyM7hscVVr98SvgHPejywiIM2BWRhHJNzAl1O8wflUM08PZ7oV/
5gXiPHDZJNuFQ3ECIQVwMHsIxvzYFQNVQxYx8up+cuIVDbZSQc4aH2FyrK3R/HrW
xcpPQYeF0bPsZBpSG6V6ObHw2AEyEQR7ssd69Cu8gUAOtJwxgoxpkwWVWo8AUmSm
rrFdudinPONFeXiFxGAW
=EgJz
-----END PGP SIGNATURE-----

--------------enig26CA1F6FE6837F1AEBA7985F--
