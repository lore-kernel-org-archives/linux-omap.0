From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: NOTE: hwmod changes merged to linux-omap master for testing
Date: Mon, 04 Oct 2010 12:34:50 -0700
Message-ID: <87pqvpyco5.fsf@deeprootsystems.com>
References: <20101002004821.GN3117@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90C96B@dbde02.ent.ti.com>
	<8762xi3sm1.fsf@deeprootsystems.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CD4F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64132 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab0JDTey (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 4 Oct 2010 15:34:54 -0400
Received: by pwj5 with SMTP id 5so1214658pwj.19
        for <linux-omap@vger.kernel.org>; Mon, 04 Oct 2010 12:34:53 -0700 (PDT)
In-Reply-To: <E0D41E29EB0DAC4E9F3FF173962E9E9402DB90CD4F@dbde02.ent.ti.com>
	(Manjunath Kondaiah G.'s message of "Mon, 4 Oct 2010 22:16:21 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"G, Manjunath Kondaiah" <manjugk@ti.com> writes:

>> "G, Manjunath Kondaiah" <manjugk@ti.com> writes:
>> 
>> > Hi Tony,
>> > With latest merges on master branch with commit ID:
>> > 0882b1455797b0a104978000a622c3f2412e7cf5 omap: READ CAREFULLY: Fix 
>> > build after merging in hwmod support for testing
>> >
>> > Booting with zoom3 seems to be fine but observed issues 
>> with omap4 blaze board. 
>> >
>> > Looks like multiple warning dumps and finally it crashes 
>> after "Freeing init memory" with both NFS and ramdisk file systems.
>> >
>> > The complete bootlogs are available at:
>> > NFS bootlog:
>> > http://pastebin.com/nrWQ5FGG
>> 
>> In the future, it helps greatly if you state what defconfig 
>> you're using, 
>
> ok. I have used omap2plus_defconfig
>
>> and specifically what you've changed from the 
>> default defconfig.
> No changes to defconfig
>
>> 
>> Looking at this log, you've enabled CPUidle in your config, 
>> which is not
>> (yet) supported for OMAP4 in mainline.
>
> As I mentioned no changes to defconfig and it looks like cpu idle
> is disabled and cpu idle wait is enabled in .config after running
> make omap2plus_defconfig

OK, my fault.  I misread your bootlog, and now see that it's the
default idle path that is triggering the fault, not CPUidle.

I tried on my es2.0 panda and see the same thing now, dump below.
The misc. PM warnings on boot are expected as OMAP4 does not have
functioning PM support in mainline yet.    The error that crashes is
somewhat different, but also likely related to PM as it appears to be
triggered the upon the first attempt at idle.

I haven't debugged any further, but you might want to try again with
enabling more verbose kernel debugging, specifically:

CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_ERRORS=y

as you shoul hopefully get some more information as to what causes the
initial panic.

Kevin


[    3.495330] Waiting for root device /dev/mmcblk0p2...                        
[    3.508880] mmc0: new high speed SDHC card at address d555                   
[    3.516265] mmcblk0: mmc0:d555 SU08G 7.60 GiB                                
[    3.523223]  mmcblk0: p1 p2                                                  
[    3.607177] EXT3-fs: barriers not enabled                                    
[    3.612609] kjournald starting.  Commit interval 5 seconds                   
[    3.624664] EXT3-fs (mmcblk0p2): using internal journal                      
[    3.630401] EXT3-fs (mmcblk0p2): mounted filesystem with ordered data mode   
[    3.637878] VFS: Mounted root (ext3 filesystem) on device 179:2.             
[    3.644287] Freeing init memory: 268K                                        
[    3.716003] Kernel panic - not syncing: Attempted to kill init!              
[    3.722381] CPU0: stopping                                                   
[    3.725250] [<c0052540>] (unwind_backtrace+0x0/0xec) from [<c004b2f8>] (do_I)
[    3.733917] [<c004b2f8>] (do_IPI+0xfc/0x184) from [<c03efdfc>] (__irq_svc+0x)
[    3.742095] Exception stack(0xc056df78 to 0xc056dfc0)                        
[    3.747375] df60:                                                       00000
[    3.755920] df80: 00000000 0000348f c056c000 c05e8aa8 c003503c c0580234 80032
[    3.764465] dfa0: 0000001f 00000000 00000000 c056dfc0 c00b7b4c c004cd44 2000f
[    3.773040] [<c03efdfc>] (__irq_svc+0x9c/0x160) from [<c004cd44>] (default_i)
[    3.781677] [<c004cd44>] (default_idle+0x30/0x38) from [<c004d2f0>] (cpu_idl)
[    3.790130] [<c004d2f0>] (cpu_idle+0x9c/0xf8) from [<c0008ba8>] (start_kerne)
[    3.798767] [<c0008ba8>] (start_kernel+0x2a4/0x300) from [<80008084>] (0x800)

