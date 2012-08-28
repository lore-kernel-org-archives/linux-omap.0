From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: omap: ratelimit omap_l3_smx error log spam
Date: Tue, 28 Aug 2012 07:19:38 -0700
Message-ID: <CAMQu2gwMk68_BNc4O0M52OACUVLLGzRCQe+5mGH_40DrwAQ4KA@mail.gmail.com>
References: <1346101403-5882-1-git-send-email-aaro.koskinen@iki.fi>
 <CAMQu2gyEctrq_3K8W6VahMW-ODOiv7TjrBfPTkZqNGJ+0m9ozw@mail.gmail.com>
 <20120827220254.GA783@harshnoise.musicnaut.iki.fi> <CAMQu2gz9HE0xEoW7gu257rpLWdCUpt7N6GQNQzWVhFb-A+69hg@mail.gmail.com>
 <20120827232613.GB783@harshnoise.musicnaut.iki.fi> <CAMQu2gwHp3PgB-TqPTNWcbRuXRT0wjfvF99nYqfDyWr1GiUvCg@mail.gmail.com>
 <20120828122042.GC783@harshnoise.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:40427 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752218Ab2H1OUB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 10:20:01 -0400
Received: by iage36 with SMTP id e36so11882683iag.24
        for <linux-omap@vger.kernel.org>; Tue, 28 Aug 2012 07:19:59 -0700 (PDT)
In-Reply-To: <20120828122042.GC783@harshnoise.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Aug 28, 2012 at 5:20 AM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Mon, Aug 27, 2012 at 05:17:30PM -0700, Shilimkar, Santosh wrote:
>> On Mon, Aug 27, 2012 at 4:26 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> > I tried bypassing the whole SRAM init, but the device does not seem to
>> > boot up at all.
>> >
>> > If I comment out the memset alone, then it boots and the issue is gone:
>> >
>> > +#if 0
>> >         memset_io(omap_sram_base + SRAM_BOOTLOADER_SZ, 0,
>> >                   omap_sram_size - SRAM_BOOTLOADER_SZ);
>> > +#endif
>> >
>> Good. So the issue is indeed direct or indirect access to the secure SRAM.
>> As security can dynamically resize the secure RAM size it is even harder
>> to fix this issue properly. One easier way to deal with the issue is map only
>> needed SRAM and leave rest for security.
>>
>> For now, Can you check if reducing the size of the SRAM in init is helping you
>> to get way with the issue. Sorry it might need few iterations for you to get
>> a working SRAM size.
>
> The problem is triggered by writing to the beginning of the SRAM area,
> not to the end. I need to skip the first 16k (0x4000) to get rid of
> the errors. Maybe the base address calculation is wrong? This could
> also explain why it's still possible to use the device - it seems the
> allocator starts from the end, and moves towards the base...
>
Or the PPA has resized the secure area of 16K. As you have seen the issue
on one OMAP3 device, it makes sense to takeout that 16K from the public
SRAM map.

Can you send the patch with fixed base address fir PUB SRAM ?

Regards
Santosh
