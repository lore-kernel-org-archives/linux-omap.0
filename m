From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030
 madc module
Date: Fri, 7 Jan 2011 10:44:55 +0000
Message-ID: <20110107104455.GB9209@opensource.wolfsonmicro.com>
References: <1294286200-16446-1-git-send-email-j-keerthy@ti.com>
 <20110106120433.GC17184@sirena.org.uk>
 <AANLkTinuwejAgJ+F0e4LFAhR-gL8bfFmyOwHdSEWAsRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:56430 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751543Ab1AGKoj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 05:44:39 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTinuwejAgJ+F0e4LFAhR-gL8bfFmyOwHdSEWAsRw@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "J, KEERTHY" <j-keerthy@ti.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, linux-omap@vger.kernel.org, amit.kucheria@canonical.com, balajitk@ti.com

On Fri, Jan 07, 2011 at 02:55:45PM +0530, J, KEERTHY wrote:
> On Thu, Jan 6, 2011 at 5:34 PM, Mark Brown
> > On Thu, Jan 06, 2011 at 09:26:40AM +0530, Keerthy wrote:

> >> +static ssize_t madc_read(struct device *dev,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribu=
te *devattr, char *buf)
> >> +{
> >> + =A0 =A0 struct sensor_device_attribute *attr =3D to_sensor_dev_a=
ttr(devattr);

=2E..

> >> + =A0 =A0 return sprintf(buf, "%ld\n", val);

> > Does this return data in the appropriate units - milivolts for volt=
ages?

> This function returns the raw channel values read and not in terms of=
 the
> units.

It needs to convert the values into real world units before they go to
userspace - look at what applications like sensors do with the values.

> >> + =A0 =A0 case TWL4030_MADC_RT:
> >> + =A0 =A0 default:
> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;

> > This looks odd - the function won't actually do anything for non-SW
> > conversions but won't return an error?

> Ok. In the case of RT conversion request no software setting is requi=
red
> and it is signal driven. So the function does nothing in case of RT.

Again, the biggest problem is that the code isn't clear.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
