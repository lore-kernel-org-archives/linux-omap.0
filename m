From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 5/6] omap board changes for v3.8 merge window
Date: Tue, 13 Nov 2012 11:12:36 -0800
Message-ID: <20121113191235.GH6801@atomide.com>
References: <pull-1352828737-887235>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:22349 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750969Ab2KMTMj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 14:12:39 -0500
Content-Disposition: inline
In-Reply-To: <pull-1352828737-887235>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/board-v2-signed

for you to fetch changes up to 0449410b0b8aeafa9b7e8bb719e4eeda8a5623fd:

  ARM: OMAP1: use BUG_ON where possible (2012-11-12 15:20:44 -0800)

----------------------------------------------------------------
Board updates for omaps mostly to deal with enabling
display support with device tree until the bindings
are ready.

----------------------------------------------------------------
Pavel Machek (1):
      ARM: OMAP2+: Nokia N9/N900/N950 -- mention product names

Sasha Levin (1):
      ARM: OMAP1: use BUG_ON where possible

Tomi Valkeinen (3):
      OMAP: panda: move display init from board file to dss-common.c
      OMAP: omap4sdp: move display init from board file to dss-common.c
      OMAP: board-generic: enable DSS for panda & sdp boards

 arch/arm/mach-omap1/board-fsample.c    |   3 +-
 arch/arm/mach-omap1/board-h2.c         |   3 +-
 arch/arm/mach-omap1/board-h3.c         |   3 +-
 arch/arm/mach-omap1/board-perseus2.c   |   3 +-
 arch/arm/mach-omap2/Kconfig            |   4 +-
 arch/arm/mach-omap2/Makefile           |   2 +-
 arch/arm/mach-omap2/board-4430sdp.c    | 157 +------------------
 arch/arm/mach-omap2/board-generic.c    |  10 ++
 arch/arm/mach-omap2/board-omap4panda.c |  68 +-------
 arch/arm/mach-omap2/board-rm680.c      |   2 +-
 arch/arm/mach-omap2/board-rx51.c       |   2 +-
 arch/arm/mach-omap2/dss-common.c       | 276 +++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/dss-common.h       |  14 ++
 13 files changed, 311 insertions(+), 236 deletions(-)
 create mode 100644 arch/arm/mach-omap2/dss-common.c
 create mode 100644 arch/arm/mach-omap2/dss-common.h
