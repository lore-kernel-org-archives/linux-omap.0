From: Felipe Balbi <balbi@ti.com>
Subject: Re: DTR gpio handling removed by
 985bfd54c826c0ba873ca0adfd5589263e0c6ee2
Date: Thu, 14 Aug 2014 17:58:02 -0500
Message-ID: <20140814225802.GA12109@saruman.home>
References: <CAAfyv36aMkE5e6Bo1hy1md+Z5EjrZjP+foZTyncp5GFtnaL_sg@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J/dobhs11T7y2rNN"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAAfyv36aMkE5e6Bo1hy1md+Z5EjrZjP+foZTyncp5GFtnaL_sg@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
To: Belisko Marek <marek.belisko@gmail.com>
Cc: Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 14, 2014 at 11:04:58PM +0200, Belisko Marek wrote:
> during 3.15 release was removed by commit
> 985bfd54c826c0ba873ca0adfd5589263e0c6ee2 code which was added by
> 9574f36fb801035f6ab0fbb1b53ce2c12c17d100 by Neil Brown. We're using
> DTR gpio in gta04 device. I plan to post DT binding for DTR gpio +
> documentation and find out that Neil's code was removed by Felipe.
> Greg can you please revert mentioned commit? We're using DTR gpio in
> gta04 device. Or is there other way how to proceed? Thanks.

there are *NO* users of that in tree, if you're using it, then please
add a proper DTS for your device and figure out a way of passing DTR
gpio through DT.

Keep in mind, also, that we might be switching back to 8250 driver (see
thread from Sebastian Siewior) so you might want to look into a way of
adding *generic* gpio-based DTR handling.

--=20
balbi

--J/dobhs11T7y2rNN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT7T76AAoJEIaOsuA1yqREiLgP/ik3RdwQbiZBZqukv02rGKQz
pNsQrbf9kch4rheqyWpoEpbcoRqnTPPiYB/PtvQ+2F3OGFQuf6QfDDptg9l11fN7
MIoSSS8vk9jY9Zp2PMkzc/L6dUtLPWKCvO1+HXQ3yhtzcWDtbaATbsT2bz/niA1t
2mHfEr4gzHegaMYn4stAhy0xxHIW+ID68J4xB7fu3NUVRTuAfUFbvMrn3rJDHQbf
kXBg9ZaSadRUMEPiw+7TLGQZAt2mNe7f4CWJxKRhHbE3PlfwJzQDde6kEW9C3B7I
W8mjYHPRrNgPyEJ/cYCRfvSZrzriyaOANhupF/MI6zXLVzp8wK1yO3FUXmW3z5Gq
XT/gXtDCAbkU6phvdvE1sxOvTcouLpQFEfp4Jb+xiNxGw8l+PA8+aVOmyVrQYb60
y5ZOvT2Z+f9BY1XxjRDHSfjJg1bZVa4Quwbx722c4IYJ+UevgPJEDP1WjA4cFrhw
+zfXFY2bwJAioDzXsGH3g74tqDFM49B41n7S6afiPlJNVOBGjv9BglvXV/+xtJn8
Pds9nnqeZSMG1cSDw1ZFwCS1JlceKnGg9xp4WZLr+KdccqESWz2/GUnOrrnypcWN
KFjUG8H+WGEEhGBA15abg2IGHQdNC9G27pSyw0QndxNV/q36I4LQtpW3YjpL3gRW
Chw52HfJGvVkkraD451E
=bD0J
-----END PGP SIGNATURE-----

--J/dobhs11T7y2rNN--
