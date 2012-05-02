From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
Date: Wed, 2 May 2012 10:34:29 +0530
Message-ID: <CAJ6a13ZBwZn20ObD2hy=xna8oFoKtdczYNxyWACJZoJkhKhsUQ@mail.gmail.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<20120426191159.GA9415@sirena.org.uk>
	<CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
	<20120427175657.GP18260@opensource.wolfsonmicro.com>
	<87397o3n4y.fsf@ti.com>
	<20120430095429.GB3170@opensource.wolfsonmicro.com>
	<87wr4wriq3.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aob106.obsmtp.com ([74.125.149.76]:50256 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752818Ab2EBFEa convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 May 2012 01:04:30 -0400
Received: by obcni5 with SMTP id ni5so547992obc.41
        for <linux-omap@vger.kernel.org>; Tue, 01 May 2012 22:04:29 -0700 (PDT)
In-Reply-To: <87wr4wriq3.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, rjw@sisk.pl, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, j-pihet@ti.com, durgadoss.r@intel.com

On Tue, May 1, 2012 at 3:21 AM, Kevin Hilman <khilman@ti.com> wrote:
> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>
>> On Fri, Apr 27, 2012 at 02:01:17PM -0700, Kevin Hilman wrote:
>>> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>>
>>> > But presumably these things should integrate somehow - for exampl=
e,
>>> > should devfreq and cpufreq be providing inputs into what AVS is d=
oing,
>>> > and if so how?
>>
>>> The way it is currently designed, cpufreq/devfreq/regulator layers =
don't
>>> need to know about AVS.
>>
>> Yes, and that was a part of my concern, but see below.
>>
>>> The higher-level layers only know about the "nominal" voltage. =A0A=
VS
>>> hardware does automatic, adaptive, micro-adjustments around that no=
minal
>>> voltage, and these micro-adjustments are managed by the AVS hardwar=
e
>>> sending commands to the PMIC. =A0(specifically, on OMAP, the AVS se=
nsors
>>> provide inputs to the voltage processor (VP) which provide inputs t=
o the
>>> voltage controller (VC) which sends commands to the PMIC[1].)
>>
>> Right, that's what I'd understood it to be.
>>
>>> The driver proposed here is primarily for initializing the various
>>> parameters/sensitivity/etc. of the AVS hardware, but the actual vol=
tage
>>> adjustments are done in hardware by VC/VP.
>>
>> It's not just a driver, though - it's also creating this power/avs
>> thing, though now I look at the code rather than just its shape ther=
e's
>> not actually an abstraction being added here, it's mostly just strai=
ght
>> code motion of the arch/arm code that's there already. =A0The change=
log
>> and the shape of the code make it sound like this is intended to be
>> somewhat generic when really it's providing some OMAP specific tunin=
g
>> for the device which is much less of a concern.
>>
>> I guess for now it's probably OK to just clarify in the documentatio=
n
>> and say that whoever adds the second driver has to work on making th=
is
>> generic :)
>
> Agreed.
>
> In a different thread (which I can't seem to find now) we discussed t=
his
> as well, so it just sounds like the changelog should clarify this a b=
it
> better.

Kevin/Mark,

Thanks for the feedback. I will add more documentation
to clarify this aspect. Please let me know if there are any more
things to be taken care of in this patch set.

>
> Kevin
>
>> This does also sound rather like it's in a similar area to the curre=
nt
>> management work which Durgadoss R (CCed) was working on, though with=
 a
>> slightly different application and in the OMAP case it's pretty much=
 all
>> hidden in the external processor.
>



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
