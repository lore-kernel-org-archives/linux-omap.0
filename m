From: Tony Lindgren <ton@atomide.com>
Subject: [GIT PULL 1/6] omap cleanup fixes for v3.8 merge window
Date: Mon, 12 Nov 2012 16:59:04 -0800
Message-ID: <6047.89056019417$1352768363@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:42542 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752655Ab2KMA7K (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Nov 2012 19:59:10 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit edf8dde393f879fc2d8c22d4bc01ff8d37b80e1a:

  Merge branch 'linus' into omap-for-v3.8/cleanup-headers-prepare-multiplatform-v3 (2012-11-09 14:58:01 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.8/cleanup-fixes-signed

for you to fetch changes up to e05cf58d50e3ce3601ebf753728eee0df759e38f:

  ARM: OMAP2+: remove duplicated include from board-overo.c (2012-11-12 14:02:48 -0800)

----------------------------------------------------------------
Minor fixes to the clean-up done for ARM common multi-platform
support for omaps.

----------------------------------------------------------------
Benoit Cousson (1):
      ARM: OMAP: debug-leds: Use resource_size instead of hard coded macro

Wei Yongjun (1):
      ARM: OMAP2+: remove duplicated include from board-overo.c

 arch/arm/mach-omap2/board-overo.c | 1 -
 arch/arm/plat-omap/debug-leds.c   | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)
