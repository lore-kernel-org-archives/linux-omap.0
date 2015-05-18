From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: dts: am335x-bone* enable pmic-shutdown-controller
Date: Mon, 18 May 2015 13:37:27 -0700
Message-ID: <20150518203727.GI10274@atomide.com>
References: <20150513144846.GC6605@localhost>
 <CAALWOA-hkgrMi+OeNrmwaVpdEfNadFn0R-QbpXi9LU-4sbakJQ@mail.gmail.com>
 <20150518152108.GE10274@atomide.com>
 <CAOCHtYgwyQy+hQE2PeUd+7U9wNygVOUuAb-VSh_9K5y7zFHEWA@mail.gmail.com>
 <20150518162936.GF10274@atomide.com>
 <CAOCHtYjtziBwfSMGPRrQ7rfDEf_dC=7rPytQUxVXy8bSp-8NNw@mail.gmail.com>
 <20150518170354.GG10274@atomide.com>
 <7ECB47C4-812D-4465-82EE-56796B987011@konsulko.com>
 <20150518181455.GH10274@atomide.com>
 <D3CA3985-8C25-4B0C-A3DF-A3E2AF8450BD@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:51908 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932114AbbERUha (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 May 2015 16:37:30 -0400
Content-Disposition: inline
In-Reply-To: <D3CA3985-8C25-4B0C-A3DF-A3E2AF8450BD@konsulko.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Robert Nelson <robertcnelson@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Johan Hovold <johan@kernel.org>, devicetree <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Felipe Balbi <balbi@ti.com>

* Pantelis Antoniou <pantelis.antoniou@konsulko.com> [150518 11:19]:
> Hi Tony,
>=20
> > On May 18, 2015, at 21:14 , Tony Lindgren <tony@atomide.com> wrote:
> >=20
> > * Pantelis Antoniou <pantelis.antoniou@konsulko.com> [150518 11:02]=
:
> >> Hi Tony,
> >>=20
> >>> On May 18, 2015, at 20:03 , Tony Lindgren <tony@atomide.com> wrot=
e:
> >>>=20
> >>> * Robert Nelson <robertcnelson@gmail.com> [150518 09:51]:
> >>>> On Mon, May 18, 2015 at 11:29 AM, Tony Lindgren <tony@atomide.co=
m> wrote:
> >>>>> * Robert Nelson <robertcnelson@gmail.com> [150518 09:15]:
> >>>>>> On Mon, May 18, 2015 at 10:21 AM, Tony Lindgren <tony@atomide.=
com> wrote:
> >>>>>>=20
> >>>>>> All the rev information is in the board's eeprom:
> >>>>>>=20
> >>>>>> hexdump -e '8/1 "%c"' /sys/bus/i2c/devices/0-0050/eeprom -s 12=
 -n 4
> >>>>>>=20
> >>>>>> Rev A5B
> >>>>>> 0A5B
> >>>>>>=20
> >>>>>> Rev C
> >>>>>> 000C
> >>>>>>=20
> >>>>>> Just another default qwerk to add to Pantelis' bone_capemgr. ;=
)
> >>>>>=20
> >>>>> It seems we should not even instantiate some devices on BBB
> >>>>> until the EEPROM is parsed.. So maybe something like this:
> >>>>>=20
> >>>>> 1. The problem devices are initially set with status =3D "disab=
led"
> >>>>>  in the dts
> >>>>>=20
> >>>>> 2. We set up drivers/*/bbb-eeprom.c that parses the board
> >>>>>  revision at module_init time, and then flips the selected
> >>>>>  devices to have status =3D "enabled" and populates the revisio=
n
> >>>>>  info based on the eeprom and SoC revision passed in pdata.
> >>>>>  Then those devices get their struct device created and
> >>>>>  probed, but at a much later time.
> >>>>>=20
> >>>>> So rather than trying to init all that early, let's just
> >>>>> init them much later when we have the proper I2C driver
> >>>>> running?
> >>>>=20
> >>>> I see that working just fine.  We (beagleboard.org) enforce the =
eeprom
> >>>> data, as all the official images require a proper baseboard eepr=
om.
> >>>=20
> >>> OK
> >>>=20
> >>>> We just have to be very careful to limit the scope, otherwise we=
 will
> >>>> end up with Pantelis' rejected capebus from the v3.2.x days...
> >>>=20
> >>> Naturally I was thinking #2 above would use Pantelis' code for
> >>> CONFIG_OF_OVERLAY in mainline. But instead of the earlier patches=
,
> >>> we can make things happen much later on to avoid the detect of
> >>> EEPROM early on.
> >>=20
> >> Already been taken care of:
> >>=20
> >> https://lkml.org/lkml/2015/2/18/258
> >>=20
> >> The patchset works, but it still needs some review eyeballs.
> >> There might be a rename to variants or something.
> >>=20
> >> You were part of that thread too :)
> >=20
> > Right, and what I mean with #2 above is that we can make this all
> > into a regular drivers/* device driver with no need for the
> > early hacks in your series in arch/arm/mach-omap2/am33xx-dt-quirks.=
c.
> >=20
>=20
> It=E2=80=99s going to be tough. This is touching the pmic that needs =
to be=20
> initialized early since a whole bunch of drivers depend on it.

With the $subject driver we just need to have have RTC driver not
probe until the the EEPROM is parsed in the drivers/foo/bbb-eeprom.c
driver and the RTC overlay is initialized. Or what's the issue
you're talking about?

But in any case, let's not merge a copy of the I2C driver into
arch/arm/mach-omap2/am33xx-dt-quirks.c. We can do all this with
drivers/foo/bbb-eeprom.c that's just a regular device driver.
=20
> >> I think it=E2=80=99s best if we go this path instead of twiddling =
with the
> >> status properties manually. Conceptually the idea is similar to
> >> the detection of the white/black, with the added joy of revision
> >> detection.
> >=20
> > If some device drivers depend on the I2C EEPROM, we should not
> > create the struct device entry for those until the I2C EEPROM
> > driver has parsed the EEPROM. And there's no need to do that
> > early, we want to do everything as late as possible. That way
> > we have real debug console available in most cases.
> >=20
>=20
> FWIW the first patch used an early platform device, but that made thi=
ngs
> even more complicated.

No need to do any early platform devices, we just need to delay
the creation of struct device for the problem drivers.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
