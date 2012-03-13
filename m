From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] one kernel panic fix for v3.3-rc7
Date: Tue, 13 Mar 2012 11:33:52 -0700
Message-ID: <20120313183352.GN12083@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:15793 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753941Ab2CMSd4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Mar 2012 14:33:56 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Olof,

Here's one more kernel panic fix that I dropped from last weeks
fixes as it was still being discussed.

This is a fix for the regression caused by fixing an earlier
regression for smsc911x fixed regulators :(

Turns out that we have more than one smsc911x on some boards,
and the earlier fix causes a kernel panic for board trying to
register second smsc911x instance, even if the second smsc911x
is on an add-on board that is not connected.

Note that the boards with second smsc911x will also need to be
patched later on to provide their own regulators.

Regards,

Tony


The following changes since commit fde7d9049e55ab85a390be7f415d74c9f62dd0f9:
  Linus Torvalds (1):
        Linux 3.3-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fix-smsc911x-regulator

Kevin Hilman (1):
      ARM: OMAP2+: gpmc-smsc911x: only register regulator for first instance

 arch/arm/mach-omap2/gpmc-smsc911x.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)
