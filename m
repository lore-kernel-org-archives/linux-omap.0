From: "Cousson, Benoit" <b-cousson@ti.com>
Subject: [GIT PULL] ARM: OMAP: Miscellaneous DT cleanup for 3.4
Date: Thu, 16 Feb 2012 23:22:19 +0100
Message-ID: <4F3D819B.6020007@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57694 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896Ab2BPWW0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Feb 2012 17:22:26 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Tony,

Here is a small cleanup series to prepare for further DT series for 3.4.

Thanks,
Benoit


The following changes since commit d65b4e98d7ea3038b767b70fe8be959b2913f16d:
  Linus Torvalds (1):
        Linux 3.3-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/dt_base

Benoit Cousson (5):
      ARM: OMAP2+: board-generic: Remove un-needed .atag_offset for DT_MACHINE
      ARM: OMAP2+: omap_device: Replace dev_warn by dev_dbg in omap_device_build_from_dt
      ARM: OMAP2+: pm: Do not init statically the SR and voltage layer with DT
      ARM: OMAP1: kconfig: Enable IRQ_DOMAIN by default for OMAP1 platforms
      arm/dts: OMAP3&4: Remove the '0x' prefix for serial nodes

 arch/arm/boot/dts/omap3.dtsi        |    8 ++++----
 arch/arm/boot/dts/omap4.dtsi        |    8 ++++----
 arch/arm/mach-omap2/board-generic.c |   12 ++++--------
 arch/arm/mach-omap2/pm.c            |    8 ++++++++
 arch/arm/plat-omap/Kconfig          |    1 +
 arch/arm/plat-omap/omap_device.c    |    2 +-
 6 files changed, 22 insertions(+), 17 deletions(-)
