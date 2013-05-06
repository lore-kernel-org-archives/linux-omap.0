From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] Urgent omap timer fix for current merge window
Date: Mon, 6 May 2013 16:46:11 -0700
Message-ID: <20130506234610.GK28721@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:33983 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756915Ab3EFXqQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 May 2013 19:46:16 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit dc2d3db8137fba0f62d7517e1bea8a47f69fcbc4:

  Merge tag 'omap-for-v3.10/timer-signed' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into next/drivers (2013-04-08 19:30:48 +0200)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-for-merge-window

for you to fetch changes up to 08a48be32ff31d38bcfec7d210c954cb62fd5cd7:

  ARM: OMAP4: change the device names in usb_bind_phy (2013-05-06 16:39:16 -0700)

----------------------------------------------------------------
An urgent fix for a timer mismerge for and a regression fix for
musb device naming change.

----------------------------------------------------------------
Kishon Vijay Abraham I (1):
      ARM: OMAP4: change the device names in usb_bind_phy

Vaibhav Hiremath (1):
      ARM: OMAP2+: Fix mismerge for timer.c between ff931c82 and da4a686a

 arch/arm/mach-omap2/board-4430sdp.c    | 2 +-
 arch/arm/mach-omap2/board-omap4panda.c | 2 +-
 arch/arm/mach-omap2/timer.c            | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)
