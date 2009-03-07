From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/4] Still more omap fixes for current -rc series
Date: Sat, 7 Mar 2009 07:55:31 -0800
Message-ID: <20090307155530.GA11078@atomide.com>
References: <20090304182342.27331.35004.stgit@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ikeVEW9yuYc//A+q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52921 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754709AbZCGPzf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Mar 2009 10:55:35 -0500
Content-Disposition: inline
In-Reply-To: <20090304182342.27331.35004.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Tony Lindgren <tony@atomide.com> [090304 10:31]:
> This should be it for the omap fixes for this -rc cycle. Hopefully
> we can still get these in.

Russell, here's the pull request for you for these fixes.

Tony
 

--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pull.txt"

The following changes since commit fec6c6fec3e20637bee5d276fb61dd8b49a3f9cc:
  Linus Torvalds (1):
        Linux 2.6.29-rc7

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes

Aaro Koskinen (2):
      ARM: OMAP: sched_clock() corrected
      ARM: OMAP: Allow I2C bus driver to be compiled as a module

David Brownell (1):
      ARM: OMAP: Fix compile error if pm.h is included

Koen Kooi (1):
      ARM: OMAP: board-omap3beagle: set i2c-3 to 100kHz

 arch/arm/mach-omap2/board-omap3beagle.c  |    4 +++-
 arch/arm/plat-omap/Makefile              |    3 ++-
 arch/arm/plat-omap/common.c              |   14 +++++---------
 arch/arm/plat-omap/include/mach/common.h |    2 +-
 arch/arm/plat-omap/include/mach/pm.h     |    2 +-
 5 files changed, 12 insertions(+), 13 deletions(-)

--ikeVEW9yuYc//A+q--
