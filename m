From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] two trivial omap build error fixes for v3.8 merge window
Date: Wed, 19 Dec 2012 09:18:28 -0800
Message-ID: <20121219171828.GP4989@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:13806 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755667Ab2LSRSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 12:18:33 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Here's few more trivial build fixes caused by the merge
conflicts.

Tony


The following changes since commit 5031a2a7c12b837a0913c4139ebeb6bbff5e1aa5:

  Merge tag 'for-v3.8-part2' of git://git.infradead.org/battery-2.6 (2012-12-19 08:14:08 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/fixes-for-merge-window-part2-signed

for you to fetch changes up to a702e279da5154d09a894bf9eac594845da3f390:

  ARM: OMAP: Fix build breakage due to missing include in i2c.c (2012-12-19 08:37:30 -0800)

----------------------------------------------------------------
Looks like few more trivial merge errors caused by the
multiplatform related header clean-up popped up.

----------------------------------------------------------------
Peter Ujfalusi (1):
      ARM: OMAP2+: Fix compillation error in mach-omap2/timer.c

Vaibhav Bedia (1):
      ARM: OMAP: Fix build breakage due to missing include in i2c.c

 arch/arm/mach-omap2/i2c.c   | 1 +
 arch/arm/mach-omap2/timer.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
