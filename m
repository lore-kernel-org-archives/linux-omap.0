From: Mike Turquette <mturquette@ti.com>
Subject: [PATCH 0/8] OMAP3+: Voltage: introduce Adaptive Body-Bias ldo suppport
Date: Wed, 29 Jun 2011 17:25:52 -0700
Message-ID: <1309393560-8874-1-git-send-email-mturquette@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:56083 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754144Ab1F3AdJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Jun 2011 20:33:09 -0400
Received: by yib17 with SMTP id 17so810458yib.8
        for <linux-omap@vger.kernel.org>; Wed, 29 Jun 2011 17:33:07 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, nm@ti.com, Mike Turquette <mturquette@ti.com>

This patchset adds Adaptive Body-Bias ldo handling to the OMAP voltage
code with support for 36xx and 44xx chips.  ABB handling is a mandatory
part of the voltage scaling process when operating at high OPPs.

A longer explanation is that due to voltage domain trimming and silicon
characterstics some silicon may experience instability when operating at
a high voltage.  To compensate for this an Adaptive Body-Bias ldo
exists.  First featured in OMAP3630, the purpose of this ldo is to
provide a voltage boost to PMOS backgates when a voltage domain is
operating at a high OPP.  In this mode the ldo is said to be in Forward
Body-Bias.  At OPPs within a nominal voltage range the ABB ldo is
bypassed.

The TRM defines voltages that require Forward Body-Bias as FAST OPP's,
and all other voltages as NOMINAL OPP's.

Find more info in the 36xx TRM in section 3.5.6.6.1 "ABB LDOs Control"
and in the 4430 TRM in section 3.8.4.3 "ABB LDOs Control" and 3.10.4.2
"Changing OPP".

Tested on OMAP 4430 SDP.  Built against Kevin's pm-wip/voltdm branch and
compiled with omap2plus_defconfig.

Mike Turquette (6):
  OMAP3630: PRM: add ABB PRM register definitions
  OMAP3+: ABB: Adaptive Body-Bias structures & data
  OMAP3+: OPP: add ABB data to voltage tables
  OMAP3+: Voltage: add ABB data to voltage domains
  OMAP3+: ABB: initialization & transition functions
  OMAP3+: Voltage: add ABB to voltage scaling

Nishanth Menon (2):
  OMAP3+: PM: VP: generalize PRM interrupt helpers
  OMAP3+: PRM: add tranxdone IRQ handlers for ABB

 arch/arm/mach-omap2/Makefile                  |    7 +-
 arch/arm/mach-omap2/abb.c                     |  218 +++++++++++++++++++++++++
 arch/arm/mach-omap2/abb.h                     |   90 ++++++++++
 arch/arm/mach-omap2/abb36xx_data.c            |   38 +++++
 arch/arm/mach-omap2/abb44xx_data.c            |   44 +++++
 arch/arm/mach-omap2/omap_opp_data.h           |    5 +-
 arch/arm/mach-omap2/opp3xxx_data.c            |   37 ++--
 arch/arm/mach-omap2/opp4xxx_data.c            |   25 ++--
 arch/arm/mach-omap2/prm-regbits-34xx.h        |   34 ++++
 arch/arm/mach-omap2/prm2xxx_3xxx.c            |   53 +++++--
 arch/arm/mach-omap2/prm2xxx_3xxx.h            |   14 ++-
 arch/arm/mach-omap2/prm44xx.c                 |   64 +++++--
 arch/arm/mach-omap2/prm44xx.h                 |   10 +-
 arch/arm/mach-omap2/vc.c                      |   10 +-
 arch/arm/mach-omap2/voltage.c                 |    4 +
 arch/arm/mach-omap2/voltage.h                 |    2 +
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    3 +
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    3 +
 arch/arm/mach-omap2/vp.c                      |    9 +-
 arch/arm/mach-omap2/vp.h                      |    9 -
 arch/arm/mach-omap2/vp3xxx_data.c             |    4 +-
 arch/arm/mach-omap2/vp44xx_data.c             |    6 +-
 22 files changed, 598 insertions(+), 91 deletions(-)
 create mode 100644 arch/arm/mach-omap2/abb.c
 create mode 100644 arch/arm/mach-omap2/abb.h
 create mode 100644 arch/arm/mach-omap2/abb36xx_data.c
 create mode 100644 arch/arm/mach-omap2/abb44xx_data.c

-- 
1.7.4.1

