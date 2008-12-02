From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Tue, 2 Dec 2008 12:19:05 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E904F18D@dbde02.ent.ti.com>
References: <200812012238.54240.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50419 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750957AbYLBGti convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Dec 2008 01:49:38 -0500
In-Reply-To: <200812012238.54240.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "davinci-linux-open-source-bounces@linux.davincidsp.com" <davinci-linux-open-source-bounces@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "Hadli, Manjunath" <mrh@ti.com>, "R, Sivaraj" <sivaraj@ti.com>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Tuesday, December 02, 2008 12:09 PM
> To: Hiremath, Vaibhav
> Cc: dbrownell@users.sourceforge.net; video4linux-list@redhat.com;
> davinci-linux-open-source-bounces@linux.davincidsp.com; linux-
> omap@vger.kernel.org; Jadav, Brijesh R; Shah, Hardik; Hadli,
> Manjunath; R, Sivaraj; Karicheri, Muralidharan
> Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
>=20
> On Monday 01 December 2008, Hiremath, Vaibhav wrote:
> > >
> > > Another common use of driver_data is to hold a pointer
> > > to a struct holding chip-specific data that doesn't fit
> > > into a simple bitmask.
> > >
> > [Hiremath, Vaibhav] I am trying to use/save complete init sequence
> in
> > id->driver_data -
> >
> > static const struct i2c_device_id tvp514x_id[] =3D {
> > =A0=A0=A0=A0=A0=A0=A0=A0{"tvp5146", (unsigned int)&tvp5146_init},
>=20
> Well, kernel_ulong_t ...
>=20
> > =A0=A0=A0=A0=A0=A0=A0=A0{"tvp5146m2", (unsigned int)&tvp514xm_init}=
,
> > =A0=A0=A0=A0=A0=A0=A0=A0{"tvp5147", (unsigned int)&tvp5147_init},
> > =A0=A0=A0=A0=A0=A0=A0=A0{"tvp5147m1", (unsigned int)&tvp514xm_init}=
,
> > =A0=A0=A0=A0=A0=A0=A0=A0{},
> > };
> >
> > NOTE: Please note that init sequence for 46, 47 are different.
> >
>=20
> > I prefer to use second option, instead of comparing the name
> string in
> > s_power every time. And it will be very easy to add even more
> chips
> > providing generic solution; we need to just add entry to
> i2c_device_id
> > with expected init sequence and you are done.
>=20
> If I interpret your words correctly, I agree.  The whole point of
> the id table is to let probe just use the "id" directly to get at
> descriptors with chip-specific data.
>=20
> - Dave
>=20
[Hiremath, Vaibhav] We are almost on same page, but you are looking to =
implement this in probe function where we do have "id" straight coming =
as params.
But for the devices like OMAP where power management is critical thing,=
 I want to put the TVP to off state and bring it again whenever require=
d (being used). For this, we do have ioctl interface called " ioctl_s_p=
ower" under V4L2-Int framework.=20

To get the sequence supported for registered chip (46/47/4xM), I need i=
ndex under the I2C_table (client->driver->id_table[index]) which will g=
ive me the driver_data for registered chip.

>=20
> > Any suggestions or inputs appreciated???
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
