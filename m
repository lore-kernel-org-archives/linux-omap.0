From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ARM: OMAP2+: Fix compillation error in mach-omap2/timer.c
Date: Wed, 19 Dec 2012 10:50:09 +0100
Message-ID: <1355910609-31336-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:54831 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546Ab2LSJuR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Dec 2012 04:50:17 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

prom_add_property() has been renamed to of_add_property()
This patch fixes the following comilation error:

arch/arm/mach-omap2/timer.c: In function =E2=80=98omap_get_timer_dt=E2=80=
=99:
arch/arm/mach-omap2/timer.c:178:3: error: implicit declaration of funct=
ion =E2=80=98prom_add_property=E2=80=99 [-Werror=3Dimplicit-function-de=
claration]
cc1: some warnings being treated as errors
make[1]: *** [arch/arm/mach-omap2/timer.o] Error 1
make[1]: *** Waiting for unfinished jobs....

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Tony,

today's mainline does not compile due to this API rename in of core.
Not sure if we alreasy have fix for this pending.

Regards,
Peter

 arch/arm/mach-omap2/timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 7016637..cece724 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -175,7 +175,7 @@ static struct device_node * __init omap_get_timer_d=
t(struct of_device_id *match,
 			continue;
 		}
=20
-		prom_add_property(np, &device_disabled);
+		of_add_property(np, &device_disabled);
 		return np;
 	}
=20
--=20
1.8.0.2

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
