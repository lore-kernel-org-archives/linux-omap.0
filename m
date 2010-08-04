From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/3] Few more omap patches for the 2.6.36 merge window
Date: Wed, 04 Aug 2010 14:32:54 +0300
Message-ID: <20100804112916.25027.94640.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:61767 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755789Ab0HDLc2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Aug 2010 07:32:28 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are few more small patches from the linux-omap list
that have not yet been posted to linux-arm-kernel list for
review.

Regards,

Tony

---

Anand Gadiyar (2):
      OMAP3630: Add ES1.1 and ES1.2 detection
      omap: 3630: disable TLL SAR on 3630 ES1

Artem Bityutskiy (1):
      omap: device: improve errors handling


 arch/arm/mach-omap2/id.c               |   28 +++++++++++++++++++++++++---
 arch/arm/mach-omap2/powerdomains34xx.h |   12 ++++++++++--
 arch/arm/plat-omap/include/plat/cpu.h  |   15 +++++++++++----
 arch/arm/plat-omap/omap_device.c       |    4 +++-
 4 files changed, 49 insertions(+), 10 deletions(-)

-- 
Signature
