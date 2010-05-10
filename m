From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/5] OMAP4: PRCM: Spring cleanup
Date: Mon, 10 May 2010 22:31:53 +0200
Message-ID: <1273523518-17758-1-git-send-email-b-cousson@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:32990 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab0EJUcB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 May 2010 16:32:01 -0400
Received: from dlep35.itg.ti.com ([157.170.170.118])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4AKW1CV011127
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Mon, 10 May 2010 15:32:01 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Benoit Cousson <b-cousson@ti.com>

Hi,

This series remove a couple of useless or non-functional registers
from the OMAP4430 ES1.0 defines. 
It cleans as well the registers that didn't stick to the PRCM
naming convention and add a couple of new defines for offset.

Comments are welcome.

Regards,
Benoit


Benoit Cousson (3):
  OMAP4: CM: Remove non-functional registers in ES1.0
  OMAP4: PRM: Remove MPU internal code name and apply PRCM naming convention
  OMAP4: PRCM: Remove duplicate definition of base addresses

Rajendra Nayak (2):
  OMAP4: PRCM: Add offset defines for all CM registers
  OMAP4: PRCM: Add offset defines for all PRM registers

 arch/arm/mach-omap2/clockdomains44xx.h     |    4 +-
 arch/arm/mach-omap2/cm44xx.h               |  301 +++++++++++++++++++---
 arch/arm/mach-omap2/powerdomains44xx.h     |   10 +-
 arch/arm/mach-omap2/prcm-common.h          |   18 +-
 arch/arm/mach-omap2/prm.h                  |    4 +-
 arch/arm/mach-omap2/prm44xx.h              |  389 ++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/omap44xx.h |    1 +
 7 files changed, 641 insertions(+), 86 deletions(-)

