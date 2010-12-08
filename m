From: "Varadarajan, Charulatha" <charu@ti.com>
Subject: Re: [PATCH 12/11] omap1: Fix gpio mpuio bank to work for multi-omap
 for 7xx/15xx/16xx
Date: Wed, 8 Dec 2010 09:52:39 +0530
Message-ID: <AANLkTi=9yHGJf6s0O+ZjYDrrQ6rKqzJJdSvRZ=-911J9@mail.gmail.com>
References: <1290689318-10191-1-git-send-email-charu@ti.com>
 <20101201183357.GI17222@atomide.com> <87zkso4hu3.fsf@deeprootsystems.com>
 <AANLkTinY8FKbVvXD29KpgGnsnKwQziXws+zKLZWn69Hj@mail.gmail.com>
 <20101204212554.GM17222@atomide.com> <20101207232315.GE17435@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:34367 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750732Ab0LHEXU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Dec 2010 23:23:20 -0500
Received: by mail-iw0-f174.google.com with SMTP id 9so973278iwn.19
        for <linux-omap@vger.kernel.org>; Tue, 07 Dec 2010 20:23:19 -0800 (PST)
In-Reply-To: <20101207232315.GE17435@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, paul@pwsan.com, b-cousson@ti.com, p-basak2@ti.com, Cory Maccarrone <darkstar6262@gmail.com>, Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>

Tony,

On Wed, Dec 8, 2010 at 04:53, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [101204 13:16]:
>> * Varadarajan, Charulatha <charu@ti.com> [101202 06:08]:
>> > On Thu, Dec 2, 2010 at 15:28, Kevin Hilman <khilman@deeprootsystems.com> wrote:
>> >
>> > >
>> > > Tony, you can also add
>> > >
>> > > Acked-by: Kevin Hilman <khilman@deeprootsystems.com>
>>
>> OK, updated. Also made one more GPIO patch to allow us to deal
>> with the 7xx vs 15xx/16xx MPUIO registers.


Thanks for this patch which uses bank stride for OMAP1 MPUIO GPIO.
This would be very helpful while doing GPIO driver cleanup.

Thanks,
V Charulatha

>
> Turns out that broke drivers/mtd/nand/ams-delta.c as it directly uses
> multiple lines in parallel. So let's use 15xx/16xx offsets instead
> and divide them by two.
>
> Regards,
>
> Tony
>
>
> From: Tony Lindgren <tony@atomide.com>
> Date: Sat, 4 Dec 2010 12:39:43 -0800
> Subject: [PATCH] omap1: Fix gpio mpuio bank to work for multi-omap for 7xx/15xx/16xx
>
> We need to divide the 15xx/16xx offset by 2 for 7xx. Use bank->stride
> for that. This allows us to get rid of the duplicate defines for the
> MPUIO registers.
>
> Note that this will cause omap-keypad.c driver to not work on 7xx.
> However, the right fix there is to move over to gpio-keys instead as
> suggested by Cory Maccarrone <darkstar6262@gmail.com> and
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>.
>
> Cc: Cory Maccarrone <darkstar6262@gmail.com>
> Cc: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>

<<snip>>
