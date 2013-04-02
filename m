From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 08/28] ARM: OMAP: CM-T35: Kconfig option for the display
 options
Date: Tue, 2 Apr 2013 11:07:38 +0300
Message-ID: <515A91CA.7060801@ti.com>
References: <1364474962-20439-1-git-send-email-tomi.valkeinen@ti.com> <1364474962-20439-9-git-send-email-tomi.valkeinen@ti.com> <51546B2C.2030101@compulab.co.il> <51547790.7010108@ti.com> <5157FF21.9000702@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig6F80C19A5A865FC1DC617FAB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58489 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760662Ab3DBIHn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Apr 2013 04:07:43 -0400
In-Reply-To: <5157FF21.9000702@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>, Mike Rapoport <mike@compulab.co.il>

--------------enig6F80C19A5A865FC1DC617FAB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-31 12:17, Igor Grinberg wrote:
>=20
>=20
> On 03/28/13 19:02, Tomi Valkeinen wrote:
>> On 2013-03-28 18:09, Igor Grinberg wrote:
>>> On 03/28/13 14:49, Tomi Valkeinen wrote:
>>>> Boards with multiple display options for the same video bus have all=
 the
>>>> possible linux display devices present at the same time. Only one of=

>>>> those devices should be used at a time, as the video bus cannot be
>>>> shared.
>>>
>>> Yes, only one can be used at a time, but you can switch at runtime...=

>=20
>> Yep. But the panel drivers need to know about this, and they cannot do=

>> more or less anything in the driver probe function, which I think shou=
ld
>> be the place to reserve resources and do initialization. With the
>> current model that would lead to multiple drivers trying to acquire th=
e
>> same resources.
>=20
> Yep, this is a problem, but it only means that probably
> the platform device framework is not suitable for this.
>=20
> What about having some kind of display manager which will have a privat=
e
> list of registered devices and will instantiate only those that are mar=
ked
> active?
> This also might be useful with DT.

We can't have a generic manager that handles instantiating the devices,
as we don't know what device they are. They could be platform devices,
i2c, anything. There could even be a single device that creates multiple
displays.

>>>> This model is hacky, and will be changed in the forthcoming DSS patc=
hes
>>>> to a model where only one display device can be present on a single
>>>> video bus.
>>>
>>> What do you mean by "present"?
>>> Is it active? or registered? or compiled in?
>=20
>> I mean that only one device can be registered. Well, nothing strictly
>> prevents having multiple devices registered, but if the devices have
>> matching drivers, the drivers would acquire the same resources. Possib=
ly
>> the same gpios, but at least the same video bus.
>=20
> Well, I think, we should follow/extend the already existing EDID concep=
t...
> Instantiate a display device only when one has been "plugged in".
> By "plugged in" I mean enabled - made active.

This brings the complication that we need a way to make the display
active even if the display device doesn't exist. So we need to know
about the display even if it's not there.

>>>> This patch creates Kconfig options to select which of the display
>>>> devices is present on the board. While this model is also somewhat
>>>> hacky, and prevents us from using a single kernel image for all the
>>>> display options, it allows us to make the DSS driver changes for DT
>>>> adaptation. And with DT, the information about display devices can b=
e
>>>> passed from the bootloader, solving the mess.
>>>
>>> Hmmm, the fact that we cannot use the same binary for multiple displa=
ys...
>>> This does not sound right and good at all...
>>> While we try to move to support multiple platforms in the same binary=
, we
>>> cannot support multiple displays? I agree that the multiplatform stuf=
f is
>>> not really related, but you know what I mean...
>=20
>> Yes, I quite agree that this sucks =3D). There are a few reasons I cho=
se
>> to try this approach:
>=20
>> - The whole multi-display feature is hacky
>=20
>> - DT support for DSS has been in development too long time. We really
>> need it, preferably yesterday. This change helps getting DT support re=
ady.
>=20
> Yes, but I don't think this should involve removing the existing
> functionality..
> Let me exaggerate a bit: this is like removing ARM support from mainlin=
e,
> so it will make less noise and headache to Linus...

That is exaggerating quite a bit ;). But yes, I agree that we should not
remove the features. I just couldn't find a manageable way to have them
while still moving forward to DT and CDF.

 Tomi


--------------enig6F80C19A5A865FC1DC617FAB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRWpHKAAoJEPo9qoy8lh71hZoP/ip1O1VI6n+mQotyr17SXsor
eFyg9ai1FihG+8eBvgxRmkorHNqiWniv/KP3AmtWuDkOelF5LRW1WPW6EKNLx0Bg
c6Ko2+X7ALriev3fbl+ou+Mdr0HhsMEJmx06uaGlAOT5NpQkJQ+Em3iREiQK726o
v9lnLG2ZXFpum8Wzd8MoP/dgt2vQrJftjPrrdgG+5Qh4ma/WCoGdAOK8kv2m9Fhv
JVmibRW4ORpgg0dIwDmToPjuN7IaaRoG49hLtthStt3JZWylrZcxUZC394K/BxxH
85K4sNAjJd2uT1KbT9rWWKCyG/qRVBjnHEqH6BTg+K82T5HU4XS1a3JUTU89X4iK
yq05eysNF/1syD3VuEjyX09lrm5x7YpB9G3aqDq8j8X9brrmgU9AH/wrRDa+sHab
gE9FqPBm9FIuNUcXRVv0kQvYVnT2/VIDaWqCdtzeSPXFOHaN0MkISS+6pGJ3cK6n
mWj1vqx1nyn68fCzM7//+wb/18iQXcRlWCzMRKjkDDsMOj5rtq5ybYSSC/8WudAi
cMJ6F+RaJ8626dxAcgNQQukZJmRjOIJtwH5Rze0nptDd3lstrp+cgfnRKbkF6YUC
F/J9NxK64S8Zo3QUfjrzufba/8g8UnriRuxHJ/ODM4NNbx5xZnOgiuL2CfFQLTsM
PmFhh3Cjf9sHE/4bFzPK
=knTJ
-----END PGP SIGNATURE-----

--------------enig6F80C19A5A865FC1DC617FAB--
