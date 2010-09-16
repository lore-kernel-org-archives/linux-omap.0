From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing frequency
Date: Thu, 16 Sep 2010 10:28:42 +0530
Message-ID: <AANLkTimC7_pGag4e+Q0fasP=mdsug8xrU95UJLKOJHvf@mail.gmail.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com> <20100915224007.GJ4174@atomide.com>
 <alpine.DEB.2.00.1009151707370.458@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:38625 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752159Ab0IPE7E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 00:59:04 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so98893wwd.13
        for <linux-omap@vger.kernel.org>; Wed, 15 Sep 2010 21:59:02 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1009151707370.458@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, khilman@deeprootsystems.com

On Thu, Sep 16, 2010 at 4:40 AM, Paul Walmsley <paul@pwsan.com> wrote:
> On Wed, 15 Sep 2010, Tony Lindgren wrote:
>
>> * Paul Walmsley <paul@pwsan.com> [100915 12:07]:
>> > >
>> > > This change has been commited to both TI's android 2.6.29 and 2.6.32 kernels.
>> > > The commits can be viewed here:
>> > > http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=5679c7b1142f3cc2b9285181d53f6b40c4d0296d
>> > > http://git.omapzoom.org/?p=kernel/omap.git;a=commit;h=cf16e57823575d98e9d5165aa7a498ffb751c940
>> > >
>> > > This patch has been rebased on the latest linux-omap tree and tested on
>> > > Kevin Hilman's pm branch.
>>
>> Sounds like a very important fix. But also a good example of how
>> messed up things are with the TI Linux kernel development.
>>
>> Why has this fix it been sitting in some TI internal tree since
>> Fri, 12 Mar 2010?
>

Er, the Mar 12 commit date is misleading - it's likely a customer-internal
tree. It was committed to a TI internal tree 29 June/15 July, and sent to the
list within a week of the second revision.

The people who discovered this are on customer support - we spend
a significant amount of time solving bugs like these, but have very
little gap before the next big one strikes. We work tight production
schedules, getting products out and only just have enough time to
inform internal teams, but not enough to check if these fixes apply
to internal trees (mainline is far far away) and get them there.

(FWIW, Jon's been responsible for discovering and fixing more bugs
on OMAP than almost anyone else I know.)

For this specific patch, I'm not sure if other TI PM teams even
knew about the existence of this patch until end-June.



> About two months of it is my fault, since it was posted to l-o on July 21.
> But all the time between 12 March and 21 July is up to TI to answer.
> This really could have been a useful patch for certain vendors to have
> that are using CORE DVFS on their currently-shipping OMAP3 devices.

Sure, and I'm certain those other vendors have an equal number of critical
bug fixes sitting in their own trees, which they steadfastly refuse to
share with
other competing vendors until their own products are out. (I have specific
examples in mind, but don't want to start another flame war).

Grow up - when a bug is discovered in the field, people are not likely to
share with others in the interest of their own product timelines. While
this may overall be less beneficial for everyone, that is indeed how many
think and work.

>
>> This same bug has been patched in three different trees? But not in
>> the mainline kernel?
>>
>> And this is happening all the time with the TI fixes.
>
> Yeah.

OMAP4 has been demonstrably different - almost every single patch
reaches mainline almost as soon as it is discovered. We had new
silicon woken up with near-mainline code, and new boards supported
in mainline even before the number of boards were in the mid-double digits.

We're working very hard to keep things this way - give us a break. Stop
inciting flame wars. A little support and understanding on your part
would go a long way.

- Anand
