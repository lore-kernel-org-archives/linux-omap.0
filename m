From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 10/12] ARM: OMAP3: hwmod data: fix IVA interface clock
Date: Wed, 07 Mar 2012 19:38:39 -0700
Message-ID: <20120308023839.8205.66682.stgit@dusk>
References: <20120308023614.8205.78768.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45808 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894Ab2CHCmL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Mar 2012 21:42:11 -0500
In-Reply-To: <20120308023614.8205.78768.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The OMAP3 hwmod data listed iva2_ck as an interface clock between the
IVA and L3.  This is incorrect.  iva2_ck is not an interface clock.
Since it cannot auto-idle, specifying it here prevents the IVA and at
least one of the CORE clockdomains from going idle, which causes PM
problems such as these upon system suspend:

[   70.626129] Powerdomain (iva2_pwrdm) didn't enter target state 1
[   70.626190] Powerdomain (core_pwrdm) didn't enter target state 1

Fix by specifying the actual interface clock in the hwmod data.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 3b245e9..c05a445 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2325,7 +2325,7 @@ static struct omap_hwmod_ocp_if omap3xxx_l4_wkup__l4_sec = {
 static struct omap_hwmod_ocp_if omap3xxx_l3__iva = {
 	.master		= &omap3xxx_l3_main_hwmod,
 	.slave		= &omap3xxx_iva_hwmod,
-	.clk		= "iva2_ck",
+	.clk		= "core_l3_ick",
 	.user		= OCP_USER_MPU | OCP_USER_SDMA,
 };
 


