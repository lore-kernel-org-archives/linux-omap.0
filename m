From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: v3.4-rc4 DSS PM problem (Was: Re: Problems with 3.4-rc5)
Date: Fri, 25 May 2012 14:55:27 +0200
Message-ID: <CAORVsuWrWXFR7cnBGD+R4omKRjCCvkhHhOVhR_tj=gjA0tUyVA@mail.gmail.com>
References: <1336033721.14378.2.camel@deskari>
	<WC20120503084938.900446@terrafix.co.uk>
	<1336050442.14378.10.camel@deskari>
	<WC20120504091902.970499@terrafix.co.uk>
	<1336139415.2552.4.camel@deskari>
	<1336140072.2552.6.camel@deskari>
	<WC20120504140943.7604D0@terrafix.co.uk>
	<1336143281.2552.21.camel@deskari>
	<1336143500.2552.23.camel@deskari>
	<1336483598.5761.45.camel@deskari>
	<WC20120514073642.6306D7@terrafix.co.uk>
	<1336982138.2532.32.camel@lappyti>
	<alpine.DEB.2.00.1205151148440.16649@utopia.booyaka.com>
	<1337159300.7692.22.camel@deskari>
	<alpine.DEB.2.00.1205241022180.2572@utopia.booyaka.com>
	<1337934288.2842.19.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:65118 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab2EYMz2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 08:55:28 -0400
Received: by lbbgm6 with SMTP id gm6so611638lbb.19
        for <linux-omap@vger.kernel.org>; Fri, 25 May 2012 05:55:27 -0700 (PDT)
In-Reply-To: <1337934288.2842.19.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Joe Woodward <jw@terrafix.co.uk>, khilman@ti.com, Archit Taneja <a0393947@ti.com>, linux-omap@vger.kernel.org

Hi Tomi, Paul!

On Fri, May 25, 2012 at 10:24 AM, Tomi Valkeinen <tomi.valkeinen@ti.com=
> wrote:
> On Thu, 2012-05-24 at 18:39 -0600, Paul Walmsley wrote:
>> cc Jean
>>
>> Hello Tomi,
>>
>> On Wed, 16 May 2012, Tomi Valkeinen wrote:
>>
>> > I also suspect that this could be just a plain DSS bug. The defaul=
t FIFO
>> > low/high thresholds are 960/1023 bytes (i.e. DSS starts refilling =
the
>> > FIFO when there are 960 or less bytes in the fifo, and stops at 10=
23.
>> > The fifo is 1024 bytes). The values are calculated with fifo_size =
-
>> > burst_size and fifo_size - 1.
>> >
>> > We are now using FIFO merge features, which combines multiple fifo=
s into
>> > one when possible, making the fifo size 1024*3 =3D 3072. Using the=
 same
>> > low threshold and increasing the high threshold to 960/3071 works =
fine.
>> > Changing the high threshold to 3008 causes underflows. Increasing =
the
>> > low threshold to ~1600 makes DSS work again.
>>
>> Just a few thoughts.
>>
>> In terms of the high threshold, it seems really strange to me that
>> changing the high threshold would make such a difference. =A0Na=EFve=
ly, I'd
>> assume that you'd want to set it as high as possible? =A0I suppose i=
n cases
>> where the interconnect is congested, setting it lower might allow lo=
wer
>> latency for other interconnect users, but I'd hope we don't have to =
worry
>> much about that. =A0So it doesn't seem to me that there would be any
>> advantage to setting it lower than the maximum.
>
> It's true that the high threshold should be set as high as possible, =
and
> this is what we do. Except for DSI command mode output on OMAP3, wher=
e,
> for unknown reason, the highest value (fifosize - 1) doesn't work and=
 we
