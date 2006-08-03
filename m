From: tony@atomide.com
Subject: Re: GPMC timings for smc91x on 24xx (WAS: Pending July patches)
Date: Thu, 3 Aug 2006 11:55:18 -0700
Message-ID: <20060803185509.GA5604@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A506F16C69@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A506F16C69@dlee02.ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Woodruff, Richard <r-woodruff2@ti.com> [060803 08:57]:
> > Sure if you take a snapshot of the code and hack it for your board for
> a
> > year the merge back to the current tree is a big pain. If you want to
> > merge something then, you need to allocate the resouces to do that.
> 
> We did make some effort at that time. Our resource window as defined at
> that time wasn't so big.  What we got was, we don't like this, and there
> should only be mach-omap directory and not mach-omap2.  Keeping it all
> in a shared structure at that time meant a higher bar of entry.  After
> more people outside of TI started working on it, it did eventually go to
> OMAP2 + Plat.

Maybe TI should have somebody working on doing the merging? And if
it's done early enough customers would have decent Linux support for new
processors and then only have to deal with writing the board specific device
drivers.
 
> Practically speaking available time is limited.  Perhaps it needs to be
> more but those are not the parameters I set.

I don't think it's reasonable to expect somebody else will take care
of cleaning up TI code except little bits here and there as needed
for own use.
 
> > Product vendors can certainly do their board specific hacks on the
> > common code. Who's saying you have to wait for something instead of
> > doing your own board specific hacks?
> 
> No body waits.
> 
> Better aligning capabilities windows results in more functionality
> getting in.  Having working things evolving would seem to be better for
> many interests.

Yes indeed. How about posting some patches for upcoming processors for
discussion a bit earlier if possible?
 
> OMAP3 isn't so far off.  One of the side goals of my chip centric point
> of view is to look at how OMAP2 went and see if there are any factors
> which can make OMAP3 come in easier (aside from the obvious adding
> resources).  It is pretty safe to say there will be an OMAP3 directory,
> for some reason that wasn't an easy call for OMAP2.  By putting high
> coupling between the chips like was started in OMAP2 means things won't
> move well.

Let me guess... You copy clock.c, gpio.c, dma.c, pm.c, etc to omap3
directory and hack on it to make it work on omap3 and then call it
omap3 and it's totally different from earlier code? :)

AFAIK from chip to chip estimated 60 - 80% of internal omap devices are
same except for the bus address. And maybe some added features. What is
so different with omap3 if you can tell us something?
 
> > > One measure might be I know of several vendors in production of
> OMAP2
> > > chips for over a year using less well structured trees.  I don't
> think
> > > the same can happen from this tree yet.  Now, those less well
> structured
> > > trees many not have been able to exist with out a good branch off
> point
> > > which this tree provides...  balance...
> > 
> > Sure. Then go use your hacked 2.6.10 tree. If you're in a rush you
> must
> > use what's available and hack the available code for your board.
> However
> > somebody needs to look after the integration too. Hack and forget
> > attitude means duplicating the work over and over again. Think about
> > the MMC drivers Linux has seen for example: Because of lack of
> > coordination it was written 3 times for omap.
> 
> Yes, that is true.  And the USB subsystem has been rewritten 3 times
> also.  In some sense that is the way of Linux and why it has evolved
> faster than others.  Like I lobbied it's a balance.

Heh, not quite the same scale of complexity luckily :)
 
> > > Thanks for the good work.
> > 
> > Whatever. Rather thank Komal for all the good work on merging TI code.
> 
> Generally we try and help where we can in this forum.  I do help Komal
> and you and others where I can.  Boards, data clarification, some
> code...

I appreciate all that for sure. But it sure would be nice to have
somebody dedicated to merging code for new processors at TI.
 
> I saw a 2430 patch recently which seemed reasonable which hasn't had
> many comments.  A little tweak here and there and it boots.  What holds
> such things back from being merged?  Many people benefit from it
> working.

>From what I can see it looks pretty good. I just have not had time to
take a look at it yet, sorry. I should have more time now with some
other stuff out of the way. Anyways, compared to LKML we've been
quite fast merging patches in general.

Regards,

Tony
