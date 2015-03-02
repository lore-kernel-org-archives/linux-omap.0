From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL v2] ARM: OMAP2+: first set of hwmod and PRCM fixes for
 v4.0-rc
Date: Mon, 2 Mar 2015 04:13:51 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503020413320.9987@utopia.booyaka.com>
References: <alpine.DEB.2.02.1503020402460.9987@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42074 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbbCBENw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Mar 2015 23:13:52 -0500
In-Reply-To: <alpine.DEB.2.02.1503020402460.9987@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v4.0-rc/omap-fixes-a

for you to fetch changes up to 50f59d07e9822274a2e6034777eb4e90cfb30cfc:

  ARM: OMAP4+: PRM: fix omap4 version of prm_save_and_clear_irqen (2015-03-01 16:58:25 -0700)

- ----------------------------------------------------------------
ARM: OMAP2+: first set of hwmod and PRCM fixes for v4.0-rc

This series fixes the following bugs:

- - a lockdep problem with the OMAP hwmod code;
- - incorrect PCIe hwmod data for the DRA7xx chips;
- - the clockdomain handling in the hardreset deassertion code,
  preventing idle;
- - the use of an IRQ status register rather than an IRQ enable register
  in the OMAP4 PRM code.

Basic build, boot, and PM test results are available here:

http://www.pwsan.com/omap/testlogs/omap-hwmod-a-for-v4.0-rc/20150301165949/

- ----------------------------------------------------------------
Kishon Vijay Abraham I (1):
      ARM: DRA7: hwmod_data: Fix hwmod data for pcie

Peter Ujfalusi (1):
      ARM: omap2+: omap_hwmod: Set unique lock_class_key per hwmod

Tero Kristo (2):
      ARM: OMAP2+: hwmod: fix deassert hardreset clkdm usecounting
      ARM: OMAP4+: PRM: fix omap4 version of prm_save_and_clear_irqen

 arch/arm/mach-omap2/omap_hwmod.c          |  10 +--
 arch/arm/mach-omap2/omap_hwmod.h          |   1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c | 103 +++++++-----------------------
 arch/arm/mach-omap2/prm44xx.c             |   4 +-
 4 files changed, 32 insertions(+), 86 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU8+NdAAoJEMePsQ0LvSpLWAsQAIFPj9Ha4r8T78q1s/Q57HZI
uygJxhWN2j1//z4F17Ya+Ig1MAJryBILDUitvC4IhkeWgKS5Y3TNLfYmnYiSxuJT
pzpgnmnuF7AY2tUtQkxuxbg2JDjNFB4EAWolbEDRYlYl5dzCy+UP4uJfXl5UBRRO
D461ZhgBzTuLcQADePMDld2o62BDZ4GQT9ItGmcnlN+oujasLbRR68EAoLLHpo1i
sGYVlMSzduaZe+dN1SNty4QKJoI1BI9PTQ5jVCpHZGuJ0JkS94Y7ir34yDQ6Er5G
bjan1Qv5oA2v6TmwxNAD5gcH/D+TIsemlp5uF4PANJdwLyDMNsVxI6FLxonfaCTD
+f5rn0u8C+xAiX8X71XonYBWvglfn5csXuPD8O8RgoohnuXNF2y957sHANp6PwWT
KLd9YCKpNzQJsy/TswlbNrOHUrkMXbO9fbA/XAsYgH7wXPmDr+55EhB5jSJZwhmU
A0Ab4BMJqPQQwQIgzWn4Mz6ZVaDgxBRD9DIiOl+41ZiOYFS/URC0Mnx1ofMjvY5H
pBakVSQc9IF2OmGWRjO2eEygzL2EpHGwUEaIjIWg8oy7fkZ4eZfKZ2yRfW/kshp9
McYUngoNtYInVLULIsQ148HCWel7jpSCJO/kLq9L7cMcW/e6GjddbRyMEiAP19CF
j1ePWtyWAWZrtwMbyOai
=92Qe
-----END PGP SIGNATURE-----
