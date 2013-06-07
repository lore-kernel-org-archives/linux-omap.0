From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: Request for OMAPDSS testing
Date: Fri, 7 Jun 2013 11:39:57 +0300
Message-ID: <51B19C5D.3060406@ti.com>
References: <51AD99F5.7060506@ti.com> <20130606204342.GB3507@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="----enig2ATJRKFDOOPPOGGOTIDTP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:48573 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751721Ab3FGIkU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jun 2013 04:40:20 -0400
In-Reply-To: <20130606204342.GB3507@blackmetal.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Igor Grinberg <grinberg@compulab.co.il>, Thomas Weber <weber@corscience.de>, Mike Rapoport <mike@compulab.co.il>, Steve Sakoman <steve@sakoman.com>, =?windows-1252?Q?Gra=9Evydas_Ignotas?= <notasas@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

------enig2ATJRKFDOOPPOGGOTIDTP
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 06/06/13 23:43, Aaro Koskinen wrote:
> Hi,
>=20
> On Tue, Jun 04, 2013 at 10:40:37AM +0300, Tomi Valkeinen wrote:
>> I've made some big changes on the omapdss device model, which involves=

>> converting all the panel drivers. I've got only a bunch of boards, so =
I
>> hope some of you can perhaps do some minimal tests on some other board=
s.
>>
>> I've got: Beagle (old one), Panda, 4430SDP, Overo with LCD43.
>>
>> The code can be found from the below git branch. It's based on 3.10-rc=
1.
>>
>> git://gitorious.org/linux-omap-dss2/linux.git work/dss-dev-model
>>
>> All you need to do to get things working is to enable the new panel
>> drivers from kernel config, under Device drivers/Graphics support/OMAP=
2+
>> Display Subsystem support/OMAP Display Device Drivers/
>=20
> I tested Nokia N900 by pulling your tree and doing the following .confi=
g
> changes:
>=20
> 	# CONFIG_PANEL_ACX565AKM is not set
>=20
> 	CONFIG_PANEL_SONY_ACX565AKM=3Dy
>=20
> The frame buffer console seems to work OK.

Excellent, thanks!

 Tomi



------enig2ATJRKFDOOPPOGGOTIDTP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIbBAEBAgAGBQJRsZxdAAoJEPo9qoy8lh71ipEP+OcUO3S8ukIQjnxM/3OmbCkx
q6zyB7zv7a8w7JHJvknITRl4MRrFlJ5MnStEuogTevrDTJF5e4bwdDtvRrqmnj4Q
Jvz55Heg79jNbLMuNlY1wu8Iauv7afhuSuYauNg7y3V3RfVmTzHZgQNwt8dX7D8r
qXGvNvdWkv9FTs+A6J4qVADnWb4FVCed8wdJh44vNMdNLvYUWa5AEDYAuTbFQemP
i8NbTGlH3irgzWM9yYpj2VI8PqoLrvPsvuHPMq03JChu5fsleMk6sYEyjyOqhUZy
zTRIWAOMyNZcqf6wojW0iAawMMs/awYq/Ij2FBNUGbqhtYivip2z6GPB6P4ck6zS
9sCK3wCb7FmJLHxXPp/PZV9EEOXDfJhqgzJai4+/62eHhr0kYWAWszlYP+Y2kpsn
AqpsyVN9XkhQinJYFqBcQWp5iKm11vYGbxzrwclNfcFFBTDoJe5wLyUxc5V3drKL
kUgw0gOfh6B2N/Oj4tKY4gsvLa57MMDbw56Yip1yJChjlj0rsEwUAlf1xzqTF141
oC7shvw0j7weB1suR+tQsGaC/RShVqwN7grQ6mrMu7FJQi3eVUved4j6ywM7LIDd
/UF3NVWdJSxf2HunLrAMI38CRVGx/zuF3OgFtCT4Bk3X6mboFIFgTwlpReyhUEmp
cJdqsyMVCXFGtsrQnwo=
=eH1s
-----END PGP SIGNATURE-----

------enig2ATJRKFDOOPPOGGOTIDTP--
