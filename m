From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 02/20] ARM: OMAP3+: SmartReflex: add missing error-handling code
Date: Wed,  1 Feb 2012 09:49:41 +0100
Message-ID: <1328086199-28486-3-git-send-email-j-pihet@ti.com>
References: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46589 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753966Ab2BAIuQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 Feb 2012 03:50:16 -0500
Received: by wgbdt10 with SMTP id dt10so1012846wgb.1
        for <linux-omap@vger.kernel.org>; Wed, 01 Feb 2012 00:50:15 -0800 (PST)
In-Reply-To: <1328086199-28486-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Julia Lawall <julia@diku.dk>, Jean Pihet <j-pihet@ti.com>

From: Julia Lawall <julia@diku.dk>

At this point, the ioremap has taken place, so the error handling code at
the label err_iounmap should be used rather than returning directly.

The semantic match that finds this problem is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier x;
@@

kfree(x)

@@
identifier r.x;
expression E1!=0,E2,E3,E4;
statement S;
@@

(
if (<+...x...+>) S
|
if (...) { ... when != kfree(x)
               when != if (...) { ... kfree(x); ... }
               when != x = E3
* return E1;
}
... when != x = E2
if (...) { ... when != x = E4
 kfree(x); ... return ...; }
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>
Acked-by: Kevin Hilman <khilman@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 9dd9345..7e755bb 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -897,7 +897,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
 		ret = sr_late_init(sr_info);
 		if (ret) {
 			pr_warning("%s: Error in SR late init\n", __func__);
-			return ret;
+			goto err_iounmap;
 		}
 	}
 
-- 
1.7.5.4

