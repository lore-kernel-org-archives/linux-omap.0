From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH] ARM: OMAP3: clock: Back-propagate rate change from cam_mclk to dpll4_m5 on all OMAP3 platforms
Date: Mon, 21 Apr 2014 15:06:23 +0200
Message-ID: <1398085583-9615-1-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:38902 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbaDUNGT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2014 09:06:19 -0400
Received: from avalon.ideasonboard.com (147.20-200-80.adsl-dyn.isp.belgacom.be [80.200.20.147])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D83B359AB
	for <linux-omap@vger.kernel.org>; Mon, 21 Apr 2014 15:04:07 +0200 (CEST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

=46rom: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Commit 7b2e1277598e4187c9be3e61fd9b0f0423f97986 ("ARM: OMAP3: clock:
Back-propagate rate change from cam_mclk to dpll4_m5") enabled clock
rate back-propagation from cam_mclk do dpll4_m5 on OMAP3630 only.
Perform back-propagation on other OMAP3 platforms as well.

Reported-by: Jean-Philippe Fran=C3=A7ois <jp.francois@cynove.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/mach-omap2/cclock3xxx_data.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/cclock3xxx_data.c b/arch/arm/mach-omap=
2/cclock3xxx_data.c
index 8f5121b..eb8c75e 100644
--- a/arch/arm/mach-omap2/cclock3xxx_data.c
+++ b/arch/arm/mach-omap2/cclock3xxx_data.c
@@ -456,7 +456,8 @@ static struct clk_hw_omap dpll4_m5x2_ck_hw =3D {
 	.clkdm_name	=3D "dpll4_clkdm",
 };
=20
-DEFINE_STRUCT_CLK(dpll4_m5x2_ck, dpll4_m5x2_ck_parent_names, dpll4_m5x=
2_ck_ops);
+DEFINE_STRUCT_CLK_FLAGS(dpll4_m5x2_ck, dpll4_m5x2_ck_parent_names,
+			dpll4_m5x2_ck_ops, CLK_SET_RATE_PARENT);
=20
 static struct clk dpll4_m5x2_ck_3630 =3D {
 	.name		=3D "dpll4_m5x2_ck",
--=20
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
