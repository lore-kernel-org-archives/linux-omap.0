From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 3/5] OMAP2+: hwmod: Fix what _init_clock returns
Date: Mon, 07 Mar 2011 22:44:31 -0700
Message-ID: <20110308054429.1309.36007.stgit@twilight.localdomain>
References: <20110308054315.1309.10538.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:60581 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752945Ab1CHFp0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 8 Mar 2011 00:45:26 -0500
In-Reply-To: <20110308054315.1309.10538.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Rajendra Nayak <rnayak@ti.com>, =?utf-8?q?Beno=C3=AEt?= Cousson <b-cousson@ti.com>

=46rom: Rajendra Nayak <rnayak@ti.com>

_init_clock always returns 0 and does
not propogate the error (in case of failure)
back to the caller, causing _init_clocks to
fail silently.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Acked-by: Beno=C3=AEt Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/oma=
p_hwmod.c
index 9b4f6cd..671f871 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -926,7 +926,7 @@ static int _init_clocks(struct omap_hwmod *oh, void=
 *data)
 	if (!ret)
 		oh->_state =3D _HWMOD_STATE_CLKS_INITED;
=20
-	return 0;
+	return ret;
 }
=20
 /**


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
