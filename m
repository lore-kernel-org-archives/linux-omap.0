From: Mike Turquette <mturquette@ti.com>
Subject: [RFC][PATCH 0/5] Introduce .get_voltage callback into voltdm
Date: Wed, 3 Oct 2012 18:16:00 -0700
Message-ID: <1349313365-5262-1-git-send-email-mturquette@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46431 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932203Ab2JDBQw (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 3 Oct 2012 21:16:52 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Turquette <mturquette@linaro.org>

From: Mike Turquette <mturquette@linaro.org>

This series creates a new callback for struct voltagedomain,
.get_voltage.  This fetches the voltage from hardware, if possible, and
returns it to the caller.  We use this call to populate
voltdm->nominal_volt at boot time.

The need for this came out of the Adaptive Body-Bias patches.  There is
a corner case where voltdm->nominal_volt is zero at boot, but the ABB
pre-scale function needs to know the current voltage as a part of its
logic.  Without this series voltdm->nominal_volt will be zero until
after voltdm->scale completes, which is too late for the ABB pre-scale
logic.

It is possible to have ABB without this series.  In the event that
voltdm->nominal_volt is zero then the ABB pre-scale function can simply
return early.  However this opens up a condition that burns power
needlessly:

1) The bootloader enables Forward Body-Bias mode on the ABB ldo and runs
the voltage domain at a high OPP

2) Linux boots and the first transition of that voltage domain is to a
lower OPP.

3) The voltage of that vdd is unknown so the ABB pre-scale function
returns early and FBB is left enabled at an OPP that would otherwise not
need it.

This scenario is not validated and is best avoided.  This series is one
step towards that.

Mike Turquette (5):
  ARM: omap: vc: replace data_shift with data_mask
  ARM: omap: introduce .get_voltage callback
  ARM: omap: vc: .get_voltage callback
  ARM: omap: vp: .get_voltage callback
  ARM: omap: initialize voltdm->nominal_volt

 arch/arm/mach-omap2/vc.c          |   23 ++++++++++++++++++++++-
 arch/arm/mach-omap2/vc.h          |    3 ++-
 arch/arm/mach-omap2/vc3xxx_data.c |    2 +-
 arch/arm/mach-omap2/vc44xx_data.c |    2 +-
 arch/arm/mach-omap2/voltage.c     |   13 +++++++++++++
 arch/arm/mach-omap2/voltage.h     |    1 +
 arch/arm/mach-omap2/vp.c          |   22 ++++++++++++++++++++++
 arch/arm/mach-omap2/vp.h          |    1 +
 8 files changed, 63 insertions(+), 4 deletions(-)

-- 
1.7.9.5

