From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 00/11] OMAP4: Fixes for voltage scale
Date: Wed, 18 May 2011 00:17:23 -0500
Message-ID: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44872 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752604Ab1ERFRi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 01:17:38 -0400
Received: from dlep34.itg.ti.com ([157.170.170.115])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5HcZL025726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:38 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep34.itg.ti.com (8.13.7/8.13.7) with ESMTP id p4I5Hb9G002948
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:37 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

Hi,
The following patches are on top of:
git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git
branch: pm-wip/voltdm_c

This contains a set of misc fixes and cleanups necessary for voltage scale
to function.

Tested on: SDP4430

Nishanth Menon (9):
  OMAP3+: PM: SR: fix debugfs
  OMAP3+: PM: voltage: add required debugfs interfaces
  OMAP3+: PM: VP: fix vstepmax
  OMAP4: PM: VC: support configuration of i2c clks
  OMAP4: PM: VC: fix highspeed i2c for SR
  OMAP4: PM: VC: fix channel bit offset for MPU
  OMAP4: PM: TWL6030: fix uv to voltage for >0x39
  OMAP4: PM: TWL6030: address 0V conversions
  OMAP4: PM: TWL6030: add cmd register

Patrick Titiano (2):
  OMAP4: PM: TWL6030: fix voltage conversion formula
  OMAP4: PM: TWL6030: fix ON/RET/OFF voltages

 arch/arm/mach-omap2/omap_twl.c         |   68 ++++++++++++++++++++++---------
 arch/arm/mach-omap2/prm-regbits-44xx.h |    8 ++++
 arch/arm/mach-omap2/smartreflex.c      |   21 +++++++++-
 arch/arm/mach-omap2/vc.c               |   55 +++++++++++++++----------
 arch/arm/mach-omap2/vc.h               |   37 ++++++++++++++++-
 arch/arm/mach-omap2/vc3xxx_data.c      |    2 +-
 arch/arm/mach-omap2/vc44xx_data.c      |   12 +++++-
 arch/arm/mach-omap2/voltage.c          |   66 +++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h          |    9 ++++
 arch/arm/mach-omap2/vp.c               |    2 +-
 10 files changed, 232 insertions(+), 48 deletions(-)

Regards,
Nishanth Menon
