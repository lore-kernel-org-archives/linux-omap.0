From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP: igep0020: fix smsc911x dummy regulator id
Date: Wed, 9 May 2012 08:23:59 -0700
Message-ID: <20120509152358.GH5088@atomide.com>
References: <1336555679-15676-1-git-send-email-ebutera@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:30578 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759778Ab2EIPYD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 May 2012 11:24:03 -0400
Content-Disposition: inline
In-Reply-To: <1336555679-15676-1-git-send-email-ebutera@users.sourceforge.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enrico Butera <ebutera@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>, Enrico Butera <ebutera@users.berlios.de>

* Enrico Butera <ebutera@users.sourceforge.net> [120509 02:32]:
> From: Enrico Butera <ebutera@users.berlios.de>
> 
> id 0 is already used and causes errors at boot:
> 
> WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9c/0xac()
> sysfs: cannot create duplicate filename '/devices/platform/reg-fixed-voltage.0'
> 
> Fix it by using the next available one (id=1).

Thanks adding into fixes with updated comments for the regression,
updated patch below.

Tony


From: Enrico Butera <ebutera@users.berlios.de>
Date: Wed, 9 May 2012 11:27:59 +0200
Subject: [PATCH] ARM: OMAP: igep0020: fix smsc911x dummy regulator id

id 0 is already used and causes errors at boot:

WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9c/0xac()
sysfs: cannot create duplicate filename '/devices/platform/reg-fixed-voltage.0'

Fix it by using the next available one (id=1).

This was caused by 5b3689f4 (ARM: OMAP2+: smsc911x: Add fixed
board regulators) that did not account for some regulators
already being used.

Signed-off-by: Enrico Butera <ebutera@users.berlios.de>
[tony@atomide.com: updated comments for regression causing commit]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-igep0020.c b/arch/arm/mach-omap2/board-igep0020.c
index 930c0d3..740cee9 100644
--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -641,7 +641,7 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 
 static void __init igep_init(void)
 {
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	regulator_register_fixed(1, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 
 	/* Get IGEP2 hardware revision */
