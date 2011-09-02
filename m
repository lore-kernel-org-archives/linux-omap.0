From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] OMAP2: clockdomain/powerdomain: remove OMAP_CHIP bitmasks
Date: Thu, 01 Sep 2011 20:19:11 -0600
Message-ID: <20110902021321.8185.63172.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:47534 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933094Ab1IBCbo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 22:31:44 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Remove the OMAP_CHIP bitmasks from the powerdomain and clockdomain
code.  In their place, use lists of powerdomains and clockdomains to
register for particular chips and chip families.

The intention of this change is to reduce the number of lines that
need to be patched to add support for new SoCs that are similar to
previous SoCs.

This series has been boot-tested on a 2430SDP, BeagleBoard 35xx and
37xx, and PandaBoard 44xxES2, but I don't have boards for all of the
different variants needed for a complete test.

A git branch is available at git://git.pwsan.com/linux-2.6 based on
v3.1-rc4 with prcm-fixes-a-3.1rc.


- Paul

---
pwrdm_clkdm_remove_omap_chip_cleanup_3.2
   text	   data	    bss	    dec	    hex	filename
6330180	 656956	5591124	12578260	 bfedd4	vmlinux.omap2plus_defconfig.orig
6330432	 656052	5591124	12577608	 bfeb48	vmlinux.omap2plus_defconfig

Paul Walmsley (4):
      OMAP: clockdomain: split clkdm_init()
      OMAP: clockdomain code/data: remove omap_chip bitmask from struct clockdomain
      OMAP: powerdomain: split pwrdm_init() into two functions
      OMAP: powerdomain: remove omap_chip bitmasks


 arch/arm/mach-omap2/Makefile                     |    5 
 arch/arm/mach-omap2/clockdomain.c                |  149 +++-
 arch/arm/mach-omap2/clockdomain.h                |   22 -
 arch/arm/mach-omap2/clockdomain2xxx_3xxx.c       |    4 
 arch/arm/mach-omap2/clockdomain44xx.c            |    2 
 arch/arm/mach-omap2/clockdomains2420_data.c      |  155 ++++
 arch/arm/mach-omap2/clockdomains2430_data.c      |  181 +++++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |  803 ----------------------
 arch/arm/mach-omap2/clockdomains3xxx_data.c      |  398 +++++++++++
 arch/arm/mach-omap2/clockdomains44xx_data.c      |  409 ++---------
 arch/arm/mach-omap2/io.c                         |    8 
 arch/arm/mach-omap2/powerdomain-common.c         |    7 
 arch/arm/mach-omap2/powerdomain.c                |   87 ++
 arch/arm/mach-omap2/powerdomain.h                |    9 
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |   19 -
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |   44 +
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   81 +-
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   20 -
 18 files changed, 1104 insertions(+), 1299 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains2420_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomains2430_data.c
 create mode 100644 arch/arm/mach-omap2/clockdomains3xxx_data.c

