From: Omar Ramirez Luna <omar.ramirez@copitl.com>
Subject: Re: Beagleboard xM - play video file : BUG: scheduling while atomic:
 queue1:src/92/0x0000008e , then kernel panic
Date: Wed, 24 Oct 2012 17:49:47 -0500
Message-ID: <CAJ6Av5Mhn-Me0P3asve8NX00cRKONBL4fe7Pr59r4W-gd+kY+Q@mail.gmail.com>
References: <7fad4160-e437-4ea3-b140-4c98a04045f4@googlegroups.com>
	<8d3b5995-b3f7-406b-9172-b3187922dc75@googlegroups.com>
	<CAMP44s2JnoYHN0a-DQCnj-mtGbZK8q7iFBDFR4MQ4L0-n7DYPw@mail.gmail.com>
	<01a2f6b7-ee81-4653-b5f3-a53def9301ca@googlegroups.com>
	<1f842c9c-41cc-415f-ac31-30c85c7f6563@googlegroups.com>
	<CAMP44s137rkBirwX5smMLUnZe6eS0qft0RzO3=vNoDxKpZE_RQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59068 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422655Ab2JXWts (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 24 Oct 2012 18:49:48 -0400
Received: by mail-ie0-f174.google.com with SMTP id k13so1453397iea.19
        for <linux-omap@vger.kernel.org>; Wed, 24 Oct 2012 15:49:48 -0700 (PDT)
In-Reply-To: <CAMP44s137rkBirwX5smMLUnZe6eS0qft0RzO3=vNoDxKpZE_RQ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Selso Liberado <selso.liberado@gmail.com>, gst-dsp@googlegroups.com, linux-omap@vger.kernel.org, Omar Ramirez Luna <or.rmz1@gmail.com>

Hi,

On Wed, Oct 24, 2012 at 10:34 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> Hi,
>
> Selso, hopefully you don't mind, but I'll forward this to the
> linux-omap mailing list, as this seems to be an interesting kernel
> problem in tidspbridge.
>
> Omar, any ideas?

I don't see tidspbridge trace paths (but I don't discard something
wrong either ;)), however I do see a framebuffer, dss, dispc trace,
might be a good point to start checking:

[  467.404663] BUG: scheduling while atomic:
>> dspvdec0:src/94/0x0000008d
>> ht=(int)400, pix[  467.420623] Modules linked in:el-aspect-ratio=
>> tidspbridge(C)(fraction)1/1, f mailbox_machramerate=(fracti mailboxon)143/6
>> Pipeli
>> ne is PREROLLED [  467.442810] [<c001369c>] (unwind_backtrace+0x0/0xe0) from
>> [<c05b99e4>] (__schedule_bug+0x48/0x5c)
>> ...
>> Setting pip[  467.462066] [<c05b99e4>] (__schedule_bug+0x48/0x5c) from
>> [<c05c2d1c>] (__schedule+0x60/0x798)
>> eline to PLAYING[  467.480987] [<c05c2d1c>] (__schedule+0x60/0x798) from
>> [<c05c183c>] (schedule_timeout+0x1dc/0x218)
>>  ...
>> New clock:[  467.500213] [<c05c183c>] (schedule_timeout+0x1dc/0x218) from
>> [<c05c2a34>] (wait_for_common+0x104/0x1bc)
>> [  467.520050] [<c05c2a34>] (wait_for_common+0x104/0x1bc) from [<c0362f00>]
>> (omap_dispc_wait_for_irq_interruptible_timeout+0x4c/0x84)
>>
>> [  467.542510] [<c0362f00>]
>> (omap_dispc_wait_for_irq_interruptible_timeout+0x4c/0x84) from [<c0364158>]
>> (dss_mgr_wait_for_vsync+0x50/0x60)
>> [  467.564208] [<c0364158>] (dss_mgr_wait_for_vsync+0x50/0x60) from
>> [<c03773fc>] (omapfb_ioctl+0x9cc/0xed0)
>> [  467.583099] [<c03773fc>] (omapfb_ioctl+0x9cc/0xed0) from [<c0345e9c>]
>> (do_fb_ioctl+0x56c/0x5a8)
>> [  467.601196] [<c0345e9c>] (do_fb_ioctl+0x56c/0x5a8) from [<c011ffa4>]
>> (vfs_ioctl+0x24/0x40)
>> [  467.618804] [<c011ffa4>] (vfs_ioctl+0x24/0x40) from [<c0120ab4>]
>> (do_vfs_ioctl+0x560/0x5a8)
>> [  467.636535] [<c0120ab4>] (do_vfs_ioctl+0x560/0x5a8) from [<c0120b48>]
>> (sys_ioctl+0x4c/0x6c)
>> [  467.654205] [<c0120b48>] (sys_ioctl+0x4c/0x6c) from [<c000d4c0>]
>> (ret_fast_syscall+0x0/0x30)

...
>> CONFIG_TIDSPBRIDGE_CACHE_LINE_CHECK=y

I wasn't aware that now gst-dsp supported this, might be time to update mine.

Anyway, right now I have lots of debugging enabled and specifically
the one that spits "scheduling while atomic" with kernel 3.7-rc2, and
I'm not seeing this with the fakesink decode, and the encoder to a
file, I don't have framebuffer nor display though.

What kernel is this? If non-mainline, I might try it out of curiosity.

Regards,

Omar
