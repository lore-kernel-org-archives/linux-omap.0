From: "J, KEERTHY" <j-keerthy@ti.com>
Subject: Re: [PATCH V3 00/10] PM: Create the AVS(Adaptive Voltage Scaling)
Date: Tue, 8 May 2012 09:18:48 +0530
Message-ID: <CAJ6a13arx4bNzc1ByXj=E9gwE3hrw7muZUwmbo3doYAzK-pAnQ@mail.gmail.com>
References: <1335462041-4949-1-git-send-email-j-keerthy@ti.com>
	<20120426191159.GA9415@sirena.org.uk>
	<CAJ6a13a6WN9h1QZynpEOf-R6RXwWBZ2eOPkTeNc15JX_YfAz_w@mail.gmail.com>
	<20120427175657.GP18260@opensource.wolfsonmicro.com>
	<87397o3n4y.fsf@ti.com>
	<331ABD5ECB02734CA317220B2BBEABC13E9B1A67@DBDE01.ent.ti.com>
	<87mx5jy2li.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:37764 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755355Ab2EHDst convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 May 2012 23:48:49 -0400
Received: by obbtb18 with SMTP id tb18so9203618obb.19
        for <linux-omap@vger.kernel.org>; Mon, 07 May 2012 20:48:48 -0700 (PDT)
In-Reply-To: <87mx5jy2li.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>, "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@sisk.pl" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "Pihet-XID, Jean" <j-pihet@ti.com>

On Tue, May 8, 2012 at 5:18 AM, Kevin Hilman <khilman@ti.com> wrote:
> "AnilKumar, Chimata" <anilkumar@ti.com> writes:
>
>> On Sat, Apr 28, 2012 at 02:31:17, Hilman, Kevin wrote:
>>> Hi Mark,
>>>
>>> Mark Brown <broonie@opensource.wolfsonmicro.com> writes:
>>>
>>> > On Fri, Apr 27, 2012 at 11:09:10AM +0530, J, KEERTHY wrote:
>>> >
>>> >> Devfreq and cpufreq are related to dynamic frequency/voltage swi=
tching between
>>> >> pre defined Operating Performance Points or the OPPs. Every OPP =
being
>>> >> a voltage/frequency pair. Smartreflex is a different
>>> >> power management technique.
>>> >
>>> > But presumably these things should integrate somehow - for exampl=
e,
>>> > should devfreq and cpufreq be providing inputs into what AVS is d=
oing,
>>> > and if so how?
>>>
>>> The way it is currently designed, cpufreq/devfreq/regulator layers =
don't
>>> need to know about AVS.
>>>
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
>>>
>>> The driver proposed here is primarily for initializing the various
>>> parameters/sensitivity/etc. of the AVS hardware, but the actual vol=
tage
>>> adjustments are done in hardware by VC/VP.
>>>
>>> The only thing the higher-level layers might potentially need to do=
 to
>>> enable/disable AVS around transitions (e.g. when changing OPP, AVS =
is
>>> disabled before changing OPP and only re-enabled when the new nomin=
al
>>> voltage has been acheived.)
>>>
>>> On OMAP, we handle this inside the OMAP-specific voltage layer whic=
h is
>>> called by the regulator framework, so even the regulators do not ne=
ed
>>> any knowledge of AVS.
>>
>> Kevin,
>>
>> I want to point out some cases of SR implementation where this may n=
ot
>> be true.
>>
>> Devices like DM8168, DM8148 and AM335X use Class 2B implementation o=
f SR.
>>
>> Under this, SR module issues an interrupt to ARM when there is a nee=
d to
>> change the voltage based on temperature changes, ageing etc.
>>
>> Once the interrupt arrives, kernel needs to adjust voltage using reg=
ulator API.
>> The voltage change is a micro adjustment as in other SR classes.
>
> That can easily be handled writing a plugin specific to class 2B. =A0=
This
> driver was designed so plugins for other classes can be supported.
>
> Sure, we might need some enhancements for other classes (we already k=
now
> that we will for class 1 support.) =A0However, the purpose of this se=
ries
> is to do the cleanups necessary for the driver to move to drivers/*.

AnilKumar,

The intent of the series as explained by Kevin if to do the necessary c=
lean up
for the driver to move from mach-omap to drivers/*. We will for sure ne=
ed
more enhancements for other classes support.

>
> Support for additional classes can be added after the driver is moved
> if/when folks are motivated to post that support upstream.
>
>> The SR class 2B implementation on these devices does not exist in ma=
inline.
>> I can point to some public repositories if you are interested in tak=
ing a look at
>> the current code.
>
> No thanks. =A0We can discuss it when you post support for it to mainl=
ine.
>
> Kevin
>
>> Implementation of this SR method is must on at least the DM8168 devi=
ce and
>> I know some customers who are using it on their production systems.
>>
>> Regards
>> AnilKumar
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kern=
el" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/



--=20
Regards and Thanks,
Keerthy
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
