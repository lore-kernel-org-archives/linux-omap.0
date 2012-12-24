From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/3] ARM: OMAP AM33xx: hwmod data: resolve sparse warnings
Date: Sun, 23 Dec 2012 18:25:00 -0700
Message-ID: <20121224012458.13698.43620.stgit@dusk.lan>
References: <20121224012304.13698.43551.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:57209 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752496Ab2LXB10 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 20:27:26 -0500
In-Reply-To: <20121224012304.13698.43551.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Mugunthan V N <mugunthanvnm@ti.com>, Richard Cochran <richardcochran@gmail.com>, "David S. Miller" <davem@davemloft.net>, Vaibhav Hiremath <hvaibhav@ti.com>, Peter Korsgaard <jacmet@sunsite.dk>

Commit 70384a6af0914d5dcec034643941e29d3e3e69f7 ("ARM: OMAP3+:
hwmod: Add AM33XX HWMOD data for davinci_mdio module") adds two
new sparse warnings:

arch/arm/mach-omap2/omap_hwmod_33xx_data.c:2518:30: warning: symbol 'am33xx_mdio_addr_space' was not declared. Should it be static?
arch/arm/mach-omap2/omap_hwmod_33xx_data.c:2526:26: warning: symbol 'am33xx_cpgmac0__mdio' was not declared. Should it be static?

Fix by marking the two new records as static.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: David S. Miller <davem@davemloft.net>
---
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 081c71e..02ca493 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -2515,7 +2515,7 @@ static struct omap_hwmod_ocp_if am33xx_l4_hs__cpgmac0 = {
 	.user		= OCP_USER_MPU,
 };
 
-struct omap_hwmod_addr_space am33xx_mdio_addr_space[] = {
+static struct omap_hwmod_addr_space am33xx_mdio_addr_space[] = {
 	{
 		.pa_start	= 0x4A101000,
 		.pa_end		= 0x4A101000 + SZ_256 - 1,
@@ -2523,7 +2523,7 @@ struct omap_hwmod_addr_space am33xx_mdio_addr_space[] = {
 	{ }
 };
 
-struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio = {
+static struct omap_hwmod_ocp_if am33xx_cpgmac0__mdio = {
 	.master		= &am33xx_cpgmac0_hwmod,
 	.slave		= &am33xx_mdio_hwmod,
 	.addr		= am33xx_mdio_addr_space,


