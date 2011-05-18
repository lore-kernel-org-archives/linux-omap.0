From: Nishanth Menon <nm@ti.com>
Subject: [PM-WIP/voltdm_c][PATCH 08/11] OMAP4: PM: TWL6030: fix uv to voltage for >0x39
Date: Wed, 18 May 2011 00:17:31 -0500
Message-ID: <1305695854-9638-9-git-send-email-nm@ti.com>
References: <1305695854-9638-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:47763 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754924Ab1ERFRk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 May 2011 01:17:40 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id p4I5Hdr5028660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500
Received: from dlep26.itg.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id p4I5HdkC004915
	for <linux-omap@vger.kernel.org>; Wed, 18 May 2011 00:17:39 -0500 (CDT)
In-Reply-To: <1305695854-9638-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: kevin <khilman@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Nishanth Menon <nm@ti.com>

using 1.35V as a check is not correct, we know that beyond 0x39,
voltages are non linear - hence use the conversion iff uV greater
than that for 0x39. For example, with  709mV as the smps offset,
the max linear is actually 1.41V(0x39vsel)!

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index 78fd985..fce7e6d 100644
--- a/arch/arm/mach-omap2/omap_twl.c
+++ b/arch/arm/mach-omap2/omap_twl.c
@@ -134,8 +134,13 @@ static u8 twl6030_uv_to_vsel(unsigned long uv)
 	 * hardcoding only for 1.35 V which is used for 1GH OPP for
 	 * OMAP4430.
 	 */
-	if (uv == 1350000)
+	if (uv > twl6030_vsel_to_uv(0x39)) {
+		if (uv == 1350000)
+			return 0x3A;
+		pr_err("%s:OUT OF RANGE! non mapped vsel for %ld Vs max %ld\n",
+			__func__, uv, twl6030_vsel_to_uv(0x39));
 		return 0x3A;
+	}
 
 	if (smps_offset & 0x8)
 		return DIV_ROUND_UP(uv - 709000, 12660) + 1;
-- 
1.7.0.4

