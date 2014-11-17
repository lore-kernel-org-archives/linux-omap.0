From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: Fail to enter retention
Date: Mon, 17 Nov 2014 21:46:22 +0200
Message-ID: <CAJ2oMhL5x3nAxTQg36O9-DUfHK9iy-g9+qqN=bYj3Nw7HNjAnA@mail.gmail.com>
References: <CAJ2oMh+jALrwq8sOf84+zK-0=vSS790jsW-jjgZtBCXvJDuG4w@mail.gmail.com>
	<20141117162209.GE7046@atomide.com>
	<CAJ2oMh+t-Wahe=CTbrZQ=C2X-0n_x6FSzhwA6opyzhDFvJXdZg@mail.gmail.com>
	<20141117180944.GG7046@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:51337 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751907AbaKQTqX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 17 Nov 2014 14:46:23 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so2804834wiv.11
        for <linux-omap@vger.kernel.org>; Mon, 17 Nov 2014 11:46:22 -0800 (PST)
In-Reply-To: <20141117180944.GG7046@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

>You need to look if you have some devices blocking deeper
>idle states in cm_idlest*_core and cm_idlest_per registers.

>The device will automatically idle whatever it can if there
>are no blockers. I believe at least EHCI still is blocking,
>and MUSB if configured and cable connected.

I'll check the registers value, should I then try to modify this
registers in order to get into retention ?
I will still have to disable serial right ? Maybe some kernel process
which run in background prevents retention ?
Is there some simple way to debug this or do I need to modify these registers ?

Thank you very much,
Ran

On Mon, Nov 17, 2014 at 8:09 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Ran Shalit <ranshalit@gmail.com> [141117 09:14]:
>> Hi Tony,
>>
>> Thanks very much for suggestions,
>> I am able to wakeup the uart (though it takes about 10 seconds till it wakeup).
>
> The wake-up should happen within few hundred milliseconds at most.
> Sounds like you're waking on some timer event instead.
>
>> Do you have any suggestion, how I can understnad why it did not get
>> into retention and how to continue from this point ?
>
> You need to look if you have some devices blocking deeper
> idle states in cm_idlest*_core and cm_idlest_per registers.
>
> The device will automatically idle whatever it can if there
> are no blockers. I believe at least EHCI still is blocking,
> and MUSB if configured and cable connected.
>
> Regards,
>
> Tony
