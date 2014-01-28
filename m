From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [BISECTED] OMAP: DSS: clk rate mismatch
Date: Tue, 28 Jan 2014 11:04:35 +0200
Message-ID: <52E772A3.4090401@ti.com>
References: <52E697C0.6000202@gmail.com> <1390848104.4936.62.camel@mars>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="dDHe9PUjef0koNQfeq5jCibkk6UbhUul4"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390848104.4936.62.camel@mars>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Fritz <chf.fritz@googlemail.com>
Cc: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, pali.rohar@gmail.com, pavel@ucw.cz, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

--dDHe9PUjef0koNQfeq5jCibkk6UbhUul4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2014-01-27 20:41, Christoph Fritz wrote:
> On Mon, 2014-01-27 at 19:30 +0200, Ivaylo Dimitrov wrote:
>> linux-next-20140124 DSS is broken on N900  - display stays black (ther=
e=20
>> is some noise though). I booted the kernel with qemu and it gives the =

>> following warning:
>>
>> [    0.623779] DSS: set fck to 172800000
>> [    0.624237] ------------[ cut here ]------------
>> [    0.624298] WARNING: CPU: 0 PID: 1 at=20
>> drivers/video/omap2/dss/dss.c:497 dss_set_fck_rate+0x68/0x8c()
>> [    0.624359] clk rate mismatch: 288000000 !=3D 172800000
>=20
> Here are also clock regressions since next-20140122 regarding
> dss_set_fck_rate() and sys_clkout2 occuring in my current patchset for =
a
> dm37xx100 board. Please see here:

I presume you get a similar warning on your board? What rates does it
report?

 Tomi



--dDHe9PUjef0koNQfeq5jCibkk6UbhUul4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS53KjAAoJEPo9qoy8lh71nrUP/Aozq4UI3WJfP6KEppXq0lBS
MB67vtGweAA9DpxF/G9dlex0hU5ORuuBYSczlRfjSNABp5Zj06yaq2Hx8Xkejsn0
4tqPXQPGeRsj+h7IoWMH+RjqFtJ8xkFW62xlTC5eghQxBBBzgydIXomikCp57Sd8
UnWcrTQSFUbsUo/dOT8BvjmFMD2ZuLV6fvIh5D5uzzQO88EV2LpFs6DTPp247F1x
/Jp3uA5AeFGY5m+6y4rbf+HcdcDFKInRoG+YA7k4Ck/Vgf33N8Mo4NDRRoXED4nh
a3SQIHS2MFpiDqsJNdK4x5d9JY9YzAZmPzHi8QfE0OmyCQht24zIN6lyXzJDTcRo
ErKWbSg69K579tweBugEV7MQZaoQopY7T96FkGOUyK6AYDE+oWjtXewedGVOTCnS
t55IzAwdzWiY8LgF7n5sGf1rLqID4SYc+wawO0/79+eO7LZERbELD+xZJ8pYR2iQ
7kbev9+6ETqcaVCUQA0v2zhOCuw/kFHZiWMxuHwu4G8fHLJgbBindSKvEt25E1E4
js74iEPTXc6tfxR4wRJEDXj4Y4ZcSga2Eh3IUSolp7ZAvAqpsz738PLcTTH3qzU/
gUQAqCid9SgPiUrkjDI8MUZC1Um/MtK8DCz+lzfqEanV9GZPVdurnuupc9BVm02n
8+yEO1VBEJW+OZ1so4YC
=y9vf
-----END PGP SIGNATURE-----

--dDHe9PUjef0koNQfeq5jCibkk6UbhUul4--
