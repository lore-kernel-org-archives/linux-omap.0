From: Tyler <tyler@bmsacoustics.com>
Subject: Re: Serial console not working after waking up from sleep
Date: Thu, 22 Jul 2010 21:09:04 +0000 (UTC)
Message-ID: <loom.20100722T224314-889@post.gmane.org>
References: <AANLkTind1hzgSWIfzNBxjCXPpdPhMYgUkSqYA0WjjYjR@mail.gmail.com> <4C186A97.5040208@panicking.kicks-ass.org> <AANLkTikISCuLKjHTzn6FfiqMRlIKf7tY5RZlYXU40U1W@mail.gmail.com> <4C18E3F8.1060605@panicking.kicks-ass.org> <D2943F03B81C9C458E44DFB213905E02B65BA040@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:60971 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752645Ab0GVVPI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 22 Jul 2010 17:15:08 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gplao-linux-omap-open-source-moved1@m.gmane.org>)
	id 1Oc36d-0003d3-WC
	for linux-omap@vger.kernel.org; Thu, 22 Jul 2010 23:15:04 +0200
Received: from c-24-20-89-128.hsd1.wa.comcast.net ([24.20.89.128])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 22 Jul 2010 23:15:03 +0200
Received: from tyler by c-24-20-89-128.hsd1.wa.comcast.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-omap@vger.kernel.org>; Thu, 22 Jul 2010 23:15:03 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Sapiens, Rene <rene.sapiens <at> ti.com> writes:

> 
> You can do a telnet to the device... you should be able to work with it but 
your serial session will show the garbage.
> 
> Regards,
> Rene
> 


Hello,

I am in essentially the same position, but currently working off of the pm-head 
branch.

I am just using an initramfs, and have tried a few variations.

With no_console_suspend set, I can trigger a wakeup using the 
wakeup_timer_seconds.  The power usage goes back to the pre-suspend level, and I 
see text indicating a successful wakeup, but the console never comes back.

Without no_console_suspend set, I can trigger the wakeup again with 
wakeup_timer_seconds, a console prompt comes back, but is unresponsive.

I saw Rene's response about using Telnet, but this implies that there is an 
ethernet interface available.  I have a custom board that only has a serial 
interface for external visibility, so at this point I lose insight into what is 
happening on the board.

I have two questions, if people would be so willing to oblige:

1) Does anyone know why the console doesn't come back after wakeup?  Is this 
something that may work in the future?

2) Does the console freezing mean that the other COM ports also don't work?  
Would communication on other interfaces continue to work?  For example, a GPS 
plugged into one of the other COM ports?

Thanks,

Tyler

