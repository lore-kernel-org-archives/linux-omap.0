From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH/RFC 00/19] OMAP: voltage layer cleanup and restructure
Date: Wed, 23 Mar 2011 17:00:14 -0700
Message-ID: <1300924833-26745-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:45203 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932887Ab1CXAAK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Mar 2011 20:00:10 -0400
Received: by mail-iw0-f170.google.com with SMTP id 3so9975888iwn.29
        for <linux-omap@vger.kernel.org>; Wed, 23 Mar 2011 17:00:09 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsely <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>

This series is the begining of a voltage layer cleanup and restruture
with the primary goal of splitting up voltage domain, voltage
processor (VP) and voltage controller (VC) code.

The RFC part is for the last 3 patches in the series, and for
discussion of how/if to split out the SoC specifics.  As an example, I
started on the VC and split out some functionality (setting slave i2c
addr, setting PMIC register addresses) into hooks that can be
implemented in SoC specific code.  I'd appreciate any input on this
approach as well as the types of functions/APIs that should exist at
this level.

Boot tested on 2420/n810, 3630/zoom3 and 4430/panda.

This series applies to my current pm-core branch.

Also, there are known checkpatch/whitespace problems in this series,
and that's OK for now.  That will all eventually be cleaned up as
well.

Kevin



Benoit Cousson (1):
  OMAP4: powerdomain data: add voltage domains

Kevin Hilman (18):
  OMAP2+: hwmod: remove unused voltagedomain pointer
  OMAP2+: voltage: move PRCM mod offets into VC/VP structures
  OMAP2+: voltage: move prm_irqst_reg from VP into voltage domain
  OMAP2+: voltage: start towards a new voltagedomain layer
  OMAP3: voltage: rename "mpu" voltagedomain to "mpu_iva"
  OMAP3: voltagedomain data: add wakeup domain
  OMAP3: voltage: add scalable flag to voltagedomain
  OMAP2+: powerdomain: add voltagedomain to struct powerdomain
  OMAP2: add voltage domains and connect to powerdomains
  OMAP3: powerdomain data: add voltage domains
  OMAP2+: powerdomain: add voltage domain lookup during register
  OMAP2+: voltage: keep track of powerdomains in each voltagedomain
  OMAP2+: voltage: split voltage controller (VC) code into dedicated
    layer
  OMAP2+: voltage: move VC into struct voltagedomain, misc. renames
  OMAP2+: voltage: split out voltage processor (VP) code into new layer
  OMAP2+: voltage: VC: begin spliting out SoC specifics; start with i2c
    slave addr
  OMAP2+: VC: support PMICs with separate voltage and command registers
  OMAP2+: VC: add SoC-specific op for PMIC register addresses

 arch/arm/mach-omap2/Makefile                     |   10 +-
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
 arch/arm/mach-omap2/vc.c                         |  265 +++++++
 arch/arm/mach-omap2/vc.h                         |   67 ++-
 arch/arm/mach-omap2/vc3xxx.c                     |   73 ++
 arch/arm/mach-omap2/vc3xxx_data.c                |   21 +-
 arch/arm/mach-omap2/vc44xx.c                     |   73 ++
 arch/arm/mach-omap2/vc44xx_data.c                |   30 +-
 arch/arm/mach-omap2/voltage.c                    |  856 +++++-----------------
 arch/arm/mach-omap2/voltage.h                    |   60 +-
 arch/arm/mach-omap2/voltagedomains2xxx_data.c    |   33 +
 arch/arm/mach-omap2/voltagedomains3xxx_data.c    |   51 +-
 arch/arm/mach-omap2/voltagedomains44xx_data.c    |   58 +-
 arch/arm/mach-omap2/vp.c                         |  374 ++++++++++
 arch/arm/mach-omap2/vp.h                         |   14 +-
 arch/arm/mach-omap2/vp3xxx_data.c                |    3 +-
 arch/arm/mach-omap2/vp44xx_data.c                |    4 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h     |    1 -
 28 files changed, 1280 insertions(+), 821 deletions(-)
 create mode 100644 arch/arm/mach-omap2/vc.c
 create mode 100644 arch/arm/mach-omap2/vc3xxx.c
 create mode 100644 arch/arm/mach-omap2/vc44xx.c
 create mode 100644 arch/arm/mach-omap2/voltagedomains2xxx_data.c
 create mode 100644 arch/arm/mach-omap2/vp.c

-- 
1.7.4

