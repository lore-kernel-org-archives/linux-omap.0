From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCHv7 1/2] drivers: spi: Add qspi flash controller
Date: Wed, 31 Jul 2013 12:48:57 +0300
Message-ID: <20130731094857.GA15583@radagast>
References: <1375249673-2585-1-git-send-email-sourav.poddar@ti.com>
 <1375249673-2585-2-git-send-email-sourav.poddar@ti.com>
 <20130731074952.GA14517@radagast>
 <51F8D49B.2090307@ti.com>
 <20130731092008.GC14517@radagast>
 <51F8DB98.70709@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45123 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751559Ab3GaJtS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 31 Jul 2013 05:49:18 -0400
Content-Disposition: inline
In-Reply-To: <51F8DB98.70709@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sourav Poddar <sourav.poddar@ti.com>
Cc: balbi@ti.com, broonie@kernel.org, spi-devel-general@lists.sourceforge.net, grant.likely@linaro.org, linux-omap@vger.kernel.org, rnayak@ti.com

--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 31, 2013 at 03:10:40PM +0530, Sourav Poddar wrote:
> >>words can be of any length (1, 2 or 4) bytes. So, I think it should be
> >>decremented by 1 only.
> >this is wrong.
> >
> hmm..got the point.
> I will pass the count address also to ti_qspi_read_data/write_data and ma=
ke
> use of the switch statement to decrement the count.

why don't you return the amount of bytes to decrement in case of
success ?

--=20
balbi

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJR+N2JAAoJEIaOsuA1yqREj2cP/2T4im5JhBXuEj2vaEFR4cEV
HhbELEcUkThmbwOMLqNnIho5IJijRlSf1vp/HwRECmjEvgzUL8frM5YsvmN4/2tb
akQAHEzIxQE2zTtMbxTR1NzfBfd7K9ViDpnN0MhO3h8huF/AEzy1CejfkxW+/wcR
46yKXYiqjcJ838gZpl6B23UaCUXYCVu7YWd5GuJkOF+suG1YyO1MIXHHOaRyly6q
pojdU+WfEJRlzKV8c+FP1lOg+/ea0psNLFpLGJPUUsjMtBWFjjD05817AqkmxfOl
D1tIWzkCbT4p7lsFvaqe8btVSbssIj78FKV80lAvtwPx52hHkKIXAp/uPk7u7Tmi
YFnBzJdKUDltULU9su5fd5ST0b8s4pBx1uPQLDkgmkT+kYEI082BW8AK4nXUZFD3
vbKAGSFLSQwb0NXjFAc4c5uyh6fCH8f/MywGFUeidt5UwngXXw8CWfTgQQaCe3sC
VteU1hvN/9eZbgijPIAetXfSUCSWYK9oMGvyJc4GkWd1V/JCqbHAaUFZyMxA1CFX
EeD1oZMbIbQFd/o7r9HwhWr93lFuA43pMH+pMA1qLldyvTCmUQqO4k2zCB7HfsHf
jV/2v8MROtMPOfneNBx4C5Ijpk0PmvC3TvXIwTryqNZrYgj3o5AVzY183XN8hFHw
hON1/C7erQKV8iuf7Icj
=Fmo7
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
