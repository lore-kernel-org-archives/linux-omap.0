From: Tony Lindgren <tony@atomide.com>
Subject: updated git pull request for omap compile fixes, mailbox and hsmmc
Date: Thu, 8 Jan 2009 09:36:12 +0200
Message-ID: <20090108073611.GW27566@atomide.com>
References: <20090107111415.GF27566@atomide.com> <20090107111615.GG27566@atomide.com> <20090107111744.GH27566@atomide.com> <20090107161843.GA11471@n2100.arm.linux.org.uk> <20090107175020.GU27566@atomide.com> <20090107220053.GD11471@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:55408 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213AbZAHHgS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jan 2009 02:36:18 -0500
Content-Disposition: inline
In-Reply-To: <20090107220053.GD11471@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, "Nikula Jarkko (NRC/Helsinki)" <jarkko.nikula@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090108 00:01]:
> On Wed, Jan 07, 2009 at 07:50:21PM +0200, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [090107 18:18]:
> > > On Wed, Jan 07, 2009 at 01:17:45PM +0200, Tony Lindgren wrote:
> > > > -	set_irq_type(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), IRQ_TYPE_EDGE_RISING);
> > > > -	if (request_irq(OMAP_GPIO_IRQ(SW_ENTER_GPIO16), &apollon_sw_interrupt,
> > > > +	set_irq_type(gpio_to_irq(SW_ENTER_GPIO16), IRQ_TYPE_EDGE_RISING);
> > > > +	if (request_irq(gpio_to_irq(SW_ENTER_GPIO16), &apollon_sw_interrupt,
> > > 
> > > NAK.  I wonder how the f*** this got anywhere near the mainline kernel.
> > > No no no no no.  set_irq_type + request_irq is utter crap and should be
> > > rejected whenever its seen.  There's absolutely no need for it -
> > > request_irq is sufficient.  Get rid of this set_irq_type usage from
> > > everywhere please.
> > 
> > Blind search and replace? :) I've removed the GPIO key code as there's
> > already a patch to do that cleaner with gpio_keys.
> 
> Revised patch is fine.

OK, here's the pull request again:

The following changes since commit ede6f5aea054d3fb67c78857f7abdee602302043:
  Linus Torvalds (1):
        Fix up 64-bit byte swaps for most 32-bit architectures

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-misc-for-rmk

Hiroshi DOYU (10):
      omap mailbox: cleanup omap2 register definition with macro
      omap mailbox: add initial omap3 support
      omap mailbox: print hardware revision at startup
      omap mailbox: fix empty struct device for omap_mbox
      omap mailbox: fix empty struct device for omap1
      omap mailbox: fix empty struct device for omap2
      omap mailbox: add save_/restore_ctx() for PM
      omap mailbox: move mailbox.h into mailbox.c
      omap mailbox: convert sequence bit checking to module paramter
      omap mailbox: remove unnecessary header file inclusion

Jarkko Nikula (1):
      ARM: OMAP: Fix gpio by switching to generic gpio calls, v2

Madhusudhan Chikkature (1):
      omap mmc: Add new omap hsmmc controller for 2430 and 34xx, v3

Tony Lindgren (1):
      ARM: OMAP: Fix missing includes

 arch/arm/mach-omap1/board-sx1.c            |    6 +-
 arch/arm/mach-omap1/devices.c              |    2 +-
 arch/arm/mach-omap1/mailbox.c              |   31 +-
 arch/arm/mach-omap1/mcbsp.c                |    1 +
 arch/arm/mach-omap2/board-apollon.c        |   64 +--
 arch/arm/mach-omap2/board-ldp.c            |    2 +-
 arch/arm/mach-omap2/devices.c              |   38 +-
 arch/arm/mach-omap2/mailbox.c              |  195 +++--
 arch/arm/mach-omap2/mcbsp.c                |    1 +
 arch/arm/plat-omap/Kconfig                 |    8 +
 arch/arm/plat-omap/i2c.c                   |    1 +
 arch/arm/plat-omap/include/mach/gpio.h     |   10 -
 arch/arm/plat-omap/include/mach/mailbox.h  |   27 +-
 arch/arm/plat-omap/include/mach/omap34xx.h |    1 +
 arch/arm/plat-omap/mailbox.c               |  152 +++-
 arch/arm/plat-omap/mailbox.h               |  100 ---
 drivers/mfd/twl4030-core.c                 |    1 +
 drivers/mmc/host/Kconfig                   |   10 +
 drivers/mmc/host/Makefile                  |    1 +
 drivers/mmc/host/omap_hsmmc.c              | 1242 ++++++++++++++++++++++++++++
 drivers/mtd/onenand/omap2.c                |    6 +-
 21 files changed, 1581 insertions(+), 318 deletions(-)
 delete mode 100644 arch/arm/plat-omap/mailbox.h
 create mode 100644 drivers/mmc/host/omap_hsmmc.c
