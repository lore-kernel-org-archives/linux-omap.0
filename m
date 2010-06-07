From: Mike Chan <mike@android.com>
Subject: Re: Future of resource framework?
Date: Mon, 7 Jun 2010 12:29:46 -0700
Message-ID: <AANLkTinWlhSODuYOnIGugFKrQc0Z1t_ZMHFq9z59aJEy@mail.gmail.com>
References: <AANLkTilpHjef3xbxB9QN9bj6MFmJA1jMwVxNQyZQcSKy@mail.gmail.com>
	<871vd5kxqg.fsf@deeprootsystems.com>
	<AANLkTinSB0bIorWTwLuNhWC9g4oQArAhx-WdY-K-aadS@mail.gmail.com>
	<87hbljisi1.fsf@deeprootsystems.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0321623820@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:53922 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273Ab0FGT3r convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Jun 2010 15:29:47 -0400
Received: by gye5 with SMTP id 5so2512143gye.19
        for <linux-omap@vger.kernel.org>; Mon, 07 Jun 2010 12:29:46 -0700 (PDT)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321623820@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Paul Walmsley <paul@pwsan.com>

On Thu, Jun 3, 2010 at 8:01 PM, Gadiyar, Anand <gadiyar@ti.com> wrote:
> Kevin Hilman wrote:
>> Mike Chan <mike@android.com> writes:
>>
>> > On Fri, May 21, 2010 at 9:47 AM, Kevin Hilman
>> > <khilman@deeprootsystems.com> wrote:
>> >> Mike Chan <mike@android.com> writes:
>> >>
>> >>> I'm not sure if this has been discussed, yet but since it seems =
that
>> >>> the resource framework will not be making it upstream, I am curi=
ous
>> >>> what are the replacements under consideration. I am starting to =
see
>> >>> similar issues on other platforms (msm / tegra) so more generic
>> >>> (non-omap) solution might be something to consider.
>> >>
>> >> Hi Mike,
>> >>
>> >> Which parts of the SRF do you currently use and find useful? =A0I=
t would
>> >> be helpful for us to to understand the parts you see as useful an=
d
>> >> potentially helpful to generalize.
>> >>
>> >
>> > Off the top of my head, for Droid specifically, OPP values are use=
ful,
>> > although in theory if you changed OPP requests to cpu throughput t=
hat
>> > might give the equivalent functionality.
>> >
>> > Memory bus speeds / bandwidth, although its tied to CPU, which
>> > ultimately ends up in a cpu speed bump.
>> >
>> > Although most of the usage I've seen are just hacks, ie: the drive=
r
>> > knows it needs 550mhz from the cpu so it will request some bogus
>> > value.
>> >
>> >
>> >> As you know, the current implementation has a several layers
>> >> and attempts to manage several things: OPPs, latencies etc.
>> >>
>> >> Our current plans are essentially to break up the "one framework =
to
>> >> rule them all" philosophy and design of SRF and manage the variou=
s
>> >> pieces by exending other layers such as the new OPP layer and vol=
tage
>> >> layers. =A0Latencies are being managed by the omap_device layer a=
nd we
>> >> will hopefully have some discussions with the broader linux-pm
>> >> community about generalizing that more into the generic driver mo=
del
>> >> over this year.
>> >>
>> >
>> > Bus speed is a common resource I see for omap / msm / tegra. Clock=
s
>> > for devices also.
>> >
>> > ie: If I'm doing heavy mem operation and need max memory bus, I mi=
ght
>> > need to request higher performance. (which might mean 600mhz on
>> > omap34030, on msm it might mean AXI clock running at 128mhz, and
>> > something else on tegra).
>> >
>> > Or if I'm doing graphics, I may need to up the gfx clock rate, or
>> > swich which pll its sourcing etc.. etc..
>> >
>> > It doesn't look like pm qos has bus support, or even clock support=
,
>> > and this gets tricky if you want something semi-general.
>>
>> What we're hoping to work towards (and has come up in the suspend
>> blocker related discussions) is moving towards a way to track
>> per-device (or per-subsystem) constraints like latency and throughpu=
t
>> in real world terms (usecs, bytes/sec, etc.) that would be general
>> way.
>>
>> These constraints would then be visible to the bus- or
>> platform-specific code that could make intelligent decisions with th=
em
>> (i.e whether or not to raise/lower OPP or bus speed, or whether or n=
ot
>> to power down a powerdomain etc.)
>>
>
>
> What if a driver knows that it cannot afford to let the PM layer
> turn off the power domain at certain points of time (maybe as long
> as a USB cable is connected). How can this be specified in terms
> of a latency or throughput constraint?
>

Are there cases for this in omap? From what I've seen with omap3430
(atleast our hw configuration for Droid) we haven't run into this
case.

If you want to prevent a particular domain from entering RET or OFF, I
believe you'd have to look at the latency values in the cpuidle34xx.c
(or whatever it maybe called in .35) and match those latency in your
driver against the PM_QOS_CPU_DMA_LATENCY. The omap cpuidle registers
a table of various cpu states, which are a combination of ON, RET and
OFF for various domains. (Note only handles a few domains so maybe you
need to extend the table or rev a new constraint type or something to
pm_qos).

It seems kind of hacky and not very general, but I've only seen a need
for something like this on msm7k / msm8k, and the need was an msm
specific driver and have not yet seen a need for this on omap[3403] or
tegra but things could change.

-- Mike

> Just curious, since I don't understand current OMAP3 PM code
> as well as I would like to.
>
> - Anand
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
