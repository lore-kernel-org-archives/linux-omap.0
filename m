From: jouni.hogander@nokia.com (=?utf-8?Q?H=C3=B6gander?= Jouni)
Subject: Re: [PATCH RFC]OMAP3:PM:Dynamic Calculation of SDRC stall latency during DVFS
Date: Tue, 02 Mar 2010 08:56:26 +0200
Message-ID: <87zl2rnrdx.fsf@trdhcp146196.ntc.nokia.com>
References: <5A47E75E594F054BAF48C5E4FC4B92AB031E80D573@dbde02.ent.ti.com>
	<87bpfqkhan.fsf@trdhcp146196.ntc.nokia.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0321A2036B@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:46722 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753173Ab0CBG5Y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Mar 2010 01:57:24 -0500
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0321A2036B@dbde02.ent.ti.com> (ext Reddy's message of "Tue\, 23 Feb 2010 10\:59\:52 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Reddy, Teerth" <teerth@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Kevin Hilman <khilman@deeprootsystems.com>

"ext Reddy, Teerth" <teerth@ti.com> writes:

> Hi Jouni,
>
>> -----Original Message-----
>> From: H=C3=B6gander Jouni [mailto:jouni.hogander@nokia.com]
>> Sent: Monday, February 15, 2010 2:27 PM
>> To: Reddy, Teerth
>> Cc: linux-omap@vger.kernel.org; Sripathy, Vishwanath; Paul Walmsley;=
 Kevin
>> Hilman
>> Subject: Re: [PATCH RFC]OMAP3:PM:Dynamic Calculation of SDRC stall l=
atency
>> during DVFS
>>=20
>> "ext Reddy, Teerth" <teerth@ti.com> writes:
>>=20
>> > From: Teerth Reddy <teerth@ti.com>
>> >
>> > Dynamic Calculation of SDRC stall latency during DVFS
>> >
>> > The patch has the changes to calculate the dpll3 clock stabilizati=
on
>> delay dynamically. The SRAM delay is calibrated during bootup using =
the
>> gptimers and used while calculating the stabilization delay. By usin=
g the
>> dynamic method the dependency on the type of cache being used is rem=
oved.
>> Hence there is no need of loop based calculation.
>> >
>> > The wait time for L3 clock stabilization is calculated using the f=
ormula
>> : 4*REFCLK + 8*CLKOUTX2, which uses the M, N and M2 read from the
>> registers.Since this value gives slightly less value, 2us is added a=
s
>> buffer for safety.
>> > This works fine for omap3.
>>=20
>> I think you could make a difference on 3630 in this patch. 3630 has
>> different formula to calculate needed delay after setting m2 divider=
=2E
>
> We have considered the worst case scenario and used this formula
> which holds good for 3630 as well. We have used register dump and
> observability  signal analysis to comeup with this formula.

At least the formula used in the patch is quite strictly the one used
for 3430. In 3430 used oscillator and m and n selection have huge
impact on needed delay (12, 19.2 etc...). In 3630 these doesn't have
impact on needed delay anymore. So using own formula for 3630, would
give few benefits. No need to take this delay into account in
oscillator selection and on m and n selection.

>
>
> Regards
> Teerth
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Jouni H=C3=B6gander
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
