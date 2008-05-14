From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH] ARCH: OMAP: MUSB: Do not block sleep
Date: Thu, 15 May 2008 01:51:25 +0300
Message-ID: <1210805485-2645-1-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:33626 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756994AbYENWuc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 May 2008 18:50:32 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>, =?utf-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@nokia.com>

Do not block sleep while musb clock is enabled
as it completely blocks dynamic sleep.

Thanks to Jouni H=C3=B6gander.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
Signed-off-by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/usb-musb.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-m=
usb.c
index cbd59f8..bd3556b 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -58,7 +58,6 @@ static int musb_set_clock(struct clk *clk, int state)
 		if (clk_on > 0)
 			return -ENODEV;
=20
-		omap2_block_sleep();
 		clk_enable(clk);
 		clk_on =3D 1;
 	} else {
@@ -67,7 +66,6 @@ static int musb_set_clock(struct clk *clk, int state)
=20
 		clk_disable(clk);
 		clk_on =3D 0;
-		omap2_allow_sleep();
 	}
=20
 	return 0;
--=20
1.5.4.3.447.gc95b3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
