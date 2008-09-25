From: "Rajendra Nayak" <rnayak@ti.com>
Subject: RE: clk_disable_unused() is bugged
Date: Thu, 25 Sep 2008 10:23:16 +0530
Message-ID: <00c701c91eca$a16afc20$LocalHost@wipultra1382>
References: <alpine.DEB.2.00.0809240807450.15312@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:53177 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750841AbYIYExf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Sep 2008 00:53:35 -0400
In-Reply-To: <alpine.DEB.2.00.0809240807450.15312@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: 'Paul Walmsley' <paul@pwsan.com>, Tero.Kristo@nokia.com
Cc: linux-omap@vger.kernel.org

Hi Paul,

I tried this patch on top of the pm-1 branch. On the 3430SDP I see idle being able to
hit CORE RET, but system suspend seems to crash. See the crash log below.

regards,
Rajendra

# echo mem > /sys/power/state
<6>PM: Syncing filesystems ... PM: Syncing filesystems ... done.
done.
Freezing user space processes ... Freezing user space processes ... (elapsed 0.0
0 seconds) (elapsed 0.00 seconds) done.
done.
Freezing remaining freezable tasks ... Freezing remaining freezable tasks ... (e
lapsed 0.00 seconds) (elapsed 0.00 seconds) done.done.

