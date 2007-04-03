From: tony@atomide.com
Subject: Re: [PATCH 4/4] ARM: OMAP: Update TSC2301 touchscreen config name
	in board-n800.c
Date: Tue, 3 Apr 2007 15:46:29 -0400
Message-ID: <20070403194626.GB24864@atomide.com>
References: <20070322111502.8988f08a.jarkko.nikula@nokia.com>
	<20070330191344.GJ18375@atomide.com>
	<20070402100511.7f18c104.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070402100511.7f18c104.jarkko.nikula@nokia.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [070402 16:40]:
> On Fri, 30 Mar 2007 15:13:46 -0400
> "ext Tony Lindgren" <tony@atomide.com> wrote:
> 
> > * Jarkko Nikula <jarkko.nikula@nokia.com> [070322 05:17]:
> > > Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> > > ---
> > >  arch/arm/mach-omap2/board-n800.c |    2 +-
> > >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > This is already applied now too.
> > 
> Not correctly :-)
> 
> It seems that you took "commit
> 64e78a98859a4ce028121a6b5d462b504f9b9343" from my first patchset
> changing also TSC2301-mixer config name which was not required for
> latter set.
> 
> This could be corrected by either reverting whole
> 64e78a98859a4ce028121a6b5d462b504f9b9343 and applying only this one:
> 
> http://linux.omap.com/pipermail/linux-omap-open-source/2007-March/009402.html
> 
> or by applying audio config name revert patch I'm attaching here.

Thanks, I've applied the attached patch. I'l need to redo the
omap-upstream queue anyways to try to cut it down a bit...

Tony
