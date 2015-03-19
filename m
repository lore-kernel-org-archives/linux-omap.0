From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL 2/3] omap defconfig changes for v4.1
Date: Thu, 19 Mar 2015 16:14:00 -0700
Message-ID: <44695.2259204865$1426807150@news.gmane.org>
References: <pull-1426799683-420388>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nov-007-i507.relay.mailchannels.net ([46.232.183.61]:31359 "EHLO
	relay.mailchannels.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751032AbbCSXS4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Mar 2015 19:18:56 -0400
In-Reply-To: <pull-1426799683-420388>
In-Reply-To: <pull-1426799683-420388>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/v4.1-defconfig

for you to fetch changes up to 1fd6d08cbd4bd8984241c7cef2f7c5cb67fce1aa:

  ARM: omap2plus_defconfig: Enable n900 modem as loadable modules (2015-03-16 12:48:44 -0700)

----------------------------------------------------------------
Few omap2plus_defconfig updates to add commonly used drivers as
loadable modules.

Note that I'll do patches for armv7_defconfig for these at some
point too once we're happy with omap2plus_defconfig to avoid
extra churn on the defconfig files.

----------------------------------------------------------------
Felipe Balbi (1):
      arm: config: omap2plus_defconfig: switch over to LZMA compression

Paul Walmsley (1):
      ARM: omap1_defconfig: drop obsolete Kconfig symbols

Roger Quadros (1):
      ARM: omap2plus_defconfig: Enable EXTCON_GPIO_USB

Tony Lindgren (3):
      ARM: omap2plus_defconfig: Enable leds-pwm
      ARM: omap2plus_defconfig: Update bluetooth options
      ARM: omap2plus_defconfig: Enable n900 modem as loadable modules

 arch/arm/configs/omap1_defconfig     | 16 ----------------
 arch/arm/configs/omap2plus_defconfig | 27 +++++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 16 deletions(-)
