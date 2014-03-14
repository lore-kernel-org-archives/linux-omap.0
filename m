From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: DTS: AM43x: Add DSS node
Date: Fri, 14 Mar 2014 18:34:19 +0200
Message-ID: <53232F8B.5020708@ti.com>
References: <1394701109-6721-1-git-send-email-sathyap@ti.com> <1394701109-6721-5-git-send-email-sathyap@ti.com> <20140313174623.GD25870@e106331-lin.cambridge.arm.com> <5321F77E.9000302@ti.com> <20140314091002.GG25870@e106331-lin.cambridge.arm.com> <5322CF02.4060705@ti.com> <20140314101405.GI25870@e106331-lin.cambridge.arm.com> <5322D7A4.4090602@ti.com> <5322E2D9.5000509@ti.com> <20140314140745.GL25870@e106331-lin.cambridge.arm.com> <20140314160404.GC21379@saruman.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="fomKPg6KA7SpMomHB1JAHOH7LBFrOsJMr"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49621 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755351AbaCNQee (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Mar 2014 12:34:34 -0400
In-Reply-To: <20140314160404.GC21379@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com, Mark Rutland <mark.rutland@arm.com>
Cc: "av.tikhomirov@samsung.com" <av.tikhomirov@samsung.com>, Sathya Prakash M R <sathyap@ti.com>, "tony@atomide.com" <tony@atomide.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, "paul@pwsan.com" <paul@pwsan.com>

--fomKPg6KA7SpMomHB1JAHOH7LBFrOsJMr
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 14/03/14 18:04, Felipe Balbi wrote:
> On Fri, Mar 14, 2014 at 02:07:45PM +0000, Mark Rutland wrote:
>> On Fri, Mar 14, 2014 at 11:07:05AM +0000, Tomi Valkeinen wrote:
>>> On 14/03/14 12:19, Tomi Valkeinen wrote:
>>>> On 14/03/14 12:14, Mark Rutland wrote:
>>>>
>>>>> I can't see anything obviously wrong in platform_device_del. Do you=
 have
>>>>> a backtrace?
>>>>
>>>> Yes, below.
>>>>
>>>> I can see at least drivers/usb/dwc3/dwc3-exynos.c doing the exact sa=
me thing
>>>> I do, so maybe I've got something wrong with the omapdss driver.
>>>
>>> Looks to me that the devices created by of_platform_populate() are no=
t
>>> unregisterable in all cases. The address resource created via
>>> of_platform_populate() had NULL res->parent, which causes
>>> release_resource to crash.
>>
>> Hmm. I can't see that unregistering such devices ever works as you say=
,
>> given that __release_resource expects a non-NULL parent pointer. Eithe=
r
>> we should be setting the parent pointer when initialising devices from=

>> dt or we should teach __release_resource to not care. I'll have a go a=
t
>> fixing that.
>>
>> It looks like drivers/usb/dwc3/dwc3-exynos.c only unregisters the
>> top-level device, not children. This top-level device has no
>> IORESOURCE_{IO,MEM} resources judging by
>> arch/arm/boot/dts/exynos5250.dtsi, which would explain why that driver=

>> isn't exploding: __release_resource will never get called.
>>
>> Anton, Felipe:=20
>>
>> Does unregistering the parent ensure the children get cleaned up, or
>> does it leave them dangling in the dwc3-exynos driver?
>=20
> you should platform_device_unregister() for each children and
> dwc3-exynos does that just fine:

Yes, that's what I do also, and it crashes. What Mark said above about
unregistering never working for such devices is correct, but I don't
know why he said dwc3-exynos only unregisters the top level device.

"such devices" above meaning devices with a 'reg' defined in the DT
data, if I'm not mistaken.

So at the moment, I think of_platform_populate() and
platform_device_unregister() combination in a driver is a bit risky.
Work fine for certain cases, not for some other.

 Tomi



--fomKPg6KA7SpMomHB1JAHOH7LBFrOsJMr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTIy+LAAoJEPo9qoy8lh71xzcQAI0c66vM0Q4bxfOawoRA0Fle
zkj0rFbLKgk4/C/WNspwV4+Mt9SfRc1H5KlaVyBnvrQo+h68/LT3mZZiUmDQnQi0
vtAap+t+W37DukozuJ4LtbkbBjYrO44bk/SsA1wMx0lii+WKssTN7wz4du95dMXH
M4fatj0BgV2n3J9x7yFQ6wI6phHsvpSzAKvdqiwvqHHtg4TWeKw1h+DgYXfbs8mY
zAjtUDhQsjp7N4j7ejbBY7AoGqBoqI9eABp0K1RFHfUn1Q3j46QoKb9QyewUq20U
CmZZrb2RtXni+dpbrHmfkKRxwDKyePfr7dl8mi05HCDrs6Uh1sNXxeKmQpXp1MOo
IVfJddzUp1nwz7bpFFqUYRGyWRfOpJZiZ5sgiv4VRDEHg/MjxP9drgq//DhaE+7D
5pGbG82QOdpX/oxTptE986AEPtNziQxuvh7jHO7zCJDfWvOgnuhGaXAZorEPtxpl
4/e3JVNrv/B14b6Fs/dEOJqnmrIV1+KLd6fLnQpuzrOaFP5ogTmb6I0vDdL17I8W
x23ojDB7T5SFDxJ4CXsvR5Oc9wenrj13e5Fu4CeEYdibILcW0XL1Y2GmamEogRwN
sYtrp8KQMV6eIy3pQA9FzZhlOcL5NOYZb38+sS1JpcBsEbXJn6tM27e+FbAOEo2P
qpHAsOUTSpyb99etfqAF
=efKI
-----END PGP SIGNATURE-----

--fomKPg6KA7SpMomHB1JAHOH7LBFrOsJMr--
