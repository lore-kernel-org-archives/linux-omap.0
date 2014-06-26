From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH] arm: mach-omap2: gpmc: ignore non-available nodes
Date: Thu, 26 Jun 2014 12:02:03 -0300
Message-ID: <1403794923-19511-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:57345 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbaFZPAD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2014 11:00:03 -0400
Received: by mail-yh0-f44.google.com with SMTP id f10so2179180yha.17
        for <linux-omap@vger.kernel.org>; Thu, 26 Jun 2014 08:00:02 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: pekon@ti.com, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

Currently, child nodes of the gpmc node are iterated and probed
regardless of their 'status' property. This means adding 'status =3D
"disabled";' has no effect.

This patch changes the iteration to only probe nodes marked as
available.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 arch/arm/mach-omap2/gpmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
index 2c0c281..8bc1338 100644
--- a/arch/arm/mach-omap2/gpmc.c
+++ b/arch/arm/mach-omap2/gpmc.c
@@ -1615,7 +1615,7 @@ static int gpmc_probe_dt(struct platform_device *=
pdev)
 		return ret;
 	}
=20
-	for_each_child_of_node(pdev->dev.of_node, child) {
+	for_each_available_child_of_node(pdev->dev.of_node, child) {
=20
 		if (!child->name)
 			continue;
--=20
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
