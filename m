From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 00/10] OMAP: HWMOD fixes and cleanup
Date: Fri,  7 May 2010 17:44:05 +0200
Message-ID: <1273247055-15165-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54192 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab0EGPoS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 May 2010 11:44:18 -0400
Received: from dlep33.itg.ti.com ([157.170.170.112])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o47FiIP7022568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 7 May 2010 10:44:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>

Hi,

Here is the serie based on l-o master that prepare the OMAP4 HWMOD database
introduction.

It was only tested on OMAP4 GP device for the moment using PAB board.

Comments are welcome.

Thanks,
Benoit


Benoit Cousson (10):
  OMAP4: hwmod: Replace module & device offsets by absolute clkctrl address
  OMAP: CM: Move MAX_MODULE_READY_TIME to cm.h
  OMAP4: hwmod & CM: Implement the omap4_cm_wait_module_ready function
  OMAP4: hwmod: Replace OCPIF_HAS_IDLEST by HWMOD_NO_IDLEST
  OMAP: hwmod: Fix wrong pointer iteration in oh->slaves
  OMAP: hwmod: Remove IS_ERR check with omap_clk_get_by_name return value
  OMAP: hwmod: Replace WARN by pr_warning if clock lookup failed
  OMAP: hwmod: Do not exit the iteration if one clock init failed
  OMAP: hwmod: Rename hwmod name for the MPU
  OMAP: hwmod: Replace WARN by pr_warning for clockdomain check

 arch/arm/mach-omap2/cm.c                     |    3 -
 arch/arm/mach-omap2/cm.h                     |   11 +++-
 arch/arm/mach-omap2/cm4xxx.c                 |   54 +++++++------
 arch/arm/mach-omap2/omap_hwmod.c             |  111 ++++++++++++++------------
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    2 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    2 +-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |   16 ++--
 8 files changed, 111 insertions(+), 90 deletions(-)

