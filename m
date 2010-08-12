From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 0/2] Put OMAP2 SPI CS in unactive state when return from  suspend
Date: Thu, 12 Aug 2010 07:28:29 -0700
Message-ID: <87tymzucqa.fsf@deeprootsystems.com>
References: <AANLkTin7-ZqFRH4GXT4aUfQ4sE=8Jc=3i0j8rTH7EyBm@mail.gmail.com>
	<871va52ent.fsf@deeprootsystems.com>
	<AANLkTik7O1s-UAt0abyJoakSSjHGJD6CSktOD+O=BGou@mail.gmail.com>
	<AANLkTinPbOR2OUyfiCLkkbV6gCjxib+-mmMKNf9mzeDC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:57969 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753875Ab0HLO2c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Aug 2010 10:28:32 -0400
Received: by pzk26 with SMTP id 26so446984pzk.19
        for <linux-omap@vger.kernel.org>; Thu, 12 Aug 2010 07:28:31 -0700 (PDT)
In-Reply-To: <AANLkTinPbOR2OUyfiCLkkbV6gCjxib+-mmMKNf9mzeDC@mail.gmail.com>
	(Gregory CLEMENT's message of "Thu, 12 Aug 2010 10:54:00 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gregory CLEMENT <gclement00@gmail.com>
Cc: spi-devel-general <spi-devel-general@lists.sourceforge.net>, linux-omap <linux-omap@vger.kernel.org>

Gregory CLEMENT <gclement00@gmail.com> writes:

> 2010/8/11 Kevin Hilman <khilman@deeprootsystems.com>
>>
>> Gregory CLEMENT <gclement00@gmail.com> writes:
>>
>> > We notice that when system wake up from OFF mode, then CS is in
>> > unactive state until the first SPI transfert.
>> > For our design it lead to some conflict on this I/O.
>> > Unactive state for CS when there is no transfert shoudl be the correct
>> > behaviour: this is the purpose of these patches.
>>
>> This approach handles an off-mode transition during suspend, but if
>> off-mode is enabled, you can also have an off-mode transition during
>> idle.
>>
>
> Well maybe I didn't use the correct words.
> During the system life, I monitored the CS behaviour using a oscilloscope.
> I also activate debug in omap2_mcspi, so I see when driver disable the
> clocks and restore context when device is not used.
> Each time the CS is in the correct state. It is only when there is a
> suspend with the following configuration that on resume the CS is in
> wrong state( ie activated)

OK, that should be more clear in the changelog.  The way I understood
your description, the problem was related to an off-mode transition.

>
> echo 1 > /mnt/pm_debug/enable_off_mode
> echo 0 > /mnt/pm_debug/core_pwrdm/suspend

fyi... this part isn't needed.  You're telling the OMAP PM core that
you want the CORE powerdomain to go into off-mode, but you've you've
already done that by the 'enable_off_mode' flag, which enables *all*
powerdomains to hit off mode.

> echo 1 > /mnt/pm_debug/voltage_off_while_idle
>
>
>>
>> Since you didn't describe what the conflicts you're seeing are, I would
>> assume that you'll have the same problems in idle as in suspend, and
>> this series doesn't address the idle case.
>
> I didn't see any problem in idle case, just when system resume from a
> suspend to ram (echo mem > /sys/power/state)

OK, I'd recommend you update the changelog to make that more clear.

Then, I'll leave it to the SPI folks to review your patch.

Kevin
