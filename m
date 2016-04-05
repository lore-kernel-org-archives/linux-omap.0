From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 0/3] ARM: OMAP3: Fix McBSP2/3 hwmod setup for sidetone
Date: Tue, 5 Apr 2016 16:15:23 +0300
Message-ID: <5703BA6B.1080208@ti.com>
References: <1458311007-19168-1-git-send-email-peter.ujfalusi@ti.com>
 <alpine.DEB.2.02.1603191937430.6629@utopia.booyaka.com>
 <56EFB794.5010505@ti.com>
 <alpine.DEB.2.02.1603211743200.31059@utopia.booyaka.com>
 <56FE407E.9030803@ti.com> <20160402001753.GR9329@atomide.com>
 <57026205.6020105@ti.com> <20160404151200.GA4652@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160404151200.GA4652@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, jarkko.nikula@bitmer.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 04/04/16 18:12, Tony Lindgren wrote:
>> The reason for this is that in DT boot we can not provide the
>> enable_st_clock() callback to the mcbsp driver stack. This is done f=
or legacy
>> boot in mach-omap2/mcbsp.c
>=20
> Seems like the short term fix there is to pass enable_st_clock pointe=
r
> in pdata using pdata-quirks.c.

I don't think there is a point to spend effort on a workaround via pdat=
a-quirks.

> Then for the long term solution using
> PM runtime to block gating of the clock while sidetone is active is
> the way to go it seems.

Hrm, I think one of the main issue is that with pm_runtime we can not b=
lock
the clock gating, this is why legacy code uses enable_st_clock(), which=
 will
call omap2_clk_deny_idle() or omap2_clk_allow_idle().

>> The ST does not have clocks coming from PRCM level, it only uses the=
 McBSP
>> iclk when it is enabled (the McBSP block of the McBSP). As far as pm=
_runtime
>> goes I think the ST module should not use it. We can not tell hwmod =
to
>> enable/disable the McBSP2/3 iclk when we pm_runtime for the ST. It d=
oes not
>> help at all. We can have nop action for the ST when pm_runtime is us=
ed, but
>> then why would we have it?
>=20
> Using PM runtime in the sidetone driver should just work as long as t=
he
> sidetone device driver depends on the McBSP driver before it gets pro=
bed.
> The clock framework handles things for the mcbsp ick with the usecoun=
t.

Yes, that is not the problem. The problem is that when McBSP is used w/=
o
sidetone the iclk can and should be autogated, but if the sidetone is e=
nabled
then the iclk must not autogate and this needs to be prevented in PRCM =
level.
Note also that while the McBSP is running we must be able to enable/dis=
able
the sidetone any time w/o affecting the McBSP operation.

> And doing pm_runtime_get() in the sidetone driver will do what the le=
gacy
> enable_st_clock() does currently.

it can't do that as we do not have way to deny/enable just the autoidle=
 for a
given clock.

>=20
>>> So having two separate drivers might make things a lot simpler.
>>
>> Not really. It will make things way more complicated imho. How to ha=
ndle
>> legacy boot as we still have that supported?
>=20
> Hey both the legacy driver and DT driver are really just platform dev=
ices
> and drivers. And passing both dts and platform data can be done just
> fine, no?

Sure, but McBSP2-ST needs to bind with McBSP2 driver instance and the
McBSP3-ST should bind with McBSP3 instance. In legacy mode we can store=
 the
McBSP pdev pointers in a array and use the devid or get the McBSP id fr=
om the
device name. While with DT boot we must have phandle pointing to/from S=
T
from/to McBSP node to be able to figure out who is who.

>> When the McBSP driver is loaded we must know if it has sidetone or n=
ot so
>> we can create the needed audio controls, sysfs entries. The sysfs an=
d
>> kcontrol registration could be moved out to the new ST driver, true.
>=20
> Yeah during the probe, the sidetone driver must register with the McB=
SP
> driver to tell it's there.

When McBSP driver probes, it registers itself to ASoC core and it needs=
 to
know at that point if we need to prepare for ST or not. So probably the=
 McBSP
driver needs to register to ST driver?

> I guess no need to pass anything in the
> dts or platform_data for that.
>=20
>> I actually started with two separate drivers approach first, but dec=
ided that
>> it does not worth the effort (legacy boot support, pm_runtime/hwmod =
hassle,
>> platform data, callback API design, etc).
>> I know, it is not rocket science but it is king of shoot out of cann=
on into
>> sparrows.
>> I'll think about it for a little while ;)
>=20
> Well what we've seen so far is that any kind of non-standard solution
> will always be a pain to maintain in the long run :)

The current implementation (one driver to handle McBSP and the ST) is t=
here
ever since OMAP3 was introduced afaik. Changing a working (was working)=
 design
to something which has not been tested will for sure going to open issu=
es we
have not prepared for.
I would avoid the rewrite of a proven driver architecture if it is not =
broken.

>>> If you don't treat the McBSP and sidetone as separate modules, thin=
gs can
>>> easily fail. For example, doing a read-back to flush of posted writ=
e to
>>> sidetone registers flushes nothing for McBSP and the other way arou=
nd.
>>
>> I don't see problem with the need of flushing if we would need it. I=
 don't
>> think we are doing anything proactively to flush writes in the drive=
r today
>> and we do have at least one product using the ST (n900).
>=20
> Usually the problem is with an interrupt ack write not reaching the d=
evice
> in time before something else happens. So I could see mysterious issu=
es
> happening with the McBSP and sidetone having separate interrupts. May=
be
> not a real problem, but the chance for it is still there for sure.

The ST interrupt is not in use and the McBSP interrupt is only used for
debugging purposes as McBSP and it's sidetone is not interrupt driven d=
evices.

>=20
>>>> Other option would be to deprecate the ST support as such, but tha=
t would
>>>> leave the n900 guys in trouble as they need ST to be functional...
>>>
>>> That does not sound like a nice option at all :(
>>
>> I know. This has been bugging me for a long time. I want to fix this=
 one
>> before my beagleboard-xm gives up and won't boot up anymore since af=
ter that I
>> will have no omap3 board to work with :(
>=20
> There are plenty of cheap omap3 devices available out there though :)

I might need to look for one or two, preferably a board with support fo=
r
legacy and DT boot...

--=20
P=C3=A9ter
