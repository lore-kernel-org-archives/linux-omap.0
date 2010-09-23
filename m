From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] runtime PM core for OMAP for 2.6.37
Date: Thu, 23 Sep 2010 11:30:40 -0700
Message-ID: <877hicz50v.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:38181 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499Ab0IWSan (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Sep 2010 14:30:43 -0400
Received: by gwj17 with SMTP id 17so675484gwj.19
        for <linux-omap@vger.kernel.org>; Thu, 23 Sep 2010 11:30:42 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Tony,

Pull request below to add the runtime PM core for OMAP.

Also note that this depends on an additional driver core patch from me
that is queued by Greg KH for 2.6.37:

  driver core: platform_bus: allow runtime override of dev_pm_ops

You can find this as commit 441d87898e039c155493c12696a4d7cfd7001b49
in linux-next, or you can cherry-pick it from my pm-backports branch and
put it in omap-testing until the final merge.

Thanks,

Kevin


The following changes since commit b30a3f6257ed2105259b404d419b4964e363928c:

  Linux 2.6.36-rc5 (2010-09-20 16:56:53 -0700)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git pm-runtime

Kevin Hilman (2):
      OMAP2+: PM: initial runtime PM core support
      OMAP1: PM: add simple runtime PM layer to manage clocks

 arch/arm/mach-omap1/Makefile |    2 +-
 arch/arm/mach-omap1/pm_bus.c |   98 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/Makefile |   10 +++-
 arch/arm/mach-omap2/pm_bus.c |   85 ++++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-omap1/pm_bus.c
 create mode 100644 arch/arm/mach-omap2/pm_bus.c

