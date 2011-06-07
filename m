From: Nishanth Menon <nm@ti.com>
Subject: [pm-wip/voltdm_nm][PATCH 00/10] OMAP2+: voltage: fixes
Date: Mon,  6 Jun 2011 21:16:03 -0500
Message-ID: <1307412972-25854-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:36611 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754406Ab1FGCQQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Jun 2011 22:16:16 -0400
Received: by mail-gw0-f46.google.com with SMTP id a18so1613115gwa.19
        for <linux-omap@vger.kernel.org>; Mon, 06 Jun 2011 19:16:13 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap <linux-omap@vger.kernel.org>
Cc: kevin <khilman@ti.com>, Nishanth Menon <nm@ti.com>

Bunch of fixes for VC, VP incorporating previous comments
merges two series of PMIC and voltage cleanups I send previously.

Applies on:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
voltdm_nm     3c217ab OMAP3+: PM: VC: handle mutant channel config for OMAP4 MPU channel

Original series:
http://marc.info/?l=linux-omap&m=130671118605896&w=2
http://marc.info/?l=linux-omap&m=130682723914928&w=2

Nishanth Menon (10):
  OMAP3+: VC: fix mutant channel handling
  OMAP4: PM: VC: allow channels use of default channel i2c_slaveaddr
  OMAP4: PM: VC: allow channels to use cmdra reg
  OMAP4: PM: VC: allow channels use of default channel volt_reg_addr
  OMAP4: PM: VC: allow channels use of default channel cmd_reg_addr
  OMAP3+: PM: VC: support configuring PMIC over I2C_SR
  OMAP3+: PM: VP: use uV for max and min voltage limits
  OMAP3+: PM: introduce a central pmic control
  OMAP2+: PM: secure OPP access using rcu locks
  OMAP2+: PM: init_voltages: handle non compliant bootloaders

 arch/arm/mach-omap2/Makefile    |    2 +-
 arch/arm/mach-omap2/omap_pmic.c |   74 +++++++++++++++++++++
 arch/arm/mach-omap2/omap_twl.c  |  103 ++++++++++++++----------------
 arch/arm/mach-omap2/pm.c        |   61 ++++++++++++++----
 arch/arm/mach-omap2/pm.h        |   35 +++++++++--
 arch/arm/mach-omap2/vc.c        |  134 ++++++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/vc.h        |    8 ++-
 arch/arm/mach-omap2/voltage.h   |   37 +++++++++--
 arch/arm/mach-omap2/vp.c        |    4 +-
 9 files changed, 351 insertions(+), 107 deletions(-)
 create mode 100644 arch/arm/mach-omap2/omap_pmic.c

 Regards,
 Nishanth Menon
