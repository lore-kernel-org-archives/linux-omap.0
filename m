From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: twl4030_charger: need changes to get probed?
Date: Sat, 7 Mar 2015 17:56:01 +0200
Message-ID: <CANOLnONc3+F=e3VfYZyGCtnzMOHV3GrX6cUSV1G4WJDPrgGFSg@mail.gmail.com>
References: <20150224043341.4243.23291.stgit@notabene.brown>
	<CANOLnONUtfF1UwgW3O5fkAX30UMznZXwbtPkqPFDLR4jFdNqow@mail.gmail.com>
	<20150306224034.GA20559@amd>
	<201503062356.06110@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:33317 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbbCGP4E convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 7 Mar 2015 10:56:04 -0500
In-Reply-To: <201503062356.06110@pali>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, ivo.g.dimitrov.75@gmail.com, Samuel Ortiz <sameo@linux.intel.com>, khilman@kernel.org, NeilBrown <neilb@suse.de>, sre@debian.org, linux-pm@vger.kernel.org, Aaro Koskinen <aaro.koskinen@iki.fi>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>, GTA04 owners <gta04-owner@goldelico.com>, sre@ring0.de, Tony Lindgren <tony@atomide.com>, David Woodhouse <dwmw2@infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, patrikbachan@gmail.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Sat, Mar 7, 2015 at 12:56 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com>=
 wrote:
> On Friday 06 March 2015 23:40:34 Pavel Machek wrote:
>> On Sat 2015-03-07 00:12:07, Grazvydas Ignotas wrote:
>> > On Fri, Mar 6, 2015 at 11:57 PM, Pali Roh=C3=A1r
>> > <pali.rohar@gmail.com> wrote:
>> > > On Friday 06 March 2015 22:24:17 Pavel Machek wrote:
>> > >> Hi!
>> > >>
>> > >> According to n900 dts, twl4030-bci (aka charger) should
>> > >> be included.
>> > >
>> > > AFAIK it is not present on n900...
>> >
>> > Right, it uses twl5030 variant without the charger, charging
>> > on n900 is provided by separate chip and for a good reason
>> > as twl's charger is not that good. Forcing the driver to
>> > load just ends up with it accessing non-existent registers
>> > over i2c.
>>
>> Ok, but:
>>
>> 1) Why is the twl4030-bci enabled in n900's dts, then
>>
>
> maybe it is bug in n900 dts...
>
> Grazvydas, is there some runtime check if twl4030/twl5030 chip
> has charger or not? or do we need to explicitly disable device
> twl4030-bci in DT?

Actually from looking at the schematics, it looks like the charger
pins are still there but all connected to ground. So it probably has
the charger after all, it's just not connected or used.

I'm not aware or any registers for direct detection, and indirect
detection is difficult because BCI mostly disables itself when no
charger is connected and most registers read as 0 or have old values
from last charging session (which will never happen on n900).

There is IDCODE register on twl4030 itself, but it's documented as not
meaningful when accessed over i2c (when is it meaningful then??).

drivers/mfd/twl-core.c has a i2c_device_id table of various twl4030
variants, some of which have no charger. N900 has GAIA/twl5030, which
differs from twl4030 only by vaux2 regulator according to that file.
N900's old board files specify 5030, but .dts does not.


Gra=C5=BEvydas
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
