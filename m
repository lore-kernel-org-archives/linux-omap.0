From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [REVIEW PATCH] Added OMAP3EVM support on Tomis FBDEV/DSS Patches
Date: Sat, 15 Nov 2008 14:15:24 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E5F2B75D@dbde02.ent.ti.com>
References: <C98171C5-A13C-4FE0-97DD-8BCF356212F2@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51211 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753313AbYKOIpo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 15 Nov 2008 03:45:44 -0500
In-Reply-To: <C98171C5-A13C-4FE0-97DD-8BCF356212F2@student.utwente.nl>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <k.kooi@student.utwente.nl>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: Koen Kooi [mailto:k.kooi@student.utwente.nl]
> Sent: Saturday, November 15, 2008 1:14 AM
> To: Tomi Valkeinen
> Cc: Hiremath, Vaibhav; linux-fbdev-devel@lists.sourceforge.net;
> linux-omap@vger.kernel.org
> Subject: Re: [REVIEW PATCH] Added OMAP3EVM support on Tomis
> FBDEV/DSS Patches
> 
> 
> Op 14 nov 2008, om 16:53 heeft Tomi Valkeinen het volgende
> geschreven:
> 
> > Hi,
> > On Fri, 2008-11-14 at 18:05 +0530, ext Hiremath, Vaibhav wrote:
> >
> >>>
> >>> I think the LCD panel on SDP and EVM boards are the same, so we
> >>> should
> >>> only have one driver. Do you have specifications about the LCD?
> The
> >>> manufacturer, model etc?. I didn't find any proper information
> about
> >>> the
> >>> LCD.
> >>>
> >> [Hiremath, Vaibhav] The LCD on OMAP3EVM is Sharp LCD (Model No. -
> >> LS037V7DW01).
> >> Koen has already conformed that panel3430sdp.c is working with
> >> OMAP3EVM, let me try at my end. If it works properly then we can
> >> have same file to build for both SDP and EVM. But in that case it
> >> make sense to rename file to panel-lcd.c.
> >>
> >
> > I took the liberty to add you EVM changes to my tree, with a
> comment
> > about the origin. I also changed the SDP panel name to sharp
> panel,
> > and
> > made both EVM and SDP use that. But I can't test the EVM, as I
> don't
> > have one.
> 
> I finally got rc4 working on evm and with your latest patches I get:
> 
[Hiremath, Vaibhav] What was the issue you figured out?

> udevd version 124 started
> eth0: link down
> eth0: link up, 100Mbps, full-duplex, lpa 0x8DE1
> DSS2 debug: best_ld is 1, best_pd is 3
> DSS2 debug: best_ld is 1, best_pd is 3
> DSS2 debug: best.lck_div is 1, best.pck_div is 3
> omap-dss DISPLAY: omap_dss_mgr_apply(lcd)
> omap-dss DISPC: dispc_setup_plane 0, 87200000, sw 480, 0,0, 480x640
> ->
> 480x640, (ilace 0)
> omap-dss DISPC: dispc_enable_plane 0, 1
> omap-dss DISPC: dispc_enable_plane 1, 0
> omap-dss DISPC: dispc_enable_plane 2, 0
> omap-dss DISPC: GO LCD
> Division by zero in kernel.
[Hiremath, Vaibhav] Are you using the patch I submitted or the merged code from Tomi?

