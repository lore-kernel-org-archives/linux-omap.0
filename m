From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH 0/5] mtd: plat_nand: Add default partition parser and use it
Date: Wed, 28 Mar 2012 11:12:48 -0700
Message-ID: <201203281112.48788.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail209.messagelabs.com ([216.82.255.3]:16642 "EHLO
	mail209.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758526Ab2C1SNW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Mar 2012 14:13:22 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org, linux-sh@vger.kernel.org, linux-mips@linux-mips.org

This patch series adds cmdlinepart as the default partition parser for the
plat_nand driver and updates all the arch setup code to use it.

Arch setup code that requires other partition parsers can still pass that
information as chip.part_probe_types.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
  mtd: plat_nand: Add default partition parser to driver
  arm: Use the plat_nand default partition parser
  blackfin: Use the plat_nand default partition parser
  mips: Use the plat_nand default partition parser
  sh: Use the plat_nand default partition parser

 arch/arm/mach-ep93xx/snappercl15.c        |    3 ---
 arch/arm/mach-ep93xx/ts72xx.c             |    3 ---
 arch/arm/mach-ixp4xx/ixdp425-setup.c      |    3 ---
 arch/arm/mach-omap1/board-fsample.c       |    3 ---
 arch/arm/mach-omap1/board-h2.c            |    3 ---
 arch/arm/mach-omap1/board-h3.c            |    3 ---
 arch/arm/mach-omap1/board-perseus2.c      |    3 ---
 arch/arm/mach-orion5x/ts78xx-setup.c      |    3 ---
 arch/arm/mach-pxa/balloon3.c              |    3 ---
 arch/arm/mach-pxa/em-x270.c               |    3 ---
 arch/arm/mach-pxa/palmtx.c                |    3 ---
 arch/blackfin/mach-bf561/boards/acvilon.c |    3 ---
 arch/mips/alchemy/devboards/db1200.c      |    3 ---
 arch/mips/alchemy/devboards/db1300.c      |    3 ---
 arch/mips/alchemy/devboards/db1550.c      |    3 ---
 arch/mips/pnx833x/common/platform.c       |    6 ------
 arch/sh/boards/mach-migor/setup.c         |    1 -
 drivers/mtd/nand/plat_nand.c              |    8 ++++++--
 18 files changed, 6 insertions(+), 54 deletions(-)
