From: Luciano Coelho <coelho@ti.com>
Subject: Re: [PATCH 0/2] ARM: OMAP2+: PM: code consolidation for 3.4
Date: Thu, 08 Mar 2012 20:47:13 +0200
Message-ID: <1331232433.18015.69.camel@cumari>
References: <20120202093600.12509.35052.stgit@dusk> <87ty39cc7s.fsf@ti.com>
	 <alpine.DEB.2.00.1202021140060.586@utopia.booyaka.com>
	 <alpine.DEB.2.00.1202021328450.586@utopia.booyaka.com>
	 <CAKd1q9rq67gUyXn+rOL348YwaYQiqHR8UQCSd68fpxhZHHsYGA@mail.gmail.com>
	 <87sjhjaqyi.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:46484 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752813Ab2CHSrT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 Mar 2012 13:47:19 -0500
Received: by mail-lpp01m010-f53.google.com with SMTP id c1so873367lah.40
        for <linux-omap@vger.kernel.org>; Thu, 08 Mar 2012 10:47:17 -0800 (PST)
In-Reply-To: <87sjhjaqyi.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com, linux-arm-kernel@lists.infradead.org, rnayak@ti.com

On Thu, 2012-03-08 at 10:27 -0800, Kevin Hilman wrote: 
> Hi Luca,

Hey Kevin,

Thanks for your reply! :)


> "Coelho, Luciano" <coelho@ti.com> writes:
> 
> [...]
> 
> > I can't get ttyO2 wakeup to work on my Blaze with 3.3-rc5.  It works
> > fine with 3.2.  
> 
> I assume you mean wakeup from system-wide suspend (echo mem > /sys/power/state)?

Yes, that's what I meant.

> Are you enabling UART wakeups?
> 
> They are disabled by default, so you need to:
> 
> echo enabled > /sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/wakeup

No, I was actually not enabling the UART wakeups.  But I tried it now
but it still doesn't work. :(


> It may work in v3.2 due to the fact that the UART runtime PM had the
> unintended side-effect of essentially disabling MPU and CORE PM.  With
> that bug fixed and MPU & CORE actually hitting low power states, you'll
> need to ensure UART wakeups are enabled.
> 
> If you're already enabling wakeups and this still isn't working, try
> adding 'no_console_suspend' to the kernel cmdline, try a suspend/resume
> and post the console output.

I have no_console_suspend in bootargs.  Without it, it didn't work with
3.2 either.

This is what I get when I suspend with "echo mem > /sys/power/state": 

[  128.534271] PM: Syncing filesystems ... done.                                                                        
[  129.948364] PM: Preparing system for mem sleep                                                                       
[  129.957061] Freezing user space processes ...                                                                        
[  129.961761] BUG: sleeping function called from invalid context at include/linux/freezer.h:46                         
[  129.969177] in_atomic(): 0, irqs_disabled(): 128, pid: 770, name: udevd                                              
[  129.977813] INFO: lockdep is turned off.                                                                             
[  129.977813] irq event stamp: 0                                                                                       
[  129.985168] hardirqs last  enabled at (0): [<  (null)>]   (null)                                                     
[  129.991485] hardirqs last disabled at (0): [<c004233c>] copy_process+0x3ec/0x1050                                    
[  129.996520] softirqs last  enabled at (0): [<c004233c>] copy_process+0x3ec/0x1050                                    
[  130.005218] softirqs last disabled at (0): [<  (null)>]   (null)                                                     
[  130.011291] [<c001e204>] (unwind_backtrace+0x0/0x148) from [<c0502fdc>] (dump_stack+0x20/0x24)                       
[  130.018829] [<c0502fdc>] (dump_stack+0x20/0x24) from [<c00779d0>] (__might_sleep+0x130/0x134)                        
[  130.030670] [<c00779d0>] (__might_sleep+0x130/0x134) from [<c0018998>] (do_signal+0x54/0x600)                        
[  130.031738] [<c0018998>] (do_signal+0x54/0x600) from [<c0018fa4>] (do_notify_resume+0x60/0x6c)                       
[  130.049804] [<c0018fa4>] (do_notify_resume+0x60/0x6c) from [<c00154e4>] (work_pending+0x24/0x28)                     
[  130.067138] (elapsed 0.10 seconds) done.                                                                             
[  130.070648] Freezing remaining freezable tasks ... (elapsed 0.02 seconds) done.                                      
[  130.101165] PM: Entering mem sleep                                                                                   
[  130.120056] PM: suspend of devices complete after 9.646 msecs                                                        
[  130.127716] PM: late suspend of devices complete after 7.662 msecs                                                   
[  130.134246] Disabling non-boot CPUs ...                                                                              
[  130.139953] CPU1: shutdown  

The "sleeping function" BUG is that known bug I already complained about
some time ago.  I get it all the time and, in general, it doesn't really
hurt (I guess I'm lucky most of the times not to hit a race-condition).

-- 
Cheers,
Luca.

