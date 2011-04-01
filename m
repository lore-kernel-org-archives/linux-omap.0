From: Luciano Coelho <coelho@ti.com>
Subject: [PATCH 2.6.39] omap: board-4430sdp: revert hsmmc_info reordering
Date: Fri,  1 Apr 2011 09:52:28 +0300
Message-ID: <1301640748-17161-1-git-send-email-coelho@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:40857 "EHLO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754512Ab1DAGwA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Apr 2011 02:52:00 -0400
Received: by ewy10 with SMTP id 10so920607ewy.9
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 23:51:57 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Kishore Kadiyala <kishore.kadiyala@ti.com>, Benoit Cousson <b-cousson@ti.com>

The order in which the MMC cards are defined in the the 4430sdp board
file seems to have been mistakenly reorderded as part of an unrelated
patch.  In commit 0005ae73cfe44ee42d0be12a12cc82bf982f518e, where only
the dev_name was supposed to be changed, the mmc order was changed as
well.  This caused the external SD card reader not to be recognized,
at least on Blaze.

This patch reverts this change so that the external SD card is
recognized again.

Cc: Kishore Kadiyala <kishore.kadiyala@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Luciano Coelho <coelho@ti.com>
---

I have started investigating the cause for this problem, because it
seems to me that the value in the mmc element is what should matter,
but it doesn't seem to be the case.  I believe there is a bug
elsewhere, that causes the order of the array to matter, but I'm not
very familiar with hsmmc and I don't have much time right now to delve
into the problem, so I leave this to the omap people. ;) I can always
help testing if necessary.

The change indeed seems to have been a mistake, because it was
introduced silently in v6:
https://patchwork.kernel.org/patch/595861/

In v5, the change was not there:
https://patchwork.kernel.org/patch/590441/

 arch/arm/mach-omap2/board-4430sdp.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 56702c5..8991d56 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -351,6 +351,11 @@ static struct twl4030_usb_data omap4_usbphy_data = {
 
 static struct omap2_hsmmc_info mmc[] = {
 	{
+		.mmc		= 1,
+		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
+		.gpio_wp	= -EINVAL,
+	},
+	{
 		.mmc		= 2,
 		.caps		=  MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
 		.gpio_cd	= -EINVAL,
@@ -358,11 +363,6 @@ static struct omap2_hsmmc_info mmc[] = {
 		.nonremovable   = true,
 		.ocr_mask	= MMC_VDD_29_30,
 	},
-	{
-		.mmc		= 1,
-		.caps		= MMC_CAP_4_BIT_DATA | MMC_CAP_8_BIT_DATA,
-		.gpio_wp	= -EINVAL,
-	},
 	{}	/* Terminator */
 };
 
-- 
1.7.1

