From: Joachim Eastwood <manabian@gmail.com>
Subject: Re: [PATCH] ARM: dts: Correct offset in OMAP4_WKUP_IOPAD macro
Date: Mon, 12 May 2014 18:26:56 +0200
Message-ID: <CAGhQ9VwHqUmTKHBxBG3rm1AXQZHovDVvOEiGJfVCJHSOtFE45Q@mail.gmail.com>
References: <1397924056-6462-1-git-send-email-manabian@gmail.com>
	<CAGhQ9VwU_BjrD+c9uJn9FBwo6v_BOMUCKwiOW-7eqOu056a79A@mail.gmail.com>
	<20140421153539.GB23945@atomide.com>
	<CAGhQ9VyFQgcOw8y97R6HR1apXo-89JyktADxR6jb1EJipXqqjA@mail.gmail.com>
	<CAGhQ9VxCA_VnO18zWgtWUExNE6YJd+krNEVLtyZTpyY6hRyHUg@mail.gmail.com>
	<20140506001237.GK25949@atomide.com>
	<CAGhQ9Vw+cR-cKQ-w3psZPOWOqwugntXq-9g5=4cZV-ijQZecTQ@mail.gmail.com>
	<20140509160725.GG17814@atomide.com>
	<CAGhQ9VwALSFVn3dd+VWV4AWBZnHUFqpJv7yQyLvR4U+W6nL+aQ@mail.gmail.com>
	<20140512161647.GJ31772@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ve0-f173.google.com ([209.85.128.173]:42451 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932480AbaELQ05 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 12:26:57 -0400
Received: by mail-ve0-f173.google.com with SMTP id pa12so9179536veb.32
        for <linux-omap@vger.kernel.org>; Mon, 12 May 2014 09:26:56 -0700 (PDT)
In-Reply-To: <20140512161647.GJ31772@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On 12 May 2014 18:16, Tony Lindgren <tony@atomide.com> wrote:
> * Joachim Eastwood <manabian@gmail.com> [140511 10:28]:
>> On 9 May 2014 18:07, Tony Lindgren <tony@atomide.com> wrote:
>> >
>> > I was thinking that too initially, but then we would have macros that behave
>> > in a different way:
>> >
>> > 1. Calculate the iopad offset from the iopad register area start based on
>> >    the iopad physical address
>> >
>> > 2. Calculate the iopad offset from the iopad register area start based on
>> >    the iopadd offset from the driver base address
>> >
>> >> One other possibility is to use my original patch in this mail or just
>> >> create a OMAP4_IOPAD with offset 0x040 which will on OMAP4 work for
>> >> both core and wkup.
>> >
>> > That also makes the macro behave in a different way depending on the
>> > SoC which is not nice.
>>
>> How about something like this then:
>> /*
>> * Macros to allow using the offset from the padconf physical address
>> * instead of the offset from padconf base.
>> */
>> #define OMAP_PADCONF_OFFSET(offset, base_offset) ((offset) - (base_offset))
>>
>> #define OMAP4_IOPAD(offset, val) OMAP_PADCONF_OFFSET((offset), 0x0040) (val)
>> #define OMAP5_IOPAD(offset, val) OMAP_PADCONF_OFFSET((offset), 0x0040) (val)
>>
>> The OMAP4/5 TRMs list address offsets from the padconf physical
>> address (which is not driver base address) and not absolute physical
>> address for padconf registers like some other OMAP TRMs. So create a
>> new macro to avoid confusion between different OMAP parts.
>>
>> I can cook up a patch if you like the idea above.
>
> Sure sounds good to me. The offset is different for at least omap3
> instances, so those should use OMAP3_*_IOPAD macros.

So you are okey with just OMAP4_IOPAD for both core and wkup pads?

If so I'll send out a patch with the stuff above for OMAP4 and 5.

Then I'll update my patch set, rebase it on your omap-for-v3.16/dt
branch and post it the list.

regards
Joachim Eastwood
