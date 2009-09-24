From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 08/12] omap: Fix wrong jtag_id for 850
Date: Thu, 24 Sep 2009 16:41:56 -0700
Message-ID: <20090924234156.6065.59640.stgit@localhost>
References: <20090924233027.6065.95725.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54345 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752681AbZIXXlz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Sep 2009 19:41:55 -0400
In-Reply-To: <20090924233027.6065.95725.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Angelo Arrifano <miknix@gmail.com>, linux-omap@vger.kernel.org

From: Angelo Arrifano <miknix@gmail.com>

Original message:
The previous value of the jtag_id was set for the omap730.  For the
omap850, this value is different, and this was causing
autodetection to fail.

Reported-by:
  Cory Maccarrone <darkstar6262@gmail.com>
  Angelo Arrifano <miknix@gmail.com>
  Alistair Buxton <a.j.buxton@gmail.com>

Signed-off-by: Angelo Arrifano <miknix@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/id.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index 4ef26fa..e5dcdf7 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -38,7 +38,7 @@ static struct omap_id omap_ids[] __initdata = {
 	{ .jtag_id = 0xb574, .die_rev = 0x2, .omap_id = 0x03310315, .type = 0x03100000},
 	{ .jtag_id = 0x355f, .die_rev = 0x0, .omap_id = 0x03320000, .type = 0x07300100},
 	{ .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320000, .type = 0x07300300},
-	{ .jtag_id = 0xb55f, .die_rev = 0x0, .omap_id = 0x03320500, .type = 0x08500000},
+	{ .jtag_id = 0xb62c, .die_rev = 0x1, .omap_id = 0x03320500, .type = 0x08500000},
 	{ .jtag_id = 0xb470, .die_rev = 0x0, .omap_id = 0x03310100, .type = 0x15100000},
 	{ .jtag_id = 0xb576, .die_rev = 0x0, .omap_id = 0x03320000, .type = 0x16100000},
 	{ .jtag_id = 0xb576, .die_rev = 0x2, .omap_id = 0x03320100, .type = 0x16110000},

