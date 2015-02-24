From: Felipe Balbi <balbi@ti.com>
Subject: Re: am335x: USB DMA IRQ issue
Date: Tue, 24 Feb 2015 10:36:12 -0600
Message-ID: <20150224163612.GA25042@saruman.tx.rr.com>
References: <CAGm1_ktamp-L8nb7UzGvha6EkEfAnDtv3unPE1th9RjK7RkG1g@mail.gmail.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60154 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752339AbbBXQge (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 24 Feb 2015 11:36:34 -0500
Content-Disposition: inline
In-Reply-To: <CAGm1_ktamp-L8nb7UzGvha6EkEfAnDtv3unPE1th9RjK7RkG1g@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 05, 2015 at 12:19:23PM +0100, Yegor Yefremov wrote:
> I have a problem with my am335x based board and USB.
>=20
> Kernel: Linux version 3.18.1 (YegorYefremov@development1) (gcc version
> 4.9.2 (Buildroot 2015.02-git-00797-gf1b07c0) ) #1 SMP Thu Jan 15
> 15:31:27 CET 2015
>=20
> I took two devices and equipped them with USB WLAN cards: Bus 001
> Device 003: ID 148f:5370 Ralink Technology, Corp. RT5370 Wireless
> Adapter. One device as AP and another as client. Client makes
> permanent ping to AP. And from time to time I start nuttcp session.
> After 2-3 days I get following errors:

2-3 days ? oh man... :-)

Here's one thing to try. Can you do some variable size pingtest ?
Something like below should do ?

random()
{
	size=3D$(dd if=3D/dev/urandom count=3D1 2>/dev/null|cksum|
	cut -f1 -d" "|tr '-' '\0')
	size=3D$(expr $size % 60000)
}

num=3D$1

if [ -z $num ]
then
	num=3D10000
fi

while ! ifconfig usb0 >/dev/null 2>&1; do
	printf "waiting for usb0\n"
	sleep 1;
done

ifconfig usb0 192.168.2.14

for i in $(seq 1 $num); do
	random
	printf "%d: \t pinging with size %-27d" $i $size
	if ! ping -c 6 192.168.2.15 -s $size -q -i 0 >/dev/null 2>&1; then
		printf "FAILED\n"
		break
	fi
	printf "PASSED\n"
done

cheers

--=20
balbi

--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU7Kh8AAoJEIaOsuA1yqREAK4P/0w5Fn6UbcNjQUL5jHCjbTsc
yYdUoxY6+OjXR8pyO964uvPj/x1dhjILvi8SSSz3AaVcrroCOx4DQIQNusr2dqQ/
MLdgkKHCVhTNLSh9moQk0EbgdoePS9a24H1zVpc+ZHmAE/zJBD3eA5hYWo9c42ZT
lOzrKU6wCMrRg3CYQOihOm4SDkpi2bRQJ8wPLFrImf5rBxQiUvgRaINhhU9oraga
3EmTDanmoM063AeteC898bUCZgEudGToxP0Kje7yNnuO3qHR0C23fj8OzHv1AVBf
0WJLwe8O0sMvnlcj0dHdqyXxXur1oLUInzsC+IAABgTavZNVwFNobYuFnT87Gw4h
YLO19exZj5stkiioVPi42MM0IXsTlD8eDsxsZG+f+k7jO+Zw4zDDia12Tkm9xpoP
eJ8Zulam0eUFzjUDuQrZUJtinnPceI+h5ofGsHJ/kmTiAFqX4aRIlrO/KjACUx1g
zvYypkxE19wD37122/PdzWuA9CCCgOB0ImZv2lwktyI9BD393ZGKVM8BRZLLiPwR
8eFhiTou4PVpfMMaEROQ/46I2fS5tdOBrZ3SjzU+fJ0w/8s3YOyem/+frOWgJa2f
DDQXYXg0oVNu8cxKrsqjwQITdF2CWmWPOCsc9333aDvc9oSocYUkuq1sUQfu8w6R
tp1iMIGQ6mZ/MLvVrna+
=Bh2+
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
