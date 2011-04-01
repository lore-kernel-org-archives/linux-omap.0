From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 00/13] OMAP: voltage layer cleanup and restructure: part 2
Date: Fri,  1 Apr 2011 16:40:58 -0700
Message-ID: <1301701271-22096-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:46725 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751823Ab1DAXkb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 19:40:31 -0400
Received: by mail-iw0-f173.google.com with SMTP id 42so4738938iwl.4
        for <linux-omap@vger.kernel.org>; Fri, 01 Apr 2011 16:40:30 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Here is part 2 of the voltage layer cleanup and restrucure.  This part
focuses on the VC layer cleanups and abstracions, and moves register
access functions into PRM code.

Some things still needed on top of this series, please let me know if
you want to work on any of them:

- OMAP4: hard-coded I2C SCLL/SCCH values removed and calculated based
  on sys_clk

- OMAP3: abstract CLKSETUP, VOLTSETUP, VOLTSETUP2 to something that is
  common with OMAP4 so common VC code can be used.  (Vishwa started on
  this one already, but it needs a common OMAP3/OMAP4 description.)

This series is based on part 1, and is also available in the
pm-wip/voltdm_b branch of my tree.

Kevin

Kevin Hilman (13):
  OMAP3+: add PRM VP functions for checking/clearing VP TX done status
  OMAP3+ VP: replace transaction done check/clear with VP ops
  OMAP3+: PRM: add register access functions for VC/VP
  OMAP3+: voltage: convert to PRM register access functions
  OMAP3+: VC: cleanup i2c slave address configuration
  OMAP3+: VC: cleanup PMIC register address configuration
  OMAP3+: VC bypass: use fields from VC struct instead of PMIC info
  OMAP3+: VC: cleanup voltage setup time configuration
  OMAP3+: VC: move on/onlp/ret/off command configuration into common
    init
  OMAP3+: VC: abstract out channel configuration
  OMAP4: PRM: VC: rename I2C configuration register: s/INSTE/MODE/
  OMAP3+: voltage domain: move PMIC struct from vdd_info into struct
    voltagedomain
  OMAP3+: VC: make I2C config programmable with PMIC-specific settings

 arch/arm/mach-omap2/omap_twl.c                |   32 ++--
 arch/arm/mach-omap2/prm2xxx_3xxx.c            |   56 ++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h            |   12 ++
 arch/arm/mach-omap2/prm44xx.c                 |   71 +++++++
 arch/arm/mach-omap2/prm44xx.h                 |   16 ++-
 arch/arm/mach-omap2/vc.c                      |  256 ++++++++++++++++---------
 arch/arm/mach-omap2/vc.h                      |   31 ++-
 arch/arm/mach-omap2/vc3xxx_data.c             |   14 +-
 arch/arm/mach-omap2/vc44xx_data.c             |   18 +-
 arch/arm/mach-omap2/voltage.c                 |   60 ++-----
 arch/arm/mach-omap2/voltage.h                 |   27 ++-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |   14 +-
 arch/arm/mach-omap2/voltagedomains44xx_data.c |   21 ++-
 arch/arm/mach-omap2/vp.c                      |   86 ++++-----
 arch/arm/mach-omap2/vp.h                      |   35 ++--
 arch/arm/mach-omap2/vp3xxx_data.c             |   20 +-
 arch/arm/mach-omap2/vp44xx_data.c             |   26 +--
 17 files changed, 499 insertions(+), 296 deletions(-)

-- 
1.7.4

