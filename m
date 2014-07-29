From: Tony Lindgren <tony@atomide.com>
Subject: [GIT PULL] late omap mailbox clean-up, driver parts
Date: Tue, 29 Jul 2014 04:39:18 -0700
Message-ID: <20140729113917.GP29045@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:29066 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752941AbaG2Lko (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 29 Jul 2014 07:40:44 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: arm@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

The following changes since commit cbf14f3ab9bd6295b345fc812f08ddd844fb183e:

  ARM: AM33xx: hwmod_data: Remove legacy mailbox addrs (2014-07-15 05:08:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.17/mailbox-cleanup

for you to fetch changes up to 72c1c8179cdc5ba7208d375bd3f104659fc50ad0:

  mailbox/omap: add a parent structure for every IP instance (2014-07-29 01:57:25 -0700)

----------------------------------------------------------------
Driver specific omap mailbox cleanup. Mostly to remove
broken legacy code for omap1 and move things towards
device tree.

These patches were posted a while back, but I did not
realize I was supposed to merge the driver related
parts too. So apologies for a late pull request on
these changes.

----------------------------------------------------------------

Note that these are based on the SoC related changes already
pulled.

----------------------------------------------------------------

Suman Anna (7):
      mailbox/omap: use devm_* interfaces
      mailbox/omap: remove OMAP1 mailbox driver
      mailbox/omap: remove omap_mbox_type_t from mailbox ops
      mailbox/omap: simplify the fifo assignment by using macros
      mailbox/omap: consolidate OMAP mailbox driver
      mailbox/omap: remove the private mailbox structure
      mailbox/omap: add a parent structure for every IP instance

 arch/arm/configs/omap1_defconfig |   2 -
 drivers/mailbox/Kconfig          |  19 +-
 drivers/mailbox/Makefile         |   6 +-
 drivers/mailbox/mailbox-omap1.c  | 203 ------------------
 drivers/mailbox/mailbox-omap2.c  | 357 -------------------------------
 drivers/mailbox/omap-mailbox.c   | 444 +++++++++++++++++++++++++++++++--------
 drivers/mailbox/omap-mbox.h      |  67 ------
 7 files changed, 360 insertions(+), 738 deletions(-)
 delete mode 100644 drivers/mailbox/mailbox-omap1.c
 delete mode 100644 drivers/mailbox/mailbox-omap2.c
 delete mode 100644 drivers/mailbox/omap-mbox.h
