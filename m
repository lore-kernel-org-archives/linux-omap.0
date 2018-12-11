From: Sebastian Reichel <sre@kernel.org>
Subject: Re: Droid 4: poweroff does not work? calls
Date: Tue, 11 Dec 2018 02:15:43 +0100
Message-ID: <20181211011543.7b2ufljwm45padjt@earth.universe>
References: <20181209121318.GA24478@amd>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bciqzcehawnaanau"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181209121318.GA24478@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org


--bciqzcehawnaanau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Dec 09, 2018 at 01:13:18PM +0100, Pavel Machek wrote:
> Poweroff does not seem to work on Motorola droid 4 -- it reboots. It
> seems to be problem "forever", 4.18 and 4.20-rc5 seem to be
> affected. It is bad, because when your battery is low, you get into
> reboot loop and discharge it furher, which batteries do not like.
>=20
> Any ideas, or at least idea how to debug this?

I cannot reproduce (using 8214bdf7d3e6 + a lot of omapdrm patches,
that I'm currently testing):

droid4# poweroff
[ 1097.557434] printk: systemd-shutdow: 32 output lines suppressed due to r=
atelimiting
[ 1097.862670] systemd-shutdown[1]: Sending SIGTERM to remaining processes.=
=2E.
[ 1097.920715] systemd-journald[158]: Received SIGTERM from PID 1 (systemd-=
shutdow).
[ 1097.973022] systemd-shutdown[1]: Sending SIGKILL to remaining processes.=
=2E.
[ 1098.027008] systemd-shutdown[1]: Unmounting file systems.
[ 1098.034057] systemd-shutdown[1]: Remounting '/' read-only with options '=
errors=3Dremount-ro'.
[ 1098.136413] EXT4-fs (mmcblk0p2): re-mounted. Opts: errors=3Dremount-ro
[ 1098.170623] systemd-shutdown[1]: Remounting '/' read-only with options '=
errors=3Dremount-ro'.
[ 1098.190673] EXT4-fs (mmcblk0p2): re-mounted. Opts: errors=3Dremount-ro
[ 1098.201324] systemd-shutdown[1]: All filesystems unmounted.
[ 1098.202148] systemd-shutdown[1]: Deactivating swaps.
[ 1098.213226] systemd-shutdown[1]: All swaps deactivated.
[ 1098.213958] systemd-shutdown[1]: Detaching loop devices.
[ 1098.240692] systemd-shutdown[1]: All loop devices detached.
[ 1098.370880] reboot: Power down

^ phone is off at this point

-- Sebastian

--bciqzcehawnaanau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlwPD78ACgkQ2O7X88g7
+ppr/A/7BHcRUOvED0dKt8cO5F3pj3qNnqIpsiZ1ng/fYuMCx0HnP7U384eEqm82
sQl9OfMkbvkUbtsBO/bylkG/A915wVfs1RuDCQSExjZHsreUADSre0LyKsUZyquW
yOximT6/JgTavgBN+x7CSsAMQtbiKbr1Fy9J40mQYWGHwipk61v3FxCXAC/VUXgT
7fItEvxBJ0B3k0SlTasBMBsubSnO727ozcmXBrRn53CbxOZ864FtUNjCbPq4VXii
9XtyE2wyE1/2RLRlKb6WenFgjNw0Df7ys/Weso3sJJWznPXRmETxdJAkAW89tYh6
S9RL6ISXFC36eUWcIYhhkmPmVzlMqq2nXyrOcZmvCEuoSa71MxSMt863hYp/YUR1
n30VkhXFPi1023+7PWkQdVdYqP+YvSzQnvLGDIvh0qwA56RacGKzlkVEcpean0fe
2FMNcRQe2k/eBSCFQi8/1rPWL3g7bQgrK6FZ8qQOjtM3SXQTc0i0FIt+D23OBD1y
MQM8AtG35bpOi3ulkb1s2KBbRnFztVUV0g7qzCiWYCenYOW5lvDnY5xBdQQr0U/U
aIaJEJnxp9mSO8HthQbK9j5V/bmP+b1ObPFnUOlCZVIKFysDpEZWXWAvOoOAEPw8
lgCp6mGFOAJLa224gTRf5k1Q5RFKwbHEZ23po9xAotovfg++rXU=
=aD9B
-----END PGP SIGNATURE-----

--bciqzcehawnaanau--
