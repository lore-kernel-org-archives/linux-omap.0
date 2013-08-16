From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.11-rc5
Date: Fri, 16 Aug 2013 00:19:58 -0700
Message-ID: <20130816071958.GB7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:55527 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691Ab3HPHUF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Aug 2013 03:20:05 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

  Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/fixes-against-rc5

for you to fetch changes up to d7641b2087203b971ba4a76ffa4ecfa343b4bce0:

  ARM: OMAP: rx51: change musb mode to OTG (2013-08-16 00:13:55 -0700)

----------------------------------------------------------------
Two fixes for Nokia n8x0 USB regressions and update of
Benoit Cousson's email address.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP: rx51: change musb mode to OTG

Benoit Cousson (1):
      MAINTAINERS: Update email address for Benoit Cousson

Daniel Mack (1):
      ARM: OMAP2: fix musb usage for n8x0

 MAINTAINERS                      | 6 +++---
 arch/arm/mach-omap2/board-n8x0.c | 4 ----
 arch/arm/mach-omap2/board-rx51.c | 2 +-
 arch/arm/mach-omap2/usb-musb.c   | 5 +----
 4 files changed, 5 insertions(+), 12 deletions(-)
