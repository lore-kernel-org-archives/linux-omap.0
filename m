From: NeilBrown <neilb@suse.de>
Subject: bisected regression: arm: omap3: voltage: fix channel configuration
Date: Mon, 23 Jul 2012 21:06:35 +1000
Message-ID: <20120723210635.25e0a0d8@notabene.brown>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/3czxrZ9rdoMNJgCZpAk35Oe"; protocol="application/pgp-signature"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48166 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478Ab2GWLGZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jul 2012 07:06:25 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

--Sig_/3czxrZ9rdoMNJgCZpAk35Oe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable


My GTA04 (mobile phone using OMAP3 and TWL4030 PMIC) has difficulty rebooti=
ng
with 3.5.
The first boot (after power on) works fine.  But when I reboot it hangs just
before

  Switched to new clocking rate (Crystal/Core/MPU): 26.0/332/800 MHz

is printed.  If I remove "mpurate=3D800" from the kernel command line the
problem goes away.

If I boot into 3.5, which works, and then reboot into an older working kern=
el
it freezes too.  So the 3.5 kernel leaves the device in a state which causes
any kernel to hang.

I spent a while bisecting and narrowed it down to=20

commit f9d29f1617eb1b2f1fd41622bd1a0fc51658d2f0
Author: Tero Kristo <t-kristo@ti.com>
Date:   Mon Feb 20 12:26:06 2012 +0200

    arm: omap3: voltage: fix channel configuration


If I revert this patch then the problem goes away.  So that is the fix I'll
go with for now, but if anyone wants me to try something else to help find
out what the real problem is and to find a proper fix, I'm happy to help.

Thanks,
NeilBrown

--Sig_/3czxrZ9rdoMNJgCZpAk35Oe
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIVAwUBUA0wOznsnt1WYoG5AQI8FA//czSRSGp7S8DTysZP4fF0xcc3o5vUXmIc
4H23hKitBLMpkcpx9Gu3EGJOYjAvOvmox3lP4IYtkVHSH4+d0B267rbYDZVnW8f0
b4H/5NB/IYd7YW5KoYXaDGfxTj8DevXunrCvLJSeINkoO/L2ahCXBNSnw6qCrf3+
dk9VWXwCDswd9O2YXA6Y+hXZW1/DTOcZSpv8tMB5+/dHXxaOfLiHZx1uddVA5vD/
8Ij5vsRw4NfFRdi+wATaNWt0/z0NZqqf9qgGpTRrldnXyd5fMXb23pi85xJAsvza
Pe2JZFMEIbvRWKQCt8g5UnJoO5NSZ5JOWrcLuQxtDt+6r7fbzbBcRDyukEmMoV8G
j0slBYB7k9Wpj86N6PacAGWoNqaTO/1QSgZv8IvhD6mRF/g6TWF/46xM2Kzn3VOq
jUwajimpM8ASMs8VqVDTkyF16+dMi7Gu7W6yRDGCeLCs5Ccr11wQzMlAG5zK1Eao
pjGSWmAt1VuBDoc5l18UrNOux+b7t27VqkcY65wsyTUfqxPLJ5h0FimDbSlb1pmV
NdKJeHsQuzTXjMPFErtHYRoMUGKYzm9A08PchuZL6DaNCXLfxn3/7OIBxG1LlBfm
FFh3oWswvYEw7D3c8gBRV2K2l34Z8rZ3gttNynvw4F8GBlL3XFOWpp1gxx/t4X1n
or+sqNDxmNA=
=cAi1
-----END PGP SIGNATURE-----

--Sig_/3czxrZ9rdoMNJgCZpAk35Oe--
