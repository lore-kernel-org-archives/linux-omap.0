From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Mon, 23 Jan 2017 21:22:07 +0100
Message-ID: <20170123202207.GA22712@amd>
References: <20170123124058.GA17134@amd>
 <20170123141331.GA11402@amd>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2280358628070836913=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170123141331.GA11402@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
Cc: fabio.estevam@nxp.com, rui.zhang@intel.com, linux@roeck-us.net
List-Id: linux-omap@vger.kernel.org


--===============2280358628070836913==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2017-01-23 15:13:31, Pavel Machek wrote:
> Hi!
>=20
> > It seems that battery driver stopped working on N900 between -rc4 and
> > -rc5.
>=20
> pavel@amd:/data/l/linux-n900$ git bisect log
> # bad: [41f283973653dc44af47585fa79fb6da6ffdc2e2] Merge
> /data//l/clean-cg into mini-v4.10
> # good: [4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185] It seems mainline
> -rc4 did have a fix for the sound issue. Use that one.
> git bisect start 'mini-v4.10'
> '4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185'
> # good: [e90665a5d38b17fdbe484a85fbba917a7006522d] Merge tag
> 'ceph-for-4.10-rc5' of git://github.com/ceph/ceph-client
> git bisect good e90665a5d38b17fdbe484a85fbba917a7006522d
> # good: [83fd57a740bb19286959b3085eb93532f3e7ef2c] Merge tag
> 'powerpc-4.10-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect good 83fd57a740bb19286959b3085eb93532f3e7ef2c
> # good: [c497f8d17246720afe680ea1a8fa6e48e75af852] Merge tag
> 'usb-4.10-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> git bisect good c497f8d17246720afe680ea1a8fa6e48e75af852
> # bad: [bb6c01c2dde67b165cf7c808b0f00677b6f94b96] Merge branch
> 'for-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux
> git bisect bad bb6c01c2dde67b165cf7c808b0f00677b6f94b96
> # good: [18591add41ec9558ce0e32ef88626c18cc70c686] thermal: rockchip:
> handle set_trips without the trip points
> git bisect good 18591add41ec9558ce0e32ef88626c18cc70c686
> # bad: [f53345e8cf027d03187b9417f1f8883c516e1a5b] thermal: core: move
> tz->device.groups cleanup to thermal_release
> git bisect bad f53345e8cf027d03187b9417f1f8883c516e1a5b
> # bad: [7611fb68062f8d7f416f3272894d1edf7bbff29c] thermal:
> thermal_hwmon: Convert to hwmon_device_register_with_info()
> git bisect bad 7611fb68062f8d7f416f3272894d1edf7bbff29c
> # first bad commit: [7611fb68062f8d7f416f3272894d1edf7bbff29c]
> thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
> pavel@amd:/data/l/linux-n900$
>=20
> pavel@amd:/data/l/linux-n900$ git bisect log
> # bad: [41f283973653dc44af47585fa79fb6da6ffdc2e2] Merge
> /data//l/clean-cg into mini-v4.10
> # good: [4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185] It seems mainline
> -rc4 did have a fix for the sound issue. Use that one.
> git bisect start 'mini-v4.10'
> '4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185'
> # good: [e90665a5d38b17fdbe484a85fbba917a7006522d] Merge tag
> 'ceph-for-4.10-rc5' of git://github.com/ceph/ceph-client
> git bisect good e90665a5d38b17fdbe484a85fbba917a7006522d
> # good: [83fd57a740bb19286959b3085eb93532f3e7ef2c] Merge tag
> 'powerpc-4.10-2' of
> git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
> git bisect good 83fd57a740bb19286959b3085eb93532f3e7ef2c
> # good: [c497f8d17246720afe680ea1a8fa6e48e75af852] Merge tag
> 'usb-4.10-rc5' of
> git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
> git bisect good c497f8d17246720afe680ea1a8fa6e48e75af852
> # bad: [bb6c01c2dde67b165cf7c808b0f00677b6f94b96] Merge branch
> 'for-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux
> git bisect bad bb6c01c2dde67b165cf7c808b0f00677b6f94b96
> # good: [18591add41ec9558ce0e32ef88626c18cc70c686] thermal: rockchip:
> handle set_trips without the trip points
> git bisect good 18591add41ec9558ce0e32ef88626c18cc70c686
> # bad: [f53345e8cf027d03187b9417f1f8883c516e1a5b] thermal: core: move
> tz->device.groups cleanup to thermal_release
> git bisect bad f53345e8cf027d03187b9417f1f8883c516e1a5b
> # bad: [7611fb68062f8d7f416f3272894d1edf7bbff29c] thermal:
> thermal_hwmon: Convert to hwmon_device_register_with_info()
> git bisect bad 7611fb68062f8d7f416f3272894d1edf7bbff29c
> # first bad commit: [7611fb68062f8d7f416f3272894d1edf7bbff29c]
> thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
> pavel@amd:/data/l/linux-n900$
>=20
> 7611fb68062f8d7f416f3272894d1edf7bbff29c is the first bad commit
> commit 7611fb68062f8d7f416f3272894d1edf7bbff29c
> Author: Fabio Estevam <fabio.estevam@nxp.com>
> Date:   Tue Dec 27 15:31:49 2016 -0200
>=20
>     thermal: thermal_hwmon: Convert to
>     hwmon_device_register_with_info()
>=20
>     Booting Linux on a mx6q based board leads to the following
>     warning:
>=20
>     (NULL device *): hwmon_device_register() is deprecated. Please
>     convert the
>         driver to use hwmon_device_register_with_info().
>=20
>     ,so do as suggested.
>=20
>     Also, this results in the core taking care of creating the 'name'
>         attribute, so drop the code doing that from the thermal
>         driver.
>=20
>  Suggested-by: Guenter Roeck <linux@roeck-us.net>
>  Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
>  Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>=20
> :040000 040000 b3f6095ab53677277c2f9d75cb6430afb6825765
> 156a18e983a22b8ae43c7b312a4e1c63017f0e26 M	drivers
>=20
> I'll try to revert it on the top of v4.10-rc5 now.

As I mentioned, works ok with the revert.

rx51_battery.c calls power_supply_register()
power_supply_core.c calls thermal_zone_device_register() in psy_register_th=
ermal()
thermal_core.c calls thermal_add_hwmon_sysfs()

Best regards,
									Pavel



--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliGZe8ACgkQMOfwapXb+vJIHQCfQ881yAz5AFwU1aWADiexY/Zd
PpQAn0HQwsLXLb9mL9iiiDofnyj/wyg/
=FLkb
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--


--===============2280358628070836913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2280358628070836913==--
