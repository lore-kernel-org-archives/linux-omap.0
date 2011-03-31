From: Kevin Hilman <khilman@ti.com>
Subject: Re: Question regarding suspend/resume
Date: Thu, 31 Mar 2011 13:48:06 -0700
Message-ID: <8739m3auex.fsf@ti.com>
References: <4D7FBD31.6050806@gmail.com> <87wrk0gn41.fsf@ti.com>
	<4D94E148.8060905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog115.obsmtp.com ([74.125.149.238]:52847 "EHLO
	na3sys009aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753303Ab1CaUsJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Mar 2011 16:48:09 -0400
Received: by mail-iw0-f170.google.com with SMTP id 3so3181013iwn.29
        for <linux-omap@vger.kernel.org>; Thu, 31 Mar 2011 13:48:08 -0700 (PDT)
In-Reply-To: <4D94E148.8060905@gmail.com> (Peter Barada's message of "Thu, 31
	Mar 2011 16:17:12 -0400")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Barada <peter.barada@gmail.com>
Cc: Linux OMAP list <linux-omap@vger.kernel.org>

Hi Peter,

Peter Barada <peter.barada@gmail.com> writes:

[...]

> Thanks for helping me to understand things.
>
> The kernel I'm using is TI's OMAPPSP_03.00.01.06 2.6.32 kernel [1]
> with their u-boot [2] and x-loader[3], modified to run on Logic's
> DM3730 board(s) (as we use the Micron mt29c4g48mazapakq-5 POP).  

I'm afraid somone who supports that older TI kernel will have to help
you out.

If you can reproduce on a current kernel, I'd be glad to help but I'm
currently not able (well, not willing is more accurate) to try and
figure out what's going on based on an older kernel with who knows how
many out-of-tree patches/hacks piled on.

What I can say based on the register dump you shared is that there is no
obvious driver issue going on where a clock was left on by a driver.

More than likely what is going on is that the booloader is using a
device (e.g. USB, MMC) but is leaving it in a state such that that IP
block cannot idle, so the CORE powerdomain then does not fully idle.
In older kernels like this one, the linux drivers did not fully reset
the hardware so bootloaders could cause problems like this (the u-boot
on beagle has had several problems like this.)

As a first whack at things, I would focus on USB OTG and MMC, as I've
seen problem with both on other platforms, like Beagle.  You need to
ensure that both the these modules are fully reset either by the
bootloader when it's done using them, or by the kernel in the early boot
process.  Current kernels now do the latter.

Sorry I can't be of more help,

Kevin
