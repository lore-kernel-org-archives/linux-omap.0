From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git tree updated
Date: Tue, 8 May 2007 09:26:52 -0700
Message-ID: <20070508162651.GC31967@atomide.com>
References: <20070508031945.GH31968@atomide.com>
	<5d5443650705080505j1a8beb98q279db065fdf9366c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <5d5443650705080505j1a8beb98q279db065fdf9366c@mail.gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Trilok Soni <soni.trilok@gmail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Trilok Soni <soni.trilok@gmail.com> [070508 05:06]:
> Tony,
> 
> On 5/8/07, Tony Lindgren <tony@atomide.com> wrote:
> >Hi all,
> >
> >I've updated our git tree to be in sync with mainline tree as Russell
> >has merged some of our pending patches.
> >
> >Looks like 24xx does not currently boot, it seems to hang at
> >devicemaps_init(). I've verified that at least 16xx boots.
> >
> >I'll have to continue debugging the 24xx devicemaps_init issue tomorrow,
> >if somebody gets it working before that, please post the patch :)
> >
> 
> arch/arm/mach-omap2/io.c seems have some duplication due to merging
> problem it seems.
> I have attached patch to remove those entries.

Ah, thanks, it's that thing again!

OK I need to get it merged in the omap-upstream branch, otherwise
the automerge always seems to mess it up...

Regards,

Tony
