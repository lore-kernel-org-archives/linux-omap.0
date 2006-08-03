From: Tony Lindgren <tony@atomide.com>
Subject: Re: GPMC timings for smc91x on 24xx (WAS: Pending July patches)
Date: Thu, 3 Aug 2006 18:00:01 +0300
Message-ID: <20060803145959.GB18147@atomide.com>
References: <EA12F909C0431D458B9D18A176BEE4A506F16A6C@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A506F16A6C@dlee02.ent.ti.com>
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

* Woodruff, Richard <r-woodruff2@ti.com> [060803 17:20]:
> Hello Tony,
> 
> > The reason I did not send h4 smc91x gpmc yet is that we should update
> it
> > to use gpmc_cs_set_timings() to have a nice example available for
> > others :)
> 
> So your reasoning for not including was you want something perfect to
> start with?  That bar seems a bit high especially when what is there is
> broken. The below is pretty nice, I don't know that this approach works
> for all parts which can be connected given the interface, but it should
> work well for many.

Excuse me but Komal's patch is already in the linux-omap tree and usable
with that tree. What we send to the mainline kernel should be the code
we want to live with in the long run.
 
> In general I certainly favor having something which works, then evolving
> it into something nicer.  This can result in cut and past proliferation;
> however there are not that many boards.  Once one is done nicely the
> others can be manually updated with out huge effort.  Which OMAP1 port
> currently uses this style?  If it does at what point did it start doing
> this (probably not the first pass)?

I'm not sure I understand you correctly here. Working code is in linux-omap
tree and once we're happy with it we send it upstream.

Sure if you take a snapshot of the code and hack it for your board for a
year the merge back to the current tree is a big pain. If you want to
merge something then, you need to allocate the resouces to do that.
 
> As far as 2420 vs. 2420POP vs. 2422 vs. 2423 unfortunately early chips
> did not follow a common schema, later ones do, doing things which
> captures them all can be messy.  The mechanism in the OMAP1 port was not
> constructed to work with the multi-stage check which is now necessary.
> This simple example highlights one basic issue.  The current level of
> code sharing as the processors diverge can make it harder to add trivial
> code with out breaking other ones.  This will slow the tree's adoption
> of new chips.  It is hard to say what the sharing balance should be.  If
> chips have a long lifetime then code sharing at the low level seems
> pretty good, if they only live for a couple of years adding some extra
> indirection and maintaining high levels of sharing in the old ones
> starts to lose its value.  Production volume vendor time lines and their
> compromises does force branching and fragmentation.  Perhaps one tree
> can not and should not meet all needs.  Keeping high level interface
> compatibly is really good the level of low level can be less.

Product vendors can certainly do their board specific hacks on the
common code. Who's saying you have to wait for something instead of
doing your own board specific hacks?
 
> One measure might be I know of several vendors in production of OMAP2
> chips for over a year using less well structured trees.  I don't think
> the same can happen from this tree yet.  Now, those less well structured
> trees many not have been able to exist with out a good branch off point
> which this tree provides...  balance...

Sure. Then go use your hacked 2.6.10 tree. If you're in a rush you must
use what's available and hack the available code for your board. However
somebody needs to look after the integration too. Hack and forget
attitude means duplicating the work over and over again. Think about
the MMC drivers Linux has seen for example: Because of lack of
coordination it was written 3 times for omap.
 
> Thanks for the good work.

Whatever. Rather thank Komal for all the good work on merging TI code.

Regards,

Tony
