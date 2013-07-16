From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] pinctrl-single SoC specific support for v3.12
Date: Tue, 16 Jul 2013 02:18:16 -0700
Message-ID: <20130716091816.GU7656@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:63019 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753139Ab3GPJSU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 16 Jul 2013 05:18:20 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Roger Quadros <rogerq@ti.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Linus,

Here's a pull request for the pinctrl-single changes posted
few weeks ago. Assuming this pull request and the patches
are OK, I'd like to also merge this branch into omap tree so
we can have the wake-up events working. So we'd have to
establish keeping these commits immutable.

Note that this series does not depend on the dynamic remuxing
patches I just posted. These patches can be used without the
dynamic remuxing support for devices that have dedicated
wake-up path and don't need remuxing, such as UART on most
omaps.

Regards,

Tony


The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/pinctrl-single-for-linus

for you to fetch changes up to 8f406c0772ace721f0350c92acd043732285ba9f:

  pinctrl: single: omap: Add SoC specific module for wake-up events (2013-07-15 00:17:07 -0700)

----------------------------------------------------------------
Pinctrl single changes to add support for SoC specific features
that were too late for v3.11. This branch is needed as a dependency
also for the omap tree for off-idle and USB wake-up events, so
posting it as a pull request.

----------------------------------------------------------------
Tony Lindgren (3):
      pinctrl: single: Prepare for supporting SoC specific features
      pinctrl: single: Add hardware specific hooks for IRQ and GPIO wake-up events
      pinctrl: single: omap: Add SoC specific module for wake-up events

 .../devicetree/bindings/pinctrl/pinctrl-single.txt |   5 +
 drivers/pinctrl/Makefile                           |   3 +-
 drivers/pinctrl/pinctrl-single-omap.c              | 287 +++++++++++++++++++++
 drivers/pinctrl/pinctrl-single.c                   | 158 +++++++++---
 drivers/pinctrl/pinctrl-single.h                   |  43 +++
 include/linux/platform_data/pinctrl-single-omap.h  |   4 +
 6 files changed, 468 insertions(+), 32 deletions(-)
 create mode 100644 drivers/pinctrl/pinctrl-single-omap.c
 create mode 100644 drivers/pinctrl/pinctrl-single.h
 create mode 100644 include/linux/platform_data/pinctrl-single-omap.h
