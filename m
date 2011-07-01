From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 0/5] OMAP4: PM HW bugs & PRCM fixes
Date: Fri, 1 Jul 2011 22:27:35 +0200
Message-ID: <1309552060-4547-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56848 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752817Ab1GAU1u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Jul 2011 16:27:50 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, rnayak@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul & Rajendra,

Here are a couple of fixes on PRCM header files and powerdomain data.
There are as well 2 HW bugs fixes from Santosh.

The series is based on v3.0-rc5 and tested on OMAP4430 ES2.1 + SDP.

The patches are available here:
git://gitorious.org/omap-pm/linux.git for_3.1/1_prcm_files_fixes

Regards,
Benoit


Changes since v1:
	- Add 2 HW bugs fixes


Benoit Cousson (3):
  OMAP4: prcm: Fix errors in few defines name
  OMAP4: prm: Remove wrong clockdomain offsets
  OMAP4: powerdomain data: Fix core mem states and missing cefuse flag

Santosh Shilimkar (2):
  OMAP4: clock data: Keep GPMC clocks always enabled and hardware managed
  OMAP4: powerdomain data: Remove unsupported MPU powerdomain state

 arch/arm/mach-omap2/clock44xx_data.c        |    1 +
 arch/arm/mach-omap2/cm1_44xx.h              |   28 +++++++++++-----------
 arch/arm/mach-omap2/cm2_44xx.h              |   23 ++++++++---------
 arch/arm/mach-omap2/powerdomains44xx_data.c |   27 +++++++++++----------
 arch/arm/mach-omap2/prm44xx.h               |   34 ++++++++------------------
 5 files changed, 51 insertions(+), 62 deletions(-)

