From: "Avinash.H.M" <avinashhm@ti.com>
Subject: [PATCH 0/2] OMAP2/3: fix the i2c,gpio reset timeouts during boot.
Date: Fri,  1 Apr 2011 21:04:05 +0530
Message-ID: <1301672047-31903-1-git-send-email-avinashhm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55419 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754282Ab1DAPea (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 1 Apr 2011 11:34:30 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id p31FYQnB026948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 1 Apr 2011 10:34:29 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Avinash.H.M" <avinashhm@ti.com>

Hi ,

The patches solve the reset timeouts seen in i2c and gpio modules while
booting omap2 and omap3.

Baseline:
The patches are based on 
* git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
* master branch.
* v2.6.39-rc1 commit (0ce790e)

Testing:
* build tested omap2plus_defconfig for warnings and errors. none introduced.
* boot tested on 2430. 
* tested for 'core off' in suspend resume on 3430 sdp. core off counters
  increment after suspend resume. Core off works with below commands,

echo 1 > /debug/pm_debug/enable_off_mode
echo mem > /sys/power/state
cat /debug/pm_debug/count | grep ^core

Dependencies:
* need patch "OMAP2+: hwmod data: Set hwmod flags to only allow 16-bit
  accesses to i2c" from Andry Green for accessing i2c_sysc. Without this even
  with this patch, we will see i2c reset timeouts.

br ,
- Avinash

Avinash.H.M (2):
  OMAP2/3: hwmod: fix the i2c-reset timeout during bootup
  OMAP2/3: hwmod: fix gpio-reset timeouts seen during bootup.

 arch/arm/mach-omap2/omap_hwmod.c             |   59 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/omap_hwmod_2420_data.c   |    5 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c   |    6 +++
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    7 +++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 +
 5 files changed, 79 insertions(+), 0 deletions(-)

