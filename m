From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending April patches
Date: Thu, 3 May 2007 16:44:02 +0000
Message-ID: <20070503164401.GF28985@atomide.com>
References: <46374339.4030102@googlemail.com>
	<20070502084714.4a23397d.jarkko.nikula@nokia.com>
	<57314e840705012317m45e2d42y3120f2247393d8f7@mail.gmail.com>
	<5d5443650705020134n55148159i4d30a35b12695a66@mail.gmail.com>
	<57314e840705020149v194e4807j886a7efaa15f324@mail.gmail.com>
	<5d5443650705020246v3e4427b9t9290d3e18de4ff4b@mail.gmail.com>
	<57314e840705020407q4823911i508d7ad24da47302@mail.gmail.com>
	<20070502172108.GD3520@atomide.com>
	<3B6D69C3A9EBCA4BA5DA60D913027429E55356@dlee13.ent.ti.com>
	<57314e840705022226g26570b06y6040df6ec3462f55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <57314e840705022226g26570b06y6040df6ec3462f55@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Budhee Jamaich <budheej@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Budhee Jamaich <budheej@gmail.com> [070503 05:26]:
> On 5/2/07, Woodruff, Richard <r-woodruff2@ti.com> wrote:
> >The root of all 2.6 trees is kernel.org, then linux-omap tree.  The TI
> >_downloadable_ trees branch off at a point in time as Tony said, usually
> >for pre/new-silicon or other major engagements which are not easily done
> >on the live tree.  Then beyond that you will have vendor trees like
> >MontaVista or WindRiver. These vendors combine aspects off all trees
> >into their final bundles. In cases I'm familiar with these final trees
> >are what go into production in multi-million quantities.
> 
> Thank you so much people for the help.
> I'm really trying to understand the hows the process works, and you really
> help.
> One last questions please:
> What is the process of moving new code from Linus' git tree to
> the linux-omap tree ?
> I bet it is not simple to merge many of Linus' commits..
> Thank you once again and sorry for the questions...

We pull from Linus' tree to linux-omap on regular basis, usually every
time there's a new -rc release or something important gets merged.

Then we try to send all omap patches upstream, so eventually we should
be using Linus' tree + some omap driver patches.

Tony
