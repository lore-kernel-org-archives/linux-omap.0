From: "arun c" <arun.edarath@gmail.com>
Subject: Re: Power management behavior of linux-2.6.14-omap2-v5
Date: Tue, 20 May 2008 10:16:57 +0530
Message-ID: <c656a4d20805192146m5bece6e6lffd3a65a7c414a55@mail.gmail.com>
References: <c656a4d20805182349h66efb783pc3b3658a1935ba5@mail.gmail.com>
	 <3B6D69C3A9EBCA4BA5DA60D913027429045555F3@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.189]:58052 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYETEq7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 May 2008 00:46:59 -0400
Received: by ti-out-0910.google.com with SMTP id b6so1051440tic.23
        for <linux-omap@vger.kernel.org>; Mon, 19 May 2008 21:46:58 -0700 (PDT)
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D913027429045555F3@dlee13.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: r-woodruff2@ti.com

On Mon, May 19, 2008 at 6:48 PM, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> You are just talking about your logo disappearing (usually tux)?

No not just tux.

If i run tslib (ts_test) and suspend& resume the
board then also the same behavior is happening.
ie. The normal ts_test screen disappears and
blue screen comes.

Also if i do a cat of some image to /dev/fb0 then
the same image disappears after a
suspend&resume cycle, whether this behavior also
linked to console layer?

Or a higher level mechanism (like X server)
is required to save and restore the framebuffer
after a PM cycle or it's the fb driver's responsibility
to do so?

Regards,
Arun C

>
> It has been this way for years if not forever on all Linux systems.
>
> A long while back in 2.4 this bothered me enough that I did fix it in a MV kernel.  This is in effect of the console layer not saving its logo settings.  It is not all that hard to fix.
>
> For a development system having the logo is kind of a nice thing even an advertising tool.  However, probably no one ships a system with it on.
>
> You might send a patch in to console people to fix it.  When I sent a patch to MV long back it was discarded.  I didn't send it to the proper maintainer which could have stuck then.
>
> Regards,
> Richard W.
>
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of arun c
>> Sent: Monday, May 19, 2008 1:49 AM
>> To: linux-omap@vger.kernel.org
>> Subject: Power management behavior of linux-2.6.14-omap2-v5
>>
>> Hi all,
>>
>> I am using linux-2.6.14-omap2-v5 to test PM on 2430SDP.
>>
>> I did
>>
>> a) cat myimg > /dev/fb0
>>     I can see "myimg" displayed on the lcd
>>
>> b) cat /dev/fb0 > myimg_before_sleep
>>
>> c) echo "mem" > /sys/power/state
>>     Board goes to sleep state.
>>
>> d) After a key press the board awakes and lcd
>>    becomes blue "myimg" is disappeared from
>>    the screen.
>>
>> e) cat /dev/fb0 > myimg_after_wakeup
>>
>>  The two binary files "myimg_before_sleep" and
>> "myimg_after_wakeup" differs each other.
>>
>> Can somebody explain me why such a behavior?
>> Why the lcd fails to display the same image
>> before and after sleeping?
>>
>> Regards,
>> Arun C
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
