From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Get am3517 working with device tree
Date: Tue,  3 Dec 2013 15:23:14 -0800
Message-ID: <1386112999-17271-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51098 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab3LCXXV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Dec 2013 18:23:21 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi all,

Looks like I missed am3517 earlier when making mach-omap2 boot in
device tree only mode. Here are patches to make am3517-evm bootable
with NFSroot and MMC with device tree.

This should make it easy to add further support and also to add support
for the missing am3517 craneboard and cm-t3517 boards.

These should apply against v3.12 except for the pdata-quirks.c patch
that depends on the earlier mach-omap2 device tree conversion patches.

Regards,

Tony


Nishanth Menon (1):
  ARM: OMAP2+: Fix the machine entry for am3517

Tony Lindgren (4):
  arm/dts: Fix missing entries for am3517
  ARM: OMAP2+: Use pdata quirks for emac on am3517
  ARM/dts: Add basic devices on am3517-evm
  ARM: OMAP2+: Remove legacy emac code

 arch/arm/boot/dts/am3517-evm.dts    |  35 ++++++++++-
 arch/arm/boot/dts/am3517.dtsi       |  63 ++++++++++++++++++++
 arch/arm/mach-omap2/Makefile        |   3 -
 arch/arm/mach-omap2/am35xx-emac.c   | 115 ------------------------------------
 arch/arm/mach-omap2/am35xx-emac.h   |  15 -----
 arch/arm/mach-omap2/board-generic.c |  18 ++++++
 arch/arm/mach-omap2/pdata-quirks.c  |  43 ++++++++++++++
 7 files changed, 156 insertions(+), 136 deletions(-)
 create mode 100644 arch/arm/boot/dts/am3517.dtsi
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.c
 delete mode 100644 arch/arm/mach-omap2/am35xx-emac.h

-- 
1.8.1.1

