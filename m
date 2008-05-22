From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] OMAP3 clockdomains: include D2D clockdomain on 34xx ES2+
Date: Thu, 22 May 2008 11:33:59 -0600
Message-ID: <20080522173354.1292.70542.stgit@localhost.localdomain>
References: <20080522173035.1292.74243.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41391 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756406AbYEVRgK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 22 May 2008 13:36:10 -0400
In-Reply-To: <20080522173035.1292.74243.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

The OMAP34xx ES2+ TRMs do not document the CLKTRCTRL_D2D bit, even
though the clockdomain logic remains on the chip, and must be
programmed appropriately for the CORE clockdomain to go inactive.

Thanks to Rajendra Najak <rnayak@ti.com> and Richard Woodruff
<r-woodruff2@ti.com> of TI for providing more detail on this issue;
and to Jouni H=C3=B6gander <jouni.hogander@nokia.com> for proposing thi=
s
fix.

This patch obsoletes the D2D clockdomain workaround in pm34xx.c in
Jouni's recent patch set.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---

 arch/arm/mach-omap2/clockdomains.h |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/c=
lockdomains.h
index adbc170..b5d3244 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -168,12 +168,19 @@ static struct clockdomain sgx_clkdm =3D {
 	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
 };
=20
+/*
+ * The die-to-die clockdomain was documented in the 34xx ES1 TRM, but
+ * then that information was removed from the 34xx ES2+ TRM.  It is
+ * unclear whether the core is still there, but the clockdomain logic
+ * is there, and must be programmed to an appropriate state if the
+ * CORE clockdomain is to become inactive.
+ */
 static struct clockdomain d2d_clkdm =3D {
 	.name		=3D "d2d_clkdm",
 	.pwrdm_name	=3D "core_pwrdm",
 	.flags		=3D CLKDM_CAN_HWSUP,
 	.clktrctrl_mask =3D OMAP3430ES1_CLKTRCTRL_D2D_MASK,
-	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES1),
+	.omap_chip	=3D OMAP_CHIP_INIT(CHIP_IS_OMAP3430),
 };
=20
 static struct clockdomain core_l3_34xx_clkdm =3D {


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
