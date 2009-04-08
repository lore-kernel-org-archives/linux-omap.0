From: Hugo Vincent <hugo.vincent@gmail.com>
Subject: Re: Preempt-RT on OMAP3?
Date: Thu, 9 Apr 2009 11:34:37 +1200
Message-ID: <5a7b8b7b0904081634h656ccd5eib7dfb0972880f8c1@mail.gmail.com>
References: <5a7b8b7b0904052025g74325484h66335606bebea5a3@mail.gmail.com>
	 <5a7b8b7b0904062119w42209eedp8645d096acb8c4dd@mail.gmail.com>
	 <5a7b8b7b0904071822r52e910aat2454a63b0edadb69@mail.gmail.com>
	 <200904081521.02072.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.242]:18821 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbZDHXej convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Apr 2009 19:34:39 -0400
Received: by an-out-0708.google.com with SMTP id d14so344104and.1
        for <linux-omap@vger.kernel.org>; Wed, 08 Apr 2009 16:34:38 -0700 (PDT)
In-Reply-To: <200904081521.02072.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap@vger.kernel.org

Cheers for that David.

Those patches still apply cleanly, but don't seem to affect this
particular problem.

I'm now using the 2.6.29.1 patch and the 2.6.29.1-rt5 patch against
Linux-omap 90e758af52ba803cba233fabee81176d99589f09. Here is the log
now:
http://hugovincent.com/files/lkml-20090407/boot4.log

I've spent enough time on this already, so I think I'll wait and see
if anyone takes on fixing these issues, and hope that my MUSB Rx DMA
problems go away when the pending patches hit. The RT patchset already
is working well enough for me in my application, and the only reason I
would absolutely *need* to fix it is because of nagging doubts about
possible deadlocks or crashes after I've deployed my board into the
field...

Thanks for all your help.

Hugo

On Thu, Apr 9, 2009 at 10:21 AM, David Brownell <david-b@pacbell.net> w=
rote:
> On Tuesday 07 April 2009, Hugo Vincent wrote:
>> > http://hugovincent.com/files/lkml-20090407/boot3.log
>>
>> Can anyone give me any pointers on where to start for fixing the
>> problems shown in the above boot log?
>
> You'll have to start finding out about all the funky rules
> which apply to the -RT kernels, I think.
>
> As a rule, getting drivers to work in RT kernels involves
> some changes. =A0Not all of those changes can work in mainline
> kernels. =A0Some of the changes are driver issues; while some
> are changes in RT framework code. =A0Some are bugfixes.
>
> There are a lot of reasons why not all the RT patches have
> made it to mainline ...
>
>
>> It looks like some fairly low level locking bugs (spinlock vs
>> raw_spinlock maybe?) in twl4030 IRQ handling and GP timer/clock even=
t
>> source setup.
>
> The first lockdep warning is about some IRQ dispatch code.
>
> I happen to have the appended patches sitting around; they
> might affect this particular problem (or might not). =A0I don't
> know if they'd even apply to the RT kernel.
>
> Alternatively, there's some odd rule about using workqueues
> in the current RT code. =A0Like not being able to trigger them
> from all the usual contexts. =A0If so, that seems buglike to me.
>
> - Dave
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
