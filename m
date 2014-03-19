From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: pandaboard boot crash with linux-next
Date: Wed, 19 Mar 2014 16:33:47 +0200
Message-ID: <5329AACB.7080208@ti.com>
References: <53270218.9050109@ti.com> <5329A8E9.1010000@ti.com> <AA9ED470-ADDB-4855-A016-5E36F983CF7D@antoniou-consulting.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="F11dBmKehOfKCxAT3uUHBO40oxAxVm0bL"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49202 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933739AbaCSOdx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 10:33:53 -0400
In-Reply-To: <AA9ED470-ADDB-4855-A016-5E36F983CF7D@antoniou-consulting.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pantelis Antoniou <panto@antoniou-consulting.com>
Cc: Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "Kristo, Tero" <t-kristo@ti.com>

--F11dBmKehOfKCxAT3uUHBO40oxAxVm0bL
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 19/03/14 16:29, Pantelis Antoniou wrote:
> Hi Tomi,
>=20
> On Mar 19, 2014, at 4:25 PM, Tomi Valkeinen wrote:
>=20
>> On 17/03/14 16:09, Tomi Valkeinen wrote:
>>> Hi,
>>>
>>> I noticed that my omap4 panda does not boot with today's linux-next
>>> (8808b950581f71e3ee4cf8e6cae479f4c7106405). I didn't have much time t=
o study
>>> it, but I didn't find any posts about the issue with a quick look. Be=
low is
>>> the crash.
>>
>> I bisected this to the commit:
>>
>> commit ad2c12e9bc250b3387bcb4ab9ab114f43ff6122f
>> Author: Pantelis Antoniou <panto@antoniou-consulting.com>
>> Date:   Fri Dec 13 20:08:59 2013 +0200
>>
>>    of: device_node kobject lifecycle fixes
>>
>>    After the move to having device nodes be proper kobjects the lifecy=
cle
>>    of the node needs to be controlled better.
>>
>>    At first convert of_add_node() in the unflattened functions to
>>    of_init_node() which initializes the kobject so that of_node_get/pu=
t
>>    work correctly even before of_init is called.
>>
>>    Afterwards introduce of_node_is_initialized & of_node_is_attached t=
hat
>>    query the underlying kobject about the state (attached means kobj
>>    is visible in sysfs)
>>
>>    Using that make sure the lifecycle of the tree is correct at all
>>    times.
>>
>>    Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
>>    [grant.likely: moved of_node_init() calls, fixed up locking, and
>>                   dropped __of_populate() hunks]
>>    Signed-off-by: Grant Likely <grant.likely@linaro.org>
>>
>=20
> Can you try this? It should fix it (plus it should be in -next soon)

Thanks, that fixes the issue (tested on omap4 panda).

 Tomi



--F11dBmKehOfKCxAT3uUHBO40oxAxVm0bL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJTKarLAAoJEPo9qoy8lh71SjUP/2gD+AsiNRea1x8Uc99Rx+4A
2DFptNLknwPO8loHQuGFcSrShbkTl9WUjVBlZ35eZIqUdrJ2QvaAZDsT38+OEgxx
20yCDDf3EGGUGxbZgDzyHyTASRbj8lG006NbAIKoD46jYZ+XHTD3zwmFGV5Vyd+m
+bpBhIL8trKtyOptIN87yktsg/p/wENfH0Pq/Cq9urBt9RczhiwY80bVOovIyTf0
iwhZeLh3K1igeocZNJs/86NtZ8XNu5N56nlQKleMv7J+XpIkugqlJFalmaObZftq
Yblh7X52s3OjehhkLpSMFpAUG/GfkS8AaqF8LTixIt0oK10KB3Sqp7563Uee7Iu1
c2xdJuI9GjN6MnmsFCpisip1FvXNjsY+tQb52UJWhPQzb1TP8S+ug/1PwinIyM1A
GfgaR3WyEbpqBwgUU/l41S4TGkS341f8e85GphUD77YbLJ6bMCZcC1vZf1ITI+1l
u8Rsfu711TUyZuZOZb0A8hY4VAxN2//AWmwwOMGoczvhFqdQHxR8QiIbQlJZFEsN
HfZqqL2+ZkUickkpi+lVjcNwBPpJ/YmcNNczHGCCgGj1d2chyRndl/Bhxtgq4Nqi
pLqRTo440ZAl9SzgBf6TjeQ0C8DVQgq/kPgEqqmCqbDLoiKE8SgvtE23zENQRZe8
+rb6JFm5LYFRGJBdbJ3d
=bi2d
-----END PGP SIGNATURE-----

--F11dBmKehOfKCxAT3uUHBO40oxAxVm0bL--
