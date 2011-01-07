From: Guenter Roeck <guenter.roeck@ericsson.com>
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030
 madc module
Date: Fri, 7 Jan 2011 06:45:12 -0800
Message-ID: <20110107144512.GA14633@ericsson.com>
References: <1294287457-2438-1-git-send-email-j-keerthy@ti.com>
 <20110106053328.GA7489@ericsson.com>
 <20110106120713.GD17184@sirena.org.uk>
 <20110106150430.GA9053@ericsson.com>
 <20110106202142.GC8018@opensource.wolfsonmicro.com>
 <1294350903.9786.103.camel@groeck-laptop>
 <AANLkTinkNNhrq+b5eiE7XrYQUsR2-vVD08btqM81KJA1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from imr3.ericy.com ([198.24.6.13]:57999 "EHLO imr3.ericy.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab1AGOp6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 7 Jan 2011 09:45:58 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinkNNhrq+b5eiE7XrYQUsR2-vVD08btqM81KJA1@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "amit.kucheria@canonical.com" <amit.kucheria@canonical.com>, "mikko.k.ylinen@nokia.com" <mikko.k.ylinen@nokia.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "balajitk@ti.com" <balajitk@ti.com>

On Fri, Jan 07, 2011 at 07:12:13AM -0500, J, KEERTHY wrote:
> On Fri, Jan 7, 2011 at 3:25 AM, Guenter Roeck
> <guenter.roeck@ericsson.com> wrote:
> > On Thu, 2011-01-06 at 15:21 -0500, Mark Brown wrote:
> >> On Thu, Jan 06, 2011 at 07:04:30AM -0800, Guenter Roeck wrote:
> >> > On Thu, Jan 06, 2011 at 07:07:13AM -0500, Mark Brown wrote:
> >>
> >> > > Why? =A0It's not like hwmon has an unreasonably large core or =
similar.
> >>
> >> > Because it creates an unnecessary dependency, and because it is =
not hwmon's
> >> > responsibility to provide infrastructure for other subsystems or=
 drivers.
> >>
> >> hwmon isn't really doing anything, though. =A0The *driver* is doin=
g
> >> something but it doesn't really impact the core that much. =A0Not =
that I'm
> >> particularly sold on putting the ADC core in here, but total NACK =
based
> >> on that alone seems rather harsh.
> >
> > Possibly. However, I had suggested the following earlier (to the 1s=
t
> > version of the patch):
> >
> >> I commented on this a couple of times below - the driver mixes gen=
eric
> >> ADC reading functions with hwmon functionality. Generic ADC readin=
g
> >> functionality should be moved into another driver, possibly to mfd=
=2E
> >
> > Obviously that was ignored. Maybe someone is willing to listen this=
 time
> > around.
> >
> I am sorry for not responding on the generic ADC handling part. Since=
 many
> other ADC drivers are part of hwmon i thought hwmon was the appropria=
te
> place. However I can surely split the generic ADC handling part in mf=
d and
> only hardware monitoring part in hwmon as suggested.
>=20
Other drivers don't _export_ that functionality. Key difference.

Sure, the lis3 driver does, but that should not be in hwmon in the firs=
t place
and is on the way out (if I ever get to do it), and max1111 is just set=
ting
a bad example.

Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
