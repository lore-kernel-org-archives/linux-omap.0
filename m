From: Tony Lindgren <tony@atomide.com>
Subject: [RFC 0/5] Introduce omap_has_feature
Date: Thu, 08 Jul 2010 12:37:45 +0300
Message-ID: <20100708093405.16352.11814.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56488 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592Ab0GHJht (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Jul 2010 05:37:49 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: nm@ti.com

Hi,

Here's a quick experimental patches on testing features
with omap_has_feature as discussed based on earlier patches
by Nishant Menon.

These still need to be thought through a bit on how we want
to implement it.

Regards,

Tony

---

Nishanth Menon (1):
      omap2/3: id: fix sparse warning

Tony Lindgren (4):
      omap: Implement common omap_has_feature
      omap: Replace omap3_has_ macros with omap_has_feature
      omap: Remove old omap3_has_ macros
      omap: Allow testing for omap type with omap_has_feature


 arch/arm/mach-omap2/clock3xxx_data.c  |    2 -
 arch/arm/mach-omap2/id.c              |   70 +++++++++++++++++++++++----------
 arch/arm/mach-omap2/pm34xx.c          |    2 -
 arch/arm/plat-omap/common.c           |   15 +++++++
 arch/arm/plat-omap/include/plat/cpu.h |   69 ++++++++++++++++++---------------
 5 files changed, 104 insertions(+), 54 deletions(-)

-- 
Signature
