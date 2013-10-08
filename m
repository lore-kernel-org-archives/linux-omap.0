From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes against v3.12-rc3
Date: Tue, 8 Oct 2013 15:03:24 -0700
Message-ID: <20131008220324.GV8313@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:15470 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753397Ab3JHWDa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Oct 2013 18:03:30 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org, Arnd Bergmann <arnd@arndb.de>, Kevin Hilman <khilman@linaro.org>, Olof Johansson <olof@lixom.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit 15c03dd4859ab16f9212238f29dd315654aa=
94f6:

  Linux 3.12-rc3 (2013-09-29 15:02:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/=
fixes-against-v3.12-rc3-take2

for you to fetch changes up to d1f1ca36b566aa56effdd7df69750062ec735131=
:

  ARM: OMAP2: RX-51: Add missing max_current to rx51_lp5523_led_config =
(2013-10-08 11:22:43 -0700)

----------------------------------------------------------------
=46ew fixes for omap3 related hangs and errors that people have
noticed now that people are actually using the device tree
based booting for omap3.

Also one regression fix for timer compile for dra7xx when
omap5 is not selected, and a LED regression fix for n900.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP2: gpmc-onenand: fix sync mode setup with DT

Nishanth Menon (1):
      ARM: OMAP3: Fix hardware detection for omap3630 when booted with =
device tree

Pali Roh=C3=A1r (1):
      ARM: OMAP2: RX-51: Add missing max_current to rx51_lp5523_led_con=
fig

Simon Barth (1):
      ARM: mach-omap2: board-generic: fix undefined symbol

Tony Lindgren (1):
      ARM: dts: Fix pinctrl mask for omap3

 arch/arm/boot/dts/omap3-beagle-xm.dts        |  2 +-
 arch/arm/boot/dts/omap3.dtsi                 |  4 ++--
 arch/arm/mach-omap2/board-generic.c          | 18 ++++++++++++++++++
 arch/arm/mach-omap2/board-rx51-peripherals.c |  9 +++++++++
 arch/arm/mach-omap2/gpmc-onenand.c           | 12 +++++++++++-
 arch/arm/mach-omap2/mux.h                    |  4 +---
 arch/arm/mach-omap2/timer.c                  |  4 ++--
 include/dt-bindings/pinctrl/omap.h           |  4 +---
 8 files changed, 45 insertions(+), 12 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
