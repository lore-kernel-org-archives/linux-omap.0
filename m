From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030
 madc module
Date: Mon, 31 Jan 2011 11:43:47 +0100
Message-ID: <20110131104346.GA5954@sortiz-mobl>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
 <20110106053328.GA7489@ericsson.com>
 <20110106120713.GD17184@sirena.org.uk>
 <20110106150430.GA9053@ericsson.com>
 <20110106202142.GC8018@opensource.wolfsonmicro.com>
 <1294350903.9786.103.camel@groeck-laptop>
 <AANLkTinkNNhrq+b5eiE7XrYQUsR2-vVD08btqM81KJA1@mail.gmail.com>
 <AANLkTinDVZe0eefrPZsMoUyzqfQOxZsDOaD0VG3OqXyT@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52356 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543Ab1AaKnv (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 31 Jan 2011 05:43:51 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinDVZe0eefrPZsMoUyzqfQOxZsDOaD0VG3OqXyT@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balajitk@ti.com" <balajitk@ti.com>, guenter.roeck@ericsson.com

Hi Keerthy,

On Sat, Jan 22, 2011 at 10:19:33PM +0530, J, KEERTHY wrote:
> On Fri, Jan 7, 2011 at 5:42 PM, J, KEERTHY <j-keerthy@ti.com> wrote:
> > On Fri, Jan 7, 2011 at 3:25 AM, Guenter Roeck
> > <guenter.roeck@ericsson.com> wrote:
> >> On Thu, 2011-01-06 at 15:21 -0500, Mark Brown wrote:
> >>> On Thu, Jan 06, 2011 at 07:04:30AM -0800, Guenter Roeck wrote:
> >>> > On Thu, Jan 06, 2011 at 07:07:13AM -0500, Mark Brown wrote:
> >>>
> >>> > > Why? =A0It's not like hwmon has an unreasonably large core or=
 similar.
> >>>
> >>> > Because it creates an unnecessary dependency, and because it is=
 not hwmon's
> >>> > responsibility to provide infrastructure for other subsystems o=
r drivers.
> >>>
> >>> hwmon isn't really doing anything, though. =A0The *driver* is doi=
ng
> >>> something but it doesn't really impact the core that much. =A0Not=
 that I'm
> >>> particularly sold on putting the ADC core in here, but total NACK=
 based
> >>> on that alone seems rather harsh.
> >>
> >> Possibly. However, I had suggested the following earlier (to the 1=
st
> >> version of the patch):
> >>
> >>> I commented on this a couple of times below - the driver mixes ge=
neric
> >>> ADC reading functions with hwmon functionality. Generic ADC readi=
ng
> >>> functionality should be moved into another driver, possibly to mf=
d.
> >>
> >> Obviously that was ignored. Maybe someone is willing to listen thi=
s time
> >> around.
> >>
> > I am sorry for not responding on the generic ADC handling part. Sin=
ce many
> > other ADC drivers are part of hwmon i thought hwmon was the appropr=
iate
> > place. However I can surely split the generic ADC handling part in =
mfd and
> > only hardware monitoring part in hwmon as suggested.
> >
> >> I won't let people break modularity just for convenience in a subs=
ystem
> >> I am responsible for. And forcing the hwmon subsystem, and with it=
 a
> >> specific hwmon driver, to exist just because the adc functionality=
 it
> >> provides is needed by some other (most likely unrelated) subsystem=
 /
> >> driver _does_ break modularity. Worse, it is completely unnecessar=
y to
> >> do so. Other twl4030 functionality was extracted into generic code=
=2E
> >> twl-core.c, twl4030-codec.c, twl4030-irq.c, twl4030-power.c are al=
l in
> >> mfd. I fail to see the problem with mfd/twl4030-adc.c.
> >>
> >> Guenter
> >>
> >>
> >>
> >
> > Hello Samuel,
> >
> > Is it ok to have the generic ADC functionality in mfd as a separate=
 file?
> >
> > Regards,
> > Keerthy
> >
>=20
> Hello Samuel,
>=20
> We need your valuable inputs. Can generic ADC functionality can be in
> mfd as a separate file?
If it's really generic and doesn't mix hwmon stuff in the middle, then =
yes.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
