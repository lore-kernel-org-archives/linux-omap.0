From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH v2] v4l2_device/v4l2_subdev: final (?) version
Date: Sat, 29 Nov 2008 18:56:51 -0800
Message-ID: <200811291856.51900.david-b@pacbell.net>
References: <200811291852.41794.hverkuil@xs4all.nl> <200811291422.20155.david-b@pacbell.net> <200811300006.22080.hverkuil@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:22446 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756166AbYK3C4y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 29 Nov 2008 21:56:54 -0500
In-Reply-To: <200811300006.22080.hverkuil@xs4all.nl>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Linux and Kernel Video <video4linux-list@redhat.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, linux-kernel@vger.kernel.org, Laurent Pinchart <laurent.pinchart@skynet.be>

On Saturday 29 November 2008, Hans Verkuil wrote:
> > > Are there some documented guidelines on when to use BUG_ON?
> >
> > Maybe there should be. =A0I know I've seen flames from Linus on
> > the topic. =A0Basically, treat it like a panic() where the system
> > must stop operation lest it catch fire or scribble all over the
> > (not-backed-up) disk ... if the system can keep running sanely,
> > then BUG() and friends are inappropriate.
>=20
> I think it would be good to have some document about this, since
> from what I've seen from a quick scan I'm not the only one who uses
> it incorrectly. There is no documentation in the asm-generic/bug.h
> header and there is also no documentation on this in the Documentatio=
n
> directory.

=46air enough ... but the basic advice is still going to be "strongly
avoid ever calling BUG()". =20

I'll send a patch along doing that.

- Dave


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
