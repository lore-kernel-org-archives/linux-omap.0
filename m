From: David Cross <david.cross@cypress.com>
Subject: Re: [PATCH] gpmc, EXPORT_SYMBOLS, west bridge related
Date: Tue, 07 Sep 2010 12:26:47 -0700
Message-ID: <1283887607.7250.10.camel@odc-laptop>
Reply-To: david.cross@cypress.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns2.cypress.com ([157.95.67.5]:40691 "EHLO ns2.cypress.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758074Ab0IGT0z (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 7 Sep 2010 15:26:55 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

This patch exports some of the gpmc driver functions in OMAP3. The purpose behind this patch 
is to allow device drivers compiled as loadable modules to be interfaced to the GPMC. I am
hoping that Tony is the correct maintainer and willing to ACK this change. Please let me know 
if there are any issues or concerns with this patch.
Thanks,
David

Signed-off-by: David Cross <david.cross@cypress.com>

diff -uprN -X linux-next-vanilla/Documentation/dontdiff linux-next-vanilla/arch/arm/mach-omap2/gpmc.c linux-next-incl-sdk/arch/arm/mach-omap2/gpmc.c
--- linux-next-vanilla/arch/arm/mach-omap2/gpmc.c	2010-08-31 19:32:51.000000000 -0700
+++ linux-next-incl-sdk/arch/arm/mach-omap2/gpmc.c	2010-09-01 16:10:21.000000000 -0700
@@ -133,6 +133,7 @@ void gpmc_cs_write_reg(int cs, int idx, 
 	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
 	__raw_writel(val, reg_addr);
 }
+EXPORT_SYMBOL(gpmc_cs_write_reg);
 
 u32 gpmc_cs_read_reg(int cs, int idx)
 {
@@ -141,6 +142,7 @@ u32 gpmc_cs_read_reg(int cs, int idx)
 	reg_addr = gpmc_base + GPMC_CS0_OFFSET + (cs * GPMC_CS_SIZE) + idx;
 	return __raw_readl(reg_addr);
 }
+EXPORT_SYMBOL(gpmc_cs_read_reg);
 
 /* TODO: Add support for gpmc_fck to clock framework and use it */
 unsigned long gpmc_get_fclk_period(void)
@@ -294,6 +296,7 @@ int gpmc_cs_set_timings(int cs, const st
 
 	return 0;
 }
+EXPORT_SYMBOL(gpmc_cs_set_timings);
 
 static void gpmc_cs_enable_mem(int cs, u32 base, u32 size)
 {


---------------------------------------------------------------
This message and any attachments may contain Cypress (or its
subsidiaries) confidential information. If it has been received
in error, please advise the sender and immediately delete this
message.
---------------------------------------------------------------

