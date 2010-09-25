From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/7] omap board changes for v2.6.37 merge window
Date: Fri, 24 Sep 2010 17:26:57 -0700
Message-ID: <20100925002608.24551.67183.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61243 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627Ab0IYA05 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Sep 2010 20:26:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are some board files for review for the upcoming merge window.

Regards,

Tony

---

Mathieu J. Poirier (1):
      Adding i2c eeprom driver to read EDID

Ricardo Salveti de Araujo (1):
      omap4: board-omap4panda: adding leds status1 and status2

Robert Nelson (3):
      omap: Beagle: revision detection
      omap: Beagle: only Cx boards use pin 23 for write protect
      omap: Beagle: no gpio_wp pin connection on xM

Shubhrajyoti Datta (2):
      hmc5843: Digital compass board file
      omap: 4430sdp board support for proximity sensor


 arch/arm/mach-omap2/board-4430sdp.c     |   69 +++++++++++++++++++++
 arch/arm/mach-omap2/board-omap3beagle.c |  101 ++++++++++++++++++++++++++++++-
 arch/arm/mach-omap2/board-omap4panda.c  |   32 ++++++++++
 3 files changed, 199 insertions(+), 3 deletions(-)

-- 
Signature
