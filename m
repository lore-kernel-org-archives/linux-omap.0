From: David Brownell <david-b@pacbell.net>
Subject: Re: v4l2_device/v4l2_subdev: please review (PATCH 1/3)
Date: Sat, 29 Nov 2008 11:46:43 -0800
Message-ID: <200811291146.44371.david-b@pacbell.net>
References: <200811242309.37489.hverkuil@xs4all.nl> <200811290034.44340.laurent.pinchart@skynet.be> <200811291519.39549.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:40164 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751306AbYK2Tqq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Nov 2008 14:46:46 -0500
In-Reply-To: <200811291519.39549.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@skynet.be>
Cc: video4linux-list@redhat.com, Trilok Soni <soni.trilok@gmail.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, linux-kernel@vger.kernel.org

On Saturday 29 November 2008, Hans Verkuil wrote:
> > > +And this to go from an i2c_client to a v4l2_subdev struct:
> > > +
> > > +=A0=A0=A0struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
> > > +
> > > +Finally you need to make a command function to make
> > > +driver->command() call the right subdev_ops functions:
> > > +
> > > +static int
> > > +subdev_command(struct i2c_client *client, unsigned cmd, void *ar=
g)
> > > +{=20
> > > +=A0=A0=A0return v4l2_subdev_command(i2c_get_clientdata(client), =
cmd, arg);
> > > +}
> > > +
> > > +If driver->command is never used then you can leave this out.
> > > +Eventually the driver->command usage should be removed from v4l.
> >
> > Should it then be added to the list of features scheduled for remov=
al?
>=20
> No, driver->command is part of the i2c subsystem and we are not the o=
nly=20
> users, so it can't be scheduled for removal.

ISTR that the only use of the i2c_driver.command() mechanism
is for video/DVB driver support.  It's kind of an ugly wart,
and it'd be good to see such ioctl-ish interfaces vanish.

This came up a while back as part of a "how can we clean up
the I2C stack" discussion.  So it would be nice if V4L2 wasn't
effectively adding new reasons (and advice) to use this.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
