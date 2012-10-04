From: Mike Turquette <mturquette@ti.com>
Subject: [RFC][PATCH v4? 0/7] Adaptive Body-Bias for OMAP
Date: Wed, 3 Oct 2012 18:26:07 -0700
Message-ID: <1349313974-5473-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36965 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754093Ab2JDB0g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Oct 2012 21:26:36 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

From: Mike Turquette <mturquette@linaro.org>

Adaptive Body-Bias ldos are present for some voltage domains starting
with OMAP3630.  They have three modes of operation:

 * Bypass - the default, it just follows the vdd voltage
 * Foward Body-Bias - applies voltage bias to increase transistor
   performance at the cost of power.  Used to operate safely at high
   OPPs
 * Reverse Body-Bias - applies voltage bias to decrease leakage and save
   power.  Used to save power at lower OPPs

This series adds the ABB code and per-voltage domain data for OMAP3630
and OMAP4430.  Newer OMAP4 chips and OMAP5 will need this data populated
once those platforms have OPP and voltage tables.  The voltage domain
scaling sequence is modified use these new functions.

This series build on top my previous series, "Introduce .get_voltage
callback into voltdm"[1].  While not strictly necessary that series does
take some steps to eliminate one combination of ABB and VP/VC modes that
is out-of-spec.

[1] http://marc.info/?l=linux-omap&m=134931341818379&w=2

Mike Turquette (7):
  ARM: omap: add 3630 PRM register definitions
  ARM: omap: add ABB PRM_IRQSTATUS handlers
  ARM: omap: Adaptive Body-Bias structures & data
  ARM: omap: opp: add ABB data to voltage tables
  ARM: omap: voltage: per-voltage domain ABB data
  ARM: omap: abb: init & transition functions
  ARM: omap: voltage: add ABB to voltage scaling

 arch/arm/mach-omap2/Makefile                  |    8 +-
 arch/arm/mach-omap2/abb.c                     |  322 +++++++++++++++++++++++++
 arch/arm/mach-omap2/abb.h                     |   94 ++++++++
 arch/arm/mach-omap2/abb36xx_data.c            |   39 +++
 arch/arm/mach-omap2/abb44xx_data.c            |   45 ++++
 arch/arm/mach-omap2/omap_opp_data.h           |    5 +-
 arch/arm/mach-omap2/opp3xxx_data.c            |   37 +--
 arch/arm/mach-omap2/opp4xxx_data.c            |   25 +-
 arch/arm/mach-omap2/prm-regbits-34xx.h        |   34 +++
 arch/arm/mach-omap2/prm2xxx_3xxx.c            |   36 +++
 arch/arm/mach-omap2/prm2xxx_3xxx.h            |    8 +
 arch/arm/mach-omap2/prm44xx.c                 |   44 ++++
 arch/arm/mach-omap2/prm44xx.h                 |    4 +
 arch/arm/mach-omap2/voltage.c                 |   28 ++-
 arch/arm/mach-omap2/voltage.h                 |    1 +
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    2 +
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    3 +
 arch/arm/plat-omap/include/plat/voltage.h     |    1 +
 18 files changed, 699 insertions(+), 37 deletions(-)
 create mode 100644 arch/arm/mach-omap2/abb.c
 create mode 100644 arch/arm/mach-omap2/abb.h
 create mode 100644 arch/arm/mach-omap2/abb36xx_data.c
 create mode 100644 arch/arm/mach-omap2/abb44xx_data.c

-- 
1.7.9.5

