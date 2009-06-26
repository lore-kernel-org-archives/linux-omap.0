From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: v4l2_int_device vs v4l2_subdev?
Date: Fri, 26 Jun 2009 08:30:19 +0200
Message-ID: <200906260830.20193.hverkuil@xs4all.nl>
References: <4A43FD77.1020709@mlbassoc.com> <5e9665e10906252227i4f667915rc1b52d6148c1a0e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <5e9665e10906252227i4f667915rc1b52d6148c1a0e9@mail.gmail.com>
Content-Disposition: inline
Sender: linux-media-owner@vger.kernel.org
To: "Dongsoo, Nathaniel Kim" <dongsoo.kim@gmail.com>
Cc: Gary Thomas <gary@mlbassoc.com>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Friday 26 June 2009 07:27:15 Dongsoo, Nathaniel Kim wrote:
> Hello,
>=20
> On Fri, Jun 26, 2009 at 7:43 AM, Gary Thomas<gary@mlbassoc.com> wrote=
:
> > Still trying to wrap my head around the OMAP/34xx camera support.
> > I need to use the TVP5150 sensor/controller, but the existing
> > driver uses v4l_subdev. =A0The "working" examples I've found
> > (from Sergio's tree) use sensors like ov3640 with uses v4l2_int_dev=
ice
> >
> > Are these two totally separate beasts?
> > If I have an infrastructure (I assume) based on v4l2_int_device,
> > how do I use a v4l2_subdev device driver? =A0or need I move one to
> > the other?
> >
>=20
> I've been through the same case (now I'm trying to use subdev
> framework and writing a new device driver based on that)
> As far as I understand, every v4l2 drivers are moving on subdev
> framework.

That's right. There were three different incompatible interfaces betwee=
n
the host and an i2c device. This made it impossible to reuse e.g. a sen=
sor
driver based on v4l2-int-device for omap in a USB webcam based around
the old i2c-ioctl interface. The v4l2_subdev interface was created that
will replace all these other interfaces. We will not accept new
non-v4l2-subdev drivers in the kernel, and we are working hard to conve=
rt
the last remaining non-v4l2-subdev drivers as soon as possible.

> But in user space there is nothing changed having access to=20
> device and control them.
> As you know, subdev and int-device is all about how to bind
> interface(or host?) and device and make them communicated each other.
> But using subdev device driver with int-device supporting interface
> (or host) device driver? it won't make any communication.
> So if you are running out of time with your project, you'd better use
> old driver of TVP. Like TVP driver in kernel 2.6.28 I suppose. But if
> you have enough time and wanna be challenging, try to convert
> in-device based omap3 camera interface driver to subdev supporting
> one.

Someone's got to do this. v4l2_subdev is the future and it has many
advantages over the older interfaces. The ability to be able to use the
same i2c driver in anything from USB webcams to PCI capture cards to
omap/davinci embedded platforms is very powerful.

Regards,

	Hans

> Cheers,
>=20
> Nate
>=20
>=20
> > ... dizzy from traveling down too many twisty little passages :-(
> >
> > --
> > ------------------------------------------------------------
> > Gary Thomas =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0Consulting for the
> > MLB Associates =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0Embedded world
> > ------------------------------------------------------------
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-oma=
p" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
>=20
>=20
>=20



--=20
Hans Verkuil - video4linux developer - sponsored by TANDBERG Telecom
--
To unsubscribe from this list: send the line "unsubscribe linux-media" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
