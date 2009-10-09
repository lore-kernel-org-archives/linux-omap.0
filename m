From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [RFC][PATCH 2/2] OMAP3:PM:SR: SmartReflex Refactor Rev2.0
Date: Fri, 09 Oct 2009 14:37:34 -0700
Message-ID: <87k4z4uu3l.fsf@deeprootsystems.com>
References: <1254443465-13006-1-git-send-email-nm@ti.com>
	<1254443465-13006-2-git-send-email-nm@ti.com>
	<1254443465-13006-3-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:34565 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746AbZJIVis (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Oct 2009 17:38:48 -0400
Received: by pxi9 with SMTP id 9so7072650pxi.4
        for <linux-omap@vger.kernel.org>; Fri, 09 Oct 2009 14:37:36 -0700 (PDT)
In-Reply-To: <1254443465-13006-3-git-send-email-nm@ti.com> (Nishanth Menon's message of "Thu\,  1 Oct 2009 19\:31\:05 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Linux-omap <linux-omap@vger.kernel.org>, Rajendra Nayak <rnayak@ti.com>, Roger Quadros <ext-roger.quadros@nokia.com>, Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>, Teerth Reddy <teerth@ti.com>, Paul Walmsley <paul@pwsan.com>, =?iso-8859-1?Q?H=F6gander?= Jouni <jouni.hogander@nokia.com>, Imberton Guilhem <guilhem.imberton@motorola.com>, Mike Chan <mikechan@google.com>

Nishanth Menon <nm@ti.com> writes:

> Refactor the smart reflex implementation.

One other request for this refactor.

Can you remove the usage of OMAP2_IO_ADDRESS (now gone from l-o master)
in favor of ioremap().

Here's a totally untested first pass and converting the version
currently in PM branch.  Could probably use some better error
detection though, and I didn't look up exactly what size
should be ioremap'd.

Kevin


diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 1407783..bf57b21 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -48,6 +48,7 @@ struct omap_sr {
 	u32		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
 	u32		opp5_nvalue;
 	u32		senp_mod, senn_mod;
+	u32		srbase_phys;
 	void __iomem	*srbase_addr;
 	void __iomem	*vpbase_addr;
 };
@@ -105,7 +106,7 @@ static struct omap_sr sr1 = {
 	.is_sr_reset		= 1,
 	.is_autocomp_active	= 0,
 	.clk_length		= 0,
-	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR1_BASE),
+	.srbase_phys		= OMAP34XX_SR1_BASE,
 };
 
 static struct omap_sr sr2 = {
@@ -113,7 +114,7 @@ static struct omap_sr sr2 = {
 	.is_sr_reset		= 1,
 	.is_autocomp_active	= 0,
 	.clk_length		= 0,
-	.srbase_addr		= OMAP2_IO_ADDRESS(OMAP34XX_SR2_BASE),
+	.srbase_phys		= OMAP34XX_SR2_BASE,
 };
 
 static void cal_reciprocal(u32 sensor, u32 *sengain, u32 *rnsen)
@@ -987,6 +988,11 @@ static int __init omap3_sr_init(void)
 		return -ENODEV;
         }
 
+	sr1.srbase_addr = ioremap(sr1.srbase_phys, SZ_4K);
+	sr2.srbase_addr = ioremap(sr2.srbase_phys, SZ_4K);
+	if (WARN_ON(!sr1.srbase_addr) || WARN_ON(!sr2.srbase_addr))
+		return;
+
 	/* Enable SR on T2 */
 	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
 					R_DCDC_GLOBAL_CFG);
