From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH 00/17] i2c: deprecate class based instantiation for
 embedded I2C drivers
Date: Fri, 28 Mar 2014 08:55:49 +0100
Message-ID: <20140328075548.GD2708@katana>
References: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+B+y8wtTXqdUj1xM"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1392026654-5343-1-git-send-email-wsa@the-dreams.de>
Sender: linux-doc-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: adi-buildroot-devel@lists.sourceforge.net, davinci-linux-open-source@linux.davincidsp.com, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--+B+y8wtTXqdUj1xM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 10, 2014 at 11:03:54AM +0100, Wolfram Sang wrote:
> With I2C, class based instantiation means if a master driver has e.g.
> I2C_CLASS_HWMON set, all slave drivers with this class will try to probe a
> device using an array of possible addresses and some heuristics. That cre=
ates
> traffic and needs time, even when nothing is connected. This mechanism is
> needed when you do not have another method to describe the slaves. Embedd=
ed I2C
> drivers do not need class based instantiation, since there is i2c_board_i=
nfo or
> devicetree description. Some drivers have the class flags set, though, an=
d it
> has spread further over the years. We can't remove the flags directly, be=
cause
> there might be users out there relying on this feature. So, we add a
> deprecation warning if a device is instantiated via class attributes. Aft=
er
> giving some time to switch over, we can then finally remove the class fla=
gs and
> gain boot time.
>=20
> Patch 1 adds some missing documentation. Patch 2 adds the deprecation fea=
ture.
> Patches 3+4 are tested on hardware I need. Patches 5-17 are suggestions f=
or
> drivers I think could benefit from that. For those, acks are needed befor=
e I
> will apply them to my tree. If you use a different driver which can also
> benefit from this, just send a patch adding the new DEPRECATED flag.
>=20
> The series can also be found here:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/deprecate=
d_class
>=20
> Thanks,
>=20
>    Wolfram
>=20
>=20
> Wolfram Sang (17):
>   Documentation: i2c: describe devicetree method for instantiating
>     devices
>   i2c: add deprecation warning for class based instantiation
>   i2c: i2c-omap: deprecate class based instantiation
>   i2c: i2c-at91: deprecate class based instantiation
>   i2c: i2c-bcm2835: deprecate class based instantiation
>   i2c: i2c-bfin-twi: deprecate class based instantiation
>   i2c: i2c-davinci: deprecate class based instantiation
>   i2c: i2c-designware-platdrv: deprecate class based instantiation
>   i2c: i2c-mv64xxx: deprecate class based instantiation
>   i2c: i2c-nomadik: deprecate class based instantiation
>   i2c: i2c-ocores: deprecate class based instantiation
>   i2c: i2c-rcar: deprecate class based instantiation
>   i2c: i2c-s3c2410: deprecate class based instantiation
>   i2c: i2c-sirf: deprecate class based instantiation
>   i2c: i2c-stu300: deprecate class based instantiation
>   i2c: i2c-tegra: deprecate class based instantiation
>   i2c: i2c-xiic: deprecate class based instantiation

I reconsidered and have now applied all patches. That way, all these
drivers can be converted to no class based instantiation in one go after
some grace period. If it turns out, one driver actually needs it, there
is still the grace period left to remove the DEPRECATED flag again.


--+B+y8wtTXqdUj1xM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTNSsEAAoJEBQN5MwUoCm2aPUP/0fNAS8+v21TjZp/oZc/OYXJ
uPl3yGMTuEjEF6vMpjRZAgLdEEBzp3kY65odh5LzyfcVGw+MxGFsSgyaHlDEvLVI
8VCGE+09XzaCRqOOq98QFrVZCnvEhxyYAM2paB1E8s0W6Sl4Cx6mhTT4xKt5EShg
l44GTiG+ce5hqsvzdf4GgKRGOt+jdNL6drojM26HA3osAj3O7FUHbB2kFXB/cR+2
Bkx5D2vPfMFWdaoy6OWoBLw/Mu8bdTEpKSeAJHSHJfb8MDJbwj3OAnE727c5N9AC
QyrYNv/ENAizaJXtTpPjGDwWltZf4dGuGqCIp1rGIa+Qb3cu/yM9LvhU9gUvGWxq
0RgrlfRyNp51Jzc6kLpOrkCirejm6T4m2zg8mwvVE+aCMi4MIY3+GFtlxkvTMqvo
5fuo3+wHKpE8ThQWhxBq+5g2LU7LIPq8LbfWXSwAH9axLhpSrBrPDS6QuLcsR/3Y
DZ50lOjdXGkRq+Ts1+yv0nMaoWonjBJZfJ0CzWcz7caJ7/vLQmaP+Ps0FenpgRYQ
PmDkVkobDhwD35ca2JJpoZd2osqT9W5z1pzrVip0loEvI7fNyfRdHTic22YS4NgK
hY8qwdWL3wywbGpEaHAajXv2wI8dT4QcF5B1KCmRD3FBbWAPSWWeZidD2rc915My
kAHhWUihcNGI5n8hFyt9
=Xl2M
-----END PGP SIGNATURE-----

--+B+y8wtTXqdUj1xM--
