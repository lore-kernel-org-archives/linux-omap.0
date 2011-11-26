From: NeilBrown <neilb@suse.de>
Subject: [PATCH 0/4] fixes for twl4030-irq in mainline
Date: Sun, 27 Nov 2011 07:17:41 +1100
Message-ID: <20111126201334.16080.85045.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:41339 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754324Ab1KZUTS (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 26 Nov 2011 15:19:18 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>

Hi,
  The recent tidying up of twl4030-irq seems to have left it broken.
At least it doesn't work for me on my gta04 (www.gta04.org).  The
first interrupt from the device freezes the whole system (by being
constantly delivered)

The following 4 patches make it work for me and addresses some other
less critical issues like a typo in a comment :-)

Thanks,
NeilBrown


---

NeilBrown (4):
      twl4030-irq: fix typo
      twl4030-irq: set tertiary interrupts to be nested/threaded.
      twl4030-irq: use request_threaded_irq in place of irq_set_chained_handler.
      twl4030-irq: Base interrupt must be one-shot


 drivers/mfd/twl4030-irq.c |   21 +++++++++++++--------
 1 files changed, 13 insertions(+), 8 deletions(-)

-- 
Signature

