From: Tony Lindgren <tony@atomide.com>
Subject: git pull request for omap-fixes (Re: [PATCH 0/4] omap fixes for
	-rc series)
Date: Thu, 6 Nov 2008 09:29:58 -0800
Message-ID: <20081106172957.GW21736@atomide.com>
References: <1225419078-32213-1-git-send-email-tony@atomide.com> <20081106142824.GA28704@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56040 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbYKFRaM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Nov 2008 12:30:12 -0500
Content-Disposition: inline
In-Reply-To: <20081106142824.GA28704@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [081106 06:29]:
> On Thu, Oct 30, 2008 at 07:11:14PM -0700, Tony Lindgren wrote:
> > Here are few omap fixes for the current -rc series.
> 
> These all look fine.

The following changes since commit 45beca08dd8b6d6a65c5ffd730af2eac7a2c7a03:
  Linus Torvalds (1):
        Linux v2.6.28-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Sanjeev Premi (1):
      ARM: OMAP: Fix compiler warnings in gpmc.c

Tony Lindgren (2):
      ARM: OMAP: Fix get_irqnr_and_base to clear spurious interrupt bits
      ARM: OMAP: Fix define for twl4030 irqs

Zhaolei (1):
      ARM: OMAP: Fix debugfs_create_*'s error checking method for arm/plat-omap

 arch/arm/mach-omap2/gpmc.c                    |    6 ++----
 arch/arm/plat-omap/clock.c                    |   20 ++++++++++----------
 arch/arm/plat-omap/include/mach/entry-macro.S |    4 +++-
 arch/arm/plat-omap/include/mach/irqs.h        |    2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)