Suspending console(s) (use no_console_suspend to debug)
Suspending console(s) (use no_console_suspend to debug)
<1>Unhandled fault: external abort on non-linefetch (0x1028) at 0xd8050440
Internal error: : 1028 [#1]
Modules linked in:
CPU: 0    Not tainted  (2.6.27-rc7-omap1-04977-g9e6782a-dirty #16)
PC is at omap_dispc_enable_lcd_out+0x28/0x48
LR is at clk_enable+0x44/0x58
pc : [<c018698c>]    lr : [<c003c4c8>]    psr: 20000013
sp : c7a3bd90  ip : c7a3bd60  fp : c7a3bda4
r10: c0376b4c  r9 : 00000005  r8 : c0365cbc
r7 : c797fc00  r6 : 00000000  r5 : 00000000  r4 : 00000000
r3 : c038eb48  r2 : d8050400  r1 : 00000008  r0 : 00000000
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
Control: 00c5387f  Table: 87a44018  DAC: 00000015
Process sh (pid: 382, stack limit = 0xc7a3a2e0)
Stack: (0xc7a3bd90 to 0xc7a3c000)
bd80:                                     c7a3bd28 c038eb48 c7a3bdbc c7a3bda8
bda0: c0188098 c0186970 c791dc00 00000003 c7a3be24 c7a3bdc0 c0184858 c0188070
bdc0: 00000002 c789e0b4 00000005 c0376b4c c7a3bdf4 c7a3bde0 c01b4e78 c01b4d74
bde0: c7a3be24 002bdc00 c7a3be0c c7a3bdf8 c02033d4 c01b4e5c 00000000 c006e444
be00: c7a3be1c c7a3be1c c0376a1c c0365c10 00000000 00000002 c7a3be34 c7a3be28
be20: c0185b68 c018479c c7a3be44 c7a3be38 c01a8d48 c0185b50 c7a3be54 c7a3be48
be40: c01a8e38 c01a8d34 c7a3be6c c7a3be58 c01aaeb4 c01a8df4 00000000 c0365c10
be60: c7a3bea4 c7a3be70 c01ab2cc c01aae88 c78444d4 c79b4ed4 c0052ddc c0389c3c
be80: 00000003 00000003 c7a17000 00000004 c7a2dbb8 c029dbbc c7a3bec4 c7a3bea8
bea0: c0074c24 c01aaf84 00000000 c0389f44 00000003 00000003 c7a3bedc c7a3bec8
bec0: c0074e60 c0074be4 c030f868 00000003 c7a3bf04 c7a3bee0 c0074f6c c0074da0
bee0: c780fcc8 00000004 c7a2dba0 c780a7a0 c03727a8 c7a3bf70 c7a3bf14 c7a3bf08
bf00: c0168598 c0074ed0 c7a3bf44 c7a3bf18 c00dd558 c0168584 c7a3a000 c79fc920
bf20: 40018000 c7a3bf70 00000004 40018000 c7a3a000 00000000 c7a3bf6c c7a3bf48
bf40: c009c574 c00dd454 00000003 00000003 00000000 00000000 c79fc920 00000004
bf60: c7a3bfa4 c7a3bf70 c009ca2c c009c4c8 00000000 00000000 c79fc920 00000000
bf80: c7a3bfa4 00000004 40018000 4022c4f8 00000004 c002dd68 00000000 c7a3bfa8
bfa0: c002dbc0 c009c9f4 00000004 40018000 00000001 40018000 00000004 00000000
bfc0: 00000004 40018000 4022c4f8 00000004 00000004 0000000a 4022c000 00000874
bfe0: 00000004 becb75f0 40175aa0 401c249c 60000010 00000001 8049e021 8049e421
Backtrace:
[<c0186964>] (omap_dispc_enable_lcd_out+0x0/0x48) from [<c0188098>] (omap_dispc_
suspend+0x34/0x88)
 r4:c038eb48
[<c0188064>] (omap_dispc_suspend+0x0/0x88) from [<c0184858>] (omapfb_blank+0xc8/
0x198)
 r5:00000003 r4:c791dc00
[<c0184790>] (omapfb_blank+0x0/0x198) from [<c0185b68>] (omapfb_suspend+0x24/0x2
c)
 r7:00000002 r6:00000000 r5:c0365c10 r4:c0376a1c
[<c0185b44>] (omapfb_suspend+0x0/0x2c) from [<c01a8d48>] (platform_drv_suspend+0
x20/0x24)
[<c01a8d28>] (platform_drv_suspend+0x0/0x24) from [<c01a8e38>] (platform_pm_susp
end+0x50/0x5c)
[<c01a8de8>] (platform_pm_suspend+0x0/0x5c) from [<c01aaeb4>] (pm_op+0x38/0x7c)
[<c01aae7c>] (pm_op+0x0/0x7c) from [<c01ab2cc>] (device_suspend+0x354/0x47c)
 r5:c0365c10 r4:00000000
[<c01aaf78>] (device_suspend+0x0/0x47c) from [<c0074c24>] (suspend_devices_and_e
nter+0x4c/0x150)
[<c0074bd8>] (suspend_devices_and_enter+0x0/0x150) from [<c0074e60>] (enter_stat
e+0xcc/0x130)
 r6:00000003 r5:00000003 r4:c0389f44
[<c0074d94>] (enter_state+0x0/0x130) from [<c0074f6c>] (state_store+0xa8/0xc4)
 r5:00000003 r4:c030f868
[<c0074ec4>] (state_store+0x0/0xc4) from [<c0168598>] (kobj_attr_store+0x20/0x24
)
[<c0168578>] (kobj_attr_store+0x0/0x24) from [<c00dd558>] (sysfs_write_file+0x11
0/0x144)
[<c00dd448>] (sysfs_write_file+0x0/0x144) from [<c009c574>] (vfs_write+0xb8/0x14
8)
[<c009c4bc>] (vfs_write+0x0/0x148) from [<c009ca2c>] (sys_write+0x44/0x70)
 r7:00000004 r6:c79fc920 r5:00000000 r4:00000000
[<c009c9e8>] (sys_write+0x0/0x70) from [<c002dbc0>] (ret_fast_syscall+0x0/0x2c)
 r8:c002dd68 r7:00000004 r6:4022c4f8 r5:40018000 r4:00000004
Code: ebfffef2 e59f3020 e3a00000 e5932000 (e5923040)
<4>---[ end trace 1c65dc045eaee4ae ]---

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org 
> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Paul Walmsley
> Sent: Wednesday, September 24, 2008 7:40 PM
> To: Tero.Kristo@nokia.com
> Cc: linux-omap@vger.kernel.org
> Subject: Re: clk_disable_unused() is bugged
> 
> Hello Tero (and anyone else),
> 
> On Wed, 24 Sep 2008, Tero.Kristo@nokia.com wrote:
> 
> > clk_disable_unused (in plat-omap/clock.c) is bugged in 
> latest kernel. It
> > checks whether ck->enable_reg is zero, and in most cases 
> this happens to
> > be so (CM_FCLKEN = 0.) Seems to be caused by some late change to
> > clocktree where enable_reg fields are defined as module offsets, not
> > register addresses. This bug causes several clocks to remain enabled
> > after boot, and at least on OMAP3 it prevents retention.
> > 
> > Paul, you got a fix coming for this?
> 
> Yes, here's something that should at least fix the 
> clk_disable_unused() 
> problem.  It seems to work on 2430SDP and 3430SDP here.  
> 
> Any other help testing from anyone else is appreciated -
> 
> 
> - Paul
> 
> 
> Author: Paul Walmsley <paul@pwsan.com>
> Date:   Wed Sep 24 04:48:05 2008 -0600
> 
>     OMAP2/3 clock: fix CONFIG_OMAP_RESET_CLOCKS
>     
>     plat-omap/clock.c was skipping clocks with enable_reg == 
> 0.  This no longer
>     works now that we use enable_reg as an offset from a PRCM module.
>     
>     Problem found and traced by Tero Kristo <tero.kristo@nokia.com> -
>     thanks Tero.
>     
>     Signed-off-by: Paul Walmsley <paul@pwsan.com>
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 197974d..7bbfba2 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -384,8 +384,11 @@ static int __init clk_disable_unused(void)
>  	unsigned long flags;
>  
>  	list_for_each_entry(ck, &clocks, node) {
> -		if (ck->usecount > 0 || (ck->flags & ALWAYS_ENABLED) ||
> -			ck->enable_reg == 0)
> +		if (ck->usecount > 0 ||
> +		    (ck->flags & (ALWAYS_ENABLED | 
> PARENT_CONTROLS_CLOCK)))
> +			continue;
> +
> +		if (cpu_class_is_omap1() && ck->enable_reg == 0)
>  			continue;
>  
>  		spin_lock_irqsave(&clockfw_lock, flags);
> --
> To unsubscribe from this list: send the line "unsubscribe 
> linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

