From: Pavel Machek <pavel@ucw.cz>
Subject: Re: v4.10-rc4 to v4.10-rc5: battery regression on Nokia N900
Date: Mon, 23 Jan 2017 15:19:28 +0100
Message-ID: <20170123141331.GA11402@amd>
References: <20170123124058.GA17134@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170123124058.GA17134@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: pali.rohar@gmail.com, sre@kernel.org, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, khilman@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com, abcloriens@gmail.com
Cc: linux@roeck-us.net, fabio.estevam@nxp.com, rui.zhang@intel.com
List-Id: linux-omap@vger.kernel.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> It seems that battery driver stopped working on N900 between -rc4 and
> -rc5.

pavel@amd:/data/l/linux-n900$ git bisect log
# bad: [41f283973653dc44af47585fa79fb6da6ffdc2e2] Merge
/data//l/clean-cg into mini-v4.10
# good: [4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185] It seems mainline
-rc4 did have a fix for the sound issue. Use that one.
git bisect start 'mini-v4.10'
'4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185'
# good: [e90665a5d38b17fdbe484a85fbba917a7006522d] Merge tag
'ceph-for-4.10-rc5' of git://github.com/ceph/ceph-client
git bisect good e90665a5d38b17fdbe484a85fbba917a7006522d
# good: [83fd57a740bb19286959b3085eb93532f3e7ef2c] Merge tag
'powerpc-4.10-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 83fd57a740bb19286959b3085eb93532f3e7ef2c
# good: [c497f8d17246720afe680ea1a8fa6e48e75af852] Merge tag
'usb-4.10-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good c497f8d17246720afe680ea1a8fa6e48e75af852
# bad: [bb6c01c2dde67b165cf7c808b0f00677b6f94b96] Merge branch
'for-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux
git bisect bad bb6c01c2dde67b165cf7c808b0f00677b6f94b96
# good: [18591add41ec9558ce0e32ef88626c18cc70c686] thermal: rockchip:
handle set_trips without the trip points
git bisect good 18591add41ec9558ce0e32ef88626c18cc70c686
# bad: [f53345e8cf027d03187b9417f1f8883c516e1a5b] thermal: core: move
tz->device.groups cleanup to thermal_release
git bisect bad f53345e8cf027d03187b9417f1f8883c516e1a5b
# bad: [7611fb68062f8d7f416f3272894d1edf7bbff29c] thermal:
thermal_hwmon: Convert to hwmon_device_register_with_info()
git bisect bad 7611fb68062f8d7f416f3272894d1edf7bbff29c
# first bad commit: [7611fb68062f8d7f416f3272894d1edf7bbff29c]
thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
pavel@amd:/data/l/linux-n900$

pavel@amd:/data/l/linux-n900$ git bisect log
# bad: [41f283973653dc44af47585fa79fb6da6ffdc2e2] Merge
/data//l/clean-cg into mini-v4.10
# good: [4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185] It seems mainline
-rc4 did have a fix for the sound issue. Use that one.
git bisect start 'mini-v4.10'
'4f8d9925eb1de1ec1c4183164f1bc7b01f5ae185'
# good: [e90665a5d38b17fdbe484a85fbba917a7006522d] Merge tag
'ceph-for-4.10-rc5' of git://github.com/ceph/ceph-client
git bisect good e90665a5d38b17fdbe484a85fbba917a7006522d
# good: [83fd57a740bb19286959b3085eb93532f3e7ef2c] Merge tag
'powerpc-4.10-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux
git bisect good 83fd57a740bb19286959b3085eb93532f3e7ef2c
# good: [c497f8d17246720afe680ea1a8fa6e48e75af852] Merge tag
'usb-4.10-rc5' of
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb
git bisect good c497f8d17246720afe680ea1a8fa6e48e75af852
# bad: [bb6c01c2dde67b165cf7c808b0f00677b6f94b96] Merge branch
'for-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux
git bisect bad bb6c01c2dde67b165cf7c808b0f00677b6f94b96
# good: [18591add41ec9558ce0e32ef88626c18cc70c686] thermal: rockchip:
handle set_trips without the trip points
git bisect good 18591add41ec9558ce0e32ef88626c18cc70c686
# bad: [f53345e8cf027d03187b9417f1f8883c516e1a5b] thermal: core: move
tz->device.groups cleanup to thermal_release
git bisect bad f53345e8cf027d03187b9417f1f8883c516e1a5b
# bad: [7611fb68062f8d7f416f3272894d1edf7bbff29c] thermal:
thermal_hwmon: Convert to hwmon_device_register_with_info()
git bisect bad 7611fb68062f8d7f416f3272894d1edf7bbff29c
# first bad commit: [7611fb68062f8d7f416f3272894d1edf7bbff29c]
thermal: thermal_hwmon: Convert to hwmon_device_register_with_info()
pavel@amd:/data/l/linux-n900$

7611fb68062f8d7f416f3272894d1edf7bbff29c is the first bad commit
commit 7611fb68062f8d7f416f3272894d1edf7bbff29c
Author: Fabio Estevam <fabio.estevam@nxp.com>
Date:   Tue Dec 27 15:31:49 2016 -0200

    thermal: thermal_hwmon: Convert to
    hwmon_device_register_with_info()

    Booting Linux on a mx6q based board leads to the following
    warning:

    (NULL device *): hwmon_device_register() is deprecated. Please
    convert the
        driver to use hwmon_device_register_with_info().

    ,so do as suggested.

    Also, this results in the core taking care of creating the 'name'
        attribute, so drop the code doing that from the thermal
        driver.

 Suggested-by: Guenter Roeck <linux@roeck-us.net>
 Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
 Signed-off-by: Zhang Rui <rui.zhang@intel.com>

:040000 040000 b3f6095ab53677277c2f9d75cb6430afb6825765
156a18e983a22b8ae43c7b312a4e1c63017f0e26 M	drivers

I'll try to revert it on the top of v4.10-rc5 now... and yes, it fixes
the issue.

Any idea what went wrong and how to fix that?

Anyway as we are at -rc5 and this is warning fix that caused a
regression on different hardware... it should be reverted.

Best regards,

								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAliGEPAACgkQMOfwapXb+vJLjQCgxB71ABi0ByWaC/MsXPO55rRn
Z1QAnRYQpMKc+W1xWu2UxsYFt16UhwtY
=J41d
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