> [<c0033a60>] (dump_stack+0x0/0x14) from [<c0033a8c>]
> (__div0+0x18/0x20)
> [<c0033a74>] (__div0+0x0/0x20) from [<c01a235c>] (Ldiv0+0x8/0x10)
> [<c01c7f08>] (check_fb_var+0x0/0x35c) from [<c01c8280>]
> (omapfb_check_var+0x1c/0x20)
>   r7:c6711e08 r6:c708bc00 r5:00004601 r4:c01c8264
> [<c01c8264>] (omapfb_check_var+0x0/0x20) from [<c01b55dc>]
> (fb_set_var
> +0xd4/0x254)
> [<c01b5508>] (fb_set_var+0x0/0x254) from [<c01b59c0>] (fb_ioctl
> +0x170/0x4f0)
> [<c01b5850>] (fb_ioctl+0x0/0x4f0) from [<c00c59c8>] (vfs_ioctl
> +0x34/0x94)
>   r8:c0030004 r7:c7b4e6c0 r6:03d7ca30 r5:00004601 r4:c7b4e6c0
> [<c00c5994>] (vfs_ioctl+0x0/0x94) from [<c00c5fc8>] (do_vfs_ioctl
> +0x4a4/0x4e4)
>   r7:c7b4e6c0 r6:03d7ca30 r5:c7b4e6c0 r4:c70f9290
> [<c00c5b24>] (do_vfs_ioctl+0x0/0x4e4) from [<c00c6048>] (sys_ioctl
> +0x40/0x64)
>   r9:c6710000 r8:c0030004 r6:00004601 r5:03d7ca30 r4:00000006
> [<c00c6008>] (sys_ioctl+0x0/0x64) from [<c002fe80>]
> (ret_fast_syscall
> +0x0/0x2c)
>   r7:00000036 r6:00000281 r5:000001fc r4:00000000
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best_ld is 255, best_pd is 255
> DSS2 debug: best.lck_div is 0, best.pck_div is 0
> Division by zero in kernel.
> [<c0033a60>] (dump_stack+0x0/0x14) from [<c0033a8c>]
> (__div0+0x18/0x20)
> [<c0033a74>] (__div0+0x0/0x20) from [<c01a235c>] (Ldiv0+0x8/0x10)
> [<c01c7f08>] (check_fb_var+0x0/0x35c) from [<c01c8280>]
> (omapfb_check_var+0x1c/0x20)
>   r7:c6711e08 r6:c708bc00 r5:00004601 r4:c01c8264
> [<c01c8264>] (omapfb_check_var+0x0/0x20) from [<c01b55dc>]
> (fb_set_var
> +0xd4/0x254)
> [<c01b5508>] (fb_set_var+0x0/0x254) from [<c01b59c0>] (fb_ioctl
> +0x170/0x4f0)
> [<c01b5850>] (fb_ioctl+0x0/0x4f0) from [<c00c59c8>] (vfs_ioctl
> +0x34/0x94)
>   r8:c0030004 r7:c7b4e6c0 r6:03d7ca30 r5:00004601 r4:c7b4e6c0
> [<c00c5994>] (vfs_ioctl+0x0/0x94) from [<c00c5fc8>] (do_vfs_ioctl
> +0x4a4/0x4e4)
>   r7:c7b4e6c0 r6:03d7ca30 r5:c7b4e6c0 r4:c70f9290
> [<c00c5b24>] (do_vfs_ioctl+0x0/0x4e4) from [<c00c6048>] (sys_ioctl
> +0x40/0x64)
>   r9:c6710000 r8:c0030004 r6:00004601 r5:03d7ca30 r4:00000006
> [<c00c6008>] (sys_ioctl+0x0/0x64) from [<c002fe80>]
> (ret_fast_syscall
> +0x0/0x2c)
>   r7:00000036 r6:00000281 r5:000001fc r4:00000000
> omap-dss DISPLAY: omap_dss_mgr_apply(lcd)
> omap-dss DISPC: dispc_setup_plane 0, 87200000, sw 480, 0,0, 480x640
> ->
> 480x640, (ilace 0)
> omap-dss DISPC: dispc_enable_plane 0, 1
> omap-dss DISPC: dispc_enable_plane 1, 0
> omap-dss DISPC: dispc_enable_plane 2, 0
> omap-dss DISPC: GO LCD
> omap-dss DISPLAY: omap_dss_mgr_apply(lcd)
> omap-dss DISPC: dispc_setup_plane 0, 87200000, sw 480, 0,0, 480x640
> ->
> 480x640, (ilace 0)
> omap-dss DISPC: dispc_enable_plane 0, 1
> omap-dss DISPC: dispc_enable_plane 1, 0
> omap-dss DISPC: dispc_enable_plane 2, 0
> omap-dss DISPC: GO LCD
> omap-dss DISPLAY: omap_dss_mgr_apply(lcd)
> omap-dss DISPC: dispc_setup_plane 0, 87200000, sw 480, 0,0, 480x640
> ->
> 480x640, (ilace 0)
> omap-dss DISPC: dispc_enable_plane 0, 1
> omap-dss DISPC: dispc_enable_plane 1, 0
> omap-dss DISPC: dispc_enable_plane 2, 0
> omap-dss DISPC: GO LCD
> 
> the DSS2 printks are at the end of find_lck_pck_divs() and
> dispc_calc_clock_div() in dispc.c.
> 
> regards,
> 
> Koen
