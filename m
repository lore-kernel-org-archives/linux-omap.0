From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: linux-omap-pm troubles on Gumstix Overo
Date: Wed, 07 Apr 2010 08:56:35 -0700
Message-ID: <87tyrnfe8c.fsf@deeprootsystems.com>
References: <4BBBF808.80000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:45339 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932581Ab0DGP4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 7 Apr 2010 11:56:39 -0400
Received: by pva18 with SMTP id 18so777199pva.19
        for <linux-omap@vger.kernel.org>; Wed, 07 Apr 2010 08:56:38 -0700 (PDT)
In-Reply-To: <4BBBF808.80000@gmail.com> (Peter Tseng's message of "Tue\, 06 Apr 2010 23\:12\:08 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Tseng <tsenpet09@gmail.com>
Cc: linux-omap@vger.kernel.org

Peter Tseng <tsenpet09@gmail.com> writes:

> Hey there,
>
> My name's Peter and I'm working with the linux-omap-pm kernel on the
> Gumstix Overo board for an academic project.
>
> Back when the linux-omap-pm branch was still on 2.6.33-rc8, I could
> compile and run the kernel on the Overo without any problems. Suspend to
> memory (via mem > /sys/power/state) worked just fine. Unfortunately,
> ever since 2.6.34-rcX releases started coming out, I have been running
> into problems:
>
> First of all, I was under the impression that omap3_pm_defconfig was
> supposed to more-or-less work "out of the box". This has not been the
> case, as when I try to compile:
>
> make ARCH=arm omap3_pm_defconfig
> make ARCH=arm -j4 uImage
> CROSS_COMPILE=/opt/arm-2009q3/bin/arm-none-linux-gnueabi-
>
> I get these error messages back.
>
> arch/arm/mach-omap2/omap44xx-smc.S: Assembler messages:
> arch/arm/mach-omap2/omap44xx-smc.S:30: Error: missing expression -- `smc'
> make[1]: *** [arch/arm/mach-omap2/omap44xx-smc.o] Error 1
> make: *** [arch/arm/mach-omap2] Error 2

Hmm, this one looks like a compiler specific issue.  I too see this
when switching to CSL 2009q3, but don't see it with 2009q1 or 2008q3

> Fortunately, this is solved by using menuconfig and un-checking the
> OMAP4 in System Type (this shouldn't affect anything, as the Overo is
> using the OMAP3...)
>
>
> Unfortunately, after building that, when I try to boot the Overo, this
> is as far as it gets:
>
> ## Booting kernel from Legacy Image at 82000000 ...
>    Image Name:   Linux-2.6.34-rc3-09551-gb301cc7
>    Image Type:   ARM Linux Kernel Image (uncompressed)
>    Data Size:    1994520 Bytes =  1.9 MB
>    Load Address: 80008000
>    Entry Point:  80008000
>    Verifying Checksum ... OK
>    Loading Kernel Image ... OK
> OK
>
> Starting kernel ...
>
> Uncompressing Linux... done, booting the kernel.
>
> I have no idea if it simply hangs here, or it is working and simply not
> printing anything to the serial console. (If it helps at all, the
> processor *seems* warm, but I cannot be sure of this).

What's your commandline?

Can you try enabling CONFIG_DEBUG_LL=y and and CONFIG_EARLY_PRINTK=y
and append 'earlyprintk' on the kernel command line.

This will hopefully give more detailed reasons for the dump.

I seem to have corrupted the flash on my overo so it's not booting
currently, but the current PM branch kernel does boot fine on my
beagle C3.

>
> To see if the problem can be solved by going back to 2.6.33, I do a git
> checkout of the corresponding branch:
>
> git checkout -b stable v2.6.33
>
> I compile with the attached .config file, and the overo boots up just
> fine (though at some point in the process modprobe complains to me about
> omaplfb not found...)
>
> However, now when I try to suspend, I get this:
>
> root@overo:~# echo mem > /sys/power/state
> PM: Syncing filesystems ... done.
> Freezing user space processes ... (elapsed 0.01 seconds) done.
> Freezing remaining freezable tasks ... (elapsed 0.01 seconds) done.
> Suspending console(s) (use no_console_suspend to debug)
> PM: suspend of devices complete after 109.004 msecs
> PM: late suspend of devices complete after 0.274 msecs
> Class driver suspend failed for cpu0
> PM: early resume of devices complete after 0.030 msecs
> PM: resume of devices complete after 343.597 msecs
> Restarting tasks ... done.
>
> The "Class driver suspend failed for cpu0" is what concerns me, and I've
> tried a lot of stuff and have remained unable to get suspend working again.

Try disabling CPUfreq, which is not supported in 2.6.33 mainline.
This error is coming since the CPUfreq core is reporting an error when
trying to supend.

> To summarize, my questions are:
>
> 1. Why do the 2.6.34-rcX kernels stop at "Uncompressing Linux... done,
> booting the kernel."?
> 2. Why does the 2.6.33 kernel fail to suspend with "Class driver suspend
> failed for cpu0"? Did I incorrectly perform the git checkout, or did I
> misconfigure something?
> 3. And finally, for my future work, since I am interested in power
> management, is there a possible solution to suspending to disk? (Perhaps
> termed "hibernate")

I'm not aware of work on this, but I believe this will require some
ARM-generic work, not OMAP-specific.

Kevin

> I would greatly appreciate any pointers in the right direction so I can
> get this working again. Thanks a lot for your time and attention.
