From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 1/4] omap late not urgent fixes part 2 for v3.13 merge window
Date: Wed, 23 Oct 2013 07:36:42 -0700
Message-ID: <3441.8765608736$1382539018@news.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:20503 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750949Ab3JWOgu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 23 Oct 2013 10:36:50 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 8ff875e7f93e900e7a7e78f1c9c05a22b33c27cf:

  ARM: mach-omap1: Fix omap1510_fpga_init_irq() implicit declarations. (2013-10-08 11:04:22 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.13/fixes-not-urgent-part2

for you to fetch changes up to 0bebda684857f76548ea48c8886785198701d8d3:

  ARM: OMAP2+: irq, AM33XX add missing register check (2013-10-22 07:50:18 -0700)

----------------------------------------------------------------
Few more omap fixes that are not regressions or oopses and can
wait for the merge window.

----------------------------------------------------------------
Afzal Mohammed (1):
      ARM: OMAP2+: wakeupgen: AM43x adaptation

Markus Pargmann (1):
      ARM: OMAP2+: irq, AM33XX add missing register check

 arch/arm/mach-omap2/irq.c            |  2 +-
 arch/arm/mach-omap2/omap-wakeupgen.c | 18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)
