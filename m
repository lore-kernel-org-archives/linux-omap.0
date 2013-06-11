From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 10/22] mfd/ti_am335x_tscadc: Add DT support
Date: Tue, 11 Jun 2013 18:10:51 +0100
Message-ID: <20130611171051.GA4320@laptop>
References: <1370950268-7224-1-git-send-email-bigeasy@linutronix.de>
 <1370950268-7224-11-git-send-email-bigeasy@linutronix.de>
 <20130611142347.GF29135@zurbaran>
 <51B73756.5010004@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <51B73756.5010004-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>, Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> >> Signed-off-by: Pantelis Antoniou <panto-wVdstyuyKrO8r51toPun2/C9HSW9iNxf@public.gmane.org>
> >> Signed-off-by: Patil, Rachna <rachna-l0cyMroinI0@public.gmane.org>
> >> Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
> >> [bigeasy: module alias, rename to ti,am3359-tscadc as it was teste=
d on
> >>           AM3359]
> > I honestly can't tell if this is a change from the last version of =
your
> > patchset or a description of this patch changes in general.
> > This is cluttering your commit logs, please remove this as well.
>=20
> I took the original patch. Every change I made to it because people
> asked to merge changes into the patch where the problem occurred I
> added it here before my sign-off.
>=20
> In the end I would like not to post a patch with "From: !=3D me" and
> don't make change which the original author did not do. Also dropping
> their authorship isn't nice. What could we agree on?

Generally speaking, if it is necessary to merge various author's
patches into one, then you can the merger will tend to take authorship
of the commit. Note that just because you are the author of the
commit, it doesn't mean you authored the patch.

I also use the rule of thumb that if you make significant changes to a
patch, then you can also assume authorship too. I'll leave the 'how
much is significant' to your own good judgement.

If you're just making a few fixups, then just add your SOB in the
normal way. That should be enough reward for a mere few patch fixes.

Adding little 'I-did-this' notes to the commit log should mostly be
avoided IMO.

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
