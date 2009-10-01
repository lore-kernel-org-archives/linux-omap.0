From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 1/1] OMAP: I2C: Add mpu wake up latency constraint in i2c
Date: Thu, 01 Oct 2009 07:58:23 -0700
Message-ID: <87fxa3i2k0.fsf@deeprootsystems.com>
References: <1253204923-21916-1-git-send-email-kalle.jokiniemi@digia.com>
	<1253204923-21916-2-git-send-email-kalle.jokiniemi@digia.com>
	<87bpkso0dj.fsf@deeprootsystems.com>
	<1254383040.22468.130.camel@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f177.google.com ([209.85.222.177]:33908 "EHLO
	mail-pz0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752952AbZJAPGA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 11:06:00 -0400
Received: by pzk7 with SMTP id 7so122821pzk.33
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 08:06:04 -0700 (PDT)
In-Reply-To: <1254383040.22468.130.camel@ubuntu> (Kalle Jokiniemi's message of "Thu\, 1 Oct 2009 10\:44\:00 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Cc: "jhnikula@gmail.com" <jhnikula@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:

> On Wed, 2009-09-30 at 19:36 +0300, Kevin Hilman wrote:
>> Kalle Jokiniemi <kalle.jokiniemi@digia.com> writes:
>> 
>> > While waiting for completion of the i2c transfer, the
>> > MPU could hit OFF mode and cause several msecs of
>> > delay that made i2c transfers fail more often. The
>> > extra delays and subsequent re-trys cause i2c clocks
>> > to be active more often. This has also an negative
>> > effect on power consumption.
>> >
>> > Added a constraint that allows MPU to wake up in few
>> > hundred usecs, which is roughly the average i2c wait
>> > period.
>> >
>> > The constraint function is passed as platform data from
>> > plat-omap/i2c.c and applied only on OMAP34XX devices.
>> 
>> Seems like the latency value should also be (optionally) passed in
>> pdata so this can be experimented with per-platform.
>
> Well, it kind of is already, since we pass the function that sets the
> latency from platform code. And that function has the latency
> hard-coded. 

I see it now, I initially thought that hard-coded value was in the
driver, not in plat-omap/i2c.c.

> My though was to use little #ifdeffery in defining the
> function (and latency) for say omap3, and omap4 platforms.
>
> If #ifdeffery is out of the question, we could define
> omap3_i2c_set_mpu.. and omap4_i2c_set_mpu.. functions and pass one in
> init according to some "if (cpu_is_omapxyz)" statement. I think omap1&2
> don't need any latency constraints (and cannot use them as there is no
> pm-layer implementation for those).
>
> What do you think?

I recommend setting the functions at runtime using cpu_is* and
allowing the functino to be NULL on platforms that don't need it.
Combined with the NULL check proposed by Jarkko that should work well.

Kevin

