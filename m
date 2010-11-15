From: Tony Lindgren <tony@atomide.com>
Subject: Re: linux-next 20101115 fails to boot on zoom3
Date: Mon, 15 Nov 2010 09:34:16 -0800
Message-ID: <20101115173415.GI9264@atomide.com>
References: <4CE135B0.8070405@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:49414 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933013Ab0KOReU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Nov 2010 12:34:20 -0500
Content-Disposition: inline
In-Reply-To: <4CE135B0.8070405@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, "Cousson, Benoit" <b-cousson@ti.com>

* Anand Gadiyar <gadiyar@ti.com> [101115 05:19]:
> Hi all,
> 
> Linux-next as of 20101115 fails to boot up on a zoom3. earlyprintk throws
> the following crash.
> 
> [    0.000000] MUX: Add partition: #1: core, flags: 0
> [    0.000000] Unable to handle kernel paging request at virtual address 01000268

I'll merge the following fix into Benoit's patch. Looks like hese patches
need still a bit more testing :)

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Mon, 15 Nov 2010 09:30:11 -0800
Subject: [PATCH] omap: mux: Fix omap_mux_write_array

Otherwise we can get:

MUX: Add partition: #1: core, flags: 0
Unable to handle kernel paging request at virtual address 01000268

Also fix a cosmetic issue in omap_mux_init while.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -796,7 +796,7 @@ static void omap_mux_init_signals(struct omap_mux_partition *partition,
 				  struct omap_board_mux *board_mux)
 {
 	omap_mux_set_cmdline_signals();
-	omap_mux_write_array(partition->base, board_mux);
+	omap_mux_write_array(partition, board_mux);
 }
 
 #else
@@ -816,7 +816,7 @@ static void omap_mux_init_signals(struct omap_mux_partition *partition,
 
 static u32 mux_partitions_cnt;
 
-int __init omap_mux_init(const char * name, u32 flags,
+int __init omap_mux_init(const char *name, u32 flags,
 			 u32 mux_pbase, u32 mux_size,
 			 struct omap_mux *superset,
 			 struct omap_mux *package_subset,
