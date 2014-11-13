From: Paul Walmsley <paul@pwsan.com>
Subject: [GIT PULL] ARM: OMAP2+: some clock/hwmod patches for v3.19
Date: Thu, 13 Nov 2014 22:50:52 +0000 (UTC)
Message-ID: <alpine.DEB.2.02.1411132249550.17030@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:36165 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933065AbaKMWux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Nov 2014 17:50:53 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/for-v3.19/omap-a

for you to fetch changes up to 79005fbd3e1d671d08c45c9140ee9826efdc367c:

  ARM: OMAP2+: hwmod: drop unnecessary list initialization (2014-11-13 09:36:55 -0700)

- ----------------------------------------------------------------
Some OMAP clock/hwmod patches for v3.19.

Most of the patches are clock-related.  The DPLL implementation is
changed to better align to the common clock framework.
There is also a patch that removes a few lines from the hwmod code -
this patch should have no functional effect.

Basic build, boot, and PM test logs for these patches can be found here:

http://www.pwsan.com/omap/testlogs/omap-a-for-v3.19/20141113094101/

- ----------------------------------------------------------------
Felipe Balbi (1):
      ARM: OMAP2+: hwmod: drop unnecessary list initialization

Tero Kristo (5):
      ARM: OMAP3: clock: use clk_features flags for omap3 DPLL4 checks
      ARM: OMAP3: clock: add new rate changing logic support for noncore DPLLs
      ARM: OMAP4: clock: add support for determine_rate for omap4 regm4xen DPLL
      ARM: OMAP3: clock: add support for dpll4_set_rate_and_parent
      ARM: OMAP3+: DPLL: use determine_rate() and set_rate_and_parent()

 arch/arm/mach-omap2/cclock3xxx_data.c |   6 ++
 arch/arm/mach-omap2/clock.c           |   4 +
 arch/arm/mach-omap2/clock.h           |   1 +
 arch/arm/mach-omap2/clock3xxx.c       |  38 +++++++-
 arch/arm/mach-omap2/dpll3xxx.c        | 179 ++++++++++++++++++++++------------
 arch/arm/mach-omap2/dpll44xx.c        |  41 ++++++++
 arch/arm/mach-omap2/omap_hwmod.c      |   2 -
 drivers/clk/ti/dpll.c                 |  15 +++
 include/linux/clk/ti.h                |  15 +++
 9 files changed, 238 insertions(+), 63 deletions(-)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZTVVAAoJEMePsQ0LvSpL2pYP/ikYjpFzR0WpR/JHRwmCIe5X
AgagOfimnSTqDKcLhnBgsVPfwxHHW+Uy6ubFGLOKGyKmVooQnfKL9nn6YXRfRi65
XuPmHLu9xdHwLsgBtiX2KSzLCmh6wqOqTDtYedwj8B0U8BsNpYVs01YchtJ4uR4p
XpExYB6X6KvIl2PM14KoH35af6ZMkfnDXrLDtgBQ9KKea7e8U3SsZaTvnAZwu9W/
GxSijMsStWC03oa+1Q4hpwJXYIuPbRolhDwwIu2NslO018J5zmShNZQ5HpzKZ6Fh
+Hh2aVE7z1BWTF+6KUVmmdBTNXpvnaKhktoGiZHLYB+r8HpFX2XG+Qd1F21UaKut
TxaKSCdUDUxz/tDjE1wKDc0L4qYPC4eK9vgznOMudRMRSWV74dQQWyYIcXB/Wgk+
zQtSeBWxZN9c+xU+92gjb9HvSA8WKXeuW0RugbKTykySXSSPNi2emf3tzDoULNHL
NZwYEKB197hk5ZvDmitN2t05R2EbUaC6eCTGxXFOkmYbbYaUFgvLsPzE8M+osKAb
1NcZC7eOH+9dF7afcn/C/b4a4B8D8A2PLl/QQ7P6sX/6++s3ec9aRAkVK+pp1zrW
Dp+7J/T3zXqERjebT2vs3gQr0aaaT5N7HpScNkCAJaO+xiTirGHj6+YvVPqjD5kx
sUlvR5n7z6SKRWMcuxIS
=FxGb
-----END PGP SIGNATURE-----
