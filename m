From: Tony Lindgren <tony@atomide.com>
Subject: Re: [patch] bugfix: SOUND: SOC: OMAP: Add support for
	Gumstix Overo
Date: Sat, 4 Oct 2008 07:10:06 +0000
Message-ID: <20081004071006.GC30190@muru.com>
References: <200810030811.33484.david-b@pacbell.net>
	<20081003151846.GA9127@sirena.org.uk>
	<200810030837.15131.david-b@pacbell.net>
	<20081003174948.GA17906@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <20081003174948.GA17906@sirena.org.uk>
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

On Fri, Oct 03, 2008 at 06:49:48PM +0100, Mark Brown wrote:
> On Fri, Oct 03, 2008 at 08:37:14AM -0700, David Brownell wrote:
> 
> > So if the only place these are queued is the OMAP tree, and
> > there is no particular objection to the patch, then there'd
> > seem be no issue merging it to the OMAP tree and having it
> > be part of the initial merge-to-mainline...
> 
> Yes, please squash it in with the other changes when you submit the
> twl4030 dependant stuff.

Also, the McBSP changes needed for ASoC are on their way to the
mainline kernel.

Tony
