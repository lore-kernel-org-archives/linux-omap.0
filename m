From: "Gadiyar, Anand" <gadiyar@ti.com>
Subject: Re: [PATCH] omap3: Prevent SDRC deadlock when L3 is changing frequency
Date: Fri, 17 Sep 2010 01:53:54 +0530
Message-ID: <AANLkTinXdow4tzmwpx6nRe5VCN5Q8_aKz9EibxKinWWO@mail.gmail.com>
References: <1279728155-2643-1-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1009151300190.458@utopia.booyaka.com> <20100915224007.GJ4174@atomide.com>
 <alpine.DEB.2.00.1009151707370.458@utopia.booyaka.com> <AANLkTimC7_pGag4e+Q0fasP=mdsug8xrU95UJLKOJHvf@mail.gmail.com>
 <20100916185743.GJ29610@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:39148 "HELO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753907Ab0IPUYQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 16 Sep 2010 16:24:16 -0400
Received: by mail-ww0-f44.google.com with SMTP id 18so268301wwb.13
        for <linux-omap@vger.kernel.org>; Thu, 16 Sep 2010 13:24:14 -0700 (PDT)
In-Reply-To: <20100916185743.GJ29610@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, Jon Hunter <jon-hunter@ti.com>, linux-omap <linux-omap@vger.kernel.org>, khilman@deeprootsystems.com

On Fri, Sep 17, 2010 at 12:27 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Gadiyar, Anand <gadiyar@ti.com> [100915 21:51]:
>>
>> > About two months of it is my fault, since it was posted to l-o on July 21.
>> > But all the time between 12 March and 21 July is up to TI to answer.
>> > This really could have been a useful patch for certain vendors to have
>> > that are using CORE DVFS on their currently-shipping OMAP3 devices.
>>
>> Sure, and I'm certain those other vendors have an equal number of critical
>> bug fixes sitting in their own trees, which they steadfastly refuse to
>> share with
>> other competing vendors until their own products are out. (I have specific
>> examples in mind, but don't want to start another flame war).
>>
>> Grow up - when a bug is discovered in the field, people are not likely to
>> share with others in the interest of their own product timelines. While
>> this may overall be less beneficial for everyone, that is indeed how many
>> think and work.
>
> I don't buy this. But maybe some of TI's customers can comment on this?
>
> AFAIK everybody wants to avoid the duplicate effort of finding and fixing
> these bugs.
>
> TI is the only party who is even aware of all the bugs fixed in various
> places. And it's TI who should follow up that the bugfixes get posted
> in a timely manner.
>

We're committed 100% to making sure mainline is working well
on OMAPs. This means that any bugs we discover will be reported,
and any fixes we have will make their way upstream as soon as possible.

I'm not going to go and fight what's happened in the past. But for the
future, we're taking steps to make sure mainline works well.

For the past - OMAP3 and before - we'll do our best to scrub all internal
trees for missing bugs/features/what not and hopefully this will
go upstream as we discover those.

Sounds fair?

- Anand
