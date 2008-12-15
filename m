From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: N810 suspend
Date: Mon, 15 Dec 2008 14:02:21 -0800
Message-ID: <87prjt9jwy.fsf@deeprootsystems.com>
References: <20081215210823.GD5334@swansys>
	<20081215211430.GJ10664@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:58880 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbYLOWC2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Dec 2008 17:02:28 -0500
Received: by nf-out-0910.google.com with SMTP id d3so490540nfc.21
        for <linux-omap@vger.kernel.org>; Mon, 15 Dec 2008 14:02:26 -0800 (PST)
In-Reply-To: <20081215211430.GJ10664@atomide.com> (Tony Lindgren's message of "Mon\, 15 Dec 2008 13\:14\:32 -0800")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux-OMAP List <linux-omap@vger.kernel.org>

Tony Lindgren <tony@atomide.com> writes:

> * green <greenfreedom10@gmail.com> [081215 13:08]:
>> What are the chances of getting suspend (resume from) working on the N810?  Are 
>> there any patches or branches around that I can test (I'm slowly learning how 
>> to use git)?
>> 
>> I'm running Debian on an N810.  With the current state of power management in 
>> linux-omap, the N810 will only run (with LCD off) for about 12 hours on a 
>> charge.
>
> Well you need to make sure the serial clocks are not enabled. Kevin
> has some patches for that in his pm branch. So you'll most likely want
> to use his whole pm branch.
>
> Also, you need to make sure you have sleep while idle enabled:
>
> # echo 1 > /sys/power/sleep_while_idle
>
> It used to work, but I have not tried for six months or so.
>

Suspend/resume on n810 is currently broken in linux-omap.  I submitted
a patch a week or so ago to fix an assembly bug which was crashing the
suspend, but it is still not resuming.

Most likely a simple fix needed to init the proper wakeup sources, but
I haven't tested further.

Kevin




