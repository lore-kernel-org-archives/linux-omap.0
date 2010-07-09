From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
Subject: Re: [PM-SR][PATCH 1/2 v2] omap3: sr: fix memory leak and simplify
 the code
Date: Fri, 09 Jul 2010 18:36:37 +0300
Message-ID: <1278689797.9953.136.camel@localhost>
References: <[PATCH 1/2] omap3: sr: fix memory leak and simplify the code>
	 <1278687874-26123-1-git-send-email-nm@ti.com>
Reply-To: Artem.Bityutskiy@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:65330 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab0GIPk4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Jul 2010 11:40:56 -0400
In-Reply-To: <1278687874-26123-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@deeprootsystems.com>, Thara Gopinath <thara@ti.com>, "De-Schrijver Peter (Nokia-MS/Helsinki)" <Peter.De-Schrijver@nokia.com>

On Fri, 2010-07-09 at 17:04 +0200, ext Nishanth Menon wrote:
> From: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
>=20
> This patch fixes the following problem indicated by kmemleak:
>=20
> kmemleak: unreferenced object 0xdf93c280 (size 64):
> kmemleak:   backtrace:
> kmemleak:     [<c00df6d4>] create_object+0x104/0x200
> kmemleak:     [<c00d7638>] kmem_cache_alloc+0xe4/0xf4
> kmemleak:     [<c000fc38>] omap_devinit_smartreflex+0x44/0x244
> kmemleak:     [<c003a33c>] do_one_initcall+0x5c/0x1b8
> kmemleak:     [<c00083fc>] kernel_init+0x94/0x110
> kmemleak:     [<c003ba04>] kernel_thread_exit+0x0/0x8
>=20
> The reason is that 'omap_devinit_smartreflex()' allocates 'sr_data',
> then passes it to 'omap_device_build()', which 'kmemdup()'s it and
> uses the copy. But 'omap_devinit_smartreflex()' never frees 'sr_data'=
=2E
>=20
> This patch make 'sr_data' to be a stack variable, which eliminates
> the memory leak and simplifies the code a bit.
>=20
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Thara Gopinath <thara@ti.com>,
> Cc: Peter p2 De Schrijver <peter.de-schrijver@nokia.com>
> Cc: Nishanth Menon <nm@ti.com>
>=20
> Signed-off-by: Artem Bityutskiy <Artem.Bityutskiy@nokia.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> ---
> Changes from V1:
> 	rebased to latest pm-sr branch
> 	default of sr_data set to 0 to make it equivalent to kzalloc

Oh, right. Thanks for fixing!

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
