From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: GPMC timings for smc91x on 24xx (WAS: Pending July patches)
Date: Thu, 3 Aug 2006 10:57:38 -0500
Message-ID: <EA12F909C0431D458B9D18A176BEE4A506F16C69@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

> Sure if you take a snapshot of the code and hack it for your board for
a
> year the merge back to the current tree is a big pain. If you want to
> merge something then, you need to allocate the resouces to do that.

We did make some effort at that time. Our resource window as defined at
that time wasn't so big.  What we got was, we don't like this, and there
should only be mach-omap directory and not mach-omap2.  Keeping it all
in a shared structure at that time meant a higher bar of entry.  After
more people outside of TI started working on it, it did eventually go to
OMAP2 + Plat.

Practically speaking available time is limited.  Perhaps it needs to be
more but those are not the parameters I set.

> Product vendors can certainly do their board specific hacks on the
> common code. Who's saying you have to wait for something instead of
> doing your own board specific hacks?

No body waits.

Better aligning capabilities windows results in more functionality
getting in.  Having working things evolving would seem to be better for
many interests.

OMAP3 isn't so far off.  One of the side goals of my chip centric point
of view is to look at how OMAP2 went and see if there are any factors
which can make OMAP3 come in easier (aside from the obvious adding
resources).  It is pretty safe to say there will be an OMAP3 directory,
for some reason that wasn't an easy call for OMAP2.  By putting high
coupling between the chips like was started in OMAP2 means things won't
move well.

> > One measure might be I know of several vendors in production of
OMAP2
> > chips for over a year using less well structured trees.  I don't
think
> > the same can happen from this tree yet.  Now, those less well
structured
> > trees many not have been able to exist with out a good branch off
point
> > which this tree provides...  balance...
>=20
> Sure. Then go use your hacked 2.6.10 tree. If you're in a rush you
must
> use what's available and hack the available code for your board.
However
> somebody needs to look after the integration too. Hack and forget
> attitude means duplicating the work over and over again. Think about
> the MMC drivers Linux has seen for example: Because of lack of
> coordination it was written 3 times for omap.

Yes, that is true.  And the USB subsystem has been rewritten 3 times
also.  In some sense that is the way of Linux and why it has evolved
faster than others.  Like I lobbied it's a balance.

> > Thanks for the good work.
>=20
> Whatever. Rather thank Komal for all the good work on merging TI code.

Generally we try and help where we can in this forum.  I do help Komal
and you and others where I can.  Boards, data clarification, some
code...

I saw a 2430 patch recently which seemed reasonable which hasn't had
many comments.  A little tweak here and there and it boots.  What holds
such things back from being merged?  Many people benefit from it
working.

Regards,
Richard W.
