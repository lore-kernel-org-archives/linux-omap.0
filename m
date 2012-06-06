From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/3] ARM: OMAP3: Fix omap3_l3_block_irq warning when
 CONFIG_BUG is not set
Date: Wed, 06 Jun 2012 01:22:48 -0700
Message-ID: <20120606082248.727.37364.stgit@muffinssi.local>
References: <20120606082156.727.42730.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63724 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987Ab2FFIWu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Jun 2012 04:22:50 -0400
In-Reply-To: <20120606082156.727.42730.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

Otherwise we will get:

arch/arm/mach-omap2/omap_l3_smx.c: In function =E2=80=98omap3_l3_block_=
irq=E2=80=99:
arch/arm/mach-omap2/omap_l3_smx.c:156: warning: unused variable =E2=80=98=
address=E2=80=99
arch/arm/mach-omap2/omap_l3_smx.c:155: warning: unused variable =E2=80=98=
multi=E2=80=99
arch/arm/mach-omap2/omap_l3_smx.c:154: warning: unused variable =E2=80=98=
initid=E2=80=99
arch/arm/mach-omap2/omap_l3_smx.c:153: warning: unused variable =E2=80=98=
code=E2=80=99
arch/arm/mach-omap2/omap_l3_smx.c: At top level:
arch/arm/mach-omap2/omap_l3_smx.c:68: warning: =E2=80=98omap3_l3_code_s=
tring=E2=80=99 defined but not used
arch/arm/mach-omap2/omap_l3_smx.c:90: warning: =E2=80=98omap3_l3_initia=
tor_string=E2=80=99 defined but not used

=46ix it by always showing the L3 error.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_l3_smx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/om=
ap_l3_smx.c
index a05a62f..acc2164 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -155,10 +155,11 @@ static irqreturn_t omap3_l3_block_irq(struct omap=
3_l3 *l3,
 	u8 multi =3D error & L3_ERROR_LOG_MULTI;
 	u32 address =3D omap3_l3_decode_addr(error_addr);
=20
-	WARN(true, "%s seen by %s %s at address %x\n",
+	pr_err("%s seen by %s %s at address %x\n",
 			omap3_l3_code_string(code),
 			omap3_l3_initiator_string(initid),
 			multi ? "Multiple Errors" : "", address);
+	WARN_ON(1);
=20
 	return IRQ_HANDLED;
 }

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
