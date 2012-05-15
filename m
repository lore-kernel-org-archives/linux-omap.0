From: Kevin Hilman <khilman@ti.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Tue, 15 May 2012 10:29:11 -0700
Message-ID: <87pqa5mjyw.fsf@ti.com>
References: <1336033721.14378.2.camel@deskari>
	<WC20120503084938.900446@terrafix.co.uk>
	<1336050442.14378.10.camel@deskari>
	<WC20120504091902.970499@terrafix.co.uk>
	<1336139415.2552.4.camel@deskari> <1336140072.2552.6.camel@deskari>
	<WC20120504140943.7604D0@terrafix.co.uk>
	<1336143281.2552.21.camel@deskari> <1336143500.2552.23.camel@deskari>
	<1336483598.5761.45.camel@deskari>
	<WC20120514073642.6306D7@terrafix.co.uk>
	<1336982138.2532.32.camel@lappyti> <87mx5apefo.fsf@ti.com>
	<1337066897.1951.12.camel@lappyti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog131.obsmtp.com ([74.125.149.247]:54580 "EHLO
	na3sys009aog131.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965223Ab2EOR3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 May 2012 13:29:13 -0400
Received: by pbbrq2 with SMTP id rq2so8168382pbb.34
        for <linux-omap@vger.kernel.org>; Tue, 15 May 2012 10:29:12 -0700 (PDT)
In-Reply-To: <1337066897.1951.12.camel@lappyti> (Tomi Valkeinen's message of
	"Tue, 15 May 2012 10:28:17 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, Paul Walmsley <paul@pwsan.com>, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

Tomi Valkeinen <tomi.valkeinen@ti.com> writes:

> On Mon, 2012-05-14 at 15:48 -0700, Kevin Hilman wrote:
>> Tomi Valkeinen <tomi.valkeinen@ti.com> writes:
>> 
>> > On Mon, 2012-05-14 at 08:36 +0100, Joe Woodward wrote:
>> >> Any news on this?
>> >> 
>> >> This thread seems to have gone a little quiet...
>> >
>> > Hi,
>> >
>> > I've been doing testing to understand the problem, but so far I don't
>> > have any idea why things go wrong. I haven't found out any logic in
>> > which configuration works and which doesn't. Looks to me that for some
>> > reason the PM prevents DSS from getting data fast enough with certain
>> > fifo thresholds.
>> >
>> > I have two ways to avoid the problem, but I've been reluctant to make
>> > patches for those because I feel it's just hiding the problem. One way
>> > is to change DISPC SIDLEMODE or MIDLEMODE to disallow idle/standby. The
>> > other is to use certain fifo threshold values, which just seem to work
>> > for unknown reasons.
>> >
>> > Considering that we already have a SIDLEMODE hack in DSS for omap3 when
>> > using DSI, I wonder if the omap3 PM + DSS combination is just plain
>> > broken, and we should disallow idle. I'm not quite sure what are the
>> > implications of that.
>> >
>> > I'd appreciate comments from the PM people =).
>> 
>> Unfortunately, without the bandwidth to dig into this deeply myself, I
>> don't have much to add.
>
> Yes, that's understandable.
>
> However, can you shed some light about the PM in OMAP3. What is it that
> happens here regarding PM, which does not happen is USB gadget driver is
> compiled in? Or when I set DSS to no-idle or no-standby? Something about
> L3/core/memory going into idle state?

My first guess would have been that in those two cases, CORE was
prevented from going into retention, but based on what you said earlier,
it sounds like CORE is always staying on.

Just to clarify: by USB gadget, I assume you mean MUSB? (a.k.a USB OTG,
or HS USB in the TRM)?  I'm a bit confused because earlier you mentioned
keeping usbhost_pwrdm active, but USB host is separate IP in its own
powerdomain, whereas USB OTG is an IP in the CORE powerdomain.

> I tried to look at the debugfs/pm_debug/ files, but I couldn't see a
> difference between working and non-working cases. At least the
> OFF/RET/ON/etc states were not affected. Are there some other debug
> files to look at? Are there power saving features that are not
> observable via debug files?

There may not be a difference in the actual states being hit, but there
may be subtle differences in latencies to enter/exit the various states.

An interesting experiment would be to disable the deeper C-states in
CPUidle and see if the problem still exists.  Here's a little shell
snippet to do this via sysfs:

# CPUidle: disable everything but C1
cd /sys/devices/system/cpu/cpu0/cpuidle
for state in state[1-6]*; do
  if [ -e ${state} ]; then 
    echo 1 > ${state}/disable
  fi
done

>> As we know, it's not unheard of for various IPs to have bugs in
>> smart-idle mode ;)
>> 
>> The one thing I can say is that the reason it probably worked on earlier
>> kernels was because the UART driver was not actually idling, so you were
>> probably never hitting low power states.  
>
> There is also a change in the DSS fifos, which probably triggered this.
> I think I can fall back to the old behavior.

Because of the current boot defaults, the only pwrdm that is actively
transitioning during idle is the MPU pwrdm.

So if preventing the MPU pwrdm from hitting idle makes the problem go
away, we'd need to better understand this wakeup latency constraint and
possibly code it in the DSS driver.

Kevin

