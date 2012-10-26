From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/3] omap plat header removal for v3.8 merge window, part2
Date: Fri, 26 Oct 2012 14:23:39 -0700
Message-ID: <143.269150476222$1351286637@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:29450 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965612Ab2JZVXo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 26 Oct 2012 17:23:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 3e9a6321f9895eac9a3d241d3126e44021e7102b:

  Merge tag 'omap-for-v3.8/cleanup-headers-signed' into omap-for-v3.8/cleanup-headers-serial-take2 (2012-10-24 13:25:44 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-headers-serial-take2-signed

for you to fetch changes up to 3d82cbbb3aadb4f8a30e3f614e51be96574a0855:

  ARM: OMAP: Split plat/serial.h for omap1 and omap2+ (2012-10-24 13:34:31 -0700)

----------------------------------------------------------------
These changes remove plat/serial.h usage for omap2+.

Note that this branch is based on a tty commit 3e9a6321
(tty/serial/8250: Make omap hardware workarounds local to 8250.h)
merged with omap-for-v3.8/cleanup-headers-signed.

The tty commit is needed to keep things compiling for omaps,
and omap-for-v3.8/cleanup-headers-signed is needed to avoid
multiple merge conflicts with the includes. I've verified
with Greg KH that the tty commit above is immutable and OK
to use as a base.

----------------------------------------------------------------
Tony Lindgren (2):
      ARM: OMAP: Split uncompress.h to mach-omap1 and mach-omap2
      ARM: OMAP: Split plat/serial.h for omap1 and omap2+

 arch/arm/mach-omap1/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-omap1/include/mach/hardware.h        |    2 +-
 arch/arm/mach-omap1/include/mach/serial.h          |   53 +++++
 arch/arm/mach-omap1/include/mach/uncompress.h      |  121 +++++++++++-
 arch/arm/mach-omap2/board-rm680.c                  |    1 -
 arch/arm/mach-omap2/common.h                       |    3 +-
 arch/arm/mach-omap2/include/mach/debug-macro.S     |    2 +-
 arch/arm/mach-omap2/include/mach/uncompress.h      |  175 ++++++++++++++++-
 arch/arm/mach-omap2/io.c                           |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |    1 +
 .../omap_hwmod_2xxx_3xxx_interconnect_data.c       |    2 -
 .../mach-omap2/omap_hwmod_2xxx_3xxx_ipblock_data.c |    1 -
 .../mach-omap2/omap_hwmod_2xxx_interconnect_data.c |    3 +-
 arch/arm/mach-omap2/omap_hwmod_2xxx_ipblock_data.c |    1 -
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |    3 +-
 arch/arm/mach-omap2/serial.c                       |    2 +-
 .../include/plat => mach-omap2}/serial.h           |   11 --
 arch/arm/plat-omap/include/plat/uncompress.h       |  204 --------------------
 18 files changed, 354 insertions(+), 235 deletions(-)
 create mode 100644 arch/arm/mach-omap1/include/mach/serial.h
 rename arch/arm/{plat-omap/include/plat => mach-omap2}/serial.h (91%)
 delete mode 100644 arch/arm/plat-omap/include/plat/uncompress.h
