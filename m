From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv8 00/23]I2C big cleanup
Date: Thu, 13 Sep 2012 11:04:42 -0700
Message-ID: <87sjaldcjp.fsf@deeprootsystems.com>
References: <1347447496-16793-1-git-send-email-shubhrajyoti@ti.com>
	<20120912131615.GB16547@pengutronix.de>
	<87pq5quaqr.fsf@deeprootsystems.com>
	<87wqzysuu3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40902 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758671Ab2IMSE4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Sep 2012 14:04:56 -0400
Received: by obbuo13 with SMTP id uo13so4969093obb.19
        for <linux-omap@vger.kernel.org>; Thu, 13 Sep 2012 11:04:56 -0700 (PDT)
In-Reply-To: <87wqzysuu3.fsf@deeprootsystems.com> (Kevin Hilman's message of
	"Wed, 12 Sep 2012 16:08:20 -0700")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Shubhrajyoti D <shubhrajyoti@ti.com>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com

Kevin Hilman <khilman@deeprootsystems.com> writes:

> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
[...]

>> Sorry to be late to the party (again), but still catching up after some
>> time off.
>>
>> Unfortunately, this series causes PM regressions on several OMAP
>> platforms.  I hope we can hold off on this until those issues are
>> addressed.
>
> I tracked the regression down to [PATCHv8 21/22] (see reply there.)
>
> Since this series is already merged, I suggest that the problem patch be
> reverted, at least for v3.7 and until the problem is better understood
> and tested.
>
> With that patch reverted, all my PM tests are passing.  Feel free to
> add:

OK, the i2c series is off the hook.

Felipe and I spent a little time tracking this down.  Felipe suggested
that there might be a driver with periodic i2c activity keeping I2C
awake, and thus preventing CORE retention.  He was right.

On the boards where I'm seeing the failure, the RTC is firing every
second, and since the RTC is on the I2C connected PMIC, the PMIC IRQ
reads and the RTC reads are causing lots of I2C activity every second.  

With the new autosuspend feature, that is enough to keep the I2C active
continually and prevent CORE retention.

So, all that to say, from my PoV, this series can go in as is.  The PM
problem is caused by the RTC driver someplace.

Thanks Felipe,

Kevin



