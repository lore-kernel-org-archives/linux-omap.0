From: Suman Anna <s-anna@ti.com>
Subject: [PATCHv2 09/10] ARM: OMAP4: hwmod_data: Remove legacy mailbox addrs
Date: Fri, 11 Jul 2014 16:44:42 -0500
Message-ID: <1405115083-52977-10-git-send-email-s-anna@ti.com>
References: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48897 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751800AbaGKVqK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Jul 2014 17:46:10 -0400
In-Reply-To: <1405115083-52977-1-git-send-email-s-anna@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Dave Gerlach <d-gerlach@ti.com>, Jassi Brar <jaswinder.singh@linaro.org>, Pavel Machek <pavel@ucw.cz>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Suman Anna <s-anna@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>

The legacy-style definition of the hwmod addr space is no longer
required after the addition of the OMAP4 mailbox DT node, so
clean up this data.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <bcousson@baylibre.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 41e54f7..5e61b8c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4142,21 +4142,11 @@ static struct omap_hwmod_ocp_if omap44xx_l4_wku=
p__kbd =3D {
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
-static struct omap_hwmod_addr_space omap44xx_mailbox_addrs[] =3D {
-	{
-		.pa_start	=3D 0x4a0f4000,
-		.pa_end		=3D 0x4a0f41ff,
-		.flags		=3D ADDR_TYPE_RT
-	},
-	{ }
-};
-
 /* l4_cfg -> mailbox */
 static struct omap_hwmod_ocp_if omap44xx_l4_cfg__mailbox =3D {
 	.master		=3D &omap44xx_l4_cfg_hwmod,
 	.slave		=3D &omap44xx_mailbox_hwmod,
 	.clk		=3D "l4_div_ck",
-	.addr		=3D omap44xx_mailbox_addrs,
 	.user		=3D OCP_USER_MPU | OCP_USER_SDMA,
 };
=20
--=20
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
