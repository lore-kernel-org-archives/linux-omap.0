From: Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>
Subject: Re: v4l2_device/v4l2_subdev: please review (PATCH 1/3)
Date: Sun, 30 Nov 2008 14:58:22 +0100
Message-ID: <200811301458.23184.hverkuil@xs4all.nl>
References: <200811242309.37489.hverkuil@xs4all.nl>
	<200811291519.39549.hverkuil@xs4all.nl>
	<Pine.LNX.4.64.0811292002300.8352@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0811292002300.8352-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, video4linux-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, Laurent Pinchart <laurent.pinchart-AgBVmzD5pcezQB+pC5nmwQ@public.gmane.org>, "davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org" <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Saturday 29 November 2008 20:08:44 Guennadi Liakhovetski wrote:
> On Sat, 29 Nov 2008, Hans Verkuil wrote:
> > > > +Introduction
> > > > +------------
> > > > +
> > > > +The V4L2 drivers tend to be very complex due to the complexity
> > > > of the +hardware: most devices have multiple ICs, export
> > > > multiple device nodes in +/dev, and create also non-V4L2
> > > > devices such as DVB, ALSA, FB, I2C and input +(IR) devices.
> > > > +
> > > > +Especially the fact that V4L2 drivers have to setup supporting
> > > > ICs to +do audio/video muxing/encoding/decoding makes it more
> > > > complex than most. +Usually these ICs are connected to the main
> > > > bridge driver through one or +more I2C busses, but other busses
> > > > can also be used. Such devices are +called 'sub-devices'.
> > >
> > > Do you know of other busses being used in (Linux supported) real
> > > video hardware, or is it currently theoretical only ?
> >
> > The pxa_camera driver is one example of that. Also devices driven
> > by GPIO pins can be implemented this way. I did that in ivtv for
> > example: most cards use i2c audio muxers, but some have audio
> > muxers that are commanded through GPIO so I created a v4l2_subdev
> > that uses GPIO to drive these chips. Works very well indeed.
>
> I think pxa-camera (as well as sh-mobile-ceu and other soc-camera
> host drivers in the works) is not a very good example here. Sensors
> connected to embedded controllers like PXA indeed use a dedicated
> camera bus but only for data exchange. This bus comprises of data and
> synchronisation lines only. Sensors are still connected over an i2c
> bus for control and configuration, also been open to other busses, I
> haven't seen such examples as yet. I might have misunderstood what
> has been discussed here though.

I agree that it not the best example, although it is perfectly possible 
to see this as a controller sub-device. Having the same mechanism to 
talk to any type of hardware involved in video capture and display has 
definite advantages.

Once these patches are in I would definitely recommend that people start 
experimenting with them. Also be aware that this is just the first 
step. I'm going to improve on these two fundamental structs 
(v4l2_device and v4l2_subdev) to add much improved support for 
controls. Currently drivers have to spend way too much effort on 
implementing all the control handling code.

And there are many more things one can do with these structures. I'll 
just take it step by step.

Regards,

         Hans

-- 
Hans Verkuil - video4linux developer - sponsored by TANDBERG
