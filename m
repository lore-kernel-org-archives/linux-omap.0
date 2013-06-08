From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.10-rc4
Date: Sat, 8 Jun 2013 12:08:57 -0700
Message-ID: <20130608190857.GV3331@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:28863 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752215Ab3FHTJD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 8 Jun 2013 15:09:03 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:

  Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.10/fixes-v3.10-rc4

for you to fetch changes up to 03c0d27119296bb32ef4a075b9fb8bb0aeaa19c0:

  Merge tag 'omap-fixes-b-for-3.10-rc' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.10/fixes (2013-06-07 15:06:18 -0700)

----------------------------------------------------------------

A set of small fixes for omaps for the -rc cycle:

- am7303 iva2 reset PM regression fix
- am33xx uart2 dma channel fix
- am33xx gpmc properties fix
- omap44xx rtc wake-up mux fix for nirq pins
- omap36xx clock divider restore fix

There's also one tiny non-critical .dts fix for omap5
timer pwm properties.

----------------------------------------------------------------
Jean-Philippe Francois (1):
      ARM: omap3: clock: fix wrong container_of in clock36xx.c

Kevin Hilman (1):
      ARM: dts: omap4-panda|sdp: Fix mux for twl6030 IRQ pin and msecure line

Lars Poeschel (1):
      ARM: dts: AM33xx: Fix properties on gpmc node

Suman Anna (1):
      ARM: dts: OMAP5: Fix missing PWM capability to timer nodes

Thomas Petazzoni (1):
      arm: omap2: fix AM33xx hwmod infos for UART2

Tony Lindgren (3):
      ARM: OMAP3: Fix iva2_pwrdm settings for 3703
      Merge branch 'dts-fixes-for-3.10' of git://git.kernel.org/.../bcousson/linux-omap-dt into omap-for-v3.10/fixes
      Merge tag 'omap-fixes-b-for-3.10-rc' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.10/fixes

 arch/arm/boot/dts/am33xx.dtsi              |  4 ++--
 arch/arm/boot/dts/omap4-panda-common.dtsi  | 20 ++++++++++++++++++++
 arch/arm/boot/dts/omap4-sdp.dts            | 20 ++++++++++++++++++++
 arch/arm/boot/dts/omap5.dtsi               |  3 +++
 arch/arm/mach-omap2/clock36xx.c            | 18 +++++++++---------
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |  9 ++++++++-
 arch/arm/mach-omap2/pm34xx.c               |  6 ++++--
 7 files changed, 66 insertions(+), 14 deletions(-)
