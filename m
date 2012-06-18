From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCHv3 4/7] ARM: OMAP4: hwmod data: fix 32k sync timer idle modes
Date: Mon, 18 Jun 2012 00:16:08 -0600
Message-ID: <20120618061605.30632.31634.stgit@dusk>
References: <20120618061037.30632.28539.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:55786 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751579Ab2FRGS3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 18 Jun 2012 02:18:29 -0400
In-Reply-To: <20120618061037.30632.28539.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Tero Kristo <t-kristo@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

The 32k sync timer IP block target idle modes in the hwmod data are
incorrect.  The IP block does not support any smart-idle modes.
Update the data to reflect the correct modes.

This problem was initially identified and a diff fragment posted to
the lists by Beno=C3=AEt Cousson <b-cousson@ti.com>.  A patch descripti=
on
bug in the first version was also identified by Beno=C3=AEt.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 4aaaa84..6b0aedc 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -393,8 +393,7 @@ static struct omap_hwmod_class_sysconfig omap44xx_c=
ounter_sysc =3D {
 	.rev_offs	=3D 0x0000,
 	.sysc_offs	=3D 0x0004,
 	.sysc_flags	=3D SYSC_HAS_SIDLEMODE,
-	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO | SIDLE_SMART |
-			   SIDLE_SMART_WKUP),
+	.idlemodes	=3D (SIDLE_FORCE | SIDLE_NO),
 	.sysc_fields	=3D &omap_hwmod_sysc_type1,
 };
=20


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
