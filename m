From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: OMAP3 PM: off-mode during idle, problem with UART1 console
Date: Fri, 19 Jun 2009 09:20:49 -0700
Message-ID: <87ab44xkim.fsf@deeprootsystems.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB0305A54975@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.172]:31509 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058AbZFSQUt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 19 Jun 2009 12:20:49 -0400
Received: by wf-out-1314.google.com with SMTP id 26so893603wfd.4
        for <linux-omap@vger.kernel.org>; Fri, 19 Jun 2009 09:20:51 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0305A54975@dbde02.ent.ti.com> (Rajendra Nayak's message of "Fri\, 19 Jun 2009 15\:12\:44 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Nayak, Rajendra" <rnayak@ti.com>
Cc: "Woodruff, Richard" <r-woodruff2@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

"Nayak, Rajendra" <rnayak@ti.com> writes:

>>-----Original Message-----
>>From: Kevin Hilman [mailto:khilman@deeprootsystems.com] 
>>Sent: Wednesday, June 17, 2009 8:37 PM
>>To: Nayak, Rajendra
>>Cc: Woodruff, Richard; linux-omap@vger.kernel.org
>>Subject: Re: OMAP3 PM: off-mode during idle, problem with UART1 console
>>
>>"Nayak, Rajendra" <rnayak@ti.com> writes:
>>
>>> What Silicon Rev does your SDP have? I currently am using an 
>>ES3.1 based SDP
>>> and I havent seen any of these issues you have reported with 
>>off-while-idle.
>>
>>I have and ES3.0 SDP. 
>>
>>> Infact I have kept the board running overnight a couple 
>>times in the last week 
>>> with off-while-idle and voltage scaling to 0v enabled, 
>>mainly to test the recent
>>> patch set (disabling Auto idle for PER in scratchpad memory) 
>>for stability.
>>
>>Ah, great.  That is really good to know.  Are you using 
>>omap_3430sdp_pm_defconfig?
>>
>>I see the same problems with and without your patches.
>>
>>> I will see if I can get hold of an ES3 and ES2.1 based SDP's 
>>and see if I reproduce
>>> the issue. Besides I use nfs and I am not sure if that's got 
>>something to do with it.
>>> Will try a ramdisk also.
>>
>>I'm using a ramdisk.
>>
>>> Does it take you a while to reproduce this, or is it seen 
>>after the very first UART
>>> inactivity?
>>
>>It happens on the first try.
>>
>>Could you try my uImage which has my initramfs rootfs built-in on your
>>ES3.1 SDP?
>>
>>   http://userweb.kernel.org/~khilman/tmp/rajendra/uImage.pm-vanilla
>>
>>Immediately after booting, I do
>>
>># echo 1 > /sys/power/enable_off_mode                          
>>                 
>># echo 1 > /sys/power/voltage_off_while_idle                   
>>                 
>># echo 1 > /sys/power/sleep_while_idle                         
>>                 
>>
>>and after UART inactivity, I start to see sys_off_mode LED blinking.
>
> Kevin,
>
> This image works just fine on both my ES3.1 GP as well as ES3.0 EMU SDP.
> After the sys_off LED blinks, a key press stops the blinking and also gets
> be the debug console back.
>

Rajendra,

Thanks a lot for testing.  It sounds like something specific to the
ES3.0 GP SDP.

Kevin
