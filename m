From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH v2 0/6] Basic OMAP4 PRCM register def series
Date: Wed, 12 Aug 2009 19:56:51 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0306050620@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45747 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752910AbZHLO1N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 Aug 2009 10:27:13 -0400
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

v2 of the patchset with the following comments fixed.

-1- CM1 base address fixed which was wrongly populated based on the TRM, as pointed
out by Paul Walmsley

-2- Submodule names within PRM/CM1/CM2  are named to include PRM/CM1/CM2 in the
module names to avoid any confusion as commented by Paul W. 

Hi,

This series contains patches which define OMAP4430 PRM/CM1/CM2 module register offsets
and masks.

This series applies on top of v2.6.31-rc5.

Rajendra Nayak (6):
      ARM: OMAP4: PM: Fix the PRM and CM base addresses
      ARM: OMAP4: PM: PRM/CM module offsets for OMAP4
      ARM: OMAP4: PM: Adds PRM register defs for OMAP4
      ARM: OMAP4: PM: Adds PRM register shift and mask bits
      ARM: OMAP4: PM: Adds CM1/2 register defs for OMAP4
      ARM: OMAP4: PM: Adds CM1/2 register field masks

 arch/arm/mach-omap2/cm.h                   |  249 +++++++-
 arch/arm/mach-omap2/cm1-regbits-44xx.h     |  315 ++++++++
 arch/arm/mach-omap2/cm2-regbits-44xx.h     |  541 ++++++++++++++
 arch/arm/mach-omap2/prcm-common.h          |   28 +
 arch/arm/mach-omap2/prcm.c                 |    2 +
 arch/arm/mach-omap2/prm-regbits-44xx.h     | 1063 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm.h                  |  295 ++++++++-
 arch/arm/plat-omap/common.c                |    2 +
 arch/arm/plat-omap/include/mach/common.h   |    1 +
 arch/arm/plat-omap/include/mach/omap44xx.h |    6 +-
 10 files changed, 2497 insertions(+), 5 deletions(-)

regards,
Rajendra
