From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] ARM: dts: Correct offset in OMAP4_WKUP_IOPAD macro
Date: Sun, 11 May 2014 19:27:43 +0200
Message-ID: <CAGhQ9VwALSFVn3dd+VWV4AWBZnHUFqpJv7yQyLvR4U+W6nL+aQ@mail.gmail.com>
References: <1397924056-6462-1-git-send-email-manabian@gmail.com>
	<CAGhQ9VwU_BjrD+c9uJn9FBwo6v_BOMUCKwiOW-7eqOu056a79A@mail.gmail.com>
	<20140421153539.GB23945@atomide.com>
	<CAGhQ9VyFQgcOw8y97R6HR1apXo-89JyktADxR6jb1EJipXqqjA@mail.gmail.com>
	<CAGhQ9VxCA_VnO18zWgtWUExNE6YJd+krNEVLtyZTpyY6hRyHUg@mail.gmail.com>
	<20140506001237.GK25949@atomide.com>
	<CAGhQ9Vw+cR-cKQ-w3psZPOWOqwugntXq-9g5=4cZV-ijQZecTQ@mail.gmail.com>
	<20140509160725.GG17814@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-vc0-f173.google.com ([209.85.220.173]:63372 "EHLO
	mail-vc0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991AbaEKR1o (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 11 May 2014 13:27:44 -0400
Received: by mail-vc0-f173.google.com with SMTP id il7so7680871vcb.32
        for <linux-omap@vger.kernel.org>; Sun, 11 May 2014 10:27:43 -0700 (PDT)
In-Reply-To: <20140509160725.GG17814@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 9 May 2014 18:07, Tony Lindgren <tony@atomide.com> wrote:
> * Joachim Eastwood <manabian@gmail.com> [140509 05:58]:
>> On 6 May 2014 02:12, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > OK sorry just noticed you're using it already while was about to
>> > apply your patches. Care to update that series again to not use the
>> > macro, or by adding the offsets?
>>
>> hm, I'd rather add offsets than remove the macro's now.
>>
>> How about we introduce a mask parameter in to the OMAP_IOPAD_OFFSET macro?
>> Something like this:
>> #define OMAP_IOPAD_OFFSET(pa, offset, mask) (((pa) & mask) - ((offset) & mask))
>>
>> #define OMAP4_CORE_IOPAD(pa, val) OMAP_IOPAD_OFFSET((pa), 0x0040, 0xfff) (val)
>>
>> #define OMAP4_WKUP_IOPAD(pa, val) OMAP_IOPAD_OFFSET((pa), 0xe040, 0xfff) (val)
>>
>> Of course we need to fix the other users as well.
>
> I was thinking that too initially, but then we would have macros that behave
> in a different way:
>
> 1. Calculate the iopad offset from the iopad register area start based on
>    the iopad physical address
>
> 2. Calculate the iopad offset from the iopad register area start based on
>    the iopadd offset from the driver base address
>
>> One other possibility is to use my original patch in this mail or just
>> create a OMAP4_IOPAD with offset 0x040 which will on OMAP4 work for
>> both core and wkup.
>
> That also makes the macro behave in a different way depending on the
> SoC which is not nice.
>
>> What do you think?
>
> I think it's best to add some new macros to avoid confusion.
>

I see.

How about something like this then:
/*
* Macros to allow using the offset from the padconf physical address
* instead of the offset from padconf base.
*/
#define OMAP_PADCONF_OFFSET(offset, base_offset) ((offset) - (base_offset))

#define OMAP4_IOPAD(offset, val) OMAP_PADCONF_OFFSET((offset), 0x0040) (val)
#define OMAP5_IOPAD(offset, val) OMAP_PADCONF_OFFSET((offset), 0x0040) (val)

The OMAP4/5 TRMs list address offsets from the padconf physical
address (which is not driver base address) and not absolute physical
address for padconf registers like some other OMAP TRMs. So create a
new macro to avoid confusion between different OMAP parts.

I can cook up a patch if you like the idea above.


regards
Joachim Eastwood
