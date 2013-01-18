From: Vaibhav Bedia <vaibhav.bedia@ti.com>
Subject: [PATCH 5/9] ARM: OMAP2+: AM33XX: hwmod: Fixup cpgmac0 hwmod entry
Date: Fri, 18 Jan 2013 12:49:25 +0530
Message-ID: <1358493569-17142-6-git-send-email-vaibhav.bedia@ti.com>
References: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41003 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751300Ab3ARHT5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 18 Jan 2013 02:19:57 -0500
In-Reply-To: <1358493569-17142-1-git-send-email-vaibhav.bedia@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, paul@pwsan.com, b-cousson@ti.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, khilman@deeprootsystems.com, Vaibhav Bedia <vaibhav.bedia@ti.com>

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
---
Change from RFC version:
	No change

 arch/arm/mach-omap2/omap_hwmod_33xx_data.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_33xx_data.c b/arch/arm/mach-omap2/omap_hwmod_33xx_data.c
index f2f408c..34a67e4 100644
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

