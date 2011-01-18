From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC+CFT] Use word operations in bitops
Date: Tue, 18 Jan 2011 15:43:44 +0000
Message-ID: <20110118154344.GG10997@n2100.arm.linux.org.uk>
References: <20110116121911.GB27542@n2100.arm.linux.org.uk> <20110117100857.GS6917@pengutronix.de> <20110117104618.GB18626@n2100.arm.linux.org.uk> <20110118153257.GA10686@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:35955 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229Ab1ARPp6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jan 2011 10:45:58 -0500
Content-Disposition: inline
In-Reply-To: <20110118153257.GA10686@pengutronix.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

On Tue, Jan 18, 2011 at 04:32:57PM +0100, Uwe Kleine-K=F6nig wrote:
> Hi Russell,
>=20
> On Mon, Jan 17, 2011 at 10:46:18AM +0000, Russell King - ARM Linux wr=
ote:
> > On Mon, Jan 17, 2011 at 11:08:57AM +0100, Uwe Kleine-K=F6nig wrote:
> > > On Sun, Jan 16, 2011 at 12:19:11PM +0000, Russell King - ARM Linu=
x wrote:
> > > > This does need a fair amount of testing before it can be merged=
, so I'd
> > > > like to see a number of Tested-by's against this patch.  Please=
 also
> > > > indicate whether you tested on LE or BE or both, which filesyst=
ems, and
> > > > whether they were read-only mounted or read-write mounted.
> > > You could make life a bit easier (at least for us at Pengutronix,
> > > probably more) if you had a branch with a defined name for patche=
s like
> > > these.  We could add that to our daily test then.
> >=20
> > No, because then it's not possible to properly tie down what has be=
en
> > tested and what hasn't.
> >=20
> > The advantage of emailed patches is that when people reply to them,=
 you
> > have a better idea that the patch to which they're replying to is t=
he
> > one they tested.
> >=20
> > Such as in this case where the follow-up patch hasn't received any
> > replies, and so I can't add the one received tested-by to the follo=
w-up
> > patch.  With the git approach, I wouldn't know what was tested unle=
ss
> > you included the commit IDs each time.
> >=20
> > And let's face it - if it was tested daily, are you going to go thr=
ough
> > the hastle of digging out the commit IDs and emailing each day to s=
ay
> > what was tested?  That sounds to me like a _lot_ more work than tes=
ting
> > the occasional emailed patch.
> I maybe wouldn't report each success, I would report if my test fails=
=2E
> You can consider this more or less valuable. Still I think given the
> ease this could be done it's worth it.
>=20
> That's how linux-next works, too.

And linux-next is an extremely poor test of whether a patch is correct
or not.  It's a good test of whether there's any merge issues between
trees and that's all.

The point of posting patches to mailing lists is to get them:
(a) reviewed, and add Reviewed-by/Acked-by attributes to them
(b) get them tested by other people and successes reported back,
    as well as failures.

You don't get (b) from any automated test system, and (b) is what I'm
after.  It's completely pointless to throw them into some sort of branc=
h
which gets automatically tested if there's no positive feedback coming
from such a test.

It gives nothing more than just throwing them at linux-next and listeni=
ng
for the resounding silence.  I personally have never had anyone say "I
tested your patch X in linux-next and it really worked for me".  It jus=
t
doesn't happen.  And so it's useless as a system for testing the qualit=
y
of patches.

I have had the extremely _rare_ report that something has broken in
linux-next, but on the whole those virtually never happen even when the=
re
has been breakage.  See the recent breakage of OMAP with the sched_cloc=
k()
fixes, which had been sitting in linux-next for about a week with no on=
e
noticing.

So, no, I give zero value to automatic test systems as a means to ascer=
tain
the quality of patches.  Their *only* use is as a tool to check whether
a particular combination of patches builds.  Nothing more.

I will continue to mail out patches which I want people to test and giv=
e
feedback on, because that is the _only_ way to do it.
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
