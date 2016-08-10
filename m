From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH] omapfb: omapfb-main: Remove deprecated
 create_singlethread_workqueue
Date: Wed, 10 Aug 2016 13:50:05 +0300
Message-ID: <7085eecc-dbeb-0e0f-dc95-c33f2f72d5b0@ti.com>
References: <20160702083056.GA26936@Karyakshetra>
 <20160702113401.GD17431@htj.duckdns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kknHiuiaVeDWMGoBcradWOhWD3O1U5OXK"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160702113401.GD17431@htj.duckdns.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>, Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--kknHiuiaVeDWMGoBcradWOhWD3O1U5OXK
Content-Type: multipart/mixed; boundary="69b1RX5D5fmb8Qk4XqjvuxGrGj4OCpiSB"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Tejun Heo <tj@kernel.org>, Bhaktipriya Shridhar <bhaktipriya96@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Oleg Nesterov <oleg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-ID: <7085eecc-dbeb-0e0f-dc95-c33f2f72d5b0@ti.com>
Subject: Re: [PATCH] omapfb: omapfb-main: Remove deprecated
 create_singlethread_workqueue
References: <20160702083056.GA26936@Karyakshetra>
 <20160702113401.GD17431@htj.duckdns.org>
In-Reply-To: <20160702113401.GD17431@htj.duckdns.org>

--69b1RX5D5fmb8Qk4XqjvuxGrGj4OCpiSB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 02/07/16 14:34, Tejun Heo wrote:
> On Sat, Jul 02, 2016 at 02:00:56PM +0530, Bhaktipriya Shridhar wrote:
>> The workqueue auto_update_work is involved in auto updating mode for
>> manual-update displays. omapfb driver uses a delayed work item to upda=
te
>> the display at a constant rate.
>>
>> Since these long-running work items aren't involved in memory reclaim =
in
>> any way, system_long_wq has been used.
>=20
> Can you please explain why this is long-running?

It shouldn't be long-running. update() should only start the transfer to
the display.

Although if something is not right (the user sets the auto-update
frequency to too high), the work could end up waiting for the previous
update to finish...

It's a debugging feature, so maybe that's not an issue.

 Tomi


--69b1RX5D5fmb8Qk4XqjvuxGrGj4OCpiSB--

--kknHiuiaVeDWMGoBcradWOhWD3O1U5OXK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXqwbdAAoJEPo9qoy8lh71JD4P/Ahfr6UdK3wikkGpYH5Y9J8u
CdBK8d/zS8DcTxnVrjf1tdo+vcu1Raby6CboS2qKVXeoQTM8Kt7OwmZD6qhLsgPT
rBw1IZa+rJzne5W85hR2k1JlCcs9nAticPv8iIPVdUKZjwI88mCIrskiNHU5wNNM
Df2tKdC46M2R80sAGfKHbHMj5KTvNFMGjx2ia3YceutiNBV/cK99MPgK7md8jmmx
coVD+T5MscEoMWThCSnyv4kLavf6iF1Z4BTHmW09wx+fqFJDU/4ywb4d8g16hC1K
mMDU8vIRlwd7sK2id12xsfOR8A9OO1mFvXEJINgOiInp5TY4EuO0u0sNBywtoOnV
nJ/dW9Z3jpp2QpUZpNFV8bbzbC0HUI2ZRaHPtshutyQxnknw7l7HgndjumxIRTAh
cizbWg4Ls1lHPcp2cy/jAymUqUOGdsaZRBIAjfXwJId6ar+3fUhK2/PWI4b/1c31
Fl5rK22wq8gJdsuQV4Vk952lpx7piNXsNLyhxIl14BXbNGyjKifxdp4uiWKXVjns
4DhsNrElWHKs8J+z1YdUlcuE6Z6g+QtOVYcaxu42+GI3drXWlBmByPLb8hcpN4IV
8QZTkx8q+8Nn7Ftcx48dnQ3eac9lgy3XXyBjhXVeLg8CBrkUbjhuFIouY0mbiPTU
l7LtxAQu5udf0AcR/mDr
=P296
-----END PGP SIGNATURE-----

--kknHiuiaVeDWMGoBcradWOhWD3O1U5OXK--
