From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 7/9] ARM: OMAP4: hwmod data: add OCP_USER_DSP;
 mark omap44xx_dsp__iva appropriately
Date: Tue, 28 Feb 2012 04:10:56 -0700
Message-ID: <20120228111055.808.79928.stgit@dusk>
References: <20120228110943.808.73639.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35184 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965165Ab2B1LLf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Feb 2012 06:11:35 -0500
In-Reply-To: <20120228110943.808.73639.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

One of the OMAP4 links was missing OCP_USER flags, since it was only
used by the DSP initiator, and we did not have an OCP_USER_DSP flag.
=46uture patches will switch the hwmod code and data to register
interfaces, rather than hwmods, and it will be mandatory for all
interfaces to have at least one user bit set.  This patch resolves the
issue by adding OCP_USER_DSP and marking the DSP-IVA interface
appropriately.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    1 +
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach=
-omap2/omap_hwmod_44xx_data.c
index 8dfed19..f3fd64d 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -1089,6 +1089,7 @@ static struct omap_hwmod_ocp_if omap44xx_dsp__iva=
 =3D {
 	.master		=3D &omap44xx_dsp_hwmod,
 	.slave		=3D &omap44xx_iva_hwmod,
 	.clk		=3D "dpll_iva_m5x2_ck",
+	.user		=3D OCP_USER_DSP,
 };
=20
 /* dsp master ports */
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/pl=
at-omap/include/plat/omap_hwmod.h
index 8814365..f0a0711 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -213,6 +213,7 @@ struct omap_hwmod_addr_space {
  */
 #define OCP_USER_MPU			(1 << 0)
 #define OCP_USER_SDMA			(1 << 1)
+#define OCP_USER_DSP			(1 << 2)
=20
 /* omap_hwmod_ocp_if.flags bits */
 #define OCPIF_SWSUP_IDLE		(1 << 0)


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
