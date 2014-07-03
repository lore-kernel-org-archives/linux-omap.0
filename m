From: Tero Kristo <t-kristo@ti.com>
Subject: [GIT PULL] ARM: OMAP2: clock data migration to DT for 3.17 merge
 window
Date: Thu, 3 Jul 2014 21:18:27 +0300
Message-ID: <53B59E73.1020709@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39758 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838AbaGCSRx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Jul 2014 14:17:53 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "tony@atomide.com" <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Mike Turquette <mturquette@linaro.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, aaro.koskinen@iki.fi

Hi Tony,

Posting this pull-request also early due to my holidays. Anyway, these 
patches were supposed to go in already during 3.16 merge window, but 
they missed it due to pending dependencies. Finalizes the move of 
OMAP24xx clock data to the DT, and also removes the legacy clock data. 
Might be good to try this branch out with n800 / 2420 hardware also as I 
don't have access to those.

---------------------------------------------------------------

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

   Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

   git@github.com:t-kristo/linux-pm.git for-v3.17/omap2-use-dt-clks

for you to fetch changes up to 6a194a6e2a8fa55e133936a124ed500aea434116:

   ARM: OMAP24xx: clock: remove legacy clock data (2014-07-02 15:59:03 
+0300)

----------------------------------------------------------------
Tero Kristo (5):
       ARM: OMAP2: convert sys_ck and osc_ck to standard clock types
       ARM: OMAP2420: clock: get rid of fixed-div property use
       ARM: OMAP2: PRM: add support for OMAP2 specific clock providers
       ARM: OMAP2: clock: use DT clock boot if available
       ARM: OMAP24xx: clock: remove legacy clock data

  .../devicetree/bindings/arm/omap/prcm.txt          |   65 +
  arch/arm/boot/dts/omap2420.dtsi                    |    3 +
  arch/arm/boot/dts/omap2430.dtsi                    |    3 +
  arch/arm/mach-omap2/Makefile                       |    6 +-
  arch/arm/mach-omap2/cclock2420_data.c              | 1931 
------------------
  arch/arm/mach-omap2/cclock2430_data.c              | 2048 
--------------------
  arch/arm/mach-omap2/clkt2xxx_osc.c                 |   69 -
  arch/arm/mach-omap2/clkt2xxx_sys.c                 |   47 -
  arch/arm/mach-omap2/clock.c                        |   21 -
  arch/arm/mach-omap2/clock.h                        |    3 -
  arch/arm/mach-omap2/clock2xxx.h                    |    2 -
  arch/arm/mach-omap2/cm-regbits-24xx.h              |    1 +
  arch/arm/mach-omap2/io.c                           |    7 +-
  arch/arm/mach-omap2/pm24xx.c                       |    4 +
  arch/arm/mach-omap2/prm_common.c                   |    2 +
  15 files changed, 85 insertions(+), 4127 deletions(-)
  create mode 100644 Documentation/devicetree/bindings/arm/omap/prcm.txt
  delete mode 100644 arch/arm/mach-omap2/cclock2420_data.c
  delete mode 100644 arch/arm/mach-omap2/cclock2430_data.c
  delete mode 100644 arch/arm/mach-omap2/clkt2xxx_osc.c
  delete mode 100644 arch/arm/mach-omap2/clkt2xxx_sys.c
