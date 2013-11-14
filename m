From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH 4/8] i2c: omap: Fix missing device tree flags for omap2
Date: Thu, 14 Nov 2013 18:49:13 +0100
Message-ID: <20131114174913.GJ11022@katana>
References: <1384396537-3486-1-git-send-email-tony@atomide.com>
 <1384396537-3486-5-git-send-email-tony@atomide.com>
 <20131114065830.GA2738@katana>
 <20131114173429.GF10317@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="72k7VsmfIboquFwl"
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20131114173429.GF10317-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--72k7VsmfIboquFwl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > It would have been helpful if the message "PATCH [0/x]" would have been
> > sent to the i2c-list also.
>=20
> Thanks, next time I'll try check the cc list in the cover letter
> manually after running git format patch. I guess there's no way
> to deal with that in an automated way.

I use this hackish script as --cc-cmd with git:

#! /bin/sh
#
# cocci_cc - send cover letter to all mailing lists referenced in a patch s=
eries
# done by Wolfram Sang in 2012 - WTFPLv2

name=3D${1##*/}
num=3D${name%%-*}

if [ "$num" =3D "0000" ]; then
	dir=3D${1%/*}
	for f in $dir/*; do
		patchname=3D${f##*/}
		[ "${patchname%%-*}" =3D "0000" ] && continue
		scripts/get_maintainer.pl --no-m $f
	done | sort -u
else
	scripts/get_maintainer.pl $1
fi


--72k7VsmfIboquFwl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJShQ0YAAoJEBQN5MwUoCm2JzYQAJwXHHHmRXHWQT6zjUkrIYAG
K/1NpfxQglsfV/pjpSE3dSceXUbmJ2YbepXB87E8IIWjZkm9nUVmCjVmX6RhGfvo
corguARgNZo2oO/m7MIfFKSrpzopRXnGXyRWShNMuv23GsYv4Dj8fMw6LVVM1ZE8
PXDeIT7/U8gZHiCZ+HNbzAHj3vHsOFLVSFbt3fQBpHY2UypkGkqWKhSqUmZeZc3n
CBwI56bUz4JfprSqfK/0epoaKlrOvCTG1CdoDnwvLhhUaVexjmnPXpDlBPOZ+yyB
UYxvzhZML41RLYRmewkj9KPj/iyDqAu4w8u395zD5mtVDCH2D1rvZT/VVQqQ7cmf
LsOo51Fliqc6+rLSyJyv3Cz3eLKTcPuSBrcpJbf2RukMTXLiSzU7R6YQJ+4wHbXC
trJ+dzk8qCiSYg5b40Y6wrJBBaqANsKm3iKF4ckCMhpPW9O0LDqR2yrv6pv+bIPO
FEk/+Wux6FD0hPfzo1qoLPRlyW9Mp42G4DU/cwpLg0YB8AuFXrGnLyy7RuTSJyCt
dQldDOMYP7V7Hhk4LMy+4+8g3fGnkoPVojhPT7LVWrppMh+9QudRyPojTfEyfoiv
X3u7BRXbegdSTdF4HtMp0Me33FvxGG1SuB41oERgSbYQeOLw92bXPdmDCR/DTfWr
h9jmvzu2wrJoZTzWrP1H
=/kgR
-----END PGP SIGNATURE-----

--72k7VsmfIboquFwl--
