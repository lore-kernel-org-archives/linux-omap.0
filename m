From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH-V2 0/3] arm:omap:omap4:Remove hardcoded reg-offs for PWRSTCTRL & PWRSTST
Date: Sun, 8 Jan 2012 15:48:11 +0530
Message-ID: <1326017894-7632-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59036 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab2AHKSY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 8 Jan 2012 05:18:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, Vaibhav Hiremath <hvaibhav@ti.com>

This patch series removes the existing hard-coded way of providing
offset to omap4_prminst_xxx API's and instead use offsets
provided in powerdomainsxxxx_data.
Also, hook up AM33XX device support to existing omap4 PRM code.

Background:
==========
PRM module in AM33XX is closer to OMAP4 PRM module, so it complete
sense to reuse all the code from existing OMAP4 implementation.
Having said that, ther is a catch here with respect to AM33XX device,

The register offset in PRM module is not consistent
across (crazy IP integration), for example,

PRM_XXX         PWRSTCTRL PWRSTST RSTCTRL RSTST
===============================================
PRM_PER_MOD:    0x0C,     0x08,   0x00,   0x04
PRM_WKUP_MOD:   0x04,     0x08,   0x00,   0x0C
PRM_MPU_MOD:    0x00,     0x04,   0x08,   NA
PRM_DEVICE_MOD: NA,       NA,     0x00,   0x08

So in order to reuse the existing OMAP4 code, we have to add
seperate entry for register offsets, especially
PWRSTCTRL & PWRSTST.

This patch series is dependent on recently submitted
voltage and powerdomain data patch for AM33xx device -

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg60719.html

Changes from V1:
	- As per Kevin's comment, patch is split into logical
	  commits for ease of review.
	- Added specific comment for cpu_is_xxx check order change.


Vaibhav Hiremath (3):
  arm:omap:omap4: Remove hardcoded reg-offs for PWRSTCTRL & PWRSTST
  arm:omap:omap4: Maintain virtual addr in in _prm_bases table
  arm:omap:omap4: Hook-up am33xx support to existing prm code

 arch/arm/mach-omap2/omap_hwmod.c            |   44 +++++++++++++++++++--------
 arch/arm/mach-omap2/powerdomain.h           |    4 ++
 arch/arm/mach-omap2/powerdomain44xx.c       |   24 +++++++-------
 arch/arm/mach-omap2/powerdomains44xx_data.c |    8 +++++
 arch/arm/mach-omap2/prcm44xx.h              |    4 ++-
 arch/arm/mach-omap2/prminst44xx.c           |   11 ++++---
 6 files changed, 64 insertions(+), 31 deletions(-)

