From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/6] OMAP3&4: clock data: Fixes and add new clocks nodes
Date: Thu, 2 Dec 2010 11:44:47 +0100
Message-ID: <1291286693-32538-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:53342 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751517Ab0LBKpu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 2 Dec 2010 05:45:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here is a collections of fixes and clock nodes addition done on OMAP3 and OMAP4
clock data files.

I have included the one that Thara already submitted after fixing the various
comments done on the original revision.

The series is based on 2.6.37-rc4 and is available here:
git://gitorious.org/omap-pm/linux.git for_2.6.38/clock

Regards,
Benoit


Benoit Cousson (2):
  OMAP4: clock data: Add control for pad_clks_ck and slimbus_clk
  OMAP3: clock data: Add "wkup_clkdm" in sr1_fck and sr2_fck

Jonathan Bergsagel (1):
  OMAP4: clock data: Add missing fields in iva_hsd_byp_clk_mux_ck

Rajendra Nayak (2):
  OMAP4: clock data: Add SCRM auxiliary clock nodes
  OMAP4: clock data: Export control to enable/disable CORE/PER M3
    clocks

Thara Gopinath (1):
  OMAP4: clock data: Add missing DPLL x2 clock nodes

 arch/arm/mach-omap2/clock3xxx_data.c |    2 +
 arch/arm/mach-omap2/clock44xx_data.c |  620 ++++++++++++++++++++++++----------
 arch/arm/mach-omap2/scrm_44xx.h      |  148 ++++++++
 3 files changed, 590 insertions(+), 180 deletions(-)
 create mode 100644 arch/arm/mach-omap2/scrm_44xx.h

