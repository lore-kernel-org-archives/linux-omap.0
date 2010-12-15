From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH v2 0/7] OMAP4: hwmod data fixes and update
Date: Wed, 15 Dec 2010 14:51:36 +0100
Message-ID: <1292421103-19282-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39529 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752650Ab0LONxK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Dec 2010 08:53:10 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here is a small set of OMAP4 hwmod data updates.

Re-order properly the data that were a little bit shuffled during
the previous merge window.
Add the new reset flags introduced in 2.6.37 and that were not
used in the hwmod data. The OMAP2 and OMAP3 fixes should come soon...
...maybe not that soon :-)
Fix some missing field in the GPIO OMAP4 hwmod data that I missed
during the review.
IVA and DSP are added just to allow the processors device creation
at boot time and avoid the warnings.

Thanks to Charu for testing the GPIO / WD_TIMER changes.
Thanks to Govindraj for testing the UART changes. 

The series is based on your clk_a_2.6.38 branch from your integration tree
(git://git.pwsan.com/linux-integration) and is available here:
git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_data

Please note that there is a slight dependency with the following patch
due to the name change of the iva fclk:
OMAP4: clock data: Add missing DPLL x2 clock node
https://patchwork.kernel.org/patch/396612/

Tested on sdp4430 + ES2.0/ES2.1.

Regards,
Benoit


Changes since v1:
    http://www.spinics.net/lists/arm-kernel/msg107082.html:
    - Include the changelog fixes from Paul
    - Fix the order of the dsp hwmod data
    - Fix OMAP2430 i2c dev_attr warning (minor fix, but not tested)
    - Include Kevin's patch to fix wakeup in hwmod core
    

Benoit Cousson (6):
  OMAP4: hwmod data: Fix hwmod entries order
  OMAP4: hwmod data: Add SYSS_HAS_RESET_STATUS flag
  OMAP4: hwmod data: Fix missing address in DMM and EMIF_FW
  OMAP4: hwmod data: Add IVA and DSP
  OMAP4: hwmod & clock data: Fix GPIO opt_clks and ocp_if iclk
  OMAP2430: hwmod data: Use common dev_attr for i2c1 and i2c2

Kevin Hilman (1):
  OMAP2+: omap_hwmod: fix wakeup enable/disable for consistency

 arch/arm/mach-omap2/clock44xx_data.c       |   12 +-
 arch/arm/mach-omap2/omap_hwmod.c           |   32 +-
 arch/arm/mach-omap2/omap_hwmod_2430_data.c |   16 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1258 ++++++++++++++++++----------
 4 files changed, 845 insertions(+), 473 deletions(-)

