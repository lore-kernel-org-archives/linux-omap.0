From: Mike Chan <mike@android.com>
Subject: Re: Future of resource framework?
Date: Thu, 3 Jun 2010 17:10:27 -0700
Message-ID: <AANLkTin_mgP4rGKTcC1xuLwN_5MDoDhEDgJb9TH4hY9s@mail.gmail.com>
References: <AANLkTilpHjef3xbxB9QN9bj6MFmJA1jMwVxNQyZQcSKy@mail.gmail.com>
	<871vd5kxqg.fsf@deeprootsystems.com>
	<AANLkTinSB0bIorWTwLuNhWC9g4oQArAhx-WdY-K-aadS@mail.gmail.com>
	<87hbljisi1.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57806 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677Ab0FDAK3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 20:10:29 -0400
Received: by gwaa12 with SMTP id a12so507148gwa.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 17:10:28 -0700 (PDT)
In-Reply-To: <87hbljisi1.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Thu, Jun 3, 2010 at 4:52 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Mike Chan <mike@android.com> writes:
>
>> On Fri, May 21, 2010 at 9:47 AM, Kevin Hilman
>> <khilman@deeprootsystems.com> wrote:
>>> Mike Chan <mike@android.com> writes:
>>>
>>>> I'm not sure if this has been discussed, yet but since it seems th=
at
>>>> the resource framework will not be making it upstream, I am curiou=
s
>>>> what are the replacements under consideration. I am starting to se=
e
>>>> similar issues on other platforms (msm / tegra) so more generic
>>>> (non-omap) solution might be something to consider.
>>>
>>> Hi Mike,
>>>
>>> Which parts of the SRF do you currently use and find useful? =A0It =
would
>>> be helpful for us to to understand the parts you see as useful and
>>> potentially helpful to generalize.
>>>
>>
>> Off the top of my head, for Droid specifically, OPP values are usefu=
l,
>> although in theory if you changed OPP requests to cpu throughput tha=
t
>> might give the equivalent functionality.
>>
>> Memory bus speeds / bandwidth, although its tied to CPU, which
>> ultimately ends up in a cpu speed bump.
>>
>> Although most of the usage I've seen are just hacks, ie: the driver
>> knows it needs 550mhz from the cpu so it will request some bogus
>> value.
>>
>>
>>> As you know, the current implementation has a several layers
>>> and attempts to manage several things: OPPs, latencies etc.
>>>
>>> Our current plans are essentially to break up the "one framework to
>>> rule them all" philosophy and design of SRF and manage the various
>>> pieces by exending other layers such as the new OPP layer and volta=
ge
>>> layers. =A0Latencies are being managed by the omap_device layer and=
 we
>>> will hopefully have some discussions with the broader linux-pm
>>> community about generalizing that more into the generic driver mode=
l
>>> over this year.
>>>
>>
>> Bus speed is a common resource I see for omap / msm / tegra. Clocks
>> for devices also.
>>
>> ie: If I'm doing heavy mem operation and need max memory bus, I migh=
t
>> need to request higher performance. (which might mean 600mhz on
>> omap34030, on msm it might mean AXI clock running at 128mhz, and
>> something else on tegra).
>>
>> Or if I'm doing graphics, I may need to up the gfx clock rate, or
>> swich which pll its sourcing etc.. etc..
>>
>> It doesn't look like pm qos has bus support, or even clock support,
>> and this gets tricky if you want something semi-general.
>
> What we're hoping to work towards (and has come up in the suspend
> blocker related discussions) is moving towards a way to track
> per-device (or per-subsystem) constraints like latency and throughput
> in real world terms (usecs, bytes/sec, etc.) that would be general
> way.
>
> These constraints would then be visible to the bus- or
> platform-specific code that could make intelligent decisions with the=
m
> (i.e whether or not to raise/lower OPP or bus speed, or whether or no=
t
> to power down a powerdomain etc.)
>

I saw a little bit on lkml / linux-pm but I may have missed some of the=
 threads.
I'm assuming these changes you're talking about are going to be an
extension to pm qos.

> That's the pie-in-the-sky future I'm hoping for, and I hope to get
> some broader discussions around this going at some conferences this
> later year (LinuxCon in Aug, Plumbers in Nov, etc.) =A0We had some ea=
rly
> discussions in this direction at ELC already, but it needs some more
> thought and discussion.
>

I think for OMAP we will be ok with the existing / incremental changes
to the SRF. Your overview of the pie-in-the-sky might be promising but
I'm not sure how timely things will happen. I suppose I should track
linux-pm more closely, I'd rather not do a bunch of throw-away work on
pm qos.

-- Mike

> Kevin
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
