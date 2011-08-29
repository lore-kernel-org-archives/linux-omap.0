From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 00/10] OMAP: voltage cleanup part B: VC cleanup
Date: Mon, 29 Aug 2011 10:49:42 -0700
Message-ID: <1314640192-2518-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:34923 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753643Ab1H2RtZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 13:49:25 -0400
Received: by mail-gw0-f53.google.com with SMTP id 20so7017690gwj.40
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 10:49:25 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

This series focuses on cleanup and better abstraction in the voltage
controller (VC) layer.

Available in the pm-wip/voltdm_b branch of my linux-omap-pm tree
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git

Applies on v3.1-rc3 + the part A series (pm-wip/voltdm_a branch)

Kevin



Kevin Hilman (10):
  OMAP3+: VC: cleanup i2c slave address configuration
  OMAP3+: VC: cleanup PMIC register address configuration
  OMAP3+: VC bypass: use fields from VC struct instead of PMIC info
  OMAP3+: VC: cleanup voltage setup time configuration
  OMAP3+: VC: move on/onlp/ret/off command configuration into common
    init
  OMAP3+: VC: abstract out channel configuration
  OMAP3+: voltage domain: move PMIC struct from vdd_info into struct
    voltagedomain
  OMAP3+: VC: make I2C config programmable with PMIC-specific settings
  OMAP3+: PM: VC: handle mutant channel config for OMAP4 MPU channel
  OMAP3+: VC: use last nominal voltage setting to get current_vsel

 arch/arm/mach-omap2/omap_twl.c                |   32 ++--
 arch/arm/mach-omap2/vc.c                      |  248 ++++++++++++++++++-------
 arch/arm/mach-omap2/vc.h                      |   35 +++-
 arch/arm/mach-omap2/vc3xxx_data.c             |   13 +-
 arch/arm/mach-omap2/vc44xx_data.c             |   18 ++-
 arch/arm/mach-omap2/voltage.c                 |   29 ++--
 arch/arm/mach-omap2/voltage.h                 |   29 ++--
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |    8 +-
 arch/arm/mach-omap2/voltagedomains44xx_data.c |   12 +-
 arch/arm/mach-omap2/vp.c                      |   13 +-
 10 files changed, 293 insertions(+), 144 deletions(-)

-- 
1.7.6

