From: Laine Walker-Avina <lwalkera@ieee.org>
Subject: [PATCH 0/5] Initial change for merge of new board
Date: Tue,  6 Apr 2010 09:51:03 -0700
Message-ID: <1270572668-2336-1-git-send-email-lwalkera@ieee.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from exprod7og120.obsmtp.com ([64.18.2.18]:56270 "HELO
	exprod7og120.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757084Ab0DFRBw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Apr 2010 13:01:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Laine Walker-Avina <lwalkera@ieee.org>

Hi all,

I'm beginning to merge some of the changes for my new board. These include:
   * Adding macros to compute the ACTIM values for the SDRAM timings, eliminating magic numbers. The original authors may want to verify their timings were converted correctly.
   * Adding the ability to use the clock API to select the divider for sys_clkout2
   * Making the GPRC timing API aware of the time-granularity flag

Let me know if there are any comments or questions.

Cheers,
Laine Walker-Avina
PASCO scientific

----

Laine Walker-Avina (5):
  OMAP: Add in helper macros for the SDRAM timings
  OMAP: Convert the sdram-*.h timings to use the SDRAM timing macros
  OMAP: Add SDRAM timings for Micron mt46h16m32lf-6
  OMAP: Add support for setting the divider for sys_clkout2 using
    clk_set_rate
  OMAP: Make set_gpmc_timing_reg aware of the TIMEPARAGRANULARITY flag

 arch/arm/mach-omap2/clock3xxx_data.c               |    1 +
 arch/arm/mach-omap2/gpmc.c                         |   14 +++-
 arch/arm/mach-omap2/sdram-hynix-h8mbx00u0mer-0em.h |   44 ++++++++-----
 arch/arm/mach-omap2/sdram-micron-mt46h16m32lf-6.h  |   67 ++++++++++++++++++++
 arch/arm/mach-omap2/sdram-micron-mt46h32m32lf-6.h  |   44 ++++++++-----
 arch/arm/mach-omap2/sdram-numonyx-m65kxxxxam.h     |   52 +++++++++------
 .../mach-omap2/sdram-qimonda-hyb18m512160af-6.h    |   50 +++++++++------
 arch/arm/plat-omap/include/plat/sdrc.h             |   23 +++++++
 8 files changed, 220 insertions(+), 75 deletions(-)
 create mode 100644 arch/arm/mach-omap2/sdram-micron-mt46h16m32lf-6.h

