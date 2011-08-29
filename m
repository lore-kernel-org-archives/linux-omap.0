From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH 2/5] OMAP4: PM: TWL6030: fix uv to voltage for >0x39
Date: Mon, 29 Aug 2011 11:15:18 -0700
Message-ID: <1314641721-5172-3-git-send-email-khilman@ti.com>
References: <1314641721-5172-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:56123 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754416Ab1H2SO5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 29 Aug 2011 14:14:57 -0400
Received: by mail-pz0-f44.google.com with SMTP id 36so10337935pzk.17
        for <linux-omap@vger.kernel.org>; Mon, 29 Aug 2011 11:14:56 -0700 (PDT)
In-Reply-To: <1314641721-5172-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org

From: Nishanth Menon <nm@ti.com>

using 1.35V as a check is not correct, we know that beyond 0x39,
voltages are non linear - hence use the conversion iff uV greater
than that for 0x39. For example, with  709mV as the smps offset,
the max linear is actually 1.41V(0x39vsel)!

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/omap_twl.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_twl.c b/arch/arm/mach-omap2/omap_twl.c
index a66bf6b..5def7c2 100644
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
1.7.6

