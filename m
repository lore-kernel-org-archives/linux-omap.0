From: Angelo Arrifano <miknix@gmail.com>
Subject: [PATCH 1/3] [ARM] omap850: Fix wrong jtag_id.
Date: Sat, 05 Sep 2009 01:00:59 +0100
Message-ID: <4AA1AA3B.7020007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f217.google.com ([209.85.220.217]:54531 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934002AbZIDX4Q (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Sep 2009 19:56:16 -0400
Received: by fxm17 with SMTP id 17so1000802fxm.37
        for <linux-omap@vger.kernel.org>; Fri, 04 Sep 2009 16:56:18 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: "Zebediah C. McClure" <zmc@lurian.net>

Original message:
The previous value of the jtag_id was set for the omap730.  For the
omap850, this value is different, and this was causing
autodetection to fail.

Reported-by:
  Cory Maccarrone <darkstar6262@gmail.com>
  Angelo Arrifano <miknix@gmail.com>
  Alistair Buxton <a.j.buxton@gmail.com>

Signed-off-by: Angelo Arrifano <miknix@gmail.com>
---
 arch/arm/mach-omap1/id.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 4ef26fa..e5dcdf7 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -38,7 +38,7 @@ static struct omap_id omap_ids[] __initdata = {
 	{ .jtag_id = 0xb574, .die_rev = 0x2, .omap_id = 0x03310315, .type =
0x03100000},
 	{ .jtag_id = 0x355f, .die_rev = 0x0, .omap_id = 0x03320000, .type =
0x07300100},
 	{ .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320000, .type =
0x07300300},
-	{ .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320500, .type =
0x08500000},
+	{ .jtag_id = 0xb62c, .die_rev = 0x1, .omap_id = 0x03320500, .type =
0x08500000},
 	{ .jtag_id = 0xb470, .die_rev = 0x0, .omap_id = 0x03310100, .type =
0x15100000},
 	{ .jtag_id = 0xb576, .die_rev = 0x0, .omap_id = 0x03320000, .type =
0x16100000},
 	{ .jtag_id = 0xb576, .die_rev = 0x2, .omap_id = 0x03320100, .type =
0x16110000},
-- 
1.6.3.3

