From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] ARM: dts: am335x-evm: fix comments for lcd pins
Date: Fri, 9 May 2014 18:09:02 +0200
Message-ID: <20140509160902.GA14250@katana>
References: <1399648580-14487-1-git-send-email-wsa@the-dreams.de>
 <20140509155929.GJ2626@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from sauhun.de ([89.238.76.85]:50547 "EHLO pokefinder.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752279AbaEIQJN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 May 2014 12:09:13 -0400
Content-Disposition: inline
In-Reply-To: <20140509155929.GJ2626@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Darren Etheridge <detheridge@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Wolfram Sang <wsa@sang-engineering.com>, Benoit Parrot <bparrot@ti.com>, =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> The same mistake is also in my EVMSK LCD enabling patch that is floating
> around on this list at the moment.  I will fix that and resend it.
> BeagleBone Black only uses the first 16 LCD pins so the dts for that is
> correct.

Well, even in the TI-based-3.2-kernel I originally got with the custom
hardware, this mistake was present in mach-omap2/mux33xx.c. No wonder it
spread from there :)

> Thanks for finding and fixing it.

Very welcome!


--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBAgAGBQJTbP2eAAoJEBQN5MwUoCm2ypcP+gKVNvkJZdPtMsKGVULcYCi4
KWZ0FWjs6LmkC4+dT7AN9+hmsuzC5EyjGz+yBKa84KvqcoitUzLvdgAutXDpfRqk
JL0aUrX1aRB/yN7qn40wxW/5gajoCu/RorrAucLqK523YqqmIaZVnej8OYzO7NhR
c81vN88cmRyj3gydblOFHMb/+/yWZl6bvJVaLWCu/ZuAG3PCldQ5OUp5Nm+TXMRE
BGhZthl0BHp6OiInCgV6QHss/fszQsl8ha3pGgzw57acOnBN94SotWZUblUEXzw9
19P+wLzXDHoVgNeoqpTvQDIGTp0cdjWF1nnbU1RC6+1gtxetZfWAyefdmdmbvFU1
4/BVTEDDOi4yXXCgh7nBu24n/6cTsjAYyO5BcoMs1jnt6qbkFLgjUvtikhOLMqhr
ffIxA0b3H6CuQxbdmayQp5Gw0jnokfLEX4O/2lrIe86nsGsuvW4RKIOHGk8HLR8z
E90Zt0MarF6+LuOnDsNkAOiK5CdXD5YWwle69QDGWIyxq+uLrSB/n12VQZmZiedj
SAjRWoPmF3dhpRkuMKnbdOoa4KZ29x4kUgW6wRjFkgeCccJGyE3rbfABzNi7bn9/
3UXgNbKcuiEyh5Y2xehz2/GvHrk/Z9Vloyo9AYsqbfeZXDTNGkS90jqjnyPFExLh
lVlka/iaeIpL/mSmW15l
=hFzS
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
