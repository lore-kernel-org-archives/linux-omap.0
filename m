From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] OMAP: USB EHCI: Support final revision of USB board
Date: Thu, 18 Sep 2008 13:29:03 -0700
Message-ID: <200809181329.04429.david-b@pacbell.net>
References: <FCCFB4CDC6E5564B9182F639FC35608701982C85CE@dbde02.ent.ti.com> <200809181222.54393.david-b@pacbell.net> <5A47E75E594F054BAF48C5E4FC4B92AB02C4007ED9@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:43234 "HELO
	smtp109.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755065AbYIRU3J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Sep 2008 16:29:09 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02C4007ED9@dbde02.ent.ti.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Greg KH <greg@kroah.com>

On Thursday 18 September 2008, Gadiyar, Anand wrote:
> >		(Hint for TI folk: =A0why not write the
> > code that way in the first place, avoiding all the delays inherent =
in
> > writing code you *know* is unsuitable for merging to mainline?)
>=20
> Well, there are only a limited number of hours in a day. :)

Bzip2 is a good way to compress things ... can that help
make those hours more productive?  ;)


> Hint taken: that that code was initially written badly is a valid poi=
nt.

And likewise, I think, that it's not an uncommon way for
things to start out.  The real problem is that such code
then sits in some (OMAP) tree for a long time and never gets
fixed and sent upstream.

One TI engineer (who I won't name!) said to me this year
that he thinks the issue is part of TI's current process.
Paraphrasing:  the code is treated as "done" when it merges
to some OMAP branch ... *NOT* when it goes upstream.  To the
extent that's true, it should get fixed.  For drivers, there
should be no problems doing so.  (Infrastructure is often a
bit different.)


> But fixing it up is a non-trivial effort as is making sure it works. =
At the time I=20
> wrote that e-mail (August 25) I did intend to have it out well before=
 Felipe's
> 11 September plan.
>=20
> As they say, the best laid plans of mice and men... At the moment it =
does
> not look like I'll be able to do this anytime soon.

Right.  That happens.

=20
> And if it's going upstream, it needs to be in better shape than it cu=
rrently is.
>=20
> Even assuming that linux-usb decides to take it in it's current shape=
, it's=20
> definitely not going to help things when the OHCI driver comes in. An=
d if
> I'm going to be doing that cleanup anyway, I might as well get it rig=
ht the
> first time. Correct?

Unless that stretches the EHCI merge out too much.  Drivers sitting
around outside of mainline for a long time (a year or more) make
trouble.  Updates to mainline generally don't make trouble.

=20
> I'm going to be re-arranging this code, writing it the way it ought t=
o have
> been the first time. But please don't expect this tomorrow.

No, I'm not ... as I noted!  Though I'd hope it's ready to push upstrea=
m
in the 2.6.29-rc0 window...

I'm just piling on with a few observations about a process problem here=
=2E
We've seen versions of this for a long time now.  Once you achieve that
re-arrangement ... it'd be nicer all around (for you, for me, for every=
one)
if the problem came up less regularly in the future.

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
