From: Shweta Gulati <shweta.gulati@ti.com>
Subject: [PATCH 0/3]: Update OPP Table and Voltage Rail Values
Date: Wed, 16 Feb 2011 11:46:35 +0530
Message-ID: <1297836995-8747-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41554 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752311Ab1BPGQl (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 01:16:41 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p1G6Gc9Z008384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:16:40 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Shweta Gulati <shweta.gulati@ti.com>

The series mainly does below:

OMAP4 only
       - Update MPU VOltage rail values for all OPPs
       - Enable OPP-Nitro and OPP-Turbo for all boards
OMAP2PLUS
       -Replace hardcoded Voltage values in OPP Table
        with Voltage Macros.

Baseline:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
Branch: pm

Tested on OMAP4430 SDP, OMAP3630 SDP and OMAP3430 SDP.

Shweta Gulati (2):
  OMAP4: Revise MPU Voltage rail values.
  OMAP4: Enable Turbo and Nitro OPP for OMAP4

Vishwanath BS (1):
  OMAP2+: Replace Voltage values with Macros.

 arch/arm/mach-omap2/opp3xxx_data.c        |   47 +++++++++++++++--------------
 arch/arm/mach-omap2/opp4xxx_data.c        |   13 ++++----
 arch/arm/plat-omap/include/plat/voltage.h |    8 ++--
 3 files changed, 35 insertions(+), 33 deletions(-)

