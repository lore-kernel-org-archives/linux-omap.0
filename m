From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Mon, 19 May 2014 21:57:18 +0300
Message-ID: <537A540E.8070302@ti.com>
References: <53730AFB.2090800@ti.com> <20140514160216.GD18463@atomide.com> <537487AE.3060906@ti.com> <20140515182133.GC23659@atomide.com> <5375A8A8.7080306@ti.com> <20140516160717.GD22031@atomide.com> <20140516174158.GA11733@earth.universe> <20140516180154.GG22031@atomide.com> <20140516213907.GL12881@atomide.com> <5379D35F.8040207@ti.com> <20140519155732.GA4849@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="MKOwBvRapmahBGhumJNFmNVtjtjRgPTgR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:55680 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751182AbaESS5y (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 19 May 2014 14:57:54 -0400
In-Reply-To: <20140519155732.GA4849@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--MKOwBvRapmahBGhumJNFmNVtjtjRgPTgR
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19/05/14 18:57, Tony Lindgren wrote:

>> I'm not sure if it's even possible to load both of those drivers at th=
e
>> same time, but if it was, and the first one would get probe() called f=
or
>> a device, and the driver would return an error, I'm quite sure the
>> driver framework won't continue trying with the other driver, as the
>> first driver already matched for the device.
>=20
> No need to load multiple drivers at this point. That's why I'm saying
> you can bail out on the undesired display controller probes using
> of_machine_is_compatible test. It's not that uncommon for drivers to do=
:

Hmm, I don't follow. If both, say, omap and exynos have a panel driver
for the same sharp panel, both need a driver for it (presuming exynos
has a proper display component driver system, which may not be true).

Both drivers would be loaded at boot time for the probe to be even to be
possible. Even if the other one bails out from a device probe using
of_machine_is_compatible, afaik the driver framework will stop probing
at that point, as that driver reports being compatible with the device
in question.

=2E..

Ah, ok, now I see. I think you mean module init, not probe? For some
reason I was just thinking about the probe stage.

Maybe that would work. I need to test tomorrow.

>>> it would be quite silly for each display controller to have to do
>>> their own remapping for shared panels?
>>
>> It would, but wouldn't it be just as silly (well, even more silly in m=
y
>> opinion) to have each display controller require driver specific
>> compatible strings for the panels used?
>=20
> Not driver specific, but hardware package specific. That's being done
> all the time. For example, compatible strings like "nvidia,tegra124",
> "ti,omap5" describe a package of an ARM core and various devices.

It feels to me rather wrong if I'd specify the compatible string for an
external piece of hardware based on the SoC it's connected to.

> But by using of_machine_is_compatible in the display drivers, you
> can use the right compatible flags from the start if you want to go
> that way.

Yes, with that we could have right compatible flags in the .dts.

>> Well, I sure hope nobody else has to implement similar thing.
>=20
> Suuuure.. I've heard that about 20 times before and guess what
> happenened? Things never got fixed until some poor maintainer
> had to start fixing it all over the place about three years later.

The poor maintainer here being me =3D). And it's still a case of
pick-your-poison. We need to hack around the issue, in some form or
another. So in any case the poor maintainer has to fix it at some point
in the future.

But all this is fixed when we have a common display framework. And
that's something that is really badly needed in some form or another,
the sooner the better.

So the "fix" here is not just some internal thing that could be left at
that and forgotten.

>> To open that up a bit, traditionally other display driver architecture=
s
>> have not had drivers for each display "entity", like the panels. So yo=
u
>> would really just have the display subsystem in the .dts, and some raw=

>> data there (panel timings) to get the panel running.
>=20
> Right, I believe that is the way to go, no doubt about it.

No, that's exactly _not_ the way to go =3D). We need proper drivers for
display components, instead of trying to avoid that and embed panel data
into the display controller's data.

> Here's a list of things that bothers me:
>=20
> 1. Searching through the dtb from a driver instead of relying on the
>    driver probe mechanism for the components in question. If the parsin=
g
>    of the dtb needs to be done it should be done in a Linux generic way=

>    from some framework instead.

The reason I haven't made the conversion code available for others to
use is that there are no other users at the moment. And I hope there
will be no other user until we get the common display framework. If
there is, we'll need to move the code to a generic place.

> 2. Having to do this all early before we even have any debug console
>    available. We are trying to move everything to happen later on to av=
oid
>    all the issues related to initializing things early.

It worked fine for me when doing it as subsys_init level. Why do you say
it'd be early, before debug console?

All the drivers with converted compatible strings are normal drivers, so
afaik things work fine if we just convert the strings before the module
init level.

> 3. Having to maintain a database in kernel of display mappings separate=
ly
>    in addition to the .dts files.

Yes, that's slightly annoying. Not really a big burden, though, as it's
quite rare to get a new encoder or panel driver.

> 4. Having this hack limited to device tree based booting while we are
>    trying to unify the functions for drivers to use to get their
>    resources.

I don't understand this one. With non-DT boot we don't have the issue at
all, there's no need for hacks.

> 5. Seeing the possibility of this spreading to other drivers.

Well, until we have a common display framework, one of the hacky options
we've discussed will spread to other drivers if they need to have their
own drivers for the same hardware devices.

Which is not nice, but not something we can escape. And using the
of_machine_is_compatible or having the compatible strings in .dts
appended with "dss" or such doesn't change that, it just changes which
hack may spread.

 Tomi



--MKOwBvRapmahBGhumJNFmNVtjtjRgPTgR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTelQSAAoJEPo9qoy8lh71x7MP/25IuJuxOUbKi5qgKQsOruSr
5djgDFy1bfKcIHQhAY7qHF3XKl8cu0nV0TCJce2X+05WfPK9JcRKfYmaa5l60mn5
U+WIRkyRRGQp9Dg9hlur+Fr8svNGFc/+hhRlUpKmx7wp52SYKUbJOI+bhzCASBbZ
oik0ZCUOvgiMgJjilbUWS8yAUd+xpPIAB18uLGyrQ3vFfDXXawHdFNEcqH09o4cp
+4QE6sC6cXt44pMCgIOcZ+AIw8kmfC1Ozho4h3BSOo3JcmWM4cH6rE+GcArdALLp
O/V9FJo2Y9MU6doBXnYD9QpHH6WsgrAe0W20muy5xH69PYykcTsqCYU70ZPzV0HD
DUDmSK/CavSBuI2pM9mD/qPl3jhTZWAehlDgr9AqAuYUdwX2hwjCjw1Nk5sqeCP5
JDCtkz3/wWDRHWhCsEp01jHQLV6zre45/VL0CKunmU4FWVFo8DhESa/4JF51few0
Qiv82qNTGqeEaZAMWcS4m1T+8FfPi1M1ilW8UW3q2awJ5HUSAdfwjgcdpaai56C2
qDD5QNZPPXRWE9tWbvC09pEYCvwKYPgvcwOz3LEb4LADoPy7qzOlHj7yQU5wunhd
N5CB6R9x6j/u53H2ws8UP4tb8fMLtOfVvAlYa2A47NOafxVfTF5DiQ6tkwiGDFzb
32zAnKIIryXUd/OBaywC
=Rn7w
-----END PGP SIGNATURE-----

--MKOwBvRapmahBGhumJNFmNVtjtjRgPTgR--
