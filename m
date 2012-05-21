From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/6] ARM: OMAP AM33xx: PRM/CM support for 3.6
Date: Mon, 21 May 2012 12:41:53 -0600
Message-ID: <20120521184053.22565.90037.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37445 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab2EUSpM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 May 2012 14:45:12 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi

This series implements low-level PRM/CM support for the AM33xx series
of chips.  This support is a prerequisite for the kernel to reset,
enable, and disable on-chip IP blocks.  

This series applies against Tony's devel-soc branch at commit
8a7289f52543cc89de73e174946edaa21a2d049d ("ARM: OMAP2+: am33xx:
Make am33xx as a separate class") plus the "ARM: OMAP2+: am33xx:
Add AM335XEVM machine support" patch from Afzal.  Currently they
are compile-tested only.

These patches are also available from git://git.pwsan.com/linux-2.6
in the branch 'am33xx_prcm_devel_3.6'.


- Paul

---

am33xx_prcm_devel_3.6
   text	   data	    bss	    dec	    hex	filename
6559798	 722684	5587872	12870354	 c462d2	vmlinux.omap2plus_defconfig.orig
6562162	 729652	5587872	12879686	 c48746	vmlinux.omap2plus_defconfig

Vaibhav Hiremath (6):
      ARM: OMAP2+: control: Add AM33XX control reg & sec clkctrl offset
      ARM: OMAP AM33xx: voltagedomain: Add voltage domain data
      ARM: OMAP AM33xx: PRM: add PRM support
      ARM: OMAP AM33xx: CM: Introduce AM33xx CM APIs and register level details
      ARM: OMAP AM33xx: powerdomains: add AM335x support
      ARM: OMAP AM33xx: clockdomains: Add clockdomain data and respective operations


 arch/arm/mach-omap2/Makefile                  |    7 
 arch/arm/mach-omap2/clockdomain.h             |    2 
 arch/arm/mach-omap2/clockdomain33xx.c         |   74 +++
 arch/arm/mach-omap2/clockdomains33xx_data.c   |  196 +++++++
 arch/arm/mach-omap2/cm-regbits-33xx.h         |  687 +++++++++++++++++++++++++
 arch/arm/mach-omap2/cm33xx.c                  |  313 +++++++++++
 arch/arm/mach-omap2/cm33xx.h                  |  420 +++++++++++++++
 arch/arm/mach-omap2/control.h                 |   39 +
 arch/arm/mach-omap2/io.c                      |    5 
 arch/arm/mach-omap2/powerdomain.h             |   23 +
 arch/arm/mach-omap2/powerdomain33xx.c         |  229 ++++++++
 arch/arm/mach-omap2/powerdomains33xx_data.c   |  185 +++++++
 arch/arm/mach-omap2/prm-regbits-33xx.h        |  357 +++++++++++++
 arch/arm/mach-omap2/prm33xx.c                 |  134 +++++
 arch/arm/mach-omap2/prm33xx.h                 |  129 +++++
 arch/arm/mach-omap2/voltage.h                 |    1 
 arch/arm/mach-omap2/voltagedomains33xx_data.c |   43 ++
 17 files changed, 2824 insertions(+), 20 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/clockdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/cm33xx.c
 create mode 100644 arch/arm/mach-omap2/cm33xx.h
 create mode 100644 arch/arm/mach-omap2/powerdomain33xx.c
 create mode 100644 arch/arm/mach-omap2/powerdomains33xx_data.c
 create mode 100644 arch/arm/mach-omap2/prm-regbits-33xx.h
 create mode 100644 arch/arm/mach-omap2/prm33xx.c
 create mode 100644 arch/arm/mach-omap2/prm33xx.h
 create mode 100644 arch/arm/mach-omap2/voltagedomains33xx_data.c

