From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: Beagleboard xM - play video file : BUG: scheduling while atomic:
 queue1:src/92/0x0000008e , then kernel panic
Date: Wed, 24 Oct 2012 17:34:51 +0200
Message-ID: <CAMP44s137rkBirwX5smMLUnZe6eS0qft0RzO3=vNoDxKpZE_RQ@mail.gmail.com>
References: <7fad4160-e437-4ea3-b140-4c98a04045f4@googlegroups.com>
	<8d3b5995-b3f7-406b-9172-b3187922dc75@googlegroups.com>
	<CAMP44s2JnoYHN0a-DQCnj-mtGbZK8q7iFBDFR4MQ4L0-n7DYPw@mail.gmail.com>
	<01a2f6b7-ee81-4653-b5f3-a53def9301ca@googlegroups.com>
	<1f842c9c-41cc-415f-ac31-30c85c7f6563@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43299 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935162Ab2JXPew (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 11:34:52 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so557418oag.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Oct 2012 08:34:51 -0700 (PDT)
In-Reply-To: <1f842c9c-41cc-415f-ac31-30c85c7f6563@googlegroups.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Selso Liberado <selso.liberado@gmail.com>
Cc: gst-dsp@googlegroups.com, linux-omap@vger.kernel.org, Omar Ramirez Luna <or.rmz1@gmail.com>

Hi,

Selso, hopefully you don't mind, but I'll forward this to the
linux-omap mailing list, as this seems to be an interesting kernel
problem in tidspbridge.

Omar, any ideas?

On Wed, Oct 24, 2012 at 5:24 PM, Selso Liberado
<selso.liberado@gmail.com> wrote:
> Hi !
>
> So I did have the best result with the beagleboard kernel community on 3.6.
> I'am a planning to test their older kernel (ie 3.0).
> Attached is a captured video file of a playback to see what is happenning on
> the screen.
>
> A the end of the playback I always get a kernel panic event with TI samples.
>
> Got EOS from element "pipeline0".
>
> Execution ended after 100096570255 ns.
>
> Setting pipeline to PAUSED ...
>
> Setting pipeline to READY ...
>
> Setting pipeline to NULL ...
>
> Freeing pipeline ...
>
> [ 503.568176] Kernel panic - not syncing: Aiee, killing interrupt handler!
>
> [ 503.581512] [<c001369c>] (unwind_backtrace+0x0/0xe0) from [<c05b941c>]
> (panic+0x84/0x1e0)
>
> [ 503.596252] [<c05b941c>] (panic+0x84/0x1e0) from [<c003bac0>]
> (do_exit+0x9c/0x7d0)
>
> [ 503.610412] [<c003bac0>] (do_exit+0x9c/0x7d0) from [<c003c4ec>]
> (do_group_exit+0xa8/0xd4)
>
> [ 503.625274] [<c003c4ec>] (do_group_exit+0xa8/0xd4) from [<c0049c64>]
> (get_signal_to_deliver+0x5ac/0x624)
>
> [ 503.641601] [<c0049c64>] (get_signal_to_deliver+0x5ac/0x624) from
> [<c000fd5c>] (do_signal+0x88/0x450)
>
> [ 503.657775] [<c000fd5c>] (do_signal+0x88/0x450) from [<c001055c>]
> (do_work_pending+0x40/0xa0)
>
> [ 503.673217] [<c001055c>] (do_work_pending+0x40/0xa0) from [<c000d500>]
> (work_pending+0xc/0x20)
>
>
> If I don't disable kernel prink to the minimum I get these errors looping on
> playback :
> [  143.113586] BUG: scheduling while atomic: queue0:src/88/0x0000008e
> [  143.126251] Modules linked in: tidspbridge(C) mailbox_mach mailbox
> [  143.138916] [<c001369c>] (unwind_backtrace+0x0/0xe0) from [<c05b99e4>]
> (__schedule_bug+0x48/0x5c)
> [  143.154449] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from [<c05c2d1c>]
> (__schedule+0x60/0x798)
> [  143.169616] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c0010534>]
> (do_work_pending+0x18/0xa0)
> [  143.184936] [<c0010534>] (do_work_pending+0x18/0xa0) from [<c000d500>]
> (work_pending+0xc/0x20)
> [  143.200561] BUG: scheduling while atomic: queue0:src/88/0x0000008e
> [  143.213409] Modules linked in: tidspbridge(C) mailbox_mach mailbox
> [  143.226470] [<c001369c>] (unwind_backtrace+0x0/0xe0) from [<c05b99e4>]
> (__schedule_bug+0x48/0x5c)
> [  143.242401] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from [<c05c2d1c>]
> (__schedule+0x60/0x798)
> [  143.257995] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c0010534>]
> (do_work_pending+0x18/0xa0)
> [  143.273742] [<c0010534>] (do_work_pending+0x18/0xa0) from [<c000d500>]
> (work_pending+0xc/0x20)
> [  143.290374] BUG: scheduling while atomic: queue0:src/88/0x0000011b
>
>
>
> Here are the cmds for loading dsp and initializing gstreamer env :
> modprobe mailbox_mach
> sleep 1
> modprobe tidspbridge base_img=/lib/dsp/baseimage.dof dsp_test_sleepstate=1
> shm_size=0x500000
>
> Here is the config for tidspbrige driver :
> CONFIG_TIDSPBRIDGE=m
> CONFIG_TIDSPBRIDGE_MEMPOOL_SIZE=0x600000
> CONFIG_TIDSPBRIDGE_RECOVERY=y
> CONFIG_TIDSPBRIDGE_CACHE_LINE_CHECK=y
> # CONFIG_TIDSPBRIDGE_NTFY_PWRERR is not set
> # CONFIG_TIDSPBRIDGE_BACKTRACE is not set
>
>
> Notice that even with the dvsdk from ti (old kernel) I manage to have by
> chance the "scheduling while atomic"
>
> Is there any way to trace the bug ? I can't event say where it is happening
> (gst plugins, glib, gstreamer plugins, tidspbridge) !
> Is there another way to test video decode ?
>
> I also tested another pipeline with quite the same result :
> root@maia:~# gst-launch -v filesrc
> location=/home/mntfat/video_720x400_avc1_low_
> profile_noaudio.mp4 ! qtdemux ! queue ! dspvdec ! omapfbsink
> Setting pipeline to PAUSED ...
> Pipeline is PREROLLING ...
> /GstPipeline:pipeline0/GstQueue:queue0.GstPad:sink: caps = video/x-h264,
> stream-format=(string)avc, alignment=(string)au, level=(string)3,
> profile=(string)constrained-baseline,
> codec_data=(buffer)0142c01effe100186742c01e9a720168676022000003005200000fa51e2c5c9001000468ce32c8,
> width=(int)720, height=(int)400, framerate=(fraction)143/6,
> pixel-aspect-ratio=(fraction)1/1
> /GstPipeline:pipeline0/GstQueue:queue0.GstPad:src: caps = video/x-h264,
> stream-format=(string)avc, alignment=(string)au, level=(string)3,
> profile=(string)constrained-baseline,
> codec_data=(buffer)0142c01effe100186742c01e9a720168676022000003005200000fa51e2c5c9001000468ce32c8,
> width=(int)720, height=(int)400, framerate=(fraction)143/6,
> pixel-aspect-ratio=(fraction)1/1
> /GstPipeline:pipeline0/GstDspVDec:dspvdec0.GstPad:sink: caps = video/x-h264,
> stream-format=(string)avc, alignment=(string)au, level=(string)3,
> profile=(string)constrained-baseline,
> codec_data=(buffer)0142c01effe100186742c01e9a720168676022000003005200000fa51e2c5c9001000468ce32c8,
> width=(int)720, height=(int)400, framerate=(fraction)143/6,
> pixel-aspect-ratio=(fraction)1/1
>
> (gst-launch-0.10:90): GStreamer-CRITICAL **: gst_mini_object_unref:
> assertion `GST_IS_MINI_OBJECT (mini_object)' failed
> /GstPipeline:pipeline0/GstDspVDec:dspvdec0.GstPad:sink: caps = video/x-h264,
> stream-format=(string)avc, alignment=(string)au, level=(string)3,
> profile=(string)constrained-baseline,
> codec_data=(buffer)0142c01effe100186742c01e9a720168676022000003005200000fa51e2c5c9001000468ce32c8,
> width=(int)720, height=(int)400, framerate=(fraction)143/6,
> pixel-aspect-ratio=(fraction)1/1
> /GstPipeline:pipeline0/GstDspVDec:dspvdec0.GstPad:src: caps =
> video/x-raw-yuv, format=(fourcc)UYVY, width=(int)720, height=(int)400,
> pixel-aspect-ratio=(fraction)1/1, framerate=(fraction)143/6
> [  466.704742] BUG: scheduling while atomic: queue0:src/91/0x0000008e
> [  466.717407] Modules linked in: tidspbridge(C) mailbox_mach mailbox
> [  466.730072] [<c001369c>] (unwind_backtrace+0x0/0xe0) from [<c05b99e4>]
> (__schedule_bug+0x48/0x5c)
> [  466.745574] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from [<c05c2d1c>]
> (__schedule+0x60/0x798)
> [  466.760742] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c0010534>]
> (do_work_pending+0x18/0xa0)
> [  466.776123] [<c0010534>] (do_work_pending+0x18/0xa0) from [<c000d500>]
> (work_pending+0xc/0x20)
> [  466.792510] BUG: scheduling while atomic: queue0:src/91/0x0000011b
> [  466.805511] Modules linked in: tidspbridge(C) mailbox_mach mailbox
> [  466.818572] [<c001369c>] (unwind_backtrace+0x0/0xe0) from [<c05b99e4>]
> (__schedule_bug+0x48/0x5c)
> [  466.834472] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from [<c05c2d1c>]
> (__schedule+0x60/0x798)
> [  466.850097] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c0010534>]
> (do_work_pending+0x18/0xa0)
> [  466.865844] [<c0010534>] (do_work_pending+0x18/0xa0) from [<c000d500>]
> (work_pending+0xc/0x20)
> [  466.882415] BUG: scheduling while atomic: queue0:src/91/0x0000011b
> [  466.896087] Modules linked in: tidspbridge(C) mailbox_mach mailbox
> [  466.909881] [<c001369c>] (unwind_backtrace+0x0/0xe0) from [<c05b99e4>]
> (__schedule_bug+0x48/0x5c)
> [  466.926361] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from [<c05c2d1c>]
> (__schedule+0x60/0x798)
> [  466.942474] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c007d67c>]
> (futex_wait_queue_me+0xf8/0x114)
> [  466.959167] [<c007d67c>] (futex_wait_queue_me+0xf8/0x114) from
> [<c007d7cc>] (futex_wait+0xd4/0x210)
> [  466.975982] [<c007d7cc>] (futex_wait+0xd4/0x210) from [<c007f67c>]
> (do_futex+0xc0/0xab4)
> [  466.991821] [<c007f67c>] (do_futex+0xc0/0xab4) from [<c0080194>]
> (sys_futex+0x124/0x168)
> [  467.007781] [<c0080194>] (sys_futex+0x124/0x168) from [<c000d4c0>]
> (ret_fast_syscall+0x0/0x30)
> [  467.025115] BUG: scheduling while atomic: queue0:src/91/0x0000011b
> [  467.039276] Modules linked in: tidspbridge(C) mailbox_mach mailbox
> [  467.053588] [<c001369c>] (unwind_backtrace+0x0/0xe0) from [<c05b99e4>]
> (__schedule_bug+0x48/0x5c)
> [  467.070709] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from [<c05c2d1c>]
> (__schedule+0x60/0x798)
> [  467.087554] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c007d67c>]
> (futex_wait_queue_me+0xf8/0x114)
> [  467.105041] [<c007d67c>] (futex_wait_queue_me+0xf8/0x114) from
> [<c007d7cc>] (futex_wait+0xd4/0x210)
> [  467.122589] [<c007d7cc>] (futex_wait+0xd4/0x210) from [<c007f67c>]
> (do_futex+0xc0/0xab4)
> [  467.139068] [<c007f67c>] (do_futex+0xc0/0xab4) from [<c0080194>]
> (sys_futex+0x124/0x168)
> [  467.155548] [<c0080194>] (sys_futex+0x124/0x168) from [<c000d4c0>]
> (ret_fast_syscall+0x0/0x30)
> [  467.173309] NOHZ: local_softirq_pending 42
> gstdsp_map_buffer: buffer not aligned: 0xb36f4008(8)-0xb3780a08(8): from
> device
> /GstPipeline:pipeline0/GstOmapFbSink:omapfbsink0.GstPad:sink: caps =
> video/x-ra[  467.201110] BUG: scheduling while atomic:
> queue0:src/91/0x0000011b
> [  467.216552] Modules linked in: tidspbridge(C) mailbox_mach mailbox
> [  467.231262] [<c001369c>] (unwind_backtrace+0x0/0xe0) from [<c05b99e4>]
> (__schedule_bug+0x48/0x5c)
> [  467.248840] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from [<c05c2d1c>]
> (__schedule+0x60/0x798)
> [  467.265991] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c0010534>]
> (do_work_pending+0x18/0xa0)
> [  467.283172] [<c0010534>] (do_work_pending+0x18/0xa0) from [<c000d500>]
> (work_pending+0xc/0x20)
> w-yuv, format=(fourcc)UYVY, widt[  467.302276] BUG: scheduling while atomic:
> dspvdec0:src/94/0x0000008d
> [  467.318664] Modules linked in: tidspbridge(C) mailbox_mach mailbox
> [  467.333587] [<c001369c>] (unwind_backtrace+0x0/0xe0) from [<c05b99e4>]
> (__schedule_bug+0x48/0x5c)
> [  467.351348] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from [<c05c2d1c>]
> (__schedule+0x60/0x798)
> [  467.368774] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c0010534>]
> (do_work_pending+0x18/0xa0)
> [  467.386230] [<c0010534>] (do_work_pending+0x18/0xa0) from [<c000d500>]
> (work_pending+0xc/0x20)
> h=(int)720, heig[  467.404663] BUG: scheduling while atomic:
> dspvdec0:src/94/0x0000008d
> ht=(int)400, pix[  467.420623] Modules linked in:el-aspect-ratio=
> tidspbridge(C)(fraction)1/1, f mailbox_machramerate=(fracti mailboxon)143/6
> Pipeli
> ne is PREROLLED [  467.442810] [<c001369c>] (unwind_backtrace+0x0/0xe0) from
> [<c05b99e4>] (__schedule_bug+0x48/0x5c)
> ...
> Setting pip[  467.462066] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from
> [<c05c2d1c>] (__schedule+0x60/0x798)
> eline to PLAYING[  467.480987] [<c05c2d1c>] (__schedule+0x60/0x798) from
> [<c05c183c>] (schedule_timeout+0x1dc/0x218)
>  ...
> New clock:[  467.500213] [<c05c183c>] (schedule_timeout+0x1dc/0x218) from
> [<c05c2a34>] (wait_for_common+0x104/0x1bc)
> [  467.520050] [<c05c2a34>] (wait_for_common+0x104/0x1bc) from [<c0362f00>]
> (omap_dispc_wait_for_irq_interruptible_timeout+0x4c/0x84)
>
> [  467.542510] [<c0362f00>]
> (omap_dispc_wait_for_irq_interruptible_timeout+0x4c/0x84) from [<c0364158>]
> (dss_mgr_wait_for_vsync+0x50/0x60)
> [  467.564208] [<c0364158>] (dss_mgr_wait_for_vsync+0x50/0x60) from
> [<c03773fc>] (omapfb_ioctl+0x9cc/0xed0)
> [  467.583099] [<c03773fc>] (omapfb_ioctl+0x9cc/0xed0) from [<c0345e9c>]
> (do_fb_ioctl+0x56c/0x5a8)
> [  467.601196] [<c0345e9c>] (do_fb_ioctl+0x56c/0x5a8) from [<c011ffa4>]
> (vfs_ioctl+0x24/0x40)
> [  467.618804] [<c011ffa4>] (vfs_ioctl+0x24/0x40) from [<c0120ab4>]
> (do_vfs_ioctl+0x560/0x5a8)
> [  467.636535] [<c0120ab4>] (do_vfs_ioctl+0x560/0x5a8) from [<c0120b48>]
> (sys_ioctl+0x4c/0x6c)
> [  467.654205] [<c0120b48>] (sys_ioctl+0x4c/0x6c) from [<c000d4c0>]
> (ret_fast_syscall+0x0/0x30)
> [  467.672943] BUG: scheduling while atomic: queue0:src/91/0x0000011b
> [  467.688415] Modules linked in: tidspbridge(C) mailbox_mach mailbox
> [  467.704132] [<c001369c>] (unwind_backtrace+0x0/0xe0) from [<c05b99e4>]
> (__schedule_bug+0x48/0x5c)
> [  467.722412] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from [<c05c2d1c>]
> (__schedule+0x60/0x798)
> [  467.740325] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c007d67c>]
> (futex_wait_queue_me+0xf8/0x114)
> [  467.758819] [<c007d67c>] (futex_wait_queue_me+0xf8/0x114) from
> [<c007d7cc>] (futex_wait+0xd4/0x210)
> [  467.777252] [<c007d7cc>] (futex_wait+0xd4/0x210) from [<c007f67c>]
> (do_futex+0xc0/0xab4)
> [  467.794647] [<c007f67c>] (do_futex+0xc0/0xab4) from [<c0080194>]
> (sys_futex+0x124/0x168)
> [  467.812042] [<c0080194>] (sys_futex+0x124/0x168) from [<c000d4c0>]
> (ret_fast_syscall+0x0/0x30)
> [  467.830200] Unable to handle kernel paging request at virtual address
> b380da00
> [  467.846893] pgd = dc44c000
> [  467.858581] [b380da00] *pgd=9c457831, *pte=9f88c307, *ppte=9f88ca37
> [  467.874267] Internal error: Oops: 81f [#1] SMP ARM
> [  467.887908] Modules linked in: tidspbridge(C) mailbox_mach mailbox
> [  467.903106] CPU: 0    Tainted: G        WC    (3.6.0+ #1)
> [  467.917388] PC is at 0xb6b7ec50
> [  467.929077] LR is at 0xb66f21e8
> [  467.940643] pc : [<b6b7ec50>]    lr : [<b66f21e8>]    psr: 20000010
> [  467.940643] sp : b4125ca8  ip : b36670e0  fp : 80808080
> [  467.969177] r10: 80808080  r9 : 80808080  r8 : 80808080
> [  467.982696] r7 : 80808080  r6 : 80808080  r5 : 80808080  r4 : 80808080
> [  467.997558] r3 : 80808080  r2 : 0008c9c0  r1 : b36670a0  r0 : b380da00
> [  468.012237] Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  Segment
> user
> [  468.027648] Control: 10c5387d  Table: 9c44c019  DAC: 00000015
> [  468.041473] Process dspvdec0:src (pid: 94, stack limit = 0xdc4742f8)
> [  468.056091] ---[ end trace 7346e43bee93ae33 ]---
> [  468.068725] note: dspvdec0:src[94] exited with preempt_count 141
> [  468.084838] NOHZ: local_softirq_pending 40

-- 
Felipe Contreras
