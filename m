From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] omap fixes for v3.15 merge window
Date: Thu, 13 Mar 2014 15:42:13 -0700
Message-ID: <20140313224213.GA27402@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:23603 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753378AbaCMWmT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2014 18:42:19 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit cfbf8d4857c26a8a307fb7cd258074c9dcd8=
c691:

  Linux 3.14-rc4 (2014-02-23 17:40:03 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/=
omap-for-v3.15/fixes-for-merge-window

for you to fetch changes up to 77319669af37a1cfc844b801e83343b37e3c7e13=
:

  ARM: OMAP4: hwmod data: correct the idlemodes for spinlock (2014-03-1=
3 14:09:57 -0700)

----------------------------------------------------------------
=46ixes for omaps that would be good to get in before v3.15-rc1.

----------------------------------------------------------------
=46lorian Vaussard (2):
      CLK: TI: OMAP4/5/DRA7: Remove gpmc_fck from dummy clocks
      ARM: dts: omap4/5: Use l3_ick for the gpmc node

Mugunthan V N (1):
      ARM: dts: am33xx: correcting dt node unit address for usb

Nishanth Menon (1):
      ARM: OMAP4: Fix definition of IS_PM44XX_ERRATUM

Stefan S=C3=83=C2=B8rensen (1):
      ARM: OMAP2+: INTC: Acknowledge stuck active interrupts

Suman Anna (1):
      ARM: OMAP4: hwmod data: correct the idlemodes for spinlock

 arch/arm/boot/dts/am33xx.dtsi              | 4 ++--
 arch/arm/boot/dts/omap4.dtsi               | 2 ++
 arch/arm/boot/dts/omap5.dtsi               | 2 ++
 arch/arm/mach-omap2/irq.c                  | 8 ++++++++
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 3 +--
 arch/arm/mach-omap2/pm.h                   | 2 +-
 drivers/clk/ti/clk-44xx.c                  | 1 -
 drivers/clk/ti/clk-54xx.c                  | 1 -
 drivers/clk/ti/clk-7xx.c                   | 1 -
 9 files changed, 16 insertions(+), 8 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
