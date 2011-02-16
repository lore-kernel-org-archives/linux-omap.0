From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: Pandaboard boot problem
Date: Wed, 16 Feb 2011 09:59:00 +0100
Message-ID: <AANLkTimn4LGiMrb6YKQvvj2BrAxmT8T6sdA0TgniB8L0@mail.gmail.com>
References: <AANLkTikCjuhHJbvK6YL40mYq2Yt99UCob4bHKRqPRToW@mail.gmail.com>
	<20110204015301.GQ3322@atomide.com>
	<AANLkTinJPPDH6bWQ-Q14k6vgx8iGQvUmPFbrWqQX1JJ5@mail.gmail.com>
	<20110214163815.d488841f.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59456 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754343Ab1BPI7B (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 03:59:01 -0500
Received: by qwa26 with SMTP id 26so1038131qwa.19
        for <linux-omap@vger.kernel.org>; Wed, 16 Feb 2011 00:59:01 -0800 (PST)
In-Reply-To: <20110214163815.d488841f.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org

Hi Jarkko,

On Mon, Feb 14, 2011 at 3:38 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> On Mon, 14 Feb 2011 15:01:30 +0100
> Jean Pihet <jean.pihet@newoldbits.com> wrote:
>
>> > If so, I've seen this same issue few times after having my panda
>> > powered off for a while, for example over the weekend.
>> >
>> > What I've noticed is that leaving just u-boot prompt running
>> > for a few minutes cures the problem somehow.. After that the
>> > kernel will boot just fine.
>> Unfortunately that is not helping.
>> I am still investigating. For the moment the pandaboard is pretty useless ;(
>>
> Try to heat TWL6030 a little. My board seems to suffer some soldering
> fault around it and the device keeps running if I warm up the chip with
> a 40 W light bulb ~1-2 cm distance.
That works! I heated the chip with a halogen heater at ~10cm distance
and the board ran fine for 3 minutes after that.

> It keeps running fine by using the Ubuntu kernel but I think reason is
> that the EHCI is initialized there and the TWL draws more current and
> thus heats up.
That probably is the reason.

> No idea why the u-boot runs fine.
That would be nice to identify the root cause and get a SW workaround in place.

The other solution is to invest in extra heaters or a sun tan machine
in the office ;p

>
> --
> Jarkko
>

Thanks,
Jean
