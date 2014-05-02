From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 06/23] ARM: OMAP: add OMAP5 DSI muxing
Date: Fri, 2 May 2014 16:06:00 +0300
Message-ID: <53639838.3070907@ti.com>
References: <535A6C40.10609@ti.com> <20140425153150.GA20807@atomide.com> <535DFAAE.1010606@ti.com> <20140428164528.GM20807@atomide.com> <535F37E9.8090609@ti.com> <20140429150529.GA27571@atomide.com> <535FD10B.4020108@ti.com> <535FD43B.3030102@ti.com> <20140429173838.GB27571@atomide.com> <5360948A.5020607@ti.com> <20140430175651.GB12362@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="CqfLSggtOOsBbUNAg5oLxsKKUAwqLRRKU"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:33186 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650AbaEBNG0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 May 2014 09:06:26 -0400
In-Reply-To: <20140430175651.GB12362@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Archit Taneja <archit@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--CqfLSggtOOsBbUNAg5oLxsKKUAwqLRRKU
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/04/14 20:56, Tony Lindgren wrote:

> Have you checked out pinctrl-single,bits binding? That should allow
> you to map random bits in a single register to a pinctrl driver
> instance.

If I recall right, the problem there was that we have one register,
which has bits for two separate devices, and the bits are mixed up. i.e.
not 16 upper bits for one, 16 lower for the other, but 5 bits for one
device, the next 5 bits for the other, then again few bits for the
first, etc.

pinctrl-single,bits didn't like it that.

>>>> Oh, also, if I do that, I need to know both the SoC version and the =
DSS
>>>> version in the driver.
>>>
>>> Don't you get all you need in the compatible string? Something like
>>> compatible ti,dss-phy-omap5?
>>
>> We do use different compatible strings for different major versions of=

>> the DSS blocks, like ti,omap5-dsi. But that exactly same DSS block cou=
ld
>> be used on some other SoC, with different control stuff.
>>
>> We could use separate compatible string for each SoC that uses DSS, bu=
t
>> then we're really encoding the SoC version into the compatible string,=

>> not DSS version.
>>
>> Of course, if there will be a separate driver managing the
>> CONTROL_DSIPHY register, then that one should use compatible string
>> specific to the SoC, as it's not a DSS driver at all.
>=20
> Yeah probably using pinctrl-single,bits, or a separate driver with sysc=
on
> makes most sense here.

Yep, I'll have to come up with something.

 Tomi



--CqfLSggtOOsBbUNAg5oLxsKKUAwqLRRKU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTY5g4AAoJEPo9qoy8lh71V5AP/2xbnvn9SHJJPVxLsGxtkoPy
KQHtQM83AerJylujPw58BCTmGmW4TXoSxH7lLMxpMlizrYSa6xu3aN9XHKqEueF1
WHCX9rDcHUmjkgjGerE6tTxA6/Bh1amzyJEQyMkyrC9Y4btNDXPvoNNSrajKfo8j
mUUThl8h72MAqoVlaFnXsQ4DokLeXlghVwl39I8bH4Md7z3OjOeSQzLaQJ8drIrW
J+5KVDpXIdT6DuJxzwHIckwQna6+xRPgO1TZvFYrMYirzeOSyzPIduc3cSDM+b3v
pBuOjvn2eJtL7i2fX3ekbZYobjoY4pQNbIBeVdQx7k6jT68WE7hnyOPgQuoK3Fxj
6TtJCo9mr3hR5kghETGATWXHztRVXukcGZzDvNk9KyHtbfpatAHK7d29eJsmyHoG
MQTX3sBOuPQN+4vIurLXkpZ3LWjJVjSicbH0ZWNZ5/D36ptyBXL0pOO6XSxZ9dTB
KehfY2Md1v+kqve699LSxqWXol99pslshuV2vZQW7iWFwo6y7MJwgH92O429dsBo
K/V9HXCqOuBPboQN3d5Q6lyblA5bfYEsvISEe83lAqFVDr5VDzfYUzNP+rBzqnjc
yb44eR8o9RtRImQBtqz+x6eI7GnRw6VCUF00sEnp+XeFcP8tTXKbN+VME/kHlYCW
Jdm43b2jrwjQDsBGSn5i
=oEgz
-----END PGP SIGNATURE-----

--CqfLSggtOOsBbUNAg5oLxsKKUAwqLRRKU--