> need to program it to fifosize - burstsize. And this was causing the
> original problem, fifosize - burstsize was not working for other outp=
uts
> properly.
>
> I guess this also hints that there's something wrong with omap3 and t=
he
> dss fifo thresholds.
>
>> Probably the low threshold is the more important parameter, from a P=
M
>> perspective. =A0If you know the FIFO's drain rate and the low thresh=
old, it
>> should be possible to calculate the maximum latency that the FIFO ca=
n
>> tolerate to avoid an underflow. =A0This could be used to specify a d=
evice PM
>> QoS constraint to prevent the interconnect latency from exceeding th=
at
>> value.
>
> Yes, this is how the low threshold should be adjusted. I have never
> tried to calculate the threshold need, though, as I haven't had all t=
he
> information and understanding to properly calculate it.
>
>> I'd guess the calculations would be something like this -- (I hope y=
ou can
>> correct my relative ignorance of the DSS in the following estimates)=
:
>>
>> Looking at mach-omap2/board-rx51-video.c, let's suppose that the FIF=
O
>> drain rate would be 864 x 480 x 32 bits/second. =A0Since the FIFO wi=
dth is
>> 32 bits, that's
>
> I think the DSS fifo entries are 8 bit on omap2/3, 128bits on omap4. =
At
> least those are the "units" used with fifo size, threshold sizes, bur=
st
> size, etc.
>
>> =A0 =A0864 x 480 =3D 414 780 FIFO entries/second, or
>>
>> =A0 =A0(1 000 000 =B5s/s / 414 780 FIFO entries/s) =3D ~2.411 =B5s/F=
IFO entry.
>>
>> So if you need a low FIFO threshold at 960 entries, you could call t=
he
>> device PM QoS functions to set a wakeup latency constraint for the
>> interconnect would be nothing greater than this:
>>
>> =A0 =A0(2.411 =B5s/FIFO entry * 960 FIFO entries) =3D 2 314.96 =B5s
>>
>> (The reality is that it would need to be something less than this, t=
o
>> account for the time needed for the GFX DMA transfer to start supply=
ing
>> data, etc.)
>
> Makes sense.
>
> Another reason for underflows we have is the different rotation engin=
es.
> VRFB on omap2/3, and TILER on omap4. Both increase the "work" needed =
to
> get pixels, although I'm not sure what the actual causes for the
> increased work are.
>
>> The ultimate goal, with Jean's device PM QoS patches, is that these
>> constraints could change the DPLL autoidle settings or powerdomain s=
tates
>> to ensure the constraint was met. =A0He's got a page here:
Indeed! The core code is ready and the OMAP power domains code is
under review for the moment. The ultimate goal is to split the overall
latency of a device into the contributors (SW, HW SoC, HW external
etc.), so the DPLL relock time would be taken into account. However
without the submitted code in place there is no way to build the
feature in incremental steps.

>>
>> =A0 http://omappedia.org/wiki/Power_Management_Device_Latencies_Meas=
urement
In the wiki page there is a link to the ELC/Fosdem presentation [1]
about the new model for the latency.
[1] http://omappedia.org/wiki/File:ELC-2012-jpihet-DeviceLatencyModel.p=
df

>>
>> (Unfortunately it's not clear what the DPLL autoidle modes and volta=
ge
>> scaling bits are set to for many of the estimates, and we also know =
that
The code is from an l-o tree + the measurement code in, so the DPLL
are allowed to auto-idle. In the new model the DPLL relock latency
contribution should be split from the power domains latency.

>> there are many software optimizations possible for our idle path.)
Sure! Recently we have had the case with the C1 cpuidle state.
Hopefully some simple experimental optimizations did fix the issue.

Regards,
Jean

>>
>> We're still working on getting the OMAP device PM QoS patches merged=
, but
>> the Linux core support is there, so you should be able to patch your
>> drivers to use them -- see for example dev_pm_qos_add_request().
>
> Thanks for the pointers, I need to study that.
>
>> Just paging through the DSS TRM section, some other settings that mi=
ght be
>> worth checking are:
>>
>> - is DISPC_GFX_ATTRIBUTES.GFXBURSTSIZE set to 16x32?
>
> Yes. (8 x 128 on omap4)
>
> I presume each DMA burst has a small overhead, so maximizing the burs=
t
> size minimizes the overhead. Do you see any other effect with the bur=
st
> size? I mean, do you see any need to know the burst size value when
> trying to calculate optimal thresholds?
>
>> - is DISPC_GFX_ATTRIBUTES.GFXFIFOPRELOAD set to 1?
>
> No. We set it to 0 so that PRELOAD is used. If I've understood right,
> the problem with using GFXFIFOPRELOAD=3D1, i.e. high threshold is use=
d for
> preload value, is that the high threshold can be quite high, and the
> preload needs to happen during vertical blanking. With a small vblank
> time and high high threshold there may not be enough time for the
> preload.
>
> Then again, I have not verified that. And I'm not sure why it would b=
e a
> problem if the FIFO is not loaded up to the preload value during
> blanking, presuming we still have enough pixels to proceed normally.
>
> For me it would make more sense to always load the fifo to full, so
> there wouldn't be need for any PRELOAD value at all.
>
>> - is DISPC_GFX_PRELOAD.PRELOAD set to the maximum possible value?
>
> No, it's left at the default value. But I have tried adjusting this (=
and
> also changing the GFXFIFOPRELOAD bit), and neither fixed the original
> problem.
>
>> - is DISPC_CONFIG.FIFOFILLING set to 1?
>
> No, it's set to 0. With this problem there's only one overlay enabled=
 so
> it shouldn't have any effect.
>
> =A0Tomi
>
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
