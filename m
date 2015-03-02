From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: first set of hwmod and PRCM fixes for
 v4.0-rc
Date: Mon, 2 Mar 2015 04:03:56 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1503020402460.9987@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:42015 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106AbbCBED5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 1 Mar 2015 23:03:57 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Tony

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

http://www.pwsan.com/omap/testlogs/test_v4.0-rc1/20150222222439/

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

iQIcBAEBAgAGBQJU8+CLAAoJEMePsQ0LvSpLU3cP/3NYx5iygsZvXczKIKC2Lejr
9uYmogLZ1fP8In/GDMjTSffd2DeO9/e0tdvaDShdbMKjREzVqLFfepsEWPSgYeFx
V22Vyi3NH+EtUjQYoB0ZpyK2PuymsIYIAOJi4eR18rhbT3ajvQwOKn9U8zdRxNZ8
9msG1MzWrbWNX32wlYatKF8n9girzYy0yZ2s96mXDphQ9/WvgIOHQKZM9IU61xQ7
KKkX+lV+dXtyhl9NzBngTRuJ5U6xRfiUir8z+LEPQ6KwGwKMiKFVieN+eIX52tLN
WpIj0sTY6TlBvSzTFVXUilMLd4Rq+3MF0U80xU/lZlGW3IVXo5fMCQT7Nag7LyXj
N8NlRNvK9dR31BjjJmPqKylPZFe/wgQ2wiFXiwdCYu8PzHzKOcNGOwzN6hOe9bhY
NUoG44gX5/89F9MWWbj42n8HtOHHoXpoup7kbuhLgoUPbOfIggmseFgWMOLApWq0
nTWaUHSaS5s1GCEM8GONQsCHUnPmxEBGiLs3xwB0f1kVqzBK3LyB315NSJATNEC4
nUmVBr6AqVAH3fhPsa8LjcraIa/FVDEWTHKSVEoLjvyl0k7yoxLYatlCqX9Yssni
ydx+hkuVwRxo6KoYPkOuj63ps/dQ5i5P07iVxAGE6GGmh3PGewn+lhmdA9cqTtjV
xf2lNp2+8Xfdl1Ooc3ke
=S6Da
-----END PGP SIGNATURE-----
