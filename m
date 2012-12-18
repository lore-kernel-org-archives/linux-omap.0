From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Re: omap DSS fails with tft410 driver panel?
Date: Tue, 18 Dec 2012 09:31:39 +0100
Message-ID: <CAAwP0s3hYiovSqRfBFDGVQCDVUqYKZrY9QXp+G-R707szdmVqA@mail.gmail.com>
References: <CAFqH_50PVJdbX0CMwo9t3RuAhzi3q6jcBwzq2R3UFighkrF7iw@mail.gmail.com>
 <CAGDS+nmx8qFSx932TudMN6ikmZ=OGkbvrZuCV=Ump+HETkU-tw@mail.gmail.com>
 <50ADE6A5.3030001@ti.com> <CAGDS+nm2YVNyq+eAF-VSq785KAKWC2GM4v5U7N1vLGTNNDfa7Q@mail.gmail.com>
 <50AF37EA.3080400@ti.com> <CAGDS+nncx71OL7tiwEot6RcyFxipj_SVg=z5Sg-Qdv2n4iyL2A@mail.gmail.com>
 <50B4A4D7.2070203@ti.com> <CAGDS+nmaGK1igkYnz0EQEycUU=LsD5yz9wxmipSnWohKvAPTXA@mail.gmail.com>
 <50B74592.3020308@ti.com> <CAGDS+n=oQYr+24mX6bdgtW=fzvfvfX5rAvNXXpxM4YKPxHDodQ@mail.gmail.com>
 <50B771D3.8050907@ti.com> <CAGDS+n=dbuEQgdw9nJ_mYQpuJr5huSgX6e3sBDcvy0+C6T5hFQ@mail.gmail.com>
 <50B777A3.1080803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f53.google.com ([209.85.219.53]:49132 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754390Ab2LRIjw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Dec 2012 03:39:52 -0500
Received: by mail-oa0-f53.google.com with SMTP id j6so327657oag.12
        for <linux-omap@vger.kernel.org>; Tue, 18 Dec 2012 00:39:51 -0800 (PST)
In-Reply-To: <50B777A3.1080803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Steve Sakoman <sakoman@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Javier Martinez Canillas <javier@dowhile0.org>

On Thu, Nov 29, 2012 at 3:56 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 2012-11-29 16:53, Steve Sakoman wrote:
>> On Thu, Nov 29, 2012 at 6:31 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>>
>>>> It is stock Linux 3.6 (i.e. commit a0d271cbfed1dd50278c6b06bead3d00ba0a88f9)
>>>
>>> Still can't reproduce. So does the null pointer deref happen at boot
>>> time? What display related kernel boot options do you have? This looks
>>> funny, considering lcd43 is a bit smaller lcd:
>>
>> Yes, it happens at boot time.
>>
>> The boot options:
>>
>> [    0.000000] Kernel command line: console=ttyO2,115200n8 mpurate=500
>> vram=12M omapfb.mode=dvi:1024x768MR-16@60 omapdss.def_disp=lcd43
>> root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait
>
> Ok, now I see it. It happens because DVI is not configured to be used,
> but you have DVI video mode specified in the command line.
>
> I'll study this further and make a fix.
>
>  Tomi
>
>
>

Hello folks,

Did you find a solution for this?

I still have the issue, when trying to start X I got:

[   25.152160] OMAPFB: ioctl QUERY_PLANE
[   25.156066] OMAPFB: ioctl SETUP_PLANE
[   25.160095] OMAPFB: omapfb_setup_plane
[   25.164093] omapdss OVERLAY error: check_overlay: paddr cannot be 0
[   25.170684] omapdss OVERLAY error: check_overlay: paddr cannot be 0
[   25.177337] omapfb omapfb: setup_plane failed
[   25.181976] OMAPFB: ioctl failed: -22

I'm using the arm-soc.git tree with the latest fixes and cleanups for
v3.8 sent by Tony yesterday and Xorg 1.13.

The latest commit id is:

commit aad05c3602ba5c42ff8d0e572b2f614f25779ede
Merge: eccf4b3 f64d204
Author: Olof Johansson <olof@lixom.net>
Date:   Mon Dec 17 18:44:26 2012 -0800

    Merge branch 'late/omap-cleanup' into for-next

I've CONFIG_OMAP2_DSS, CONFIG_FB_OMAP2 and CONFIG_PANEL_TFP410
built-in and this is my kernel command line is:

console=ttyO2,115200n8 mpurate=auto vram=12M
omapfb.mode=dvi:1024x768MR-16@60 omapfb.debug=y omapdss.def_disp=dvi
root=/dev/mmcblk0p2 rw rootfstype=ext4 rootwait

Also I have this log about a locking dependency:

[   24.690795]
[   24.690826] ======================================================
[   24.690826] [ INFO: possible circular locking dependency detected ]
[   24.690826] 3.7.0-00017-g6c2ecfb-dirty #144 Not tainted
[   24.690826] -------------------------------------------------------
[   24.690826] Xorg/1259 is trying to acquire lock:
[   24.690887]  ((fb_notifier_list).rwsem){.+.+.+}, at: [<c0068708>]
__blocking_notifier_call_chain+0x30/0x60
[   24.690887]
[   24.690887] but task is already holding lock:
[   24.690917]  (console_lock){+.+.+.}, at: [<c02cec98>] do_fb_ioctl+0x200/0x5d8
[   24.690917]
[   24.690917] which lock already depends on the new lock.
[   24.690917]
[   24.690917]
[   24.690917] the existing dependency chain (in reverse order) is:
[   24.690948]
[   24.690948] -> #1 (console_lock){+.+.+.}:
[   24.690979]        [<c00902a4>] lock_acquire+0x9c/0x124
[   24.690979]        [<c0042b0c>] console_lock+0x50/0x64
[   24.691009]        [<c0320bd0>] register_con_driver+0x38/0x134
[   24.691009]        [<c03221a0>] take_over_console+0x18/0x44
[   24.691040]        [<c02d7674>] fbcon_takeover+0x64/0xc8
[   24.691070]        [<c04f4dd4>] notifier_call_chain+0x44/0x84
[   24.691070]        [<c0068720>] __blocking_notifier_call_chain+0x48/0x60
[   24.691070]        [<c0068750>] blocking_notifier_call_chain+0x18/0x20
[   24.691101]        [<c02cf654>] register_framebuffer+0x16c/0x23c
[   24.691131]        [<c04ee990>] omapfb_create_framebuffers+0x520/0x700
[   24.691131]        [<c0723480>] omapfb_probe+0x4e4/0x768
[   24.691162]        [<c03399f8>] platform_drv_probe+0x18/0x1c
[   24.691162]        [<c03387b4>] driver_probe_device+0x78/0x210
[   24.691192]        [<c03389e0>] __driver_attach+0x94/0x98
[   24.691192]        [<c03370b4>] bus_for_each_dev+0x50/0x7c
[   24.691223]        [<c0337fe0>] bus_add_driver+0x178/0x240
[   24.691223]        [<c0338eb0>] driver_register+0x78/0x144
[   24.691253]        [<c0339be8>] platform_driver_probe+0x18/0x9c
[   24.691253]        [<c0722f70>] omapfb_init+0x28/0x54
[   24.691284]        [<c00086a4>] do_one_initcall+0x34/0x178
[   24.691284]        [<c04e47ac>] kernel_init+0x100/0x2b4
[   24.691314]        [<c0013170>] ret_from_fork+0x14/0x24
[   24.691314]
[   24.691314] -> #0 ((fb_notifier_list).rwsem){.+.+.+}:
[   24.691345]        [<c008f85c>] __lock_acquire+0x15e4/0x1b00
[   24.691345]        [<c00902a4>] lock_acquire+0x9c/0x124
[   24.691375]        [<c04f0eb8>] down_read+0x2c/0x3c
[   24.691375]        [<c0068708>] __blocking_notifier_call_chain+0x30/0x60
[   24.691406]        [<c0068750>] blocking_notifier_call_chain+0x18/0x20
[   24.691406]        [<c02ce1c0>] fb_blank+0x34/0x98
[   24.691436]        [<c02cecb0>] do_fb_ioctl+0x218/0x5d8
[   24.691436]        [<c0114924>] do_vfs_ioctl+0x80/0x5f0
[   24.691467]        [<c0114f04>] sys_ioctl+0x70/0x78
[   24.691467]        [<c00130c0>] ret_fast_syscall+0x0/0x3c
[   24.691467]
[   24.691467] other info that might help us debug this:
[   24.691467]
[   24.691497]  Possible unsafe locking scenario:
[   24.691497]
[   24.691497]        CPU0                    CPU1
[   24.691497]        ----                    ----
[   24.691497]   lock(console_lock);
[   24.691497]                                lock((fb_notifier_list).rwsem);
[   24.691528]                                lock(console_lock);
[   24.691528]   lock((fb_notifier_list).rwsem);
[   24.691528]
[   24.691528]  *** DEADLOCK ***
[   24.691528]
[   24.691528] 2 locks held by Xorg/1259:
[   24.691558]  #0:  (&fb_info->lock){+.+.+.}, at: [<c02cdf9c>]
lock_fb_info+0x18/0x3c
[   24.691589]  #1:  (console_lock){+.+.+.}, at: [<c02cec98>]
do_fb_ioctl+0x200/0x5d8
[   24.691589]
[   24.691589] stack backtrace:
[   24.691619] [<c001ac2c>] (unwind_backtrace+0x0/0xf0) from
[<c04eb508>] (print_circular_bug+0x278/0x2c4)
[   24.691650] [<c04eb508>] (print_circular_bug+0x278/0x2c4) from
[<c008f85c>] (__lock_acquire+0x15e4/0x1b00)
[   24.691650] [<c008f85c>] (__lock_acquire+0x15e4/0x1b00) from
[<c00902a4>] (lock_acquire+0x9c/0x124)
[   24.691680] [<c00902a4>] (lock_acquire+0x9c/0x124) from
[<c04f0eb8>] (down_read+0x2c/0x3c)
[   24.691711] [<c04f0eb8>] (down_read+0x2c/0x3c) from [<c0068708>]
(__blocking_notifier_call_chain+0x30/0x60)
[   24.691711] [<c0068708>] (__blocking_notifier_call_chain+0x30/0x60)
from [<c0068750>] (blocking_notifier_call_chain+0x18/0x20)
[   24.691741] [<c0068750>] (blocking_notifier_call_chain+0x18/0x20)
from [<c02ce1c0>] (fb_blank+0x34/0x98)
[   24.691741] [<c02ce1c0>] (fb_blank+0x34/0x98) from [<c02cecb0>]
(do_fb_ioctl+0x218/0x5d8)
[   24.691772] [<c02cecb0>] (do_fb_ioctl+0x218/0x5d8) from
[<c0114924>] (do_vfs_ioctl+0x80/0x5f0)
[   24.691772] [<c0114924>] (do_vfs_ioctl+0x80/0x5f0) from
[<c0114f04>] (sys_ioctl+0x70/0x78)
[   24.691802] [<c0114f04>] (sys_ioctl+0x70/0x78) from [<c00130c0>]
(ret_fast_syscall+0x0/0x3c)

I will look at this, but just wanted to ask first in case I missed
some patches that already fix this.

My complete .config [1], dmesg [2] and xorg.conf [3].

Thanks a lot and best regards,
Javier

[1]: http://fpaste.org/DJgw/
[2]: http://fpaste.org/XEs5/
[3]: http://fpaste.org/dhWd/
