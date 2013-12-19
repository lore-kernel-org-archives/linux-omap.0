From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: OMAP display subsystem - does it work?
Date: Thu, 19 Dec 2013 07:23:10 +0200
Message-ID: <52B282BE.9050705@ti.com>
References: <20131218120023.GG4360@n2100.arm.linux.org.uk>
 <52B1A922.6020901@ti.com> <20131218180240.GG27438@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8868221790544860231=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20131218180240.GG27438@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

--===============8868221790544860231==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="aqwuPDCj8gXnM1KqGpJsKhrA9md4a2HKE"

--aqwuPDCj8gXnM1KqGpJsKhrA9md4a2HKE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-12-18 20:23, Tony Lindgren wrote:

> Hmm I had the framebuffer working with DT on LDP after fixing the twl40=
30
> gpio regression with 0b2aa8bed3e1 (gpio: twl4030: Fix regression for tw=
l
> gpio output) using this pdata quirks patch:
>=20
> [PATCH 3/5] ARM: OMAP2+: Add DT init code for DPI displays and make oma=
p3 LDP to use it
>=20
> AFAIK the pdata hack above should not be needed now, but I have not tri=
ed
> with Tomi's DSS DT patches yet.
>=20
> Tomi do you have some sample panel dpi .dts entry somewhere for the LDP=
 I
> could try at some point?

Hmm, I thought this was about legacy booting on v3.14-rc4. That still
uses the board files for omap3.

> Russell, maybe all you're missing is just omapfb.vram=3D0:2M,1:5M or si=
milar
> from your kernel cmdline?

Nothing like that should be required for normal operation.

 Tomi



--aqwuPDCj8gXnM1KqGpJsKhrA9md4a2HKE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSsoLCAAoJEPo9qoy8lh71G88QAKF43u/4olMYAZeGptR/dxHF
UHcLKvGRxi6x7wlkFg70nshHokhnd+aiC8FJ48uDFnO/091/22qQaGoLM44nQ/B8
74PYhGYvJUOJDZCkrq/8lSziyYrwQBy0DEI/RrSU8D6KbGzRzSsszyrETG/CFqPC
v5+nSfUZiCQZFp6xmBiFMsA38tcXeVpo2LQRM8EZ9zYErqqeynC5IhDkpN7IW2ca
i4VmZkpyWwYlEs0tK2fDEM2HF0M0QsvQVwRxCxa1PGyQs/AYJpGfJN9dzy1HYWej
tfqey4gGy8Mb85Yvb9tivb0wnArJI0P9lZMo6s8ebwIfQg3naFzIYnHzb/R3/MqW
an33zqVV0XjcMlZ835yPYIP3rgd4fhiKFXKK1aoF2yPgrDnZCgvpIZHf2cp40CVe
GuPn12XMC91C0KxpOsMGnhfE9KwbI+dOmNcMjF48gf2x7OyhDVlyU6NzFb4bT0zs
3upREhXZXWJ7cuagKi5zGt11kiBvJvvIzO2/OHVf8GLJxuGVUAnm20otNRq4Xu8q
zi3Gzg0FmYAayfny8YDuQQ/RSRCqn+ZJXNRkVDZ80+nJUUpr16M6RE7qi0RoYC7J
j/16Zh46c54aAhp3JxVXNNeya6hEwR/jb3g303rzgyaZBgl+SAq/2Ckwo+lSD1UM
YyUgJ7BvMODkxhzK+qaG
=SmSS
-----END PGP SIGNATURE-----

--aqwuPDCj8gXnM1KqGpJsKhrA9md4a2HKE--


--===============8868221790544860231==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8868221790544860231==--
