From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: warnings/hwmod/clock fixes for pre-3.7-rc1
Date: Tue, 9 Oct 2012 16:03:59 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210091602390.5736@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57774 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751702Ab2JIQEA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Oct 2012 12:04:00 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit 0e51793e162ca432fc5f04178cf82b80a92c2659:

  Merge branch 'for-linus' of git://git.linaro.org/people/rmk/linux-arm (2012-10-07 21:20:57 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-fixes-a-for-pre3.7

for you to fetch changes up to e9332b6eed82973a8f75f1f3d57babaa331d703c:

  ARM: OMAP4/AM335x: hwmod: fix disable_module regression in hardreset handling (2012-10-08 23:08:15 -0600)

- ----------------------------------------------------------------
Some OMAP fixes for the 3.7 merge window, fixing mismerges, branch
integration issues, and bugs after the arm-soc merges.

Basic test logs are available here:

   http://www.pwsan.com/omap/testlogs/devel_late_fixes_3.7/20121009084003/

N800 isn't booting; this is a problem present in the base commit and
is due to serial driver breakage:

   http://www.spinics.net/lists/arm-kernel/msg196034.html

- ----------------------------------------------------------------
Jon Hunter (2):
      ARM: OMAP2+: hwmod data: Fix PMU interrupt definitions
      ARM: OMAP3: fix workaround for EMU clockdomain

Paul Walmsley (2):
      ARM: OMAP: omap3evm: fix new sparse warning
      ARM: OMAP4/AM335x: hwmod: fix disable_module regression in hardreset handling

Vaibhav Hiremath (1):
      ARM: am33xx: clk: Update clkdev table to add mcasp alias

 arch/arm/mach-omap2/board-omap3evm.c               |    3 +-
 arch/arm/mach-omap2/clock33xx_data.c               |    2 +
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c         |   44 ++++++++++----------
 arch/arm/mach-omap2/omap_hwmod.c                   |   31 ++++++++++++--
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    2 +-
 6 files changed, 54 insertions(+), 30 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQdEqIAAoJEMePsQ0LvSpLjvYP/RlejvRetwDYUSpwjgre/xfz
BA+we3wgi/wgZ3xbdlcFKfdj2l+jzLxspr1pt6MSFzZqJJVKPj1xgHCPJZe4QFX3
waurd+p4OUcO7qKoLQo7up9nfzsI4vnxjyDXjEUCLjAaEq18qqMi4YQEdncotrZU
hOL8yFE9ol6Ds2dLtTulnxMfqbMILa5ek+NSVWizbQbVPh8opklRQwRSbYmAgCze
USY410kyP/WVXa1hern5UnyEo4nzVpXAFf4+3LVil05p/vWgB4i/JwUINAYNr1sr
L1ells+x0z9RKybTNsrDxTQmwY8Jr+TyZJ3uikccFTpqo+TfwcfZN++Qrx+/0Q5z
GCVB4dp2aH4QLas9yTFGp/3X2BiPx5AwKX9mqhnOR3peq1lBS1D9V+BTmKAHoY6n
w2XzAF3jpE2qNLnxIym46TJYRHGrc1o6U0U5dHxjQZVx796rgUHEIZEfVznWj6lS
GaU3b8YQKN3EPKbrdIQ2y5bVEf0SnLdiOjJo+tTVBGhQ7eiVMRN6btYt8Fod2Rlq
TXleGmDGKUKI43omeALn2fJWgNrm1GIPSPU1aa3TMZQN7qa/FHyAimcY5QOqU+HT
uCUmsSukw6oIfWvV8hyN/R7AovvqaKYpyPUvxOM09G/WnoRGahk3eFHpUcEGQGqD
6PQY5o1skH1C4B++o0EL
=Yvqo
-----END PGP SIGNATURE-----
