From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH 0/2] omap2+: voltage: simple clean-ups
Date: Thu, 17 Mar 2011 20:42:35 +0530
Message-ID: <1300374757-23010-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34668 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426Ab1CQPMp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Mar 2011 11:12:45 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p2HFCgYU017029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 17 Mar 2011 10:12:44 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

This set contains simple clean-up changes.

There is a TODO in the patchset where i would need 
specific comments - whether my understanding is
right or not.

In expectation of an eminent new patch revision,
these changes have only been compiled against
omap2plus_defconfig.

BTW, I don't have OMAP4 board with me. Any test,
if necessary, would be useful.

Sanjeev Premi (2):
  omap3: voltage: remove unnecessary param passing
  omap3: voltage: fix variable type and name

 arch/arm/mach-omap2/voltage.c                 |   32 ++++++++++++++++--------
 arch/arm/mach-omap2/voltage.h                 |    3 +-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    5 +---
 arch/arm/mach-omap2/voltagedomains44xx_data.c |    6 +----
 4 files changed, 24 insertions(+), 22 deletions(-)

-- 
1.7.2.2

