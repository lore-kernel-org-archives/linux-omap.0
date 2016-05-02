From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: Nokia N900: Broken lirc ir-rx51 driver
Date: Mon, 2 May 2016 11:39:34 +0300
Message-ID: <57271246.1020000@gmail.com>
References: <201601021545.35201@pali> <20160102170657.GB12622@atomide.com>
 <20160105101841.GI22661@pali> <20160106011249.GH12777@atomide.com>
 <20160422134929.GG29406@pali> <20160502070612.GC13215@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160502070612.GC13215@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sre@kernel.org>, Nishanth Menon <nm@ti.com>, Timo Kokkonen <timo.t.kokkonen@iki.fi>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On  2.05.2016 10:06, Pavel Machek wrote:
> On Fri 2016-04-22 15:49:29, Pali Roh=E1r wrote:
>> On Tuesday 05 January 2016 17:12:50 Tony Lindgren wrote:
>>> * Pali Roh=E1r <pali.rohar@gmail.com> [160105 02:19]:
>>>> On Saturday 02 January 2016 09:06:57 Tony Lindgren wrote:
>>>>>
>>>>> Yup please take a look at thread "[PATCH 0/3] pwm: omap: Add PWM =
support
>>>>> using dual-mode timers". Chances are we still need to set up the =
dmtimer
>>>>> code to provide also irqchip functions. That way ir-rx51.c can ju=
st do
>>>>> request_irq on the selected dmtimer for interrupts.
>>>>
>>>> No I see that patch from that thread uses dmtimer.h from plat-omap=
=2E So
>>>> it is really OK?
>>>
>>> It's using the header to populate the platform data in mach-omap2 s=
o
>>> that's fine. But we do not want to directly expose the dmtimer func=
tions
>>> to device drivers as they are not Linux generic at this point.
>>>
>>> Regards,
>>>
>>> Tony
>>
>> Hi Tony! Is there any progress for ir-rx51 driver? Months ago we wer=
e
>> waiting for some omap pwm patches... What is current state?
>
> Tony now posted patch series... it would be good to test them:
>

Hmm, I guess you've missed=20
http://www.spinics.net/lists/linux-omap/msg128465.html

Regards,
Ivo
