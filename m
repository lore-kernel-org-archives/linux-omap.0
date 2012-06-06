From: Sebastian Reichel <sre@ring0.de>
Subject: Re: New randconfig build failures in OMAP
Date: Wed, 6 Jun 2012 03:25:33 +0200
Message-ID: <20120606012533.GA13213@earth.universe>
References: <20120605220214.GA29782@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:40348 "EHLO ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751845Ab2FFBs7 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Jun 2012 21:48:59 -0400
Content-Disposition: inline
In-Reply-To: <20120605220214.GA29782@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2012 at 11:02:14PM +0100, Russell King - ARM Linux wrote:
> arch/arm/mach-omap2/board-rx51-peripherals.c:147: error: implicit declara=
tion of function 'OMAP_GPIO_IRQ'
> arch/arm/mach-omap2/board-rx51-peripherals.c:147: error: initializer elem=
ent is not constant
> arch/arm/mach-omap2/board-rx51-peripherals.c:147: error: (near initializa=
tion for 'rx51_lis3lv02d_data.irq2')
> arch/arm/mach-omap2/board-rx51-peripherals.c:1033: error: initializer ele=
ment is not constant
> arch/arm/mach-omap2/board-rx51-peripherals.c:1033: error: (near initializ=
ation for 'rx51_peripherals_i2c_board_info_3[0].irq')
>=20
> Again, a missing include?

patch: http://www.spinics.net/lists/linux-omap/msg71169.html

-- Sebastian

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPzrGNAAoJENju1/PIO/qa2uQP/jLPnq+f/2JBFnH7OfxcWVnN
eOjhYhKU025Cs4gg27Xqh7XMFzQ+hZd+sdQ89iz/vDou81tjii2Eh3UI0jB3HyVV
rJ90MuhLQJLwEpi1Wd0Ipi3WLJHVLi0M6ZWfMtVlzKpQyuIBlpHou+rytX5v+E57
BB0FVtSExvz+Lest7ZlgUUkEIVP9oiAA/Hr8AqsnDJOQ++H+how2+u+8VFNqjy9r
35XDkq6AMFFfs9cpLjCHFvKLhmwrdStX7RSz4a9NB/8blCjnn/dhNjOay53NfR3v
1yxJb35k8Y1b92qIu/ZrUSjIDUaVUkV+GHeTk1etGcWXNp8/kBLd8NYn7lZsKPC3
rrzxAKR6DQ0paH4GPtgcgvuQDCtMlM3tWDyfrJXmAo+BBFjgmKaXzVI3EoZ5goL8
izBeKVrK/UshdDdRXP+aFuMszZgyIdfkRIzd5cC3f3UvO+ctWPwmwJKSyX8xLNMo
q4/we7XX+KJfwtBOxUPG1eHMAcmb6FzEVZXkDjY41GrQoto0jbb3MgERAzGfSZRh
nmYELW17e7t4vqBZyh1DM6FgVJqMzd/BHiLMhQeh+BirqxDWewpUq/Sh7ppbvcK8
0Q/mlU21uJBsG/pYsmnlDIYDMRZtBO0SM9/U0LMwuYt8uVnwiUzBZ/Py4vMoMMXd
IxOYVnYeDrcO/8eRifkj
=TRlD
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
