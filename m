From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch] bugfix: SOUND: SOC: OMAP: Add support
	for	Gumstix Overo
Date: Mon, 6 Oct 2008 09:48:08 +0300
Message-ID: <20081006064806.GE14042@atomide.com>
References: <200810030811.33484.david-b@pacbell.net>
	<20081003151846.GA9127@sirena.org.uk>
	<200810030837.15131.david-b@pacbell.net>
	<20081003174948.GA17906@sirena.org.uk>
	<20081004071006.GC30190@muru.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20081004071006.GC30190@muru.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: David Brownell <david-b@pacbell.net>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [081004 10:36]:
> On Fri, Oct 03, 2008 at 06:49:48PM +0100, Mark Brown wrote:
> > On Fri, Oct 03, 2008 at 08:37:14AM -0700, David Brownell wrote:
> > 
> > > So if the only place these are queued is the OMAP tree, and
> > > there is no particular objection to the patch, then there'd
> > > seem be no issue merging it to the OMAP tree and having it
> > > be part of the initial merge-to-mainline...
> > 
> > Yes, please squash it in with the other changes when you submit the
> > twl4030 dependant stuff.

I've pushed Dave's fix into linux-omap tree.

> Also, the McBSP changes needed for ASoC are on their way to the
> mainline kernel.
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
