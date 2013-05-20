From: Nishanth Menon <nm@ti.com>
Subject: Re: reset handling in am335x hwmod data
Date: Mon, 20 May 2013 13:03:44 -0500
Message-ID: <20130520180344.GA7653@kahuna>
References: <87ehij8lpb.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1212232033030.8937@utopia.booyaka.com>
 <20130517135022.GH14133@arwen.pp.htv.fi>
 <877gixsfdz.fsf@linaro.org>
 <87vc6hlbnz.fsf@dell.be.48ers.dk>
 <20130517181922.GA4439@kahuna>
 <79CD15C6BA57404B839C016229A409A83EC8E827@DBDE04.ent.ti.com>
 <79CD15C6BA57404B839C016229A409A83EC8E84F@DBDE04.ent.ti.com>
 <20130520150617.GA22835@kahuna>
 <79CD15C6BA57404B839C016229A409A83EC8EF60@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36347 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756189Ab3ETSEB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 20 May 2013 14:04:01 -0400
Content-Disposition: inline
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC8EF60@DBDE04.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Cc: Peter Korsgaard <jacmet@sunsite.dk>, Kevin Hilman <khilman@linaro.org>, "Balbi, Felipe" <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

On 12:47-20130520, Hiremath, Vaibhav wrote:
[...]
> > > > >
> > > > > On 20:10-20130517, Peter Korsgaard wrote:
> > > > > > >>>>> "Kevin" =3D=3D Kevin Hilman <khilman@linaro.org> writ=
es:
> > > > > >
> > > > > >  >> In this case, we cannot reset that bank, otherwise Star=
ter
> > Kit
> > > > > will
> > > > > >  >> never boot in mainline. Bad PCB design, I know, but it'=
s
> > not
> > > > > something
> > > > > >  >> we can change now :-)
> > > > > >
> > > > > >  Kevin> FWIW, we've seen this before (GPIO connected to PMI=
C
> > reset
> > > > is
> > > > > a
> > > > > >  Kevin> fun one), and this is why we have
> > > > > omap_hwmod_no_setup_reset().
> > > > > >
> > > > > > Yes, but there's no dts bindings for this, and from a quick
> > test
> > > > the
> > > > > > reset handling happens before the device tree is probed.
> > > > > I have the same issue with TPS62361 on Palmas -> GPIO control=
s
> > the
> > > > > voltage register supplying MPU, without any driver setting th=
ings
> > up,
> > > > > GPIO gets reset and obviously voltage value switches to an
> > voltage
> > > > > where
> > > > > device does not function.
> > > > >
> > > > > Solution I am working on to solve this is [1]: snippet is par=
t of
> > a
> > > > > patch that I am working on atm.
> > > > >
> > > > > This is the right way to do it IMHO. Will allow the driver to
> > exist
> > > > > when
> > > > > HWMOD will be eventually replaced by some other framework.
> > > > >
> > > > >
> > > > > [1]: http://pastebin.com/XPmAB1Zb
> > > > >
> > > > >
> > > >
> > > > Both seems to be different to me. What we need is to
> > > > Avoid reset of whole GPIO bank during kernel boot.
> > Yes - that is what the above does - as long as the GPIO is requeste=
d
> > and
> > set to the right level by the relevant driver, it is not "unused" a=
nd
> > hence not reset at late_init.
> >=20
>=20
> May be I am missing something here,
>=20
> Isn't _setup_reset() function asserts ocp_reset? And it is core_initc=
all.
Hmm.. You are right, I missed that :(
>=20
> > I am a little unclear as to why this needs to have anything to do w=
ith
> > the precise under-lying mechanism (hwmod or something else). May be
> > "both seem to be different to me" needs a little further elaboratio=
n?
> >=20
>=20
> GPIO is connected to the DDR VTT control pin, and we have observed th=
at
> Due to GPIO bank reset as part of hwmod init during bootup.
>=20
> > Is this because there is no need for an EMIF driver to handle DDR? =
and
> > reset of the GPIO will occur as EMIF is configured at bootloader an=
d
> > there is no need to do that in kernel, correspondingly there is no
> > "driver" to hold the gpio?
> > > >
> > > > Ideally, it would have been much better if drivers starts handl=
ing
> > > > Idle, ocp reset and standby on their own (killing dependency on
> > hwmod
> > > > init layer).
> > > >
> > > > But looking at current state,
> > > > I agree we need to use DT property here, so how about
> > > > Adding DT property  to GPIO node itself. But we have to parse
> > I believe you mean at OMAP specific  DT property for hwmod?
> > something like ti,hwmod-no-init-reset?
>=20
> That=E2=80=99s the idea.
>=20
> > > > It early during hwmod init stage. We should read all DT nodes
> > > > Inside function __setup() function, that way can get rid of
> > > > HWMOD_INIT_NO_RESET flag completely. Also, this will handle
> > > > Both ocp_reset and domain reset.
> > > >
> > >
> > > Forgot to mention,
> > >
> > > Since this is kernel boot failure issue, I think,
> > > By the time we reach to conclusion, another approach is to
> > > set "HWMOD_INIT_NO_RESET" flag For GPIO0 bank.
> > a) if the GPIO gets moved over to some other GPIO bank on another
> > platform,
> > this wont work
>=20
> Yes that=E2=80=99s true, but such schematic interface is not recommen=
ded.
> And we have not seen any known side-effect of not resetting GPIO0 ban=
k.
unless you mark the GPIO as taken, another driver could in-adverantly
take over the GPIO and set it to a wrong level (we had a similar story
with LED gpio between Panda Vs Panda-ES).

>=20
> > b) for platforms that dont use gpio to hold DDR power, maybe this i=
s
> > not
> > even relevant and the GPIO bank can safely be reset?
> > >
>=20
> As I mentioned, there is no known side-effect of not resetting GPIO b=
ank 0.
It should depend on the platform.

There are other uses for hwmod-no-reset -> Eg. boot logo displayed by
bootloader - if there is a reset of DSS block and re-configuration, we'=
d
notice a blank-out, which is not desirable either. There could be a few
other usage based on no-reset.

In all cases, you'd prefer to make this:
a) platform dependent (board dts)
b) reserve GPIO as well so that no other driver'd take it - if they
attempt ther'd at least be some form of warning.

--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
