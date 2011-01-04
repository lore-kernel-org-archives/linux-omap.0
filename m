From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 0/5] omap2plus: Trivial build break fixes
Date: Tue,  4 Jan 2011 23:56:11 +0530
Message-ID: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34888 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab1ADS0m (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Jan 2011 13:26:42 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@ti.com, tony@atomide.com, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

These are trivial build fixes which I found while doing some 
testing 'omap-for-linus' branch.

The series is generated against the linux-omap 'omap-for-linus' branch
and boot tested on OMAP4430 SDP and OMAP3630 ZOOM.


The following changes since commit dc69d1af9e8d9cbbabff88bb35a6782187a22229:
  Ben Gamari (1):
        omap2: Make OMAP2PLUS select OMAP_DM_TIMER


Santosh Shilimkar (5):
      omap2plus: clockdomain: Trivial fix for build break because of clktrctrl_mask
      omap2plus: prm: Trvial build break fix for undefined reference to 'omap2_prm_read_mod_reg'
      omap2plus: voltage: Trivial warning fix 'no return statement'
      omap2plus: voltage: Trivial linking fix 'undefined reference'
      omap2plus: voltage: Trivial linking fix for 'EINVAL' undeclared

 arch/arm/mach-omap2/Makefile              |    2 +-
 arch/arm/mach-omap2/clockdomain.h         |    2 +-
 arch/arm/mach-omap2/prm2xxx_3xxx.h        |   45 ++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/voltage.h |   17 ++++++++--
 4 files changed, 59 insertions(+), 7 deletions(-)


