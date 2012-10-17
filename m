From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/NOT FOR MERGING 0/5] OMAP PM patches
Date: Wed, 17 Oct 2012 18:33:58 +0300
Message-ID: <1350488043-5053-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49193 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932179Ab2JQPjn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Oct 2012 11:39:43 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

Hi guys,

this series is actually *REALLY* far from ready, but I wanted
to ask if I should continue down this track because it really
looks (to me at least) that OMAP's PM layer took a few uneecessary
shortcuts.

I'm trying to understand the reasoning behind that, so bear with
me for a while.

At least patches 1 and 4 look like they could go upstream, but
please give it a very good review. I will continue to work on
these if the rest of the community thinks it's valid, otherwise
I would like to get some explanation for the way OMAP PM layer
is implemented today.

cheers

Felipe Balbi (5):
  arm: omap: fix up _od_suspend_noirq and _od_resume_noirq
  arm: omap: don't forcefully runtime suspend a device
  arm: omap: introduce other PM methods
  i2c: omap: don't re-enable IRQs after masking them
  i2c: omap: introduce suspend/resume methods

 arch/arm/plat-omap/omap_device.c | 162 +++++++++++++++++++++++++++++++++++++--
 drivers/i2c/busses/i2c-omap.c    |  70 ++++++++++++-----
 2 files changed, 207 insertions(+), 25 deletions(-)

-- 
1.8.0.rc0

