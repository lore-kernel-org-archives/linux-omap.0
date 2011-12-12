From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] Two non-critical DMA fixes for v3.3 merge window
Date: Mon, 12 Dec 2011 14:46:49 -0800
Message-ID: <20111212224648.GI32251@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52149 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184Ab1LLWqx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Dec 2011 17:46:53 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Please pull two non-critical DMA fixes from:

git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical

These are workarounds for corner cases. There's no rush
to get them in during the -rc cycle, these are fixes for
features that never worked before.

Regards,

Tony


The following changes since commit 5611cc4572e889b62a7b4c72a413536bf6a9c416:
  Linus Torvalds (1):
        Linux 3.2-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-non-critical

Peter Ujfalusi (2):
      ARM: OMAP2+: DMA: Workaround for invalid source position
      ARM: OMAP2+: DMA: Workaround for invalid destination position

 arch/arm/plat-omap/dma.c |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)
