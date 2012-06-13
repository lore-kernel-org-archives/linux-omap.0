From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] Few MUSB fixes for ifdef removal
Date: Wed, 13 Jun 2012 03:15:00 -0700
Message-ID: <20120613101303.18645.83320.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:11855 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141Ab2FMKPF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 13 Jun 2012 06:15:05 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are two regression fixes for the MUSB ifdef removal.

Note that this series does not fix things for blackfin
or davinci, similar fixes should be done for those.

Regards,

Tony

---

Tony Lindgren (2):
      ARM: OMAP2+: Fix MUSB ifdefs for platform init code
      ARM: OMAP2: Fix tusb6010 GPIO interrupt for n8x0


 arch/arm/mach-omap2/board-n8x0.c        |    6 ++----
 arch/arm/mach-omap2/omap_phy_internal.c |    6 ------
 arch/arm/mach-omap2/usb-musb.c          |    6 ++----
 arch/arm/mach-omap2/usb-tusb6010.c      |    2 +-
 4 files changed, 5 insertions(+), 15 deletions(-)

-- 
Signature
