From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [RFC v2 08/18] ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod entry
Date: Mon, 31 Dec 2012 18:37:01 +0530
Message-ID: <1356959231-17335-9-git-send-email-vaibhav.bedia@ti.com>
References: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51544 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171Ab2LaNIV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Dec 2012 08:08:21 -0500
In-Reply-To: <1356959231-17335-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tony@atomide.com, khilman@deeprootsystems.com
Cc: Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Vaibhav Hiremath <hvaibhav@ti.com>

The current HWMOD code expects the memory region with
the IP's SYSCONFIG register to be marked with ADDR_TYPE_RT
flag.

CPGMAC0 hwmod entry specifies two memory regions and marks
both with the flag ADDR_TYPE_RT although only the 2nd region
has the SYSCONFIG register. This leads to the HWMOD code
accessing the wrong memory address for idle and standby
operations. Fix this by removing the ADDR_TYPE_RT flag from
the 1st memory region in CPGMAC0 hwmod entry.

Signed-off-by: Vaibhav Bedia <vaibhav.bedia@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Vaibhav Hiremath <hvaibhav@ti.com>
---
v1->v2:
	Address review comments from Santosh and
	Vaibhav Hiremath. Previous discussion on the change
	is @ http://lists.infradead.org/pipermail/linux-arm-kernel/2012-November/129512.html

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index 5c34d4b..863ce08 100644
--- a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
@@ -2496,7 +2496,6 @@ static struct omap_hwmod_addr_space am33xx_cpgmac0_addr_space[] = {
 	{
 		.pa_start	= 0x4a100000,
 		.pa_end		= 0x4a100000 + SZ_2K - 1,
-		.flags		= ADDR_TYPE_RT,
 	},
 	/* cpsw wr */
 	{
-- 
1.7.0.4

