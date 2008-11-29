From: Hans Verkuil <hverkuil@xs4all.nl>
Subject: Re: v4l2_device/v4l2_subdev: please review (PATCH 1/3)
Date: Sat, 29 Nov 2008 20:53:15 +0100
Message-ID: <200811292053.16121.hverkuil@xs4all.nl>
References: <200811242309.37489.hverkuil@xs4all.nl>
	<200811291519.39549.hverkuil@xs4all.nl>
	<200811291146.44371.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <video4linux-list-bounces@redhat.com>
In-Reply-To: <200811291146.44371.david-b@pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/mailman/private/video4linux-list>
List-Post: <mailto:video4linux-list@redhat.com>
List-Help: <mailto:video4linux-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/video4linux-list>,
	<mailto:video4linux-list-request@redhat.com?subject=subscribe>
Sender: video4linux-list-bounces@redhat.com
Errors-To: video4linux-list-bounces@redhat.com
To: David Brownell <david-b@pacbell.net>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, video4linux-list@redhat.com, linux-kernel@vger.kernel.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Saturday 29 November 2008 20:46:43 David Brownell wrote:
> On Saturday 29 November 2008, Hans Verkuil wrote:
> > > > +And this to go from an i2c_client to a v4l2_subdev struct:
> > > > +
> > > > +=A0=A0=A0struct v4l2_subdev *sd =3D i2c_get_clientdata(client);
> > > > +
> > > > +Finally you need to make a command function to make
> > > > +driver->command() call the right subdev_ops functions:
> > > > +
> > > > +static int
> > > > +subdev_command(struct i2c_client *client, unsigned cmd, void
> > > > *arg) +{
> > > > +=A0=A0=A0return v4l2_subdev_command(i2c_get_clientdata(client), =
cmd,
> > > > arg); +}
> > > > +
> > > > +If driver->command is never used then you can leave this out.
> > > > +Eventually the driver->command usage should be removed from
> > > > v4l.
> > >
> > > Should it then be added to the list of features scheduled for
> > > removal?
> >
> > No, driver->command is part of the i2c subsystem and we are not the
> > only users, so it can't be scheduled for removal.
>
> ISTR that the only use of the i2c_driver.command() mechanism
> is for video/DVB driver support.  It's kind of an ugly wart,
> and it'd be good to see such ioctl-ish interfaces vanish.
>
> This came up a while back as part of a "how can we clean up
> the I2C stack" discussion.  So it would be nice if V4L2 wasn't
> effectively adding new reasons (and advice) to use this.

If v4l is indeed the only user, then once all i2c drivers are converted=20
to this new sub device API, then command can indeed go away.

Would be nice, but it will probably take a few kernel cycles before we=20
are there. It's a lot of work, but very worthwhile in my opinion.

Regards,

	Hans

--=20
Hans Verkuil - video4linux developer - sponsored by TANDBERG

--
video4linux-list mailing list
Unsubscribe mailto:video4linux-list-request@redhat.com?subject=3Dunsubscr=
ibe
https://www.redhat.com/mailman/listinfo/video4linux-list
