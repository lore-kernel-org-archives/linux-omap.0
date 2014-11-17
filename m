From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: Fail to enter retention
Date: Mon, 17 Nov 2014 23:09:53 +0200
Message-ID: <CAJ2oMhJxnRjb8NUz+JyYLJYiRBA+vSA3C2q7viEZf0sVXqFtqw@mail.gmail.com>
References: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
	<20141117162209.GE7046@atomide.com>
	<CAJ2oMh+t-Wahe=CTbrZQ=C2X-0n_x6FSzhwA6opyzhDFvJXdZg@mail.gmail.com>
	<20141117180944.GG7046@atomide.com>
	<CAJ2oMhL5x3nAxTQg36O9-DUfHK9iy-g9+qqN=bYj3Nw7HNjAnA@mail.gmail.com>
	<20141117203808.GH7046@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:44677 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbaKQVJz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 16:09:55 -0500
Received: by mail-wi0-f176.google.com with SMTP id ex7so7108085wid.9
        for <linux-omap@vger.kernel.org>; Mon, 17 Nov 2014 13:09:54 -0800 (PST)
In-Reply-To: <20141117203808.GH7046@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

Hi Tony,

>Just printing the registers out in the idle loop most likely will give
>you the info you need.

Probably a dumb question... But if I try to print them won't it
automatically wakes up the serial (by the way should the serial wakeup
be configured to RX pin only ?)
Another thing I don't understand... Can it be that there is some
ongoing kernel process that also prevent me for entering retention ?
I think maybe I should try first to suspend (instead of trying to
enter retention in idle) , maybe it might bring better result ?

Thanks very much,
Ran

On Mon, Nov 17, 2014 at 10:38 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ran Shalit <ranshalit@gmail.com> [141117 11:48]:
>> >You need to look if you have some devices blocking deeper
>> >idle states in cm_idlest*_core and cm_idlest_per registers.
>>
>> >The device will automatically idle whatever it can if there
>> >are no blockers. I believe at least EHCI still is blocking,
>> >and MUSB if configured and cable connected.
>>
>> I'll check the registers value, should I then try to modify this
>> registers in order to get into retention ?
>
> No, those are read-only status registers. You need idle the
> drivers that show as blocking in those registers.
>
>> I will still have to disable serial right ? Maybe some kernel process
>> which run in background prevents retention ?
>
> Yes otherwise the UART bits will show as blocking in those
> registers.
>
>> Is there some simple way to debug this or do I need to modify these registers ?
>
> Just printing them out in the idle loop most likely will give
> you the info you need.
>
> Regards,
>
> Tony
