From: Tasslehoff Kjappfot <tasskjapp@gmail.com>
Subject: Re: Bringing back gptimer_wakeup
Date: Tue, 19 Jun 2012 10:24:50 +0200
Message-ID: <4FE03752.7030009@gmail.com>
References: <4FDEF24C.8020305@gmail.com> <87k3z4lcrs.fsf@ti.com> <CAMQu2gwsL6v06fk=nJuRtuP0HZ5Jt0BmitaQ=FHJeVC__QQXAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63921 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab2FSI1f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Jun 2012 04:27:35 -0400
Received: by lbbgm6 with SMTP id gm6so5436951lbb.19
        for <linux-omap@vger.kernel.org>; Tue, 19 Jun 2012 01:27:34 -0700 (PDT)
In-Reply-To: <CAMQu2gwsL6v06fk=nJuRtuP0HZ5Jt0BmitaQ=FHJeVC__QQXAw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-omap@vger.kernel.org

On 06/19/2012 08:07 AM, Shilimkar, Santosh wrote:
> On Mon, Jun 18, 2012 at 11:31 PM, Kevin Hilman<khilman@ti.com>  wrote:
>> Tasslehoff Kjappfot<tasskjapp@gmail.com>  writes:
>>
>>> The support for using a timer to wake from suspend was removed in:
>>> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=98e182a26bbbf5575457622337684ef61493e864
>>>
>>> I found an alternative patch
>>> (http://www.mail-archive.com/linux-omap@vger.kernel.org/msg47836.html)
>>> that claimed to keep it working using GPTIMER1 instead, but I haven't
>>> been able to make it work (likely because the timer code has changed a
>>> good deal since the patch was posted).
>>>
>>> Anyone got
>>> a) a patch that enables this feature on newer kernels, or
>>> b) an idea how the patch above can be made to work?
>>
>> The branch below (based on v3.4) will work (at least on OMAP3)
>>
>> We've been holding off on putting this back becasue the timer interface
>> has been going through some major cleanup/rework, but I would like to
>> see this make it back in soonish.
>>
> I got an off-list message from Tasslehoff, that the patch I sent worked for him.
>
> Regards
> Santosh

Ah, that was meant to be an on-list message. Santosh' fix worked well on 
my 3.2.18 kernel.

- Tasslehoff
