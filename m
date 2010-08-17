From: Cliff Brake <cliff.brake@gmail.com>
Subject: NAND ECC in linux-omap
Date: Tue, 17 Aug 2010 17:56:36 -0400
Message-ID: <AANLkTimABq72N98Ca6yJ9FgYnyDpod3qRPoTypkDn-4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46161 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751057Ab0HQV4i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Aug 2010 17:56:38 -0400
Received: by wwi17 with SMTP id 17so1700976wwi.1
        for <linux-omap@vger.kernel.org>; Tue, 17 Aug 2010 14:56:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Users <linux-omap@vger.kernel.org>, Sukumar Ghorai <s-ghorai@ti.com>

Hi,

I'm using the latest pm branch (based on linux-omap I think), and
running into the following problems.

The first is my x-loader uses software ECC.  Looking in the omap nand
driver, I made the following change which gets x-loader/u-boot working
again:

diff --git a/drivers/mtd/nand/omap2.c b/drivers/mtd/nand/omap2.c
index 133d515..1593c60 100644
--- a/drivers/mtd/nand/omap2.c
+++ b/drivers/mtd/nand/omap2.c
@@ -7,7 +7,7 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#define CONFIG_MTD_NAND_OMAP_HWECC
+//#define CONFIG_MTD_NAND_OMAP_HWECC

 #include <linux/platform_device.h>
 #include <linux/dma-mapping.h>

But, I'm still getting a ton of ECC errors in JFFS2 flash filesystem.
Does anyone have any suggestions as to where to go from here?  I see
some patches on the mail lists from Sukumar Ghorai that make HW/SW ECC
selectable from the board file.

Thanks,
Cliff

-- 
=================
http://bec-systems.com
