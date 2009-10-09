From: Sanjeev Premi <premi@ti.com>
Subject: [PATCHv2 0/1] Runtime detection of OMAP35x variants
Date: Sat, 10 Oct 2009 01:17:02 +0530
Message-ID: <1255117622-28054-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:58122 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760300AbZJITrn (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 9 Oct 2009 15:47:43 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n99Jl4Nl016423
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Oct 2009 14:47:06 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This patch allows run-time detection of different
variants in the OMAP35x family.

  [1] http://marc.info/?l=linux-omap&m=125387617812499&w=2
  
This patch was been created against omap3-upstream at:
  21f1a8f : omap: Include bitops from cpu.h

The testing was done on OMAP3EVM boards with these silicon
revisions - ES2.0, ES2.1, ES3.0 and ES3.1.

Correctness against ES1.0 and a variant of ES2.0 was verified
by 'simulation' described in the test summary below:

1) ES 3.1

   Value of IDCODE register in u-boot:
        OMAP3_EVM # md 4830a204 4
        4830a204: 4b7ae02f 00000000 00000008 000000f0    /.zK............
                 ^^^
   Print during boot-up:
        ...
        Memory policy: ECC disabled, Data cache writeback
        OMAP3430/3530 ES3.1
        ...

2) ES 3.0

   Value of IDCODE register in u-boot:
        OMAP3_EVM # md 4830a204 4
        4830a204: 3b7ae02f 00000000 00000000 000000f0    /.z;............
                 ^^^
   Print during boot-up:
        ...
        Memory policy: ECC disabled, Data cache writeback
        OMAP3430/3530 ES3.0
        ...

3) ES 2.1

   Value of IDCODE register in u-boot:
        OMAP3_EVM # md 4830a204 4
        4830a204: 2b7ae02f 00000000 00000000 000000f0    /.z+............
                 ^^^
   Print during boot-up:
        ...
        Memory policy: ECC disabled, Data cache writeback
        OMAP3430/3530 ES2.1
        ...

4) ES 2.0 (simulated)

   The code correctness was verified by 'simulating' an ES 1.0 device
   as shown in the diff below:
     -  idcode = read_tap_reg(OMAP_TAP_IDCODE);
     +  idcode = (u32)0x1b7ae02f;
        hawkeye = (idcode >> 12) & 0xffff;

   Print during boot-up:
        ...
        Memory policy: ECC disabled, Data cache writeback
        OMAP3430/3530 ES2.0
        ...

5) ES 2.0

   Value of IDCODE register in u-boot:
        OMAP3_EVM # md 4830a204 4
        4830a204: 0b7ae02f 00000000 00000000 000000f0    /.z.............
                 ^^^
   Print during boot-up:
        ...
        Memory policy: ECC disabled, Data cache writeback
        OMAP3430/3530 ES2.0
        ...

6) ES 1.0 (simulated)

   The code correctness was verified by 'simulating' an ES 1.0 device
   as shown in the diff below:

        cpuid = read_cpuid(CPUID_ID);
        if ((((cpuid >> 4) & 0xfff) == 0xc08) && ((cpuid & 0xf) == 0x0)) {
                omap_revision = OMAP3430_REV_ES1_0;
                return;
        }
     +  omap_revision = OMAP3430_REV_ES1_0;
     +  return;

   Print during boot-up:
        ...
        Memory policy: ECC disabled, Data cache writeback
        OMAP3430/3530 ES1.0
        ...

Sanjeev Premi (1):
  Runtime detection of OMAP35x devices

 arch/arm/mach-omap2/id.c              |   65 +++++++++++++++++++++++++++------
 arch/arm/plat-omap/include/mach/cpu.h |   37 +++++++++++++++++++
 2 files changed, 91 insertions(+), 11 deletions(-)

