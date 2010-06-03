From: Mike Chan <mike@android.com>
Subject: Re: Future of resource framework?
Date: Thu, 3 Jun 2010 16:31:23 -0700
Message-ID: <AANLkTinSB0bIorWTwLuNhWC9g4oQArAhx-WdY-K-aadS@mail.gmail.com>
References: <AANLkTilpHjef3xbxB9QN9bj6MFmJA1jMwVxNQyZQcSKy@mail.gmail.com>
	<871vd5kxqg.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:65072 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243Ab0FCXbs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Jun 2010 19:31:48 -0400
Received: by gye5 with SMTP id 5so524146gye.19
        for <linux-omap@vger.kernel.org>; Thu, 03 Jun 2010 16:31:47 -0700 (PDT)
In-Reply-To: <871vd5kxqg.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

On Fri, May 21, 2010 at 9:47 AM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> Mike Chan <mike@android.com> writes:
>
>> I'm not sure if this has been discussed, yet but since it seems that
>> the resource framework will not be making it upstream, I am curious
>> what are the replacements under consideration. I am starting to see
>> similar issues on other platforms (msm / tegra) so more generic
>> (non-omap) solution might be something to consider.
>
> Hi Mike,
>
> Which parts of the SRF do you currently use and find useful? =A0It wo=
uld
> be helpful for us to to understand the parts you see as useful and
> potentially helpful to generalize.
>

Off the top of my head, for Droid specifically, OPP values are useful,
although in theory if you changed OPP requests to cpu throughput that
might give the equivalent functionality.

Memory bus speeds / bandwidth, although its tied to CPU, which
ultimately ends up in a cpu speed bump.

Although most of the usage I've seen are just hacks, ie: the driver
knows it needs 550mhz from the cpu so it will request some bogus
value.


> As you know, the current implementation has a several layers
> and attempts to manage several things: OPPs, latencies etc.
>
> Our current plans are essentially to break up the "one framework to
> rule them all" philosophy and design of SRF and manage the various
> pieces by exending other layers such as the new OPP layer and voltage
> layers. =A0Latencies are being managed by the omap_device layer and w=
e
> will hopefully have some discussions with the broader linux-pm
> community about generalizing that more into the generic driver model
> over this year.
>

Bus speed is a common resource I see for omap / msm / tegra. Clocks
for devices also.

ie: If I'm doing heavy mem operation and need max memory bus, I might
need to request higher performance. (which might mean 600mhz on
omap34030, on msm it might mean AXI clock running at 128mhz, and
something else on tegra).

Or if I'm doing graphics, I may need to up the gfx clock rate, or
swich which pll its sourcing etc.. etc..

It doesn't look like pm qos has bus support, or even clock support,
and this gets tricky if you want something semi-general.

-- Mike

> For the OPP management parts, you should expect RFC patches in the
> next week or two that will start discussions on this.
>
> Thanks for the input,
>
> Kevin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
