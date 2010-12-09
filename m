From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 0/5] OMAP4: hwmod data fixes and update
Date: Fri, 10 Dec 2010 00:33:30 +0100
Message-ID: <1291937615-18571-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52333 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754881Ab0LIXeW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Dec 2010 18:34:22 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Benoit Cousson <b-cousson@ti.com>

Hi Paul,

Here is a small set of OMAP4 hwmod data updates.

Re-order properly the data that were a little bit shuffled during
the previous merge window.
Add the new reset flags introduced in 2.6.37 and that were not
used in the hwmod data. The OMAP2 and OMAP3 fixes should come soon.
Fix some missing field in the GPIO OMAP4 hwmod data that I missed
during the review.
IVA and DSP are added just to allow the processors device creation
at boot time and avoid the warnings.

Thanks to Charu for testing the GPIO / WD_TIMER changes.
Thanks to Govindraj for testing the UART changes. 

The series is based on lo/for-next (v2.6.37-rc5-66-ga2814df) and is
available here:
git://gitorious.org/omap-pm/linux.git for_2.6.38/hwmod_data

Please note that there is a slight dependency with the following patch
due to the name change of the iva fclk:
OMAP4: clock data: Add missing DPLL x2 clock node
https://patchwork.kernel.org/patch/396612/

Tested on sdp4430 + ES2.0/ES2.1.

Regards,
Benoit


Benoit Cousson (5):
  OMAP4: hwmod data: Fix hwmod entries order
  OMAP4: hwmod data: Add SYSS_HAS_RESET_STATUS flag
  OMAP4: hwmod data: Fix missing address in DMM and EMIF_FW
  OMAP4: hwmod data: Add IVA and DSP
  OMAP4: hwmod & clock data: Fix GPIO opt_clks and ocp_if iclk

 arch/arm/mach-omap2/clock44xx_data.c       |   12 +-
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 1256 ++++++++++++++++++----------
 2 files changed, 822 insertions(+), 446 deletions(-)

