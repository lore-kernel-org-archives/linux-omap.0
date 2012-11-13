From: Tony Lindgren <ton@atomide.com>
Subject: [GIT PULL 1/6] omap cleanup fixes for v3.8 merge window
Date: Tue, 13 Nov 2012 09:45:36 -0800
Message-ID: <3815.92690614543$1352828760@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:57932 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751903Ab2KMRpl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Nov 2012 12:45:41 -0500
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
