From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.5-rc4
Date: Thu, 28 Jun 2012 00:32:30 -0700
Message-ID: <20120628073229.GC19842@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:38082 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932517Ab2F1Hcd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 03:32:33 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-fixes-for-v3.5-rc4

for you to fetch changes up to e90b833ee1aae64b6fca2455001323ffe29e1698:

  ARM: OMAP4470: Fix OMAP4470 boot failure (2012-06-27 08:09:59 -0700)

----------------------------------------------------------------
Here's one more regression fix that I missed earlier, and a
trivial fix to get omap4470 booting.

----------------------------------------------------------------
Jon Hunter (1):
      ARM: OMAP4470: Fix OMAP4470 boot failure

Kevin Hilman (1):
      ARM: OMAP2+: nand: fix build error when CONFIG_MTD_ONENAND_OMAP2=n

 arch/arm/mach-omap2/board-flash.c    |    5 -----
 arch/arm/mach-omap2/clock44xx_data.c |    5 ++++-
 2 files changed, 4 insertions(+), 6 deletions(-)
