From: Sebastian Reichel <sre@ring0.de>
Subject: Re: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
Date: Mon, 9 Sep 2013 15:39:17 +0200
Message-ID: <20130909133916.GA28917@earth.universe>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1378630239-10006-5-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:37586 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753263Ab3IINj0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 9 Sep 2013 09:39:26 -0400
Content-Disposition: inline
In-Reply-To: <1378630239-10006-5-git-send-email-pali.rohar@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Anton Vorontsov <anton@enomsg.org>, Russell King <linux@arm.linux.org.uk>, David Woodhouse <dwmw2@infradead.org>, Felipe Balbi <balbi@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, freemangordon@abv.bg, aaro.koskinen@iki.fi, pavel@ucw.cz


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Pali,

On Sun, Sep 08, 2013 at 10:50:39AM +0200, Pali Roh=E1r wrote:
> This patch will register bq24150a charger in RX-51 board data.
> Patch also adding platform function between isp1704 and bq2415x
> drivers for detecting charger type.
>=20
> So finally charging battery on Nokia N900 (RX-51) working
> automatically without any proprietary Nokia bits in userspace.

cool :)

> index 9c2dd10..a993ffe 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c

AFAIK platform code for omap3 based boards is supposed to be removed
in the near future [0]. Device Tree does not support the glue layer, so
probably a small rx51 specific driver is needed.

[0] https://lkml.org/lkml/2013/8/12/70

-- Sebastian

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCAAGBQJSLc+EAAoJENju1/PIO/qaucEP/A5a1YZUYAT3jxMfHKFe8nQ3
rge32Ym45yzUeJ2rNCTuc6idg8gqsJAA64nvfMjRhitwI9RyWKAW42+15BRt71ok
jhISkLF34BBvdiRDAw1TSc564DVj4a16b7K4ORAHrlAvcDNU3h74tktkU5yzOs2v
QECmHsS+DawLlb+vXH1nlr3uqevhXFMpzcjPmYNstgXBbUrRp1Vy8BQ2mAo4rPxu
zifM9OzdzUdHeqe+Kr4gDc5hj/5HcDXVtU2LoTiuKLJgQNzyQW+Qxhu77T8bC4qO
VO+2Fp9zN8PfbMXIsyavzUebYnuXPv/T3XimDeD8t5UagmKarwzpaGyK31Jqy2En
kUIiLfaWQr0BIx09SuhbhkoM/Dk8T/PtptmgY9PVyz5GI0d8luXYRvVAFZ1GTqH9
dIVCNUEYKzT/hjevtkdTwKKnNTaHHOJd1IYvCBbkSBuTf+ExCjyCXzsfJ+CwMA/f
Gd7YMYW+IAAJX5TP9at7m60beIdaizkf5lHKgkFJDili/YSwjdd5qXlafIsQ+FlM
epErx2x0/f3wBbkEZ5YsrThFiMXDcERXJ22Nru6cM0/JOfK6ImWBMlaKQXAuR/Fd
ddscLt67nrbQuXeyl9VMTiKNHNRtE7FgvK/Ig7MVosrLPKmWfWA5DyoWUkthm1jA
WedEJdnLjqhxnBDS9pF/
=LqSM
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
