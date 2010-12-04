From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/5] Few misc patches for v2.6.38 merge window
Date: Sat, 04 Dec 2010 13:29:42 -0800
Message-ID: <20101204212904.25978.22090.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:28803 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753475Ab0LDV3p (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Dec 2010 16:29:45 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi,

Here are some misc patches for review.

Regards,

Tony

---

Evgeny Kuznetsov (1):
      omap: Ptr "isr_reg" tracked as NULL was dereferenced

Jarkko Nikula (1):
      omap: McBSP: Fix potential memory leak in omap_mcbsp_remove

Shubhrajyoti D (1):
      omap: McBSP: Make the free variable update more readable

Tony Lindgren (2):
      Fix undefined reference to omap2_i2c_mux_pins
      omap: Don't select mux by default for each board


 arch/arm/mach-omap2/Kconfig |    4 ----
 arch/arm/plat-omap/gpio.c   |    5 +++++
 arch/arm/plat-omap/i2c.c    |    7 +++++++
 arch/arm/plat-omap/mcbsp.c  |   16 +++++-----------
 4 files changed, 17 insertions(+), 15 deletions(-)

-- 
Signature
