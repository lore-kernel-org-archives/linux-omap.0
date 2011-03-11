From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/2] omap2+: Few mux patches
Date: Fri, 11 Mar 2011 12:34:13 -0800
Message-ID: <20110311203317.26901.67180.stgit@baageli.muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:33184 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab1CKUeP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Mar 2011 15:34:15 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Hi all,

Here are few omap mux related patches for review.

Regards,

Tony

---

Tony Lindgren (2):
      omap2+: mux: Fix compile when CONFIG_OMAP_MUX is not selected
      omap4: mux: Remove duplicate mux modes


 arch/arm/mach-omap2/board-cm-t35.c     |    2 
 arch/arm/mach-omap2/board-cm-t3517.c   |    2 
 arch/arm/mach-omap2/board-devkit8000.c |    2 
 arch/arm/mach-omap2/mux44xx.c          |  282 +-------------------------------
 4 files changed, 12 insertions(+), 276 deletions(-)

-- 
Signature
