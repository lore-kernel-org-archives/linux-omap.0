From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: ARM: CONFIG_FRAME_POINTER
Date: Tue, 12 May 2009 16:33:11 -0700
Message-ID: <87zldhaoco.fsf@deeprootsystems.com>
References: <7B4574D56E4ADF438756313E9A172A87396257F0@dlee01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.239]:32072 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759395AbZELXdN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 May 2009 19:33:13 -0400
Received: by rv-out-0506.google.com with SMTP id f6so2197470rvb.5
        for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 16:33:13 -0700 (PDT)
In-Reply-To: <7B4574D56E4ADF438756313E9A172A87396257F0@dlee01.ent.ti.com> (Jon Hunter's message of "Tue\, 12 May 2009 16\:46\:30 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hunter, Jon" <jon-hunter@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Hunter, Jon" <jon-hunter@ti.com> writes:

> I have been doing some testing with the latest linux-omap kernel on
> the 3430sdp and the kernel appeared to hang on start-up during the
> delay loop calibration.
>
> After debugging this I found that this was being caused because
> there was a difference in the compilation flags being used when
> compiling this kernel version and an earlier kernel version. Please
> note that I am using the code sourcery arm2007q3 compiler version
> (gcc 4.2.1) which is old I know!

There was a thread a few weeks back where various folks had noticed
this as well and we discovered using CodeSourcery 2008q3 fixed the
problem, but AFAIK, nobody went much farther in the debugging as you
did.

> Investigating further I noticed that the source of the different
> kernel compilation flags was due to the fact that kernel option
> "CONFIG_FRAME_POINTER" was missing from the .config. Although this
> is declared in the defconfig for the 3430sdp but it was not getting
> copied over to the .config.
>
> Looking at the lib/Kconfig.debug it appears that there is a new
> option added back in January called "ARCH_WANT_FRAME_POINTERS"
> [1]. And only if this new option is defined in the ARCH Kconfig will
> CONFIG_FRAME_POINTER be used. Today this is not defined for ARM.
>
> I know this is the linux-omap list and not linux-arm but wanted to
> see if anyone had any comments/inputs about this and whether I
> should be using a newer compiler.
>
> [1] http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=64dec40ddee9d36d7b83f8a0513fdeaffe260a0e;hp=a3c6018e565dc07cf3738ace6bbe412f97b1bba8 

Did a similar patch for ARM get you a booting kernel using 2007q3?

Kevin
