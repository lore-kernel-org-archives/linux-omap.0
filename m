From: Sebastian Reichel <sre@ring0.de>
Subject: OMAP3: Pinmux: DT: missing irq domain
Date: Fri, 13 Dec 2013 22:28:44 +0100
Message-ID: <20131213212843.GA25312@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ring0.de ([91.143.88.219]:60620 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751592Ab3LMV2u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 13 Dec 2013 16:28:50 -0500
Received: from comu.ring0.de (unknown [127.0.0.1])
	by smtp.ring0.de (Postfix) with ESMTP id C67E62C58F98
	for <linux-omap@vger.kernel.org>; Fri, 13 Dec 2013 22:28:48 +0100 (CET)
Received: (from spamd@localhost)
	by comu.ring0.de (8.13.8/8.13.8/Submit) id rBDLSmR0031352
	for linux-omap@vger.kernel.org; Fri, 13 Dec 2013 22:28:48 +0100
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux-OMAP <linux-omap@vger.kernel.org>


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I get the stacktrace from below two times during booting my Nokia N900 via DT.
Everything seems to work, but its annoying.

[    0.279571] irq: no irq domain found for /ocp/pinmux@48002030 !
[    0.285827] ------------[ cut here ]------------
[    0.290710] WARNING: CPU: 0 PID: 1 at drivers/of/platform.c:171 of_device_alloc+0x114/0x158()
[    0.299621] Modules linked in:
[    0.302856] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.13.0-rc2+ #477
[    0.309753] [<c00158b4>] (unwind_backtrace+0x0/0xe0) from [<c0011b24>] (show_stack+0x10/0x14)
[    0.318695] [<c0011b24>] (show_stack+0x10/0x14) from [<c051e9f8>] (dump_stack+0x68/0x84)
[    0.327178] [<c051e9f8>] (dump_stack+0x68/0x84) from [<c003db64>] (warn_slowpath_common+0x64/0x88)
[    0.336547] [<c003db64>] (warn_slowpath_common+0x64/0x88) from [<c003dba0>] (warn_slowpath_null+0x18/0x1c)
[    0.346618] [<c003dba0>] (warn_slowpath_null+0x18/0x1c) from [<c03b4254>] (of_device_alloc+0x114/0x158)
[    0.356445] [<c03b4254>] (of_device_alloc+0x114/0x158) from [<c03b42c8>] (of_platform_device_create_pdata+0x30/0x8c)
[    0.367401] [<c03b42c8>] (of_platform_device_create_pdata+0x30/0x8c) from [<c03b440c>] (of_platform_bus_create+0xe8/0x168)
[    0.378936] [<c03b440c>] (of_platform_bus_create+0xe8/0x168) from [<c03b4458>] (of_platform_bus_create+0x134/0x168)
[    0.389801] [<c03b4458>] (of_platform_bus_create+0x134/0x168) from [<c03b44e8>] (of_platform_populate+0x5c/0x8c)
[    0.400451] [<c03b44e8>] (of_platform_populate+0x5c/0x8c) from [<c075b5c0>] (pdata_quirks_init+0x2c/0x70)
[    0.410430] [<c075b5c0>] (pdata_quirks_init+0x2c/0x70) from [<c074e648>] (customize_machine+0x1c/0x40)
[    0.420166] [<c074e648>] (customize_machine+0x1c/0x40) from [<c0008920>] (do_one_initcall+0x98/0x140)
[    0.429779] [<c0008920>] (do_one_initcall+0x98/0x140) from [<c074cc64>] (kernel_init_freeable+0x16c/0x23c)
[    0.439880] [<c074cc64>] (kernel_init_freeable+0x16c/0x23c) from [<c051a520>] (kernel_init+0x8/0x100)
[    0.449523] [<c051a520>] (kernel_init+0x8/0x100) from [<c000dfb8>] (ret_from_fork+0x14/0x3c)
[    0.458374] ---[ end trace 9ca308e4d03a2990 ]---

-- Sebastian

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCAAGBQJSq3wLAAoJENju1/PIO/qahDsQAJx5KTL6KdUB0tbisFStR+tZ
lCXZu2rBA6nFe0lI95BtRYxB7KgytLcHxsKRuom//M5CRjz5+eHcqg/bhYxI61vu
poZbRx0Fw676puted5jNmu/0hMk+HD2a6AEAAGws+1KaQ0SuOi8sANUmh3OSAvit
Akq+GHkQ+Y4xsOObOvIgkboj07HFOl5OIbX1kvRSp/DHWcm9QUrStJ5tdkXuKl5B
00YPfCTViDUhz7ACk565iQxcy9eluqRAGAf/BQZ66g7O4sHti8qDhC2PI2Li/lQI
5rxEgvnGgApM0lUse0/TuhCkCOwQtOfzliC41M2WuqvMdm2sljtc6cLQH7WKN0hY
feuFqe0ci/QQvJD1W7R5CeN/h+22tdFJ4g8SZObjY/yQTkLnxVQWHAkcSzsW52re
MVGjlx0aybFXh71dEK0vdimXZRi8sYzsMWsDHFPE86n8NEJbSbDBuR6WuyXX7Ql/
8D+qBu9LYFKOkZOIiFKeeNVc3jzqTURgNzUwuKZibGppt/WDP0pVEZtnzNCge6fV
GWsBNwDaCDxQdaniaveJIFU30vh99idGwiZnKfoziKak7/eT8EUahuQRkfVqDNTa
wLPwYFgQxu/GSW8kFaqN4rlh3PD8VT6luAQvy7/Qg5vl82s9XXk95T8apKlS9ZcL
+/wSf+0aD3jL3eC2NMN9
=5nwt
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
