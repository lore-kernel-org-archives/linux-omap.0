From: Tony Lindgren <tony@atomide.com>
Subject: Re: Pending March patches
Date: Wed, 4 Apr 2007 10:36:52 -0400
Message-ID: <20070404143651.GD29129@atomide.com>
References: <20070403193046.GA24864@atomide.com>
	<20070404.102028.56387043.Hiroshi.DOYU@nokia.com>
	<20070404130449.GB29129@atomide.com>
	<20070404.171005.129442185.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070404.171005.129442185.Hiroshi.DOYU@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [070404 10:06]:
> From: "ext Tony Lindgren" <tony@atomide.com>
> Subject: Re: Pending March patches
> Date: Wed, 4 Apr 2007 09:04:51 -0400
> 
> > > Though I don't know how to deal with dspgw code, I guess, at least,
> > > "mailbox" and "mmu fw" can be merged into mainline?
> > 
> > Yes, ideally we would have DSP power on/off, mailbox, mmu fw in
> > plat-omap.
> > 
> > Then I suggest we move the rest of the DSP code into drivers/dsp/omap.
> > 
> > I don't think we can get the arch/arm/plat-omap/dsp integrated to
> > the mainline. So the chances of getting it integrated would be better
> > under drivers/dsp/omap.
> > 
> > What are your thoughts on that? I'm thinking that we could do it few
> > weeks after 2.6.21 after a stable 2.6.21-omap release.
> 
> Agreed. It would be cleaner and easy to handle other implementation also.

OK. I'll drop the "ARM: OMAP: Add DSP common code" patch from
omap-upstream for now. Then we can put together the minimal DSP init
patch later on for 2.6.23 or something. The omap-upstream queue is
already painfully big :)

What do you think we should keep in plat-omap?

Maybe just something to power up and idle the DSP, and allow using McBSP
for audio?

Tony
