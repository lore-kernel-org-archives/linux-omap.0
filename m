From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: Re: [PATCH] arm: omap: ratelimit omap_l3_smx error log spam
Date: Tue, 28 Aug 2012 16:38:24 -0700
Message-ID: <CAMQu2gxdXXa27yAYL4yEkBci7pAKH+FNjDWp8-Y86zxdqndO0Q@mail.gmail.com>
References: <1346101403-5882-1-git-send-email-aaro.koskinen@iki.fi>
 <CAMQu2gyEctrq_3K8W6VahMW-ODOiv7TjrBfPTkZqNGJ+0m9ozw@mail.gmail.com>
 <20120827220254.GA783@harshnoise.musicnaut.iki.fi> <CAMQu2gz9HE0xEoW7gu257rpLWdCUpt7N6GQNQzWVhFb-A+69hg@mail.gmail.com>
 <20120827232613.GB783@harshnoise.musicnaut.iki.fi> <CAMQu2gwHp3PgB-TqPTNWcbRuXRT0wjfvF99nYqfDyWr1GiUvCg@mail.gmail.com>
 <20120828122042.GC783@harshnoise.musicnaut.iki.fi> <CAMQu2gwMk68_BNc4O0M52OACUVLLGzRCQe+5mGH_40DrwAQ4KA@mail.gmail.com>
 <20120828230917.GD783@harshnoise.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:50493 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750973Ab2H1Xiq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Aug 2012 19:38:46 -0400
Received: by obbun3 with SMTP id un3so31498184obb.3
        for <linux-omap@vger.kernel.org>; Tue, 28 Aug 2012 16:38:45 -0700 (PDT)
In-Reply-To: <20120828230917.GD783@harshnoise.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Aug 28, 2012 at 4:09 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Tue, Aug 28, 2012 at 07:19:38AM -0700, Shilimkar, Santosh wrote:
>> Or the PPA has resized the secure area of 16K. As you have seen the issue
>> on one OMAP3 device, it makes sense to takeout that 16K from the public
>> SRAM map.
>>
>> Can you send the patch with fixed base address fir PUB SRAM ?
>
> Maybe I'm missing something, but I tried the following and now something
> else got broken:
>
>         save_secure_sram() returns 0000ff02
>
Damn. Looks like, you are running short of memory now for sram_push stuff.

Regards
Santosh
