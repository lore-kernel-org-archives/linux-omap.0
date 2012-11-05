From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: OMAP baseline test results for v3.7-rc1
Date: Mon, 5 Nov 2012 10:26:27 +0100
Message-ID: <CAORVsuUGcydD13-VcaNjmAmrsyo9ZVHGTRoSKgLyr4-Bkw7zhg@mail.gmail.com>
References: <CAORVsuWFzH3UmXCaY=iqmYsE72KOecLo40tG9BcTUBirJQ5iLA@mail.gmail.com>
	<CAORVsuV9_4oc6+voEM9PkqzkXKHipor5XJqaXfDNxAWLofXcxg@mail.gmail.com>
	<20121025101212.GD21217@arwen.pp.htv.fi>
	<20121026201539.GD29548@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210262201500.11258@utopia.booyaka.com>
	<20121029200032.GD30152@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301216330.12697@utopia.booyaka.com>
	<20121030123254.GD29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301239310.12697@utopia.booyaka.com>
	<20121030125419.GG29095@arwen.pp.htv.fi>
	<alpine.DEB.2.00.1210301313190.12697@utopia.booyaka.com>
	<CAORVsuWqoqrza-qrJskpMTj=2MW6JxNEhVzjWVXkM1mpqVO8cQ@mail.gmail.com>
	<87fw4u3oh5.fsf@deeprootsystems.com>
	<CAORVsuUWD3gHh1NcMLeGwZ=hF=UiOG2VyJkADZNcGVr1g1TFgQ@mail.gmail.com>
	<alpine.DEB.2.00.1211010242001.6693@utopia.booyaka.com>
	<CAORVsuXHxqhcTHv8Y=8gw4N+0+rx+N91bh971zK-TmcsrTu5nQ@mail.gmail.com>
	<CAORVsuUda69_sE9LpBnuETXSA2jPxw7nQ=MkAq=Or8B7t1fvcA@mail.gmail.com>
	<alpine.DEB.2.00.1211050313130.23228@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49419 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751302Ab2KEJ01 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 04:26:27 -0500
Received: by mail-ie0-f174.google.com with SMTP id k13so7632538iea.19
        for <linux-omap@vger.kernel.org>; Mon, 05 Nov 2012 01:26:27 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1211050313130.23228@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Felipe Balbi <balbi@ti.com>, aaro.koskinen@iki.fi, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Paul,

On Mon, Nov 5, 2012 at 4:15 AM, Paul Walmsley <paul@pwsan.com> wrote:
> Hi Jean,
>
> On Sat, 3 Nov 2012, Jean Pihet wrote:
>
>> The setup is as identical as possible to yours:
>> - U-Boot 2011.06-dirty (Sep 04 2012 - 17:06:58) from
>> http://www.pwsan.com/tmp/3530es3beagle-MLO-u-boot-20121023.tar.bz2.
>>   Please note that the MLO image does not run on my board and so I had
>> to use my known-to-work image.
>
> Interesting...
>
>> The result is that I could reproduce the issue but it happens much
>> more rarely on my side (only once vs quasi 100% on ~50 boot cycles).
>
> Hmm...
>
>> The issue is triggered by running 'hwclock --systohc'  while the
>> system is heavily loaded (running depmod etc.).
>
> OK.
>
>> More investigation on-going, so more to come!
>
> Great, keep us posted.
I ran some intensive stress tests on the I2C and ... unfortunately I
could not trigger the problem. It looks like the issue is caused by
some transient situation where the CORE and/or I2C is in a low power
state.

Here are the tests that have been performed from the user space:
- stress test the I2C IRQ handler by reading and writing the RTC, and
checking the amount of IRQs for the I2C bus. In that case the CORE
never goes in low power mode,
- stress test the CORE low power and wake-up transition by adjusting
the autosuspend delay (e.g.
/sys/devices/platform/omap_i2c.1/power/autosuspend_delay_ms) and
accessing the RTC after the CORE has gone in low power.

Those tests have been run for hours (>200000 IRQs) and the I2C timeout
issue could not be observed. The target low power mode is RET (not
tried with OFF).

The next step is to detect an error situation and have data logged
about the state at that moment. What do you think?

This brings an interesting discussion. As you indicated earlier,
withtout CPU_IDLE enabled nothing except the autosuspend delay is
preventing the power domains to go in low power mode. This could lead
to situations where latency constraints are not respected. The easy
and straight forward solution is to enable CPU_IDLE and use the PM QoS
constraints.

What do you think?

Regards,
Jean

>
> Will try to kick off those tests you requested within the next 24-48
> hours.
>
>
> - Paul
