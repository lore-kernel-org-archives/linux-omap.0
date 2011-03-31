From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 00/17] OMAP: voltage layer cleanup and restructure: part 1
Date: Wed, 30 Mar 2011 17:16:03 -0700
Message-ID: <1301530580-12046-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:50916 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756665Ab1CaAQC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 30 Mar 2011 20:16:02 -0400
Received: by mail-gy0-f182.google.com with SMTP id 13so881189gyg.13
        for <linux-omap@vger.kernel.org>; Wed, 30 Mar 2011 17:16:00 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This is the first of a few series of voltage layer cleanups.  In part 1, the
primary goal is to split up the voltage processor (VP) and voltage
controller (VC) into dedicated code, and create the beginnings of a
voltage domain layer modeled closely on the current clock domain and
powerdomain layer.

NOTE: there are a handful of >80 chars checkpatch warnings.
  These are mainly due to copy/paste of existing code and are
  ignored for now since this series is primarily concerned
  about shuffling some code around.  The long lines will be
  cleaned up in part 2 of the cleanups.


Benoit Cousson (1):
  OMAP4: powerdomain data: add voltage domains

Kevin Hilman (16):
  OMAP2+: hwmod: remove unused voltagedomain pointer
  OMAP2+: voltage: move PRCM mod offets into VC/VP structures
  OMAP2+: voltage: move prm_irqst_reg from VP into voltage domain
  OMAP2+: voltage: start towards a new voltagedomain layer
  OMAP3: voltage: rename "mpu" voltagedomain to "mpu_iva"
  OMAP3: voltagedomain data: add wakeup domain
  OMAP3+: voltage: add scalable flag to voltagedomain
  OMAP2+: powerdomain: add voltagedomain to struct powerdomain
  OMAP2: add voltage domains and connect to powerdomains
  OMAP3: powerdomain data: add voltage domains
  OMAP2+: powerdomain: add voltage domain lookup during register
  OMAP2+: voltage: keep track of powerdomains in each voltagedomain
  OMAP2+: voltage: split voltage controller (VC) code into dedicated
    layer
  OMAP2+: voltage: move VC into struct voltagedomain, misc. renames
  OMAP2+: voltage: split out voltage processor (VP) code into new layer
  OMAP2+: VC: support PMICs with separate voltage and command registers

 arch/arm/mach-omap2/Makefile                     |    5 +-
 arch/arm/mach-omap2/io.c                         |    5 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c       |    4 +-
 arch/arm/mach-omap2/omap_twl.c                   |   20 +-
 arch/arm/mach-omap2/pm.c                         |    4 +-
 arch/arm/mach-omap2/powerdomain.c                |   23 +
 arch/arm/mach-omap2/powerdomain.h                |   10 +
 arch/arm/mach-omap2/powerdomains2xxx_3xxx_data.c |    2 +
 arch/arm/mach-omap2/powerdomains2xxx_data.c      |    4 +
 arch/arm/mach-omap2/powerdomains3xxx_data.c      |   16 +
 arch/arm/mach-omap2/powerdomains44xx_data.c      |   18 +-
 arch/arm/mach-omap2/sr_device.c                  |    2 +-
 arch/arm/mach-omap2/vc.c                         |  274 +++++++
 arch/arm/mach-omap2/vc.h                         |   36 +-
 arch/arm/mach-omap2/vc3xxx_data.c                |   11 +-
 arch/arm/mach-omap2/vc44xx_data.c                |   15 +-
 arch/arm/mach-omap2/voltage.c                    |  856 +++++-----------------
 arch/arm/mach-omap2/voltage.h                    |   55 +-
 arch/arm/mach-omap2/voltagedomains2xxx_data.c    |   32 +
 arch/arm/mach-omap2/voltagedomains3xxx_data.c    |   51 +-
 arch/arm/mach-omap2/voltagedomains44xx_data.c    |   66 +-
 arch/arm/mach-omap2/vp.c                         |  374 ++++++++++
 arch/arm/mach-omap2/vp.h                         |   14 +-
 arch/arm/mach-omap2/vp3xxx_data.c                |    3 +-
 arch/arm/mach-omap2/vp44xx_data.c                |    4 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h     |    1 -
 26 files changed, 1113 insertions(+), 792 deletions(-)
 create mode 100644 arch/arm/mach-omap2/vc.c
 create mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c
 create mode 100644 arch/arm/mach-omap2/vp.c

-- 
1.7.4

