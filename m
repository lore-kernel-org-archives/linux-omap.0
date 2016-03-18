From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Nokia N900 - audio TPA6130A2 problems
Date: Fri, 18 Mar 2016 16:04:04 +0100
Message-ID: <20160318150404.GA30829@earth>
References: <20160316144709.GA3389@earth>
 <56E9A42B.3010209@gmail.com>
 <56E9A6D9.7000003@ti.com>
 <56E9B910.7000904@gmail.com>
 <56EA6282.5050501@ti.com>
 <56EAE8C3.1080301@gmail.com>
 <56EBD96A.8090505@ti.com>
 <1458306829.11841.2.camel@Nokia-N900>
 <20160318133641.GB16747@earth>
 <56EC0676.3000509@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56EC0676.3000509@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Tony Lindgren <tony@atomide.com>, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, Nishanth Menon <nm@ti.com>, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 18, 2016 at 03:45:26PM +0200, Ivaylo Dimitrov wrote:
> On 18.03.2016 15:36, Sebastian Reichel wrote:
>=20
> >Have you tried the ideas from <20160317004917.GA6750@earth> (Date:
> >Thu, 17 Mar 2016 01:49:18 +0100)?
> >
>=20
> To the extend I understood them :)
>=20
> Regulator is V28_A, which is always-on, so it is enabled no matter what
> probe does. Anyway, I added a various delays after regulator_enable(), to=
 no
> success.

Did you by chance also test adding a delay after setting the power
gpio? According to the datasheet:

Start-up time from shutdown: typical 5ms

> I didn't try building the driver as a module, instead I played with
> bind/unbind functionality - makes no difference.

Ok.

-- Sebastian

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJW7BjgAAoJENju1/PIO/qa8iYP+QFnFfu1K1OyChLk8Kr6/mtc
Cz5xxKhHQ+7ghDZazGtqUZ0CKWibyo6VqAD0RqHgjkSMhqIS5erlC92oLb7srYhi
xsh5yEE9k28qWRQA8QnNOZ3tukNgQW/pH+w2+HFzNa7JEaEOenxvJldx0mE93uBo
wWo81/0h/rwO51lin3dgkfK13E+VQDWPKuVxpweL/+eEadFpdRsPKa3Z0esRnsc3
Wr4so91GfNhlx/WbVkOc8uwqIFTaRHgmZRjdg5hlyF40gHFQcpU8H9Fx6ra2jsHc
2aOVS8hqUl/1h2NOm+o1nZ6acNDjBCQNHNKY9mvoncNLX6Snul69V5iKAPOCqTPk
1wwxuj1oeedLKdOz8c/arA6M3FmZnCAONDKv/yufZxnxUBBw4p7c8uuwe8VLmecx
eCcR9lu1QJVL6KBgxlQ/ww+kPg4VWex67TzEYLDegiU+zXjCDt3mLI8xr9D/HqHY
Si943kmiO+HZrjtFdRn8jjxDUPZpFwKvB/OpFK04Ltf4iqo3hAIjmI9fNDV73G39
pEXHEQ8xhT1xf+Y+eH3tgljVZDt4tvD8J5vq2GgHaQIKLnySzbtIfU1U1IMN3xe3
77hW0i6iqtarDsdYhHbPi0Nuc5C9UGycVHHxKN1P+8S/H7MOOxqvYQ9jtSFWcR86
fXT73PxRNm/YZCO7im0l
=gpO0
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
