From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 9/9] OMAP:GPIO: Implement GPIO as a platform device
Date: Wed, 12 May 2010 07:47:52 -0700
Message-ID: <87pr11qiqv.fsf@deeprootsystems.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D12CB@dbde02.ent.ti.com>
	<877hni5akk.fsf@deeprootsystems.com>
	<EAF47CD23C76F840A9E7FCE10091EFAB02C54EF825@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:39592 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755709Ab0ELOr5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 10:47:57 -0400
Received: by pxi5 with SMTP id 5so44218pxi.19
        for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 07:47:56 -0700 (PDT)
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C54EF825@dbde02.ent.ti.com> (Charulatha Varadarajan's message of "Wed\, 12 May 2010 17\:59\:06 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nayak, Rajendra" <rnayak@ti.com>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>

"Varadarajan, Charulatha" <charu@ti.com> writes:

>> 
>> >> -----Original Message-----
>> >> From: Kevin Hilman [mailto:khilman@deeprootsystems.com]
>> >> Sent: Saturday, May 01, 2010 5:34 AM
>> >> To: Varadarajan, Charulatha
>> >> Cc: linux-omap@vger.kernel.org; Nayak, Rajendra; paul@pwsan.com;
>> tony@atomide.com
>> >> Subject: Re: [PATCH 9/9] OMAP:GPIO: Implement GPIO as a platform device
>> >>
> [...]
>> >> >
>> >> > +static int init_gpio_info(void)
>> >> > +{
>> >> > +   gpio_bank_bits = 32;
>> >> > +
>> >> > +   if (cpu_is_omap15xx()) {
>> >> > +           gpio_bank_count = 2;
>> >> > +           gpio_bank_bits = 16;
>> >> > +   } else if (cpu_is_omap16xx()) {
>> >> > +           gpio_bank_count = 5;
>> >> > +           gpio_bank_bits = 16;
>> >> > +   } else if (cpu_is_omap7xx())
>> >> > +           gpio_bank_count = 7;
>> >> > +   else if (cpu_is_omap242x())
>> >> > +           gpio_bank_count = 4;
>> >> > +   else if (cpu_is_omap243x())
>> >> > +           gpio_bank_count = 5;
>> >> > +   else if (cpu_is_omap34xx() || cpu_is_omap44xx())
>> >> > +           gpio_bank_count = OMAP34XX_NR_GPIOS;
>> >>
>> >> Both the bank count and bank bits could be part of platform_data
>> >> and set in the SoC specific init.  This is the GPIO driver part
>> >> and we're trying to make this as SoC independent as possible.  Anytime
>> >> you need to add a cpu_is* or #ifdef in this code indicates something
>> >> that should be part of SoC specific init and passed in.
>> >
>> > bank count and bank bits are not specific to each device, but SoC specific.
>> > Hence I did not consider passing it as part of platform_data, because this
>> information would be duplicated across all devices in that SoC.
>> >
>> > It would be good if we have a way to pass the SoC specific data which is
>> > common for all the devices rather than duplicating them by sending them via
>> > platform_data.
>> >
>> > Anyways, I can move it to platform_data if there is no other way.
>> 
>> Probably the right place for the SoC specifics is attached to the SoC
>> specific hwmod using the dev_attr pointer.  That struct can then
>> be passed in via platform_data.
>> 
>> You can see how Thara did this for SmartReflex as an example.
>> 
>
> Using dev_attr for OMAP2PLUS is fine. How about OMAP1? 
> 1. To be implemented in a uniform way, may I get this info as 
> part of platform_data? 
> 2. Use dev_attr for OMAP2PLUS and use platform_data for OMAP1? 

Not sure I understand the question.

You should be able to use a dev_attr struct in OMAP1 and OMAP2+, as
there is technically nothing hwmod specific in the dev_attr.  It
is attached to the hwmod as a 'void *' and should be passed into the driver
as the platform_data.

Kevin

