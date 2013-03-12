From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: IS_ERR_VALUE()
Date: Tue, 12 Mar 2013 22:18:50 +0100
Message-ID: <20130312211850.GT15375@pengutronix.de>
References: <20130312141604.GV4977@n2100.arm.linux.org.uk>
 <20130312195659.GR15375@pengutronix.de>
 <20130312202237.GH30923@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54312 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755685Ab3CLVSz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 12 Mar 2013 17:18:55 -0400
Content-Disposition: inline
In-Reply-To: <20130312202237.GH30923@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hello Russell,

On Tue, Mar 12, 2013 at 08:22:38PM +0000, Russell King - ARM Linux wrot=
e:
> On Tue, Mar 12, 2013 at 08:56:59PM +0100, Uwe Kleine-K=F6nig wrote:
> > Hello,
> >=20
> > On Tue, Mar 12, 2013 at 02:16:04PM +0000, Russell King - ARM Linux =
wrote:
> > > I am removing almost all references to the above macro from arch/=
arm.
> > > Many of them are wrong.  Some of them are buggy.
> > >=20
> > > For instance:
> > >=20
> > > int gpmc_cs_set_timings(int cs, const struct gpmc_timings *t)
> > > {
> > >         int div;
> > >         div =3D gpmc_calc_divider(t->sync_clk);
> > >         if (div < 0)
> > >                 return div;
> > > static int gpmc_set_async_mode(int cs, struct gpmc_timings *t)
> > > {
> > > ...
> > >         return gpmc_cs_set_timings(cs, t);
> > >=20
> > > .....
> > >         ret =3D gpmc_set_async_mode(gpmc_onenand_data->cs, &t);
> > >         if (IS_ERR_VALUE(ret))
> > >                 return ret;
> >=20
> > Well, gpmc_calc_divider returns -1 on failure, so I agree that it's
> > wrong to use IS_ERR_VALUE on it.
>=20
> So what you've just told me is that on error, it returns -1, which is
> -EPERM.  So we end up passing an "Operation not permitted" error up?
> Yes, really, -EPERM all the way up and returning it as an error code
> for an out of range divisor value.
>=20
> Is that really appropriate.  How many times have I said to never use
> -1 as an error value?  See what a screwed situation this causes?  See
> what *not* having a clear policy on this in your mind causes?
We agree here that -1 is a bad idea. So I take this "your" as "the
author's".

> If you always treat -ve values as errors, and _always_ return a -ve
> error number as defined in the errno.h headers, then you won't ever
> make this mistake.
>=20
> > Still I don't get what is really wrong in your examples (but I didn=
't
> > check all). If a function returning an int is supposed to return 0 =
on
> > success and -ESOMEERROR on failure it doesn't matter much if I do (=
ret <
> > 0) or IS_ERR_VALUE(ret). (Even if ret is signed, the check (x) >=3D
> > (unsigned long)-MAX_ERRNO in IS_ERR_VALUE does the right thing.)
> >=20
> > There is only a semantical difference between the two checks for
> > (unsigned)ret being between MAX_INT+1 and (unsigned)-MAX_ERRNO. But=
 a
> > value in this range isn't allowed for such a function. So you could=
 also
> > just check using "if (ret)". All but the previous sentence also app=
ly to
> > functions returning an int >=3D0 on success and -ESOMEERROR on fail=
ure.
> >=20
> > So unless I missed something---and if I do, please tell me---your p=
atch
> > is not about correctness, but "only" about style and consistency?!
>=20
> So what about if the function returns a -ve number outside of MAX_ERR=
NO?
Then it's a bug in this function.

> We have an inconsistent situation then - we have some functions
> believing that it's an error, others believing it's not an error.
If my function calls a buggy function I think it doesn't matter for the
correctness of my function if there is an inconsistent situation after
the buggy call.

So in my opinion the fix goes to the called function. Still this doesn'=
t
(and shouldn't) stop a patch like yours that adds consistency.

> So, it _is_ about correctness _and_ consistency.  Not style.  Style
> doesn't come into this.  See where I've replied above about the
> importance of having this stuff clear and always doing it the same
> way.
>=20
> As soon as you start messing around doing crap like this, then you
> start allowing minor bugs to creap in.
>=20
> If you want buggy software, go and develop for Windows or something
> else.
>=20
> You clearly don't know me either.  I strive for correctness.  When
> fixing a bug, I want the bug fixed, not some sticky plaster over it.
> I hate crap like this where there's stupid idiotic differences just
> because of no good reason what so ever, which then lead to subtle
> bugs.  If you start out with a clear idea at the beginning then
> you'll be a far better coder and you'll make less mistakes.  And you
> won't mess up your error checking.
>=20
> It's people with my kind of attitude on this issue which keeps stuff
> sane and maintainable in the kernel.
I think to understand that your goal is to use the same pattern for all
functions unless it's not sensible. And yes, that's important for a
project with that many contributors.

Still if I had authored your patch I wouldn't call the usage "wrong" as
you did in your changelog. I would have written about consistency.

=46or writing my mail I looked around a bit in other areas of the kerne=
l.
I think there are many more instances to fix. E.g. drivers/base/core.c
is full of "if (retval)", "if (error)" and "if (err)".

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
