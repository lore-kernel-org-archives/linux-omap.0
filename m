From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes ready to go for v3.7-rc1
Date: Wed, 17 Oct 2012 15:02:49 -0700
Message-ID: <20121017220248.GA15569@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:30296 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751736Ab2JQWCy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 18:02:54 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Arnd & Olof,

Here are the fixes ready to pull, there's at least one more fix in works
but it still requires minor changes. The two top commits are recent as
Jon Hunter noticed an issue freeing resources in his fix and I did a
new branch to swap in the fixed patch.

Regards,

Tony


The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.7-rc1/fixes-take5-signed

for you to fetch changes up to 8119024ef7363591fd958ec89ebfaee7c18209e3:

  ARM: OMAP2+: Allow kernel to boot even if GPMC fails to reserve memory (2012-10-17 09:01:14 -0700)

----------------------------------------------------------------
A boot problem fix for am33xx beaglebone caused by GPMC,
a regression fix for local timer, and a clockdomain locking fix.
Also few minor fixes for boot time and sparse warnings.

----------------------------------------------------------------
Benoit Cousson (1):
      ARM: OMAP2+: clock data: Add dev-id for the omap-gpmc dummy fck

Jon Hunter (1):
      ARM: OMAP2+: Allow kernel to boot even if GPMC fails to reserve memory

Paul Walmsley (1):
      ARM: OMAP: resolve sparse warning concerning debug_card_init()

Sebastien Guiriec (1):
      ARM: OMAP4: devices: fixup OMAP4 DMIC platform device error message

Tero Kristo (1):
      ARM: OMAP: clockdomain: Fix locking on _clkdm_clk_hwmod_enable / disable

Tony Lindgren (1):
      ARM: OMAP4: Fix twd_local_timer_register regression

 arch/arm/mach-omap2/clock44xx_data.c |    2 +-
 arch/arm/mach-omap2/clockdomain.c    |   15 +++++++++++----
 arch/arm/mach-omap2/devices.c        |    2 +-
 arch/arm/mach-omap2/gpmc.c           |   24 +++++++++++++++++++-----
 arch/arm/mach-omap2/timer.c          |    2 +-
 arch/arm/plat-omap/debug-devices.c   |    1 +
 6 files changed, 34 insertions(+), 12 deletions(-)
