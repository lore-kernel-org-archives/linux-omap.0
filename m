From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] v4l2_device/v4l2_subdev: final (?) version
Date: Sun, 30 Nov 2008 21:34:06 -0800
Message-ID: <200811302134.07166.david-b@pacbell.net>
References: <200811291852.41794.hverkuil@xs4all.nl> <1228013385.4615.143.camel@palomino.walls.org> <200811301152.50971.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp124.sbc.mail.sp1.yahoo.com ([69.147.64.97]:40181 "HELO
	smtp124.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750714AbYLAFeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 00:34:10 -0500
In-Reply-To: <200811301152.50971.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>, Andy Walls <awalls@radix.net>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, linux-kernel@vger.kernel.org

On Sunday 30 November 2008, Hans Verkuil wrote:
> > On a more philosophical note is GPIO really a single subdev or a
> > collection of independent serial & discrete buses to a collection o=
f
> > subdevs? =A0In cx18 depending on the board, GPIO can reset chips,
> > change audio mux paths, change the state of LED's, and in the futur=
e
> > be used as a serial line (if I ever get that soft-UART to the IR
> > blaster implemented).
>=20
> Definitely a collection of subdevs. Usually each chip driven by GPIO=20
> would have its own subdev. So ivtv implements an audio muxer subdev,=20
> but it might also have additional subdevs for other chips connected t=
o=20
> the GPIO lines. I haven't explored all the possibilities yet, but I=20
> suspect that this can be a quite powerful solution.

Right.  GPIO is basically a glue tech ... the focus should be what's
being glued (the various subdevs, and their parents), not on the glue.
I think a standardized set of GPIO calls, and gpiolib, makes that a
lot easier nowadays; though maybe not always painless.

Keeping to the V4L2 topic:  I figure there will be some issues there
to sort out.  For example, it might be important to collect key
resources like GPIOs and regulators before setting up the various I2C
clients that rely on those for proper operation, or other parts of a
complex V4L2 "assembly" (to coin a term).  I understand that in some
cases those GPIOs are provided through I2C-based expanders... such
sequencing issues will become clearer as the $SUBJECT work matures.
(I'd expect the v4l2_device would manage such stuff.)

One widely accessible OMAP example:  the beagleboard.org hardware uses
a GPIO to enable its DVI output, and a regulator that must be enabled
for S-Video output.  Both should be disabled when their output channel
is not in use -- software doesn't handle that yet though! -- and I'd
expect an OMAP3 v4l2_device would understand such board-specific setup
issues.  (Support for that isn't yet in mainline though.)

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
