From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: omap4 pandaboard: clock input for TiWi module inactive
Date: Mon, 11 Mar 2013 10:51:43 +0100
Message-ID: <513DA92F.7020908@ti.com>
References: <CAEYbN3QotnnAUU=7c7=r1sHDnZ5VhgNfXfP6ANf3+ssCzmEa=A@mail.gmail.com> <513D9CB7.2010402@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59476 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752724Ab3CKJvx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 Mar 2013 05:51:53 -0400
In-Reply-To: <513D9CB7.2010402@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: Levi Pearson <levipearson@gmail.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, "Coelho, Luciano" <coelho@ti.com>, Balaji T Krishnamoorthy <balajitk@ti.com>

On 03/11/2013 09:58 AM, Roger Quadros wrote:
> (+ Peter, Luca, Balaji)
>=20
> else your e-mail might just go unnoticed ;)
>=20
> On 03/07/2013 10:37 PM, Levi Pearson wrote:
>> I recently upgraded from a 3.4 kernel to a 3.8 kernel and found that
>> the drivers for the functionality provided by the TiWi module on the
>> pandaboard (Bluetooth, WiFI, etc.) could no longer probe the device.
>> After some investigation, it turned out that the TiWi clock is
>> provided by the twl6030 PMIC chip.
>>
>> The clock output of the twl6030 was first enabled via these commits:
>>
>> https://patchwork.kernel.org/patch/546381/
>> https://patchwork.kernel.org/patch/546401/
>>
>> Since most of the functionality of the TWL6030 is power regulation a=
nd
>> the clock is enabled via a similar mechanism to the power outputs, t=
he
>> clock was added as a 'pseudo-regulator' to
>> drivers/regulator/twl-regulator.c.
>>
>> Some time later, a series of commits removed the clock functionality
>> from twl-regulator.c, apparently due to being out-of-place in the
>> Device Tree listings or something.
>>
>> The first of these is recorded here: https://lkml.org/lkml/2012/6/4/=
330
>> The next two just clean up the code that was orphaned by the previou=
s:
>>  e76ab829 "regulator: twl: Remove references to the twl4030 regulato=
r"
>>  029dd3ce "regulator: twl: Remove another unused variable warning"
>>
>> Luciano Cuelho, who maintains the driver for the WiFi portion of the
>> TiWi modules, reported the resulting breakage some time later on the
>> LKML: https://lkml.org/lkml/2012/11/15/72
>>
>> Despite the protestation of Mark Brown that his code removal wasn't
>> the cause of the problem, reverting his changes does indeed enable t=
he
>> clock.  However, it also seems to be the case that there ought to be=
 a
>> better home for the clock than twl-regulator.c.  At the time of the
>> previous discussion, it wasn't clear if the framework was in place t=
o
>> support a clock driver for the twl6030's clock, but it seems like th=
e
>> support exists now, since there's a clock driver for the twl6030's
>> companion, the twl6040 audio chip.

IMHO the 'hack' in the twl-regulator should not have been removed befor=
e we
provide proper support for the clocks via the common clock framework.

>> So: Is there any chance of simply reverting the 3 commits that broke
>> the clock?  I have done this locally, but I hate to see pandaboard
>> support in the mainstream kernel continue to be broken in this way.

We should have the clock driver under drivers/clk/ via clk-twl6030.c dr=
iver
for all the clocks twl6030 provides and use that in drivers (updating t=
he
clock tree as well).

>> If for whatever reason the commits cannot be reverted, would creatin=
g
>> a driver like drivers/clk/clk-twl6040.c that enabled the twl6030's
>> clock output be a suitable alternative?  I'd be willing to take a st=
ab
>> at writing it if there's not something like that in the works alread=
y.

If you can take this it would be great. It is still in my to-do list to
integrate the clk-twl6040 clock with the omap-mcpdm driver. I already g=
ot
working code, but it is not working in a way I would really wanted to b=
e.
Integrating external clock to the SoC's clock tree does not seams to be=
 that
straight forward: at boot time when the clock tree is initialized the e=
xternal
chip is yet to be probed -> the root clock is not there, but later on f=
or some
reason I can not get the CCF to enable the clock tree correctly.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
