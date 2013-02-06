From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap twl platform init changes for v3.9 merge window
Date: Wed, 6 Feb 2013 09:25:00 -0800
Message-ID: <20130206172500.GA25185@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:10252 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755389Ab3BFRZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Feb 2013 12:25:04 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:

  Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.9/twl-signed-v2

for you to fetch changes up to 6689c87555839d90f2a0b76d1f982713487a11d2:

  ARM: OMAP2+: Fix twl section warnings related to omap_twl4030_audio_init (2013-02-05 10:36:21 -0800)

----------------------------------------------------------------
OMAP TWL updates from Peter Ujfalusi <peter.ujfalusi@ti.com>:

Update for audio support via omap-twl4030 and pwm updates in board level,
and zoom-peripherals update to not request the TWL GPIO7.

----------------------------------------------------------------
Peter Ujfalusi (9):
      ARM: OMAP: 3430sdp: Enable extmute functionality for audio
      ARM: OMAP: zoom: Zoom2 does not have extmute functionality
      ARM: OMAP2+: twl-common: Add default twl4030 audio configuration
      ARM: OMAP2+: twl-common: Allow boards to customize the twl4030 audio setup
      ARM: OMAP: zoom: Audio support via the common omap-twl4030 machine driver
      ARM: OMAP: sdp3430: Audio support via the common omap-twl4030 machine driver
      ARM: OMAP: board-4430sdp: Proper support for TWL6030 PWM LED/Backlight
      ARM: OMAP: omap3beagle: Use the pwm_leds driver to control the PMU_STAT led
      ARM: board-zoom: Do not request LCD panel enable GPIO from twl4030

Tony Lindgren (2):
      Merge branch 'peter/for-tony' of git://gitorious.org/omap-audio/linux-audio into omap-for-v3.9/twl
      ARM: OMAP2+: Fix twl section warnings related to omap_twl4030_audio_init

 arch/arm/mach-omap2/board-3430sdp.c          | 20 ++++++++++++++
 arch/arm/mach-omap2/board-4430sdp.c          | 30 +++++++++++++++++++-
 arch/arm/mach-omap2/board-cm-t35.c           |  2 +-
 arch/arm/mach-omap2/board-devkit8000.c       |  2 +-
 arch/arm/mach-omap2/board-igep0020.c         |  2 +-
 arch/arm/mach-omap2/board-omap3beagle.c      | 41 ++++++++++++++++++++++------
 arch/arm/mach-omap2/board-omap3evm.c         |  2 +-
 arch/arm/mach-omap2/board-overo.c            |  2 +-
 arch/arm/mach-omap2/board-zoom-peripherals.c | 39 ++++++++++++++------------
 arch/arm/mach-omap2/twl-common.c             | 17 ++++++++----
 arch/arm/mach-omap2/twl-common.h             |  3 +-
 11 files changed, 120 insertions(+), 40 deletions(-)
