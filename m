From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: Bringing back gptimer_wakeup
Date: Tue, 19 Jun 2012 11:37:32 +0530
Message-ID: <CAMQu2gwsL6v06fk=nJuRtuP0HZ5Jt0BmitaQ=FHJeVC__QQXAw@mail.gmail.com>
References: <4FDEF24C.8020305@gmail.com> <87k3z4lcrs.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33462 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752615Ab2FSGIS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Jun 2012 02:08:18 -0400
Received: by qabg1 with SMTP id g1so1848180qab.20
        for <linux-omap@vger.kernel.org>; Mon, 18 Jun 2012 23:07:52 -0700 (PDT)
In-Reply-To: <87k3z4lcrs.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tasslehoff Kjappfot <tasskjapp@gmail.com>, linux-omap@vger.kernel.org

On Mon, Jun 18, 2012 at 11:31 PM, Kevin Hilman <khilman@ti.com> wrote:
> Tasslehoff Kjappfot <tasskjapp@gmail.com> writes:
>
>> The support for using a timer to wake from suspend was removed in:
>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=98e182a26bbbf5575457622337684ef61493e864
>>
>> I found an alternative patch
>> (http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47836.html)
>> that claimed to keep it working using GPTIMER1 instead, but I haven't
>> been able to make it work (likely because the timer code has changed a
>> good deal since the patch was posted).
>>
>> Anyone got
>> a) a patch that enables this feature on newer kernels, or
>> b) an idea how the patch above can be made to work?
>
> The branch below (based on v3.4) will work (at least on OMAP3)
>
> We've been holding off on putting this back becasue the timer interface
> has been going through some major cleanup/rework, but I would like to
> see this make it back in soonish.
>
I got an off-list message from Tasslehoff, that the patch I sent worked for him.

Regards
Santosh
