From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP: fix build, sparse problems in
 cleanup-headers
Date: Fri, 26 Oct 2012 20:14:32 +0000 (UTC)
Message-ID: <alpine.DEB.2.00.1210262012250.11258@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:40923 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934045Ab2JZUOd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 16:14:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony,

The following changes since commit 2da8a79f7d81853d00b6a00621aeef7545196084:

  Merge branch 'omap-for-v3.8/cleanup-headers-menelaus' into omap-for-v3.8/cleanup-headers (2012-10-25 12:21:48 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-cleanup-fixes-a-for-3.8

for you to fetch changes up to 97af08b6e10e06563309728ed2fe8fdd919c5a33:

  ARM: OMAP1: fix sparse warning added by commit 4c98dc6b8ef2f73bdbfa78186db9a76507ba9ea3 (2012-10-26 13:21:48 -0600)

- ----------------------------------------------------------------
Several fixes for build failures and sparse warnings in the
OMAP cleanup-headers branch.  Intended for 3.8 cleanup.

Basic build, boot, and PM test logs are available from here:

    http://www.pwsan.com/omap/testlogs/cleanup-headers-compile-fixes-3.8/20121026132711/

Due to underlying problems in v3.7-rc2, several tests fail.  These
failures are unrelated to these patches.

- ----------------------------------------------------------------
Paul Walmsley (3):
      ARM: OMAP2+: fix build breakage introduced by commit b7754452b3e27716347a528b47b0a1083af32520
      ARM: OMAP1: fix build breakage introduced by commit 25c7d49ed48b4843da7dea56a81ae7f620211ee0
      ARM: OMAP1: fix sparse warning added by commit 4c98dc6b8ef2f73bdbfa78186db9a76507ba9ea3

 arch/arm/mach-omap1/fpga.c   |    1 +
 arch/arm/mach-omap1/pm_bus.c |    2 ++
 drivers/mtd/onenand/omap2.c  |   36 ++++++++++++++++++++++++------------
 3 files changed, 27 insertions(+), 12 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQiu6QAAoJEMePsQ0LvSpLY3IQAJtQgiBIsGvk8FuXULl0xmt2
qftIgTpJ2r4PazBa+I2s3CZmF32vGK3vl2TE4MO+GtACRNgcZEMOuy6I3R2jg9P7
vl8Q+rZJ/v32KtWDfKGqxr1VjkUFz4qf5lPw3AqxY4nwGabeV7Ni+ys4F3BvNvSR
l2PtFY1GZZ6l52znHEDMZv2WRnlHyX5G0EFfxIfAxuTIu17d0WIQuI3/ozbwtlp3
s2wbY0akZPOF+fiMtm9hT7qVHDpqUfvnu6P/7MD41EFzqKWgW9j5qVRNDl2LzWRn
008Hd4RX6wnTGZguk7lh/v42D1SSf1ls6RJv5rPDKyaXBzexYQUWsg8OC/F9B6iN
yFMdauSDu45gvY9wJJAUy47IYnhQTHQ5PfvccnmYnymK8QjIpM5rOqGr3qkQ/zyd
hMbFOxzN1aeGcojnrgiCSCiJYIDtit9gEBoz6DnEYlKqnIuH25OlJi5/uBJ3Y809
f+Es/ajvTnZrWWA4X44UlqfW1V0WCYfDqpuzAlZVMInKrexghT34bvjMs1gu4iNr
thnZYhb386L0nD62G2yeUJpsuone2gZpbq1WQ6Mg4PDBrnIibD6BuFsToRxFTRGB
q2ZfO2Nm21gHmnVivDqs8vo/xJjEn4j6CiKI8VaZUlGg7iu7rtN0Rf7W2YfjG+h/
noV2yTKqbmtdq8PGcG2/
=A1XA
-----END PGP SIGNATURE-----
