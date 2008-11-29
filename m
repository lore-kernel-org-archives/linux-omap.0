From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] v4l2_device/v4l2_subdev: final (?) version
Date: Sat, 29 Nov 2008 14:22:19 -0800
Message-ID: <200811291422.20155.david-b@pacbell.net>
References: <200811291852.41794.hverkuil@xs4all.nl> <200811291220.47542.david-b@pacbell.net> <200811292246.20338.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp115.sbc.mail.sp1.yahoo.com ([69.147.64.88]:30438 "HELO
	smtp115.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752895AbYK2WzI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Nov 2008 17:55:08 -0500
In-Reply-To: <200811292246.20338.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@skynet.be>

On Saturday 29 November 2008, Hans Verkuil wrote:
> > > +void v4l2_device_register(struct device *dev, struct v4l2_device=
 *v4l2_dev)
> > > +{=20
> > > +=A0=A0=A0=A0=A0=A0=A0BUG_ON(!dev || !v4l2_dev || dev_get_drvdata=
(dev));
> >
> > Ouch. =A0Better to return -EINVAL, like most register() calls,
> > than *ever* use a BUG_ON() for bad parameters. =A0Same applies
> > every other place you use BUG_ON, from a quick scan ...
>=20
> Are there some documented guidelines on when to use BUG_ON?

Maybe there should be.  I know I've seen flames from Linus on
the topic.  Basically, treat it like a panic() where the system
must stop operation lest it catch fire or scribble all over the
(not-backed-up) disk ... if the system can keep running sanely,
then BUG() and friends are inappropriate.


> I see it used in other places in this way.

I tend to submit patches fixing bugs like that, when I have time.


> My reasoning was that returning an =20
> error makes sense if external causes can result in an error, but this=
=20
> test is more the equivalent of an assert(), i.e. catching a programmi=
ng=20
> bug early.

In which case a WARN() is better.  But in most cases I wouldn't
even do that.  The kernel's design center is closer to "run
robustly" than "make developers' lives easier".  Programmers
who don't check return values for critical operations like
registering core resources deserve what they get.  And if you
want to nudge them, the __must_check annotation helps catch
such goofage even earlier:  compile time, not run time.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
