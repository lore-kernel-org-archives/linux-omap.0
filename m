From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 2/2] TVP514x Driver with Review comments fixed
Date: Sat, 29 Nov 2008 00:21:07 +0530
Message-ID: <19F8576C6E063C45BE387C64729E739403E904ECE6@dbde02.ent.ti.com>
References: <200811280852.22711.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55729 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752619AbYK1Svi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Nov 2008 13:51:38 -0500
In-Reply-To: <200811280852.22711.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "video4linux-list@redhat.com" <video4linux-list@redhat.com>, "davinci-linux-open-source-bounces@linux.davincidsp.com" <davinci-linux-open-source-bounces@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Jadav, Brijesh R" <brijesh.j@ti.com>, "Shah, Hardik" <hardik.shah@ti.com>, "Hadli, Manjunath" <mrh@ti.com>, "R, Sivaraj" <sivaraj@ti.com>, "Karicheri, Muralidharan" <m-karicheri2@ti.com>



Thanks,
Vaibhav Hiremath

> -----Original Message-----
> From: David Brownell [mailto:david-b@pacbell.net]
> Sent: Friday, November 28, 2008 10:22 PM
> To: Hiremath, Vaibhav
> Cc: video4linux-list@redhat.com; davinci-linux-open-source-
> bounces@linux.davincidsp.com; linux-omap@vger.kernel.org; Jadav,
> Brijesh R; Shah, Hardik; Hadli, Manjunath; R, Sivaraj; Karicheri,
> Muralidharan
> Subject: Re: [PATCH 2/2] TVP514x Driver with Review comments fixed
>=20
> On Friday 28 November 2008, hvaibhav@ti.com wrote:
> > +=A0=A0=A0=A0=A0=A0=A0for (; next->token !=3D TOK_TERM; next++) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (next->token =3D=3D=
 TOK_DELAY) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0schedule_timeout(msecs_to_jiffies(next-
> >val));
>=20
> 			msleep(next->val);
>=20
> would be clearer and more conventional.
>=20
>=20
[Hiremath, Vaibhav] Yes, verified the implementation of msleep. It does=
 the same thing what I am doing. Good to change.

> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0continue;
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
>=20
>=20
> > +static int
> > +tvp514x_probe(struct i2c_client *client, const struct
> i2c_device_id *id)
> > +{
> > +=A0=A0=A0=A0=A0=A0=A0struct tvp514x_decoder *decoder =3D &tvp514x_=
dev;
> > +=A0=A0=A0=A0=A0=A0=A0int err;
> > +
> > +=A0=A0=A0=A0=A0=A0=A0if (i2c_get_clientdata(client))
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return -EBUSY;
> > +
>=20
> When no driver is bound to the client, clientdata is undefined.
> So just strike that ... you can rely on probe() only being
> called on un-bound drivers.
>=20
>=20
[Hiremath, Vaibhav] I am not an expert in I2C, will get back to you on =
this.

> I still don't see any post-reset chip init being done.  The data
> sheets for the tvp5146 and tvp5147 say that after reset, some
> commands must be sent ... that's not being done here.  Are you
> assuming perhaps tvp5146m2 and tvp5147m1, although they are not
> listed as chips supported by this driver?  (That's a repeat of
> a previous review comment, which garnered no response, so the
> $SUBJECT is inaccurate:  at least some review comments have not
> yet been addressed...)
>=20
[Hiremath, Vaibhav] Thanks pointing me to this, I was not aware of this=
 thing. Two same ID chips (0x46) require different reset sequence. May =
be overlooked this part due to ID.

Will have to now think how to differentiate between these two chips and=
 handle this sequence.

> - Dave
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
