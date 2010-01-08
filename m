From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] omap: Fix cmdline muxing (Re: New pinmux)
Date: Fri, 8 Jan 2010 10:00:31 -0800
Message-ID: <20100108180031.GB6831@atomide.com>
References: <4B474F9B.9020409@balister.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:64886 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985Ab0AHSA3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 13:00:29 -0500
Content-Disposition: inline
In-Reply-To: <4B474F9B.9020409@balister.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Philip Balister <philip@balister.org>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Philip Balister <philip@balister.org> [100108 07:35]:
> I am trying to work out how to use the new pinmux code on my
> Overo+Summit system. I have a recent git running with the new pinmux
> code built. I am trying to configure the mcspi1_clk pin on the
> expansion connector as gpio_171 with the following:
> 
> root@overo:~# dmesg |grep mux
> 
> Kernel command line: console=ttyS2,115200n8 vram=12M
> omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y
> omapdss.def_display=dvi root=/dev/mmcblk0p2 rw rootfstype=ext3
> rootwait omap_mux=mcspi1_clk.gpio_171=0x0
> 
> And this is what happens :(
> 
> mux: Could not set signal mcspi1_clk
> 
> mux: Setting signal i2c3_scl.i2c3_scl 0x0118 -> 0x0100
> 
> Any suggestions?

Sounds like the cmdline options got broken by some changes
I did to limit everything to happen as __init..

Can you please try the following patch?

Regards,

Tony

--WIyZ46R2i8wDzkSu
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: inline; filename="mux-fix-cmdline.patch"

>From 3b7bbb130c01ec7a2d4337d43bbfbc4e1fe1615b Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Fri, 8 Jan 2010 09:45:11 -0800
Subject: [PATCH] omap: Fix cmdline muxing

Looks like cmdline muxing got broken at some point when we
decided to limit muxing to __init code. Currently omap_mux_entry
list is not yet initialized when we try to initialize cmdline
muxing.

Fix this by calling omap_mux_init_list() before calling
omap_mux_set_cmdline_signals().

Reported-by: Philip Balister <philip@balister.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
index 459ef23..40ea9fd 100644
--- a/arch/arm/mach-omap2/mux.c
+++ b/arch/arm/mach-omap2/mux.c
@@ -998,12 +998,15 @@ int __init omap_mux_init(u32 mux_pbase, u32 mux_size,
 		omap_mux_package_fixup(package_subset, superset);
 	if (package_balls)
 		omap_mux_package_init_balls(package_balls, superset);
-	omap_mux_set_cmdline_signals();
-	omap_mux_set_board_signals(board_mux);
 #endif
 
 	omap_mux_init_list(superset);
 
+#ifdef CONFIG_OMAP_MUX
+	omap_mux_set_cmdline_signals();
+	omap_mux_set_board_signals(board_mux);
+#endif
+
 	return 0;
 }
 

--WIyZ46R2i8wDzkSu--
