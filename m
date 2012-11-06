From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [GIT PULL] OMAP: PM: voltage layer updates for v3.8
Date: Tue, 06 Nov 2012 15:56:42 -0800
Message-ID: <87bofa1e11.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:62629 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527Ab2KFX4p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 6 Nov 2012 18:56:45 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so768656pbb.19
        for <linux-omap@vger.kernel.org>; Tue, 06 Nov 2012 15:56:45 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>

Tony,

Here's a set of voltage layer updates for v3.8.

This implements all the framework changes necessary to get
auto-ret/auto-off working, but the main change to enable
auto-ret/auto-off is awaiting the functional power state changes that
are still under review/rework.

Also, this fixes that pesky VC warning about I2C config not matching
other channels that was reported by Russell.

Kevin


The following changes since commit 3d70f8c617a436c7146ecb81df2265b4626dfe89:

  Linux 3.7-rc4 (2012-11-04 11:07:39 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git tags/for_3.8-pm-voltage

for you to fetch changes up to df7cded30ced539d3b4e6bae9f3011d98c069d41:

  ARM: OMAP4: OPP: add OMAP4460 definitions (2012-11-05 15:31:49 -0800)

----------------------------------------------------------------
OMAP voltage layer updates towards supporting auto-retention/auto-off

----------------------------------------------------------------
Nishanth Menon (1):
      ARM: OMAP3+: PM: VP: use uV for max and min voltage limits

Tero Kristo (13):
      ARM: OMAP: voltage: renamed vp_vddmin and vp_vddmax fields
      ARM: OMAP3+: voltage: introduce omap vc / vp params for voltagedomains
      ARM: OMAP3: VC: calculate ramp times
      ARM: OMAP4: voltage: add support for VOLTSETUP_x_OFF register
      ARM: OMAP4: VC: calculate ramp times
      ARM: OMAP: add support for oscillator setup
      ARM: OMAP3+: vp: use new vp_params for calculating vddmin and vddmax
      ARM: OMAP3+: voltage: use oscillator data to calculate setup times
      ARM: OMAP: TWL: change the vddmin / vddmax voltages to spec
      ARM: OMAP3+: voltage: remove unused volt_setup_time parameter
      ARM: OMAP4: vc: fix channel configuration
      ARM: OMAP4: VC: setup I2C parameters based on board data
      ARM: OMAP4: TWL: enable high speed mode for PMIC communication

Vishwanath Sripathy (1):
      ARM: OMAP4: OPP: add OMAP4460 definitions

 arch/arm/mach-omap2/control.h                 |   1 +
 arch/arm/mach-omap2/omap_opp_data.h           |   9 +-
 arch/arm/mach-omap2/omap_twl.c                |  73 +----
 arch/arm/mach-omap2/opp4xxx_data.c            |  98 +++++-
 arch/arm/mach-omap2/pm.c                      |  30 ++
 arch/arm/mach-omap2/pm.h                      |  10 +
 arch/arm/mach-omap2/vc.c                      | 451 ++++++++++++++++++++++++--
 arch/arm/mach-omap2/vc.h                      |   8 +-
 arch/arm/mach-omap2/vc3xxx_data.c             |  22 ++
 arch/arm/mach-omap2/vc44xx_data.c             |  28 ++
 arch/arm/mach-omap2/voltage.h                 |  44 ++-
 arch/arm/mach-omap2/voltagedomains3xxx_data.c |   5 +
 arch/arm/mach-omap2/voltagedomains44xx_data.c |  23 +-
 arch/arm/mach-omap2/vp.c                      |   6 +-
 arch/arm/mach-omap2/vp.h                      |   7 +
 arch/arm/mach-omap2/vp3xxx_data.c             |  10 +
 arch/arm/mach-omap2/vp44xx_data.c             |  15 +
 17 files changed, 725 insertions(+), 115 deletions(-)
