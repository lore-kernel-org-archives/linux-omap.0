From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 0/4] OMAP2/3: clock/clockdomains: miscellaneous fixes
Date: Fri, 25 Feb 2011 17:20:01 -0700
Message-ID: <20110226001601.28142.46636.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46812 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565Ab1BZAUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Feb 2011 19:20:49 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello,

here are a few miscellaneous OMAP2 clock and clockdomain
data for 2.6.39.

Boot-tested on N800.  Compile-tested for omap2plus_defconfig and
omap3_defconfig.

This series is available via git in the branch 'clk_clkdm_a_2.6.39' of
git://git.pwsan.com/linux-2.6.


- Paul

---

clk_clkdm_a_2.6.39
   text	   data	    bss	    dec	    hex	filename
3701835	 230192	5390012	9322039	 8e3e37	vmlinux.n800_config.orig
3701803	 230064	5390012	9321879	 8e3d97	vmlinux.n800_config

Paul Walmsley (4):
      OMAP2xxx: clock: remove dsp_irate_ick
      OMAP2/3: clockdomains: remove warnings on an OMAP3-only compile
      OMAP2xxx: clock: fix clockdomains on gpt7_ick, 2430 mmchs2_fck clocks
      OMAP2xxx: clock data: clean up some comments


 arch/arm/mach-omap2/clock.h                      |    1 
 arch/arm/mach-omap2/clock2420_data.c             |   55 +++++++--------------
 arch/arm/mach-omap2/clock2430_data.c             |   58 ++++++++--------------
 arch/arm/mach-omap2/clock_common_data.c          |    6 ++
 arch/arm/mach-omap2/clockdomains2xxx_3xxx_data.c |    4 ++
 5 files changed, 51 insertions(+), 73 deletions(-)

