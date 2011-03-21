From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC 0/3] OMAP3: Support processor group selection by a peripheral
Date: Mon, 21 Mar 2011 16:40:20 +0530
Message-ID: <1300705823-12784-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46313 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab1CULKc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 21 Mar 2011 07:10:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

OMAP3 has PM_<processor_name>GRPSEL_<domain_name> registers
which can be programmed to allow a peripheral to choose a
processor group which it expects to wake up.
This RFC series is an attempt to provide omap_device layer
api's for drivers to be able to do this instead of direct
PRCM accesses within drivers which is the case today.

Something similar exists on OMAP4, in the form of
wakeup dependencies, which are not addressed in this
series for now.

Rajendra Nayak (3):
  OMAP3: PRM: Add grpsel programming support
  OMAP3: hwmod: Add support to associate an initiator with a hwmod
  OMAP3: omap_device: Add support to associate a device with an
    initiator

 arch/arm/mach-omap2/omap_hwmod.c             |   33 ++++++++++++
 arch/arm/mach-omap2/prcm-common.h            |    1 -
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |   70 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |    4 ++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    9 +++
 arch/arm/plat-omap/omap_device.c             |   54 ++++++++++++++++++++
 6 files changed, 170 insertions(+), 1 deletions(-)

