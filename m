From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH V3 1/2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Mon, 8 Apr 2013 23:56:17 +0200
Message-ID: <20130408215616.GA25124@avionic-0098.mockup.avionic-design.de>
References: <1363214006-10662-1-git-send-email-achew@nvidia.com>
 <1363214006-10662-2-git-send-email-achew@nvidia.com>
 <20130408214624.GZ10155@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:51340 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936362Ab3DHV4Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 17:56:25 -0400
Content-Disposition: inline
In-Reply-To: <20130408214624.GZ10155@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andrew Chew <achew@nvidia.com>, peter.ujfalusi@ti.com, acourbot@nvidia.com, linux-omap@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2013 at 02:46:24PM -0700, Tony Lindgren wrote:
> * Andrew Chew <achew@nvidia.com> [130313 15:37]:
> > The pwm-backlight driver now takes a mandatory regulator that is gotten
> > during driver probe.  Initialize a dummy regulator to satisfy this
> > requirement.
> >=20
> > Signed-off-by: Andrew Chew <achew@nvidia.com>
> > ---
> > Changed the device name of the backlight regulator supply to "pwm-backl=
ight",
> > per Peter's comment.
> >=20
> > Changed the name of the regulator to "backlight-enable", per Thierry's
> > suggestion.
>=20
> Thanks applying into omap-for-v3.10/board. Note that I'm not taking the
> second one, that should be resent to the related driver maintainers.
> You can get that list by running scripts/get_maintainer.pl against it.

The plan was to take these all through one tree, preferably the PWM tree
because it's all PWM related and the pwm-backlight change will go
through that tree as well. Technically these individual patches can be
applied as is and aren't harmful, but keeping track of the dependencies
might be difficult if they go in via separate trees.

Thierry

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRYz0AAAoJEN0jrNd/PrOh96cP+wdfbXIEuXAATCzbk3OsEMXD
+wQljDeGkpPU28pTmDzBM+Ww/7ng9YlHa+YHjTganTE5Z3HVNrB2yaaUxH49271z
8tONBmxh0fdpoKE+f3fonK8VGMUutHWdKPpewsEEJ9ENLHTZwBhcK2m6lG4GVNeJ
3f+J1QdsXybKGN5FsWhD1GFqLEbtht/BpOFO+BopUEU32NsW7avctLcBtE1sbg7d
A+sr0rAC4DUAishAbAu7QwA/m/h1OD/iWA7yKpoyjQaHRSEnZ+Key8fFbwSqCUtz
5lsOus/QN/atXTETQ3X8LpRc9B6FLEwB2MA/+c2taxBm249vaT6o4CcTODv+2Ipl
2DP8aK6q9atyrmVBaYKpGrNHcjhRd2gzPqcoJZHS0eFil3r13v1Bx6FB42pnx0Cr
OXWnc4dYW28Vj+bgslofz7tHHANSlbX0kDwLcb7nbnMhudG9Q9vDDX0YMxt+f15g
lg+A3OVsRZ1FAmgjIy1mdy3qAksXmkySvjH8nzxC8Z1QF5UEq/G7WXhXbx8wVMqi
4SyHnygbKfViu+QYXbjnExGuUhGtMH9iEK81Mi3ZL0BxVpF19FNI52erdAu5h4c0
sqILyHB1BmdYB0AuWFnKOx2xbC9UyOigMkoG41zfuKI9ClTfXiH9Vt2xNceTZlKc
vsNkE7zaJIgkQMT3XRC9
=m8dh
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
