From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: [PATCH 03/10] omap mailbox: print hardware revision at startup
Date: Fri, 16 Jan 2009 10:27:16 +0200
Message-ID: <20090116082716.17571.76251.stgit@oreo.research.nokia.com>
References: <20090116081919.17571.34378.stgit@oreo.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:28149 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761058AbZAPI1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jan 2009 03:27:35 -0500
In-Reply-To: <20090116081919.17571.34378.stgit@oreo.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---

 arch/arm/mach-omap2/mailbox.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index 3176bb7..c73fa89 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -74,6 +74,9 @@ static int omap2_mbox_startup(struct omap_mbox *mbox)
 	}
 	clk_enable(mbox_ick_handle);
 
+	l = mbox_read_reg(MAILBOX_REVISION);
+	pr_info("omap mailbox rev %d.%d\n", (l & 0xf0) >> 4, (l & 0x0f));
+
 	/* set smart-idle & autoidle */
 	l = mbox_read_reg(MAILBOX_SYSCONFIG);
 	l |= 0x00000011;

