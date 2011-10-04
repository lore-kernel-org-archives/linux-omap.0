From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] l3 cleanup for v3.2 merge window
Date: Mon, 3 Oct 2011 17:12:51 -0700
Message-ID: <20111004001251.GN6324@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:46065 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab1JDAMz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 3 Oct 2011 20:12:55 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd,

Please pull L3 interconnect error handling driver cleanup from:

git://github.com/tmlind/linux.git l3

As with dmtimer, this too eventually should go somewhere under
drivers.

Regards,

Tony


The following changes since commit a102a9ece5489e1718cd7543aa079082450ac3a2:
  Linus Torvalds (1):
        Linux 3.1-rc8

are available in the git repository at:

  git://github.com/tmlind/linux.git l3

Santosh Shilimkar (1):
      OMAP4: Fix the emif and dmm virtual mapping

Todd Poynor (2):
      OMAP: Improve register access in L3 Error handler.
      OMAP: Fix a BUG in l3 error handler.

Tony Lindgren (1):
      Merge branch 'for_3_2/omap_misc' of git://gitorious.org/omap-sw-develoment/linux-omap-dev into l3

sricharan (3):
      OMAP: Fix indentation issues in l3 error handler.
      OMAP: Fix sparse warnings in l3 error handler.
      OMAP: Print Initiator name for l3 custom error.

 arch/arm/mach-omap2/omap_l3_noc.c    |  130 ++++++++++----------
 arch/arm/mach-omap2/omap_l3_noc.h    |  224 +++++++++++++++++++---------------
 arch/arm/mach-omap2/omap_l3_smx.c    |   91 +++++++-------
 arch/arm/mach-omap2/omap_l3_smx.h    |  164 ++++++++++++------------
 arch/arm/plat-omap/include/plat/io.h |    4 +-
 5 files changed, 322 insertions(+), 291 deletions(-)
