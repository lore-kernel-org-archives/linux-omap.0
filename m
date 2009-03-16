From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/12] ARM: OMAP3: mmc-twl4030 fix name buffer length
Date: Mon, 16 Mar 2009 10:42:56 -0700
Message-ID: <20090316174255.GC19229@atomide.com>
References: <20090310205824.16425.97745.stgit@localhost> <20090310210608.16425.95680.stgit@localhost> <20090315160007.GC10786@n2100.arm.linux.org.uk> <49BE2437.6090306@nokia.com> <20090316101403.GA31868@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="doKZ0ri6bHmN2Q5y"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:49939 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754251AbZCPRnE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 Mar 2009 13:43:04 -0400
Content-Disposition: inline
In-Reply-To: <20090316101403.GA31868@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Adrian Hunter <adrian.hunter@nokia.com>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, David Brownell <dbrownell@users.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--doKZ0ri6bHmN2Q5y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090316 03:14]:
> On Mon, Mar 16, 2009 at 12:04:39PM +0200, Adrian Hunter wrote:
> > Russell King - ARM Linux wrote:
> >> On Tue, Mar 10, 2009 at 02:06:08PM -0700, Tony Lindgren wrote:
> >>> From: Adrian Hunter <adrian.hunter@nokia.com>
> >>>
> >>> Add 1 to buffer length for null terminator.
> >>
> >> Yes, and:
> >>
> >>                 sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
> >>
> >> should be snprintf to ensure that it can't overflow the buffer.
> >>
> >
> > There are only 3 controllers and everyone numbers them 1, 2 and 3.
> 
> So?  You've already had a buffer overflow, so it's clearly time that this
> code got fixed properly.

Here's this one updated to also include the snprintf.

Tony

--doKZ0ri6bHmN2Q5y
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="hsmmc-name-buf-len-v2.patch"

>From 42a81558d840eb69204edb39169227547831dd1b Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Mon, 16 Mar 2009 10:32:33 -0700
Subject: [PATCH] ARM: OMAP3: mmc-twl4030 fix name buffer length, v2

Add 1 to buffer length for null terminator and use snprintf.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
Acked-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mmc-twl4030.c b/arch/arm/mach-omap2/mmc-twl4030.c
index 437f520..84cac87 100644
--- a/arch/arm/mach-omap2/mmc-twl4030.c
+++ b/arch/arm/mach-omap2/mmc-twl4030.c
@@ -59,7 +59,7 @@ static struct twl_mmc_controller {
 	struct omap_mmc_platform_data	*mmc;
 	u8		twl_vmmc_dev_grp;
 	u8		twl_mmc_dedicated;
-	char		name[HSMMC_NAME_LEN];
+	char		name[HSMMC_NAME_LEN + 1];
 } hsmmc[] = {
 	{
 		.twl_vmmc_dev_grp		= VMMC1_DEV_GRP,
@@ -349,7 +349,8 @@ void __init twl4030_mmc_init(struct twl4030_hsmmc_info *controllers)
 			return;
 		}
 
-		sprintf(twl->name, "mmc%islot%i", c->mmc, 1);
+		snprintf(twl->name, ARRAY_SIZE(twl->name), "mmc%islot%i",
+				c->mmc, 1);
 		mmc->slots[0].name = twl->name;
 		mmc->nr_slots = 1;
 		mmc->slots[0].ocr_mask = MMC_VDD_165_195 |

--doKZ0ri6bHmN2Q5y--
