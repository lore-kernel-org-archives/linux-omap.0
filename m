From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [RFC+CFT] Use word operations in bitops
Date: Tue, 18 Jan 2011 16:32:57 +0100
Message-ID: <20110118153257.GA10686@pengutronix.de>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk>
 <20110117100857.GS6917@pengutronix.de>
 <20110117104618.GB18626@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49367 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604Ab1ARPdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 10:33:04 -0500
Content-Disposition: inline
In-Reply-To: <20110117104618.GB18626@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi Russell,

On Mon, Jan 17, 2011 at 10:46:18AM +0000, Russell King - ARM Linux wrot=
e:
> On Mon, Jan 17, 2011 at 11:08:57AM +0100, Uwe Kleine-K=F6nig wrote:
> > On Sun, Jan 16, 2011 at 12:19:11PM +0000, Russell King - ARM Linux =
wrote:
> > > This does need a fair amount of testing before it can be merged, =
so I'd
> > > like to see a number of Tested-by's against this patch.  Please a=
lso
> > > indicate whether you tested on LE or BE or both, which filesystem=
s, and
> > > whether they were read-only mounted or read-write mounted.
> > You could make life a bit easier (at least for us at Pengutronix,
> > probably more) if you had a branch with a defined name for patches =
like
> > these.  We could add that to our daily test then.
>=20
> No, because then it's not possible to properly tie down what has been
> tested and what hasn't.
>=20
> The advantage of emailed patches is that when people reply to them, y=
ou
> have a better idea that the patch to which they're replying to is the
> one they tested.
>=20
> Such as in this case where the follow-up patch hasn't received any
> replies, and so I can't add the one received tested-by to the follow-=
up
> patch.  With the git approach, I wouldn't know what was tested unless
> you included the commit IDs each time.
>=20
> And let's face it - if it was tested daily, are you going to go throu=
gh
> the hastle of digging out the commit IDs and emailing each day to say
> what was tested?  That sounds to me like a _lot_ more work than testi=
ng
> the occasional emailed patch.
I maybe wouldn't report each success, I would report if my test fails.
You can consider this more or less valuable. Still I think given the
ease this could be done it's worth it.

That's how linux-next works, too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
