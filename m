From: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: am335x: TSC & ADC reworking including DT pieces, take 4
Date: Tue, 11 Jun 2013 18:10:54 +0200
Message-ID: <20130611161054.GJ29135@zurbaran>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <20130611142358.GG29135@zurbaran>
 <51B74252.5090906@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51B74252.5090906-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hi Sebastian,

On Tue, Jun 11, 2013 at 05:29:22PM +0200, Sebastian Andrzej Siewior wro=
te:
> > Then, this is a pretty big patchset, with iio, input and mfd all mi=
xed
> > together and it is likely to create merge conflicts.
> They somehow depend on each other. Otherwise I would have sent three
> series, one per subsystem.
Of course they depend on each other, but the dependency is mostly for
iio and input to depend on the MFD changes.


> >>From what I can see from it, and please correct me if I'm
> > wrong, the iio and input changes depend on the mfd ones, and not th=
e
> > other way around. If that's so, I'm going to ask you to reshuffle y=
our
> > patch set and separate the MFD changes from the iio and input ones.=
 I'll
> > take the MFD ones and will create an immutable branch for Jonathan =
and
> > Dmitry to pull from and apply the iio and input changes on top of i=
t.
> > Merge conflicts should be mostly avoided that way.
> > AFAICT, only patch #2 should be kept with input and iio bits mixed
> > together with MFD as otherwise this would introduce functional brea=
kage.
> > Otherwise, all MFD bits from the other patches could be either sepa=
rated
> > or merged together (e.g. MFD bits from patches #6 and #8, and #16 a=
nd
> > #17).
> >=20
> > Does that sound doable to you ?
>=20
> The device renaming shouldn't matter since I added DT nodes for the m=
fd
> child devices earlier. But then the of_compatible assignments should
> go hand in hand. However if I split this then the driver won't work
> but then it does not now as well (because there is no platform_data
> provider in tree).
>=20
> Still. There is #18 which reworks the "step addressing" and involves
> changes in both (iio & input) at the same time.
Would splitting iio and input break anything there ?


> There is #21. Adding this to the initial "DT support" patch would be =
bad
> I think because it requires some changes on the iio side which have
> nothing to do with DT. Putting the iio changes before DT would requir=
e
> to make some change to platform-data part which will go away anyway.
Wouldn't it workif you split this one into an MFD+dts file changes and
another one for the iio changes ?

=20
> So I started collecting ACKs from input and iio to avoid this split. =
If
> you really want the split then I will start doing so=E2=80=A6
I think it would be nicer, yes.

Cheers,
Samuel.

--=20
Intel Open Source Technology Centre
http://oss.intel.com/
