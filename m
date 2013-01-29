From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH v2 0/9] ARM: OMAP2+: AM33XX: Misc fixes/updates
Date: Tue, 29 Jan 2013 12:29:13 +0530
Message-ID: <1359442762-13697-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53224 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750947Ab3A2G7q (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 29 Jan 2013 01:59:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

Hi,

The following patches were earlier posted as part the AM33XX
suspend-resume support series [1]. Based on the suggestion
from Santosh Shilimkar <santosh.shilimkar@ti.com> i have split
out the changes which update the various data files related
to AM33XX support. This version addresses the comments
received from Sergei Shtylyov and Peter Korsgaard on the earlier
patchset [2].

These patches apply on top of v3.8-rc5

Regards,
Vaibhav

[1] http://marc.info/?l=linux-arm-kernel&m=135698501821074&w=2
[2] http://marc.info/?l=linux-omap&m=135849360005657&w=2

Vaibhav Bedia (9):
  ARM: OMAP2+: AM33XX: CM: Get rid of unnecessary header inclusions
  ARM: OMAP2+: AM33XX: CM/PRM: Use __ASSEMBLER__ macros in header files
  ARM: OMAP2+: AM33XX: hwmod: Register OCMC RAM hwmod
  ARM: OMAP2+: AM33XX: hwmod: Update TPTC0 hwmod with the right flags
  ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod entry
  ARM: OMAP2+: AM33XX: hwmod: Update the WKUP-M3 hwmod with reset status
    bit
  ARM: OMAP2+: AM33XX: Update the hardreset API
  ARM: DTS: AM33XX: Add nodes for OCMC RAM and WKUP-M3
  ARM: OMAP2+: AM33XX: control: Add some control module registers and
    APIs

 arch/arm/boot/dts/am33xx.dtsi              | 14 +++++++++
 arch/arm/mach-omap2/cm33xx.h               |  9 ++----
 arch/arm/mach-omap2/control.c              | 20 ++++++++++++
 arch/arm/mach-omap2/control.h              | 41 ++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod.c           |  5 +--
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c | 50 +++++++++++++++++-------------
 arch/arm/mach-omap2/prm33xx.c              | 11 ++++---
 arch/arm/mach-omap2/prm33xx.h              |  4 ++-
 8 files changed, 118 insertions(+), 36 deletions(-)

-- 
1.8.1

