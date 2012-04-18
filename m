From: Kevin Hilman <khilman@ti.com>
Subject: Re: PM related performance degradation on OMAP3
Date: Tue, 17 Apr 2012 17:36:06 -0700
Message-ID: <87r4vlq3k9.fsf@ti.com>
References: <CANOLnOP5gq4Vtt00SgRNW-3GZDWk0sukBgJx4V6rkMLL+b6G-w@mail.gmail.com>
	<877gxobudk.fsf@ti.com>
	<CANOLnOPbHBshCdbmSOjYdubWqUivrVpR-+eaayu=v4Yy6yKdsQ@mail.gmail.com>
	<87ehrtn6na.fsf@ti.com>
	<CANOLnOM_-yhr-j=UO3ynJ6HyJxzd_2FshPMXMLpcBcOB0mL7Qw@mail.gmail.com>
	<87y5puwhus.fsf@ti.com>
	<CANOLnONNMPzu4GyLd_vr4qaDwqUoRHMpKaiE-GQOJDDd2VL8Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:41372 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752357Ab2DRAgN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 17 Apr 2012 20:36:13 -0400
Received: by pbcun4 with SMTP id un4so8988814pbc.36
        for <linux-omap@vger.kernel.org>; Tue, 17 Apr 2012 17:36:11 -0700 (PDT)
In-Reply-To: <CANOLnONNMPzu4GyLd_vr4qaDwqUoRHMpKaiE-GQOJDDd2VL8Jw@mail.gmail.com>
	(Grazvydas Ignotas's message of "Wed, 18 Apr 2012 00:50:56 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>

Grazvydas Ignotas <notasas@gmail.com> writes:

> On Tue, Apr 17, 2012 at 5:30 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Grazvydas Ignotas <notasas@gmail.com> writes:
>>>
>>> Ok I did some tests, all in mostly idle system with just init, busy=
box
>>> shell and dd doing a NAND read to /dev/null .
>>
>> Hmm, I seem to get a hang using dd to read from NAND /dev/mtdX on my
>> Overo. =C2=A0I saw your patch 'mtd: omap2: fix resource leak in pref=
etch-busy
>> path' but that didn't seem to help my crash.

[...]

> Also only pandora is using NAND DMA mode right now in mainline, the
> default polling mode won't exhibit the latency problem (with all othe=
r
> polling consequences like high CPU usage), so this is needed too for
> the test:

Yeah, I noticed that today when I discovered my dd tests weren't causin=
g
any DMA interrupts. ;) I switched Overo to use DMA mode by copy/paste
the pdata from Pandora board file, and now it's working fine, and I'm
seeing throughput similar to yours.

> I also forgot to mention I was using ubifs in my test (dd'ing large
> file from it), I don't think it has much effect, but if you want to
> try with that:

[...]

I'm just dd'ing raw bytes from /dev/mtdX to /dev/null, so the format
shouldn't matter I guess.

>>> To me it looks like this results from many small things adding up..
>>> Idle is called so often that pwrdm_p*_transition() and those
>>> pwrdm_for_each_clkdm() walks start slowing everything down, perhaps
>>> because they access lots of registers on slow buses?
>>
>> Yes PRCM register accesses are unfortunately rather slow, and we've
>> known that for some time, but haven't done any detailed analysis of =
the
>> overhead.
>>
>> Using the function_graph tracer, I was able to see that the pre/post
>> transition are taking an enormous amount of time:
>>
>> =C2=A0- pwrdm pre-transition: 1400+ us at 600MHz (4000+ us at 125MHz=
)
>> =C2=A0- pwrdm post-transtion: 1600+ us at 600MHz (6000+ us at 125MHz=
)
>
> Hmm, with this it wouldn't be able to do ~500+ calls/sec I was seeing=
,
> so the tracer overhead is probably quite large too..

Yes, tracer overhead is important there, but it still shows me who the
biggest contributors are to the overhead/delay.

>> Notice the big difference between 600MHz OPP and 125MHz OPP. =C2=A0A=
re you
>> using CPUfreq at all in your tests? =C2=A0If using cpufreq + ondeman=
d
>> governor, you're probably running at low OPP due to lack of CPU acti=
vity
>> which will also affect the latencies in the idle path.
>
> I used performance governor in my tests, so it all was at 600MHz.

OK, good.

Kevin

>> I'm looking into this in more detail know, and will likely have a fe=
w
>> patches for you to experiment with.
>
> Sounds good,
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
