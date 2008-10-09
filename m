From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: OMAP2 not booting in 2.6.27-rc9?
Date: Thu, 9 Oct 2008 10:32:58 +0300
Message-ID: <20081009103258.cbace620.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:34813 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750795AbYJIHds (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Oct 2008 03:33:48 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com

Hi

At least N810 hangs somewhere executing local_flush_tlb_all() in
omap_map_sram. Last printk is before that call.

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 853048d..5ddf417 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -215,8 +215,11 @@ void __init omap_map_sram(void)
 	 * mdesc->map_io(), but since we're called from map_io(), we
 	 * must do it here.
 	 */
+printk("%s @ %d\n", __func__, __LINE__);
 	local_flush_tlb_all();
+printk("%s @ %d\n", __func__, __LINE__);
 	flush_cache_all();
+printk("%s @ %d\n", __func__, __LINE__);
 
 	/*
 	 * Looks like we need to preserve some bootloader code at the


Reverting Paul's commit below doesn't help.

commit 61db7fb1c78c32b6abdc5c7965981de332aeaa5b
Author: Paul Walmsley <paul@pwsan.com>
Date:   Tue Aug 12 00:04:15 2008 +0100

    [ARM] 5192/1: ARM TLB: add v7wbi_{possible,always}_flags to
{possible,always


However Beagle is still booting fine with my current head

commit 5b99e69f31fa575e53483e1f90c3a88939ca0b95
Merge: f9ceca7... 4330ed8...
Author: Tony Lindgren <tony@atomide.com>
Date:   Tue Oct 7 14:27:17 2008 +0300

    Merge current mainline tree into linux-omap tree
    
    Merge branches 'master' and 'linus'


Jarkko
