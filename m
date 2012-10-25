From: SelsoLiberado <selso.liberado@cioinfoindus.com>
Subject: Re: Beagleboard xM - play video file : BUG: scheduling while
 atomic: queue1:src/92/0x0000008e , then kernel panic
Date: Thu, 25 Oct 2012 14:42:29 +0200
Message-ID: <7b300b8d9076f9e0ea63eb7ac4546465@cioinfin.fr.fto>
References: <7fad4160-e437-4ea3-b140-4c98a04045f4@googlegroups.com>
 <8d3b5995-b3f7-406b-9172-b3187922dc75@googlegroups.com>
 <CAMP44s2JnoYHN0a-DQCnj-mtGbZK8q7iFBDFR4MQ4L0-n7DYPw@mail.gmail.com>
 <01a2f6b7-ee81-4653-b5f3-a53def9301ca@googlegroups.com>
 <1f842c9c-41cc-415f-ac31-30c85c7f6563@googlegroups.com>
 <CAMP44s137rkBirwX5smMLUnZe6eS0qft0RzO3=vNoDxKpZE_RQ@mail.gmail.com>
 <CAJ6Av5Mhn-Me0P3asve8NX00cRKONBL4fe7Pr59r4W-gd+kY+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp-out04.msg.oleane.net ([62.161.7.2]:40439 "EHLO
	smtp-out04.msg.oleane.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758024Ab2JYMvY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 08:51:24 -0400
In-Reply-To: <CAJ6Av5Mhn-Me0P3asve8NX00cRKONBL4fe7Pr59r4W-gd+kY+Q@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Omar Ramirez Luna <omar.ramirez@copitl.com>
Cc: Felipe Contreras <felipe.contreras@gmail.com>, Selso Liberado <selso.liberado@gmail.com>, gst-dsp@googlegroups.com, linux-omap@vger.kernel.org, Omar Ramirez Luna <or.rmz1@gmail.com>

Hi Omar,

Thanks for reply.

-----------------------------------------------------------------------------------------------------------
U : "What kernel is this? If non-mainline, I might try it out of 
curiosity."
ME :
  	* code sourcery arm-2012.03-57-lite
  	* beaglboard xM rev C
  	* beagleboard kernel 3.6 (Beagleabord 3.6 branch) : 
https://github.com/beagleboard/kernel/branches
  	* gstreamer 0.10.36 with plugins base, good
  	* custom FS (busybox only and base libs)
  	* ti LI23.8
  	* package gst-dsp 0.10.2 and the branch "next" for gst-dsp plugin

I did also make test with a "stable 3.2.30" and got the bug "scheduling 
while atomic".

-----------------------------------------------------------------------------------------------------------
U : " CONFIG_TIDSPBRIDGE_CACHE_LINE_CHECK=y : I wasn't aware that now 
gst-dsp supported this, might be time to update mine"
ME : I may repeat tests without this option. Can it cause troubles ?

Also here is how I load the module driver :
modprobe tidspbridge base_img=/lib/dsp/baseimage.dof 
dsp_test_sleepstate=1
I did also tried with higher shm memory size (as seen in nokia luma 
dspbridge package) : shm_size=0x500000

About kernel cmd : kernel cmd : console=tty0 console=ttyO2,115200n8 
root=/dev/mmcblk0p2 rw rootfstype=ext3 rootwait consoleblank=0 
mpurate=800 buddy=none camera=lbcm3m1 vram=16M omapfb.mode=dvi:hd720 
omapfb.vram=0:8M,1:4M,2:4M omapdss.def_disp=dvi

-----------------------------------------------------------------------------------------------------------
U : "I'm not seeing this with the fakesink decode"
ME : Well I repeat those tests with a fakesink and got this :
root@maia:~# gst-launch -v filesrc 
location=/home/mntfat/davincieffect_480p30.mp4 ! qtdemux ! dspvdec ! 
queue ! fakesink
Setting pipeline to PAUSED ...
Pipeline is PREROLLING ...
/GstPipeline:pipeline0/GstDspVDec:dspvdec0.GstPad:sink: caps = 
video/x-h264, stream-format=(string)avc, alignment=(string)au, 
level=(string)3, profile=(string)constrained-baseline, 
codec_data=(buffer)0142c01effe100196742c01e9a7201687b6022000003000200000300781e2c5c9001000468cb8cb2, 
width=(int)720, height=(int)480, framerate=(fraction)30/1, 
pixel-aspect-ratio=(fraction)1/1

(gst-launch-0.10:81): GStreamer-CRITICAL **: gst_mini_object_unref: 
assertion `GST_IS_MINI_OBJECT (mini_object)' failed
/GstPipeline:pipeline0/GstDspVDec:dspvdec0.GstPad:sink: caps = 
video/x-h264, stream-format=(string)avc, alignment=(string)au, 
level=(string)3, profile=(string)constrained-baseline, 
codec_data=(buffer)0142c01effe100196742c01e9a7201687b6022000003000200000300781e2c5c9001000468cb8cb2, 
width=(int)720, height=(int)480, framerate=(fraction)30/1, 
pixel-aspect-ratio=(fraction)1/1
/GstPipeline:pipeline0/GstDspVDec:dspvdec0.GstPad:src: caps = 
video/x-raw-yuv, format=(fourcc)UYVY, width=(int)720, height=(int)480, 
pixel-aspect-ratio=(fraction)1/1, framerate=(fraction)30/1
gstdsp_map_buffer: buffer not aligned: 0xb3a93008(8)-0xb3b3bc08(8): 
from device
gstdsp_map_buffer: buffer not aligned: 0xb3a93008(8)-0xb3b3bc08(8): 
from device
/GstPipeline:pipeline0/GstQueue:queue0.GstPad:sink: caps = 
video/x-raw-yuv, format=(fourcc)UYVY, width=(int)720, height=(int)480, 
pixel-aspect-ratio=(fraction)1/1, framerate=(fraction)30/1
/GstPipeline:pipeline0/GstQueue:queue0.GstPad:src: caps = 
video/x-raw-yuv, format=(fourcc)UYVY, width=(int)720, height=(int)480, 
pixel-aspect-ratio=(fraction)1/1, framerate=(fraction)30/1
/GstPipeline:pipeline0/GstFakeSink:fakesink0.GstPad:sink: caps = 
video/x-raw-yuv, format=(fourcc)UYVY, width=(int)720, height=(int)480, 
pixel-aspect-ratio=(fraction)1/1, framerate=(fraction)30/1
/GstPipeline:pipeline0/GstFakeSink:fakesink0: last-message = "preroll   
******* "
Pipeline is PREROLLED ...
Setting pipeline to PLAYING ...
/GstPipeline:pipeline0/GstFakeSink:fakesink0: last-message = "event   
******* (fakesink0:sink) E (type: 118, taglist, 
video-codec=(string)\"H.264\\ /\\ AVC\", language-code=(string)en, 
bitrate=(uint)1484773;) 0x14584c8"
/GstPipeline:pipeline0/GstFakeSink:fakesink0: last-message = "event   
******* (fakesink0:sink) E (type: 118, taglist, 
encoder=(string)Lavf52.68.0, container-format=(string)\"ISO\\ 
MP4/M4A\";) 0x1458500"
/GstPipeline:pipeline0/GstFakeSink:fakesink0: last-message = "event   
******* (fakesink0:sink) E (type: 102, GstEventNewsegment, 
update=(boolean)false, rate=(double)1, applied-rate=(double)1, 
format=(GstFormat)GST_FORMAT_TIME, start=(gint64)0, 
stop=(gint64)100100000000, position=(gint64)0;) 0x1458490"
New clock: GstSystemClock
/GstPipeline:pipeline0/GstFakeSink:fakesink0: last-message = "chain   
******* (fakesink0:sink) (691200 bytes, timestamp: 0:00:00.000000000, 
duration: 0:00:00.033333333, offset: -1, offset_end: -1, flags: 256 
delta_unit ) 0xb5402a80"
/GstPipeline:pipeline0/GstFakeSink:fakesink0: last-message = "chain   
******* (fakesink0:sink) (691200 bytes, timestamp: 0:00:00.033333333, 
duration: 0:00:00.033333333, offset: -1, offset_end: -1, flags: 256 
delta_unit ) 0xb5402ae8"
/GstPipeline:pipeline0/GstFakeSink:fakesink0: last-message = "chain   
******* (fakesink0:sink) (691200 bytes, timestamp: 0:00:00.066666666, 
duration: 0:00:00.033333334, offset: -1, offset_end: -1, flags: 256 
delta_unit ) 0xb5402b50"

There are no "scheduling while atomic" traces, so you may be right 
about it is about omapfbsink.

I did also get those kernel logs :
[  179.181701] proc_end_dma: InValid address parameters b4c02c00 680
[  179.231018] memory_regain_ownership: dma info doesn't match given 
params
[  179.246459] proc_end_dma: InValid address parameters b4c02c00 680
[  179.292816] memory_regain_ownership: dma info doesn't match given 
params
[  179.308197] proc_end_dma: InValid address parameters b4c02c00 680
[  179.358123] memory_regain_ownership: dma info doesn't match given 
params
[  179.373687] proc_end_dma: InValid address parameters b4c02c00 680
[  179.428131] memory_regain_ownership: dma info doesn't match given 
params
[  179.444274] proc_end_dma: InValid address parameters b4c02c00 680
[  179.512237] procwrap_detach: deprecated dspbridge ioctl

Well I don't really understand them;

I can repeat the test without having kernel crashes.

-----------------------------------------------------------------------------------------------------------

Test on the omapfbsink with fakesrc gives no error and displays 
correctly : gst-launch -v videotestsrc ! omapfbsink


-----------------------------------------------------------------------------------------------------------
With the following pipeline video starts and system blocks on the first 
frames :
gst-launch -v filesrc 
location=/home/mntfat/video_720x400_avc1_low_profile_aac.mp4 ! qtdemux ! 
queue ! dspvdec ! queue max-size-buffers=3 max-size-bytes=0 
max-size-time=0 ! omapfbsink


But I get at the end theses logs :
[   42.131927] BUG: scheduling while atomic: dspvdec0:src/85/0x0000008d
[   42.148376] Modules linked in: tidspbridge(C) mailbox_mach mailbox
[   42.170623] [<c001369c>] (unwind_backtrace+0x0/0xe0) from 
[<c05b99e4>] (__schedule_bug+0x48/0x5c)
[   42.189605] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from 
[<c05c2d1c>] (__schedule+0x60/0x798)
[   42.207092] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c007d67c>] 
(futex_wait_queue_me+0xf8/0x114)
[   42.225158] [<c007d67c>] (futex_wait_queue_me+0xf8/0x114) from 
[<c007d7cc>] (futex_wait+0xd4/0x210)
[   42.243255] [<c007d7cc>] (futex_wait+0xd4/0x210) from [<c007f67c>] 
(do_futex+0xc0/0xab4)
[   42.260314] [<c007f67c>] (do_futex+0xc0/0xab4) from [<c0080194>] 
(sys_futex+0x124/0x168)
[   42.277374] [<c0080194>] (sys_futex+0x124/0x168) from [<c000d4c0>] 
(ret_fast_syscall+0x0/0x30)
[   42.296630] BUG: scheduling while atomic: queue0:src/82/0x0000011b
[   42.311614] Modules linked in: tidspbridge(C) mailbox_mach mailbox
[   42.326568] [<c001369c>] (unwind_backtrace+0x0/0xe0) from 
[<c05b99e4>] (__schedule_bug+0x48/0x5c)
[   42.344360] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from 
[<c05c2d1c>] (__schedule+0x60/0x798)
[   42.361785] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c0010534>] 
(do_work_pending+0x18/0xa0)
[   42.379272] [<c0010534>] (do_work_pending+0x18/0xa0) from 
[<c000d500>] (work_pending+0xc/0x20)
[   42.397735] BUG: scheduling while atomic: queue0:src/82/0x0000011b
[   42.412872] Modules linked in: tidspbridge(C) mailbox_mach mailbox
[   42.428009] [<c001369c>] (unwind_backtrace+0x0/0xe0) from 
[<c05b99e4>] (__schedule_bug+0x48/0x5c)
[   42.445861] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from 
[<c05c2d1c>] (__schedule+0x60/0x798)
[   42.463378] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c007d67c>] 
(futex_wait_queue_me+0xf8/0x114)
[   42.481414] [<c007d67c>] (futex_wait_queue_me+0xf8/0x114) from 
[<c007d7cc>] (futex_wait+0xd4/0x210)
[   42.499511] [<c007d7cc>] (futex_wait+0xd4/0x210) from [<c007f67c>] 
(do_futex+0xc0/0xab4)
[   42.516571] [<c007f67c>] (do_futex+0xc0/0xab4) from [<c0080194>] 
(sys_futex+0x124/0x168)
[   42.533569] [<c0080194>] (sys_futex+0x124/0x168) from [<c000d4c0>] 
(ret_fast_syscall+0x0/0x30)
[   42.551300] BUG: scheduling while atomic: dspvdec0:src/85/0x0000008d
[   42.566619] Modules linked in: tidspbridge(C) mailbox_mach mailbox
[   42.581909] [<c001369c>] (unwind_backtrace+0x0/0xe0) from 
[<c05b99e4>] (__schedule_bug+0x48/0x5c)
[   42.599884] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from 
[<c05c2d1c>] (__schedule+0x60/0x798)
[   42.617431] [<c05c2d1c>] (__schedule+0x60/0x798) from [<c05c183c>] 
(schedule_timeout+0x1dc/0x218)
[   42.635406] [<c05c183c>] (schedule_timeout+0x1dc/0x218) from 
[<c05c2a34>] (wait_for_common+0x104/0x1bc)
[   42.653991] [<c05c2a34>] (wait_for_common+0x104/0x1bc) from 
[<c0362f00>] (omap_dispc_wait_for_irq_interruptible_timeout+0x4c/0x84)
[   42.675140] [<c0362f00>] 
(omap_dispc_wait_for_irq_interruptible_timeout+0x4c/0x84) from 
[<c0364158>] (dss_mgr_wait_for_vsync+0x50/0x60)
[   42.696868] [<c0364158>] (dss_mgr_wait_for_vsync+0x50/0x60) from 
[<c03773fc>] (omapfb_ioctl+0x9cc/0xed0)
[   42.715820] [<c03773fc>] (omapfb_ioctl+0x9cc/0xed0) from 
[<c0345e9c>] (do_fb_ioctl+0x56c/0x5a8)
[   42.733947] [<c0345e9c>] (do_fb_ioctl+0x56c/0x5a8) from [<c011ffa4>] 
(vfs_ioctl+0x24/0x40)
[   42.751586] [<c011ffa4>] (vfs_ioctl+0x24/0x40) from [<c0120ab4>] 
(do_vfs_ioctl+0x560/0x5a8)
[   42.769348] [<c0120ab4>] (do_vfs_ioctl+0x560/0x5a8) from 
[<c0120b48>] (sys_ioctl+0x4c/0x6c)
[   42.787078] [<c0120b48>] (sys_ioctl+0x4c/0x6c) from [<c000d4c0>] 
(ret_fast_syscall+0x0/0x30)
[   42.805236] Unable to handle kernel paging request at virtual 
address b3122a00
[   42.821838] pgd = dc460000
[   42.833496] [b3122a00] *pgd=9c41b831, *pte=9f88c307, *ppte=9f88ca37
[   42.849182] Internal error: Oops: 81f [#1] SMP ARM
[   42.862854] Modules linked in: tidspbridge(C) mailbox_mach mailbox
[   42.878082] CPU: 0    Tainted: G        WC    (3.6.0+ #1)
[   42.892303] PC is at 0xb6b8ac50
[   42.903991] LR is at 0xb66fe1e8
[   42.915557] pc : [<b6b8ac50>]    lr : [<b66fe1e8>]    psr: 20000010
[   42.915557] sp : b3a3aca8  ip : b2f7c0e0  fp : 10801080
[   42.944061] r10: 10801080  r9 : 10801080  r8 : 10801080
[   42.957641] r7 : 10801080  r6 : 10801080  r5 : 10801080  r4 : 
10801080
[   42.972473] r3 : 10801080  r2 : 0008c9c0  r1 : b2f7c0a0  r0 : 
b3122a00
[   42.987182] Flags: nzCv  IRQs on  FIQs on  Mode USER_32  ISA ARM  
Segment user
[   43.002624] Control: 10c5387d  Table: 9c460019  DAC: 00000015
[   43.016448] Process dspvdec0:src (pid: 85, stack limit = 0xdc46e2f8)
[   43.031097] ---[ end trace 85176fb01ea5ff4a ]---
[   43.043792] note: dspvdec0:src[85] exited with preempt_count 141

So your right that is about omapdss, even if I don't understand why 
this is the dspvdec0 that exits.


