From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 3/4] OMAPDSS: panel-sharp-ls037v7dw01: add device tree
 support
Date: Wed, 21 May 2014 16:05:56 +0300
Message-ID: <537CA4B4.2040001@ti.com>
References: <537487AE.3060906@ti.com> <20140515182133.GC23659@atomide.com> <5375A8A8.7080306@ti.com> <20140516160717.GD22031@atomide.com> <20140516174158.GA11733@earth.universe> <20140516180154.GG22031@atomide.com> <20140516213907.GL12881@atomide.com> <5379D35F.8040207@ti.com> <20140519155732.GA4849@atomide.com> <537A540E.8070302@ti.com> <20140519195100.GB11945@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aOtLHrXQ9os9RImAuAfSBTTcQOUqg52wn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48710 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbaEUNG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 May 2014 09:06:26 -0400
In-Reply-To: <20140519195100.GB11945@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Sebastian Reichel <sre@ring0.de>, Javier Martinez Canillas <javier@dowhile0.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

--aOtLHrXQ9os9RImAuAfSBTTcQOUqg52wn
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19/05/14 22:51, Tony Lindgren wrote:

>>> 4. Having this hack limited to device tree based booting while we are=

>>>    trying to unify the functions for drivers to use to get their
>>>    resources.
>>
>> I don't understand this one. With non-DT boot we don't have the issue =
at
>> all, there's no need for hacks.
>=20
> Hmm can't we still have multiarch booting happening with the same
> panel name being used by two different display drivers?

Yes, but in that case the driver names are internal to kernel. You can
append "omapdss" or such to the driver name, and have that name used in
the board file and in the driver. It's not visible outside the kernel,
and when there's a common display framework, it can be changed without
anyone knowing.

With DT we have the old, stable .dts files that need to be supported...

>>> 5. Seeing the possibility of this spreading to other drivers.
>>
>> Well, until we have a common display framework, one of the hacky optio=
ns
>> we've discussed will spread to other drivers if they need to have thei=
r
>> own drivers for the same hardware devices.
>>
>> Which is not nice, but not something we can escape. And using the
>> of_machine_is_compatible or having the compatible strings in .dts
>> appended with "dss" or such doesn't change that, it just changes which=

>> hack may spread.
>=20
> Yes I agree they are all hacks, but your version seems to carry some
> extra early init baggage with it as I noted above :)

True, but it doesn't feel very big baggage to me. We can bail out
immediately if the machine is not omap, so for non-omap's the effect
should be negligible.

For omap there is some extra stuff being done. I don't really know heavy
it is, performance wise, but the operation itself is quite small.

I'll try and see how the other options work, which are:

- Bailing out from module_init in each display driver. The reason I
don't like this (although I haven't tried it) is that all the display
drivers need the modification, and because I need to catch the
module_init, I cannot use the helpers like module_platform_driver(), so
it adds multiple lines to every driver.

- Traveling the video graph, starting from omapdss. This one is possibly
better performance-wise than my original version, as we only need to
search for the omapdss node and can then follow the links. But the code
will be more complex.

 Tomi



--aOtLHrXQ9os9RImAuAfSBTTcQOUqg52wn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTfKS0AAoJEPo9qoy8lh71lh4P/R7/9MKWN5BuS4FIxpYKghDE
ZKXo6wSiq+qH6hNGsp0a1dYnmnDjbnItC4QyaCx1BQKtMN1+tY4Brbu830KAy7OK
y675syUzV6iWxoZnNd7/rmEsBQ15Qnila8ZB52OJeJZ2KPQrL1p5rObN00zG/kTm
gwtZiSVjT95SMGoSwnN6PJh70xhtSFAKnk9S6uE1vlpfad8XtfkfF6m6lrQgdSED
pr7v3lLO9YIbYFoM9viCzcOB2IGSXx4gIQkZgAXVGbz+uJ5XcYsfjJ/N4WspcVDK
qVe91grx7a2HrsDoE0vKNZO96EXRCqR4ostqzPLAE8W2KzwL0YNBHSqWdFNB1cdX
QJx+g4jJXoaeiTDpIJwy1jSCxBRPR2Tr1YLqa2AASqg+H5CV5nOlUVyqPiBa6xgZ
8C8rFMbrgtWeO9Hx0CkzhbU755wrHGFW5jkLy2e+nUiFACp8pgBSn/XkNBQ7Ldjn
qu88bkUjum3IqOkxJZ4FcxYKwtIncCK4P7h5vAIV8k6tTMSBMvH8fpfsoZCGyi8R
Ez+KFSowayEK8Gw0Lf1BSp+mcK7/M1nNADttT8uArEvA0d9fsPyDCw/kWG8wF3o1
OIxZ2xSuTKwGLWDRH2z5vXRHWt+w85kXtY0LFQnPGjmpeIiaLmRjwwCDnxqVTamT
wIFb67r6pR1lLYSOO0RR
=o+A5
-----END PGP SIGNATURE-----

--aOtLHrXQ9os9RImAuAfSBTTcQOUqg52wn--
