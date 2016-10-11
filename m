From: Sebastian Reichel <sre@kernel.org>
Subject: Re: latest version of bluetooth for n950?
Date: Tue, 11 Oct 2016 23:41:40 +0200
Message-ID: <20161011214139.cgxe2ms7qjgruuxb@earth>
References: <20161011074704.GA21003@amd>
 <20161011145140.cq3jex2r23wuayph@earth>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3kztabrpv2i5z6ye"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161011145140.cq3jex2r23wuayph@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pali.rohar@gmail.com, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com
List-Id: linux-omap@vger.kernel.org


--3kztabrpv2i5z6ye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 11, 2016 at 04:51:40PM +0200, Sebastian Reichel wrote:
> On Tue, Oct 11, 2016 at 09:47:04AM +0200, Pavel Machek wrote:
> > I got some free cycles to play with n900 and bluetooth. There's still
> > some unrelated config option that breaks even the old vesion of
> > patches, but I'm ready for more debugging now.
> >=20
> > Could I have the latest version of the (clean) bluetooth patch? I have
> > feeling it might work with the right config option, and would like to
> > try.
> >=20
> > For the record, here's working .config and the tricky tricky oneliner
> > that took me week to figure out.
>=20
> https://git.kernel.org/cgit/linux/kernel/git/sre/linux-n900.git/log/?h=3D=
n950-bluetooth
>=20
> My local branch is based on 4.8 and fixes a few of Marcel's
> comments. I'm currently at ELCE, but I will push my local
> stuff later in the hotel after verifying, that it works as
> expected (luckily I brought N950 with me :)).

It does not. Rebasing the pushed branch to v4.8 works, so the
problem is somewhere in my new changes. I will try to have a
look at it tomorrow.

The changes shouldn't affect you for any tests, though. Just
take the branch from above (and optionally rebase to v4.8).

-- Sebastian



--3kztabrpv2i5z6ye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAABCgAGBQJX/VyQAAoJENju1/PIO/qa9KkP/1Y+xO7yT1chi/Qvq5YuQwoa
ufV1VDuVnfR3HdJGR80ZwdB0h3dC/9gwty4wTyBFXrxHdZtHIbXu4fWNkmkjKAv8
/ywnvnlXTqbJZenSg2YYTjQxPCe12y7Gp4O+ZDSUKv555vplvPOghmNhRBZoh7PC
3HNH0cijAn5zqE1XorQN/CDGgH60+KMQyfrD2QilSQDTzgFezc5gi9bWUYLP4vBX
cuf2zl9RXK0wqKc4QS4AGMHrM70r0ZMMNsv7xDeaO2nWFpL2SbkBD/5+tAmNJub3
+WMyT2nsuec53/GfES/SlhqjGYHKB2ylRvUaINcFRdnxjTeCViIGBqMDcRcOVM9D
oXFoYl6JDWh0g0/VLb6ErdLrjlym+jOan5OP5HQvhydLIIOX1O59yfWGc9ByZUlM
kvW1Llp5pil0okYe/he18m1oGgZnIA6znnjznlU3Rx1GrqvDnBhCuD4/RUg0uRqy
xqCZj5gnrwaTa0M3SPr/KOI8vvwh9UVWQ3ipojkM/xRM5rF6aRSEn0Lw6fVr8I6q
1z6PpMZaXteTL0VMUFEWbieZ+ehLZktRfeMSWjOdnYVK8bBgmktn/FZC+ekxsg98
a13cu7NdtgN5BsQytyltq4Owk+yuTTaw2YF07Jc0irGif3M5SWxIpWU7W3ZKmU++
CXRLGGaOQXsQ5IaXxkAi
=1dA5
-----END PGP SIGNATURE-----

--3kztabrpv2i5z6ye--
