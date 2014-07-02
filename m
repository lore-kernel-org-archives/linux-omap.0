From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH v2] ARM: OMAP2+: Make GPMC skip disabled devices
Date: Wed,  2 Jul 2014 10:35:18 -0300
Message-ID: <1404308118-14843-1-git-send-email-guido@vanguardiasur.com.ar>
References: <20980858CB6D3A4BAE95CA194937D5E73EAF8D44@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:36446 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751297AbaGBNdD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 2 Jul 2014 09:33:03 -0400
Received: by mail-yh0-f49.google.com with SMTP id f73so6834300yha.22
        for <linux-omap@vger.kernel.org>; Wed, 02 Jul 2014 06:33:02 -0700 (PDT)
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73EAF8D44@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, pekon@ti.com, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>

Currently, child nodes of the gpmc node are iterated and probed
regardless of their 'status' property. This means adding 'status =3D
"disabled";' has no effect.

This patch changes the iteration to only probe nodes marked as
available.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
v2: Make patch title consistent with previous gpmc patches

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
