From: Tony Lindgren <tony@atomide.com>
Subject: Re: musb CaMeLcAsEnOmOre (was: (no subject))
Date: Tue, 14 Aug 2007 01:55:47 -0700
Message-ID: <20070814085547.GD13183@atomide.com>
References: <11870129672745-git-send-email-tony@atomide.com>
	<200708140106.25659.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <200708140106.25659.david-b@pacbell.net>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: David Brownell <david-b@pacbell.net>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [070814 01:06]:
> On Monday 13 August 2007, Tony Lindgren wrote:
> > As the musb/tusb code now mostly works for host and peripheral,
> > I'm planning to push a series of search and replace patches
> > to start converting the musb/tusb driver into something that
> > follows CodingStyle.
> 
> This is pretty much for *variables* now not types, yes?

Yeah. I mostly went through the musb common .h files and
got rid of the camelCasingThere.

> I thought the types were mostly changed already.  And some of
> the variables (and struct members) but not all.

Yes, some DMA types needed converting still. There's still some
more search and replace left to do.

> Sounds OK to me.

Will push them today then. If anybody has pending musb patches,
it should be trivial to search and replace in the patch.

Tony
