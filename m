From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3] mtd: omap: nand: Remove 0xFF's that prefixed 16bit
 NAND addresses
Date: Thu, 15 Nov 2012 13:02:09 +0200
Message-ID: <1352977329.2221.29.camel@sauron.fi.intel.com>
References: <20121029195127.GA32749@harvey-pc.matrox.com>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-h8zVQEMx5zNq4aKC1g1l"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:63908 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2993281Ab2KOLBc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Nov 2012 06:01:32 -0500
In-Reply-To: <20121029195127.GA32749@harvey-pc.matrox.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Christopher Harvey <charvey@matrox.com>
Cc: linux-mtd@lists.infradead.org, Ivan Djelic <ivan.djelic@parrot.com>, linux-omap@vger.kernel.org


--=-h8zVQEMx5zNq4aKC1g1l
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-10-29 at 15:51 -0400, Christopher Harvey wrote:
> In 16bit NAND mode the GPMC would send the address 0xNN as 0xFFNN
> instead of 0x00NN on the bus. The 0xFFs were actually uninitialized
> bits that were left unset in the GPMC command output register. The
> reason they weren't initialized in 16bit mode is that if the same code
> that writes to this register was used in 8bit mode then 2 commands
> would be output in 8bit mode. One for the low byte, and an extra 0x0
> command for the high byte. This commit uses writew if we're using
> 16bit NAND. This commit also changes the high byte in the command
> output register, but they are ignored by NAND chips anyway.
>=20
> Most chips seem fine with the extra 0xFFs, but the ONFI spec says
> otherwise.
>=20
> Signed-off-by: Christopher Harvey <charvey@matrox.com>

Pushed to l2-mtd.git, thanks!

--=20
Best Regards,
Artem Bityutskiy

--=-h8zVQEMx5zNq4aKC1g1l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAABAgAGBQJQpMuyAAoJECmIfjd9wqK0Sd4QAJYOr/HBKvLNguC5XizN95PS
vNKgIPl80fREXhc2PDOChYoHa4APL8N6VcrY3Yt9Vgw4PAtDB0Lv7sFCiA373UHo
a0UCMqOB5cwlZo3ntPcucKREELgF/48IcCKkJXMl/oiuRGpscG99U9rGGLX/3PHC
7NbqbL+clt7F3KM6dHhiGgQYADwQ+oR5p2uBMrP92ZpJCg2bWpRGVQ022+9tvcSo
d4z8bdbIWtNscS7GQnCnX6E5WTuwwaCHfL5jN7pxT7SYMp9jRapRnmyVeCzy4MS3
5YNJT4kNVg49EMHn3YupKKt5bdAH36ZpsDFZPVF5lqI1hYTyFaXBdnxfyNSCirar
as7yNHzxDM1bXeKE9KjjIK0STghe8UhaTDvYzM5zgA6NHIhWPg9MyPRlyScG3kTZ
BjBSh+oh/AfMdZH6M9mlfH4stPUqjmKauIk3YGOIupUh1AbjYeI6ACciP5kuEaGv
6790Io4jcN9vRRQdDAKUNxC+bFIyL9hW1up35xv7KIHQzhqdy4i29sM4G5pXe1Qb
28YWXkfA48mjQAuQQBCIt8WE5qjTE179cjzsrZFRxqwW5j3zmup/Y9J7EtqjM2UQ
kUHtVxtQCYCEDsXWBLhDiFxICmfKdQmxE2O+DkkRVBRyhuhwuH/T7m3uT0EgXw9C
EQzv9ci+FHud4W608PNC
=gPY8
-----END PGP SIGNATURE-----

--=-h8zVQEMx5zNq4aKC1g1l--

