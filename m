From: "Anil Sasidharan" <anilvpr@gmail.com>
Subject: Re: Re: Android on OMAP
Date: Thu, 13 Mar 2008 09:44:56 +0530
Message-ID: <f6c5b8d90803122114m20aea1ddhdc6731dabf12122b@mail.gmail.com>
References: <f6c5b8d90802252015h17382869p2e2f2f341aa84547@mail.gmail.com>
	 <023d01c87842$5354f330$16110a0a@LongCheer.net>
	 <f6c5b8d90802270049m4db620bbn25ea5eef80addfc0@mail.gmail.com>
	 <002b01c87922$afe4de40$16110a0a@LongCheer.net>
	 <f6c5b8d90802270137s3fad9201jd701111683af0b8f@mail.gmail.com>
	 <f6c5b8d90802280334r21ad952atcf8014a1b64e9b7d@mail.gmail.com>
	 <000e01c87a6e$ae8a4e70$16110a0a@LongCheer.net>
	 <f6c5b8d90802290135o476f6d06t26409f9e3ea9bb3d@mail.gmail.com>
	 <00d601c87ccb$99119210$16110a0a@LongCheer.net>
	 <f6c5b8d90803070553x68c273bdu7c702225bae33d73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:29196 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbYCMEPA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Mar 2008 00:15:00 -0400
Received: by an-out-0708.google.com with SMTP id d31so775292and.103
        for <linux-omap@vger.kernel.org>; Wed, 12 Mar 2008 21:14:56 -0700 (PDT)
In-Reply-To: <f6c5b8d90803070553x68c273bdu7c702225bae33d73@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: colorant <colorant@163.com>
Cc: linux-omap@vger.kernel.org, Dirk Behme <dirk.behme@googlemail.com>, Brian Swetland <swetland@google.com>

Hi,

         Android is up and running on Mistral's OSK2530 EVM (based on
OMAP2430 SoC). We got the HW keypad functional for Android and we are
able to execute the the default applications shipped along with the
m5-rc14 sdk.  The next thing would be to get the touchscreen and
networking functional on this platform.

Thank you very much for your support and encouragement.

Warm Regards,
Anil

On Fri, Mar 7, 2008 at 7:23 PM, Anil Sasidharan
<anils@mistralsolutions.com> wrote:
> Hi Raymond,
>
>                  I remember you having reported an error with regards
>  to vmalloc when binder tries to perform mmap. Could you get rid of
>  this problem? I was able to resolve my board hang issue. The issue was
>  due to some conflict between the device nodes for "alarm" and "eac"
>  (audio device). Now I'm able to bring up android without stracing and
>  also the binder module is functional now. However the Android home
>  screen pops up a message "com.google.googleapps not responding" and
>  the android framework stops responding to the HW keyboard events. All
>  I can see is couple of message for wakeup and sleep from power module.
>  Sometimes when I press the enter key on the HW keyboard, I do see that
>  the binder module tries to do mmap and fails with vmalloc error
>  simliar to what you had observed. The platform on which this is being
>  tried has got 128MB of RAM and the rootfs is currently mounted from an
>  NFS server.
>
>  "cat /proc/meminfo" command executed before launching Android shows
>  the following output:
>
>  MemTotal:       126680 kB
>  MemFree:        122616 kB
>  Buffers:             0 kB
>  Cached:           1788 kB
>  SwapCached:          0 kB
>  Active:            624 kB
>  Inactive:         1280 kB
>  SwapTotal:           0 kB
>  SwapFree:            0 kB
>  Dirty:               0 kB
>  Writeback:           0 kB
>  AnonPages:         128 kB
>  Mapped:            300 kB
>  Slab:             1224 kB
>  SReclaimable:      408 kB
>  SUnreclaim:        816 kB
>  PageTables:         44 kB
>  NFS_Unstable:        0 kB
>  Bounce:              0 kB
>  CommitLimit:     63340 kB
>  Committed_AS:     1504 kB
>  VmallocTotal:   122880 kB
>  VmallocUsed:     65864 kB
>  VmallocChunk:    49148 kB
>
>
>  What may be the reason for this vmalloc failure?????
>
>  Warm Regards,
>  Anil
>
>
>
>  On Mon, Mar 3, 2008 at 6:42 AM, colorant <colorant@163.com> wrote:
>  > >
>  >  > 1. If the /dev/binder device node is missing or having wrong minor
>  >  > number, the android display comes up properly.
>  >  > 2. If the /dev/binder device node is created properly by making use of
>  >  > the information from the "/proc/misc", then the "/system/bin/runtime"
>  >  > spits out the following messages and then hangs for ever.
>  >  > binder_open: 276:276
>  >  > binder_mmap: 276 40000000-40400000 (4096 K) vma 71 pagep 5f
>  >  > binder_open: 278:278
>  >  > binder_mmap: 278 42648000-42a48000 (4096 K) vma 71 pagep 5f
>  >  >
>  >  > In fact the whole system hangs :-(
>  >  >
>  >  > Currently my platform on which this whole activity is being carried
>  >  > out has only 64MB RAM and I presume the mmap calls may be failing due
>  >  > to some memory crunch.
>  >  >
>  >  > It would be great if you could share your thoughts on the above given
>  >  > observations.
>  >  >
>  >  > Warm Regards,
>  >  > Anil
>  >
>  >  Hi Anil
>  >
>  >     I guess there still is some thing we don't handle well in the vmalloc
>  >  related functions.
>  >
>  >     My output messages after the first two binder_mmap is a binder_flush as
>  >  following:
>  >
>  >  binder_open: 500:500
>  >  binder_mmap: 500 40008000-40408000 (4096 K) vma 71 pagep 5f
>  >  binder_open: 510:510
>  >  binder_mmap: 510 42650000-42a50000 (4096 K) vma 71 pagep 5f
>  >  binder_flush: 510 woke 3 threads
>  >  binder_open: 537:537
>  >  binder_mmap: 537 42650000-42a50000 (4096 K) vma 71 pagep 5f
>  >
>  >  And three more mmap later, the main screen is shown.
>  >
>  >  However I also got a mmap fail :
>  >
>  >  binder_open: 552:552
>  >  binder_mmap: 552 42650000-42a50000 (4096 K) vma 71 pagep 5f
>  >  binder_open: 554:554
>  >  binder_mmap: 554 42650000-42a50000 (4096 K) vma 71 pagep 5f
>  >  binder_open: 498:507
>  >  binder_mmap: 498 40108000-40508000 (4096 K) vma 71 pagep 5f
>  >  allocation failed: out of vmalloc space - use vmalloc=<size> to increase
>  >  size.
>  >  binder_mmap: 498 40108000-40508000 get_vm_area failed -12
>  >
>  >  And I remember that I had to modify some vmalloc related functions to make
>  >  the binder driver working happy with my 2.6.21 kernel. I think there might
>  >  be something I miss to modify which is changed from 2.6.21 kernel to 2.6.23
>  >  kernel but can be compiled without problem.
>  >
>  >  However, since I just want to verify the possiblility of porting the android
>  >  to my platform and don't want to really make it perfect for now, So I don't
>  >  want to study further at this point, I will just wait until the whole
>  >  system's src is available so that the problem hunting job is more easy to
>  >  do.
>  >
>  >  And , Just my guess, It might be helpful to read the emulator's src code ?
>  >  Since the goldfish is base on it, and I can see that some hardware releated
>  >  code, when I trace it down, it finally direct to a register reading or
>  >  writing without any clue of what is going on.
>  >
>  >  Rayomnd
>  >
>  >
>  >
>
