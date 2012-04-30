From: Tony Lindgren <tony@atomide.com>
Subject: Re: "smsc911x: Add fixed board regulators" problem
Date: Mon, 30 Apr 2012 09:11:55 -0700
Message-ID: <20120430161155.GD3739@atomide.com>
References: <CA+2YH7tPBeJARm=ipq=HTtqNH6pDu8yQKMRMgL1Cz9rkSpzRBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:48708 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753506Ab2D3QL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 30 Apr 2012 12:11:59 -0400
Content-Disposition: inline
In-Reply-To: <CA+2YH7tPBeJARm=ipq=HTtqNH6pDu8yQKMRMgL1Cz9rkSpzRBQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Enrico <ebutera@users.sourceforge.net>
Cc: linux-omap@vger.kernel.org, Russ Dill <Russ.Dill@ti.com>, Enric Balletbo i Serra <eballetbo@iseebcn.com>

Hi,

* Enrico <ebutera@users.sourceforge.net> [120430 08:02]:
> Hi,
> 
> hi get this at boot on an IGEP board (igep0020), latest linux-omap
> master (20 Apr):
> 
> [    0.047704] WARNING: at fs/sysfs/dir.c:508 sysfs_add_one+0x9c/0xac()
> [    0.047712] sysfs: cannot create duplicate filename
> '/devices/platform/reg-fixed-voltage.0'

This is because of trying to create multiple fixed regulators with
id 0 as discussed earlier. AFAIK there's still no clean way to deal
with that unfortunately..

Can you try changing the id to something random like below?

Regards,

Tony


--- a/arch/arm/mach-omap2/board-igep0020.c
+++ b/arch/arm/mach-omap2/board-igep0020.c
@@ -641,7 +641,7 @@ static struct regulator_consumer_supply dummy_supplies[] = {
 
 static void __init igep_init(void)
 {
-	regulator_register_fixed(0, dummy_supplies, ARRAY_SIZE(dummy_supplies));
+	regulator_register_fixed(42, dummy_supplies, ARRAY_SIZE(dummy_supplies));
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 
 	/* Get IGEP2 hardware revision */
