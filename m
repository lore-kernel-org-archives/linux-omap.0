From: Rajendra Nayak <rnayak@ti.com>
Subject: [RFC][PATCH 0/2] Fix prm/cm accessor api's usage on OMAP4
Date: Tue, 10 Aug 2010 20:32:54 +0530
Message-ID: <1281452576-5705-1-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57619 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932129Ab0HJPDG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Aug 2010 11:03:06 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, Rajendra Nayak <rnayak@ti.com>

Hi,

This RFC patch series fixes the prm and cm accessor api usage which is
broken today on OMAP4.

OMAP's have always had PRCM split into PRM for power and reset
management and CM for clock management.
In OMAP4 the split (physically) is not very straight forward and
there are instances of clock management control registers in PRM
and vice versa.
However it still makes sense, even on OMAP4 to logically split
PRCM into PRM and CM for better understanding and to avoid adding
additonal complexity in higher level frameworks which rely on the
accessor api;s to do the low level register accesses. 

Hence this patch series makes sure that any clock management code can
use the cm_read/write* accessor apis (without knowing the physical split)
and power and reset management code can use prm_read/write*
accessor api;s.

regards,
Rajendra

Rajendra Nayak (2):
  OMAP4: PRCM: Add prcm_mpu_base to omap_globals
  OMAP4: PRCM: Fix usage of prm/cm accessor api's for OMAP4

 arch/arm/mach-omap2/cm.h                 |    4 +-
 arch/arm/mach-omap2/prcm-common.h        |   58 +++++++++++++++---------
 arch/arm/mach-omap2/prcm.c               |   73 ++++++++++++++++++++++++++++--
 arch/arm/mach-omap2/prm.h                |    4 +-
 arch/arm/plat-omap/common.c              |    1 +
 arch/arm/plat-omap/include/plat/common.h |    1 +
 6 files changed, 112 insertions(+), 29 deletions(-)

