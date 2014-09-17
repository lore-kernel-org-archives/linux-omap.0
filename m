From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap wake-up regression fix for v3.17
Date: Wed, 17 Sep 2014 07:59:06 -0700
Message-ID: <20140917145906.GA14505@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:47978 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754786AbaIQO7Z (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2014 10:59:25 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/fix-v3.17-io-chain-v3

for you to fetch changes up to 7db143b89137de06ed289cf8b302f3bbbc5baa1f:

  ARM: OMAP3: Fix I/O chain clock line assertion timed out error (2014-09-16 15:09:44 -0700)

----------------------------------------------------------------
Regression fix for early omap3 revisions for wake-up events that
too some time to narrow down. Although a bit intrusive, this would
be good to get into the -rc cycle as there are quite a few boards
out there with omap3 es2.1 and es3.0, and we have those in at least
three boot test systems too that show errors without this patch.

----------------------------------------------------------------
Tony Lindgren (1):
      ARM: OMAP3: Fix I/O chain clock line assertion timed out error

 arch/arm/mach-omap2/omap_hwmod.c |  2 +-
 arch/arm/mach-omap2/prm3xxx.c    | 39 +++++++++++++++++++++++++++++++++++----
 2 files changed, 36 insertions(+), 5 deletions(-)
