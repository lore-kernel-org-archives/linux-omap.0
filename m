From: Omar Ramirez Luna <omar.ramirez@ti.com>
Subject: [PATCH 5/5] omap: mailbox: remove unreachable return
Date: Tue, 26 Oct 2010 16:53:04 -0500
Message-ID: <1288129984-22957-6-git-send-email-omar.ramirez@ti.com>
References: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35629 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760542Ab0JZWDT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 26 Oct 2010 18:03:19 -0400
In-Reply-To: <1288129984-22957-1-git-send-email-omar.ramirez@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Dmitry Kasatkin <dmitry.kasatkin@nokia.com>, Kevin Hilman <khilman@deeprootsystems.com>, Omar Ramirez Luna <omar.ramirez@ti.com>, Suman Anna <s-anna@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, C A Subramaniam <subramaniam.ca@ti.com>, linux-omap@vger.kernel.org

Remove unreachable return statement.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/mach-omap2/mailbox.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/mailbox.c b/arch/arm/mach-omap2/mailbox.c
index b8fd120..2dd0e07 100644
--- a/arch/arm/mach-omap2/mailbox.c
+++ b/arch/arm/mach-omap2/mailbox.c
@@ -435,8 +435,6 @@ static int __devinit omap2_mbox_probe(struct platform_device *pdev)
 		return ret;
 	}
 	return 0;
-
-	return ret;
 }
 
 static int __devexit omap2_mbox_remove(struct platform_device *pdev)
-- 
1.7.1

