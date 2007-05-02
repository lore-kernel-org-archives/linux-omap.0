From: Tony Lindgren <tony@atomide.com>
Subject: Re: [linux-pm] [PATCH] power management: remove some useless code
	from arm platforms
Date: Wed, 2 May 2007 03:48:33 +0000
Message-ID: <20070502034833.GC27201@atomide.com>
References: <1177604177.6814.81.camel@johannes.berg> <463115BA.70505@gmail.com>
	<20070427175327.d8739c5c.akpm@linux-foundation.org>
	<20070428034137.GA7200@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <20070428034137.GA7200@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, Johannes Berg <johannes@sipsolutions.net>, linux-omap-open-source@linux.omap.com, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [070428 03:41]:
> Hi,
> 
> * Andrew Morton <akpm@linux-foundation.org> [070428 00:53]:
> > On Fri, 27 Apr 2007 01:12:26 +0400
> > Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com> wrote:
> > 
> > > Johannes Berg wrote:
> > > > This patch kills some useless code omap1/omap2.
> > > Although the change looks harmless it'd be nice  CC-ing
> > > appropriate "arch" or "mach" lists.
> > > 
> > > Added omap list to CC.
> > > 
> > > BTW, you change OMAP stuff only, so your subject is slightly irrelevant.
> > > 
> > 
> > I'm not very comfortable handling OMAP code (Tony), ARM code (Russell) or
> > power-management code (Greg), and this patch is all three.
> 
> Well this patch will probably cause some minor merge conflicts with the
> pending omap patches, not a big deal though.

Looks like the omap pile still applies fine after Johannes' patches,
so no merge issue there :)

> > So ho hum.  I queued it up with Greg as the arbitrary target, but I'm not
> > sure that is really appopriate.  Probably it should have been Tony, but
> > Tony's tree is hiding from me.
> 
> The omap tree is available at [1] and the currently pending patches
> pile at [2].
> 
> > I guess we should look at dragging the OMAP git tree into -mm.
> 
> I thought Russell is about to apply the pending omap patches to his
> tree, so let's wait until we hear from him.
> 
> Assuming Russell applies the pending omap patches, things should
> be pretty much in sync with the mainline tree and linux-omap tree for
> the core omap support.
> 
> There will be some driver and PM patches that would fit to -mm tree
> though. At least the voltage framework, and possibly the DSP code later
> on, come to mind.
> 
> Regards,
> 
> Tony
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git
> [2] git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-upstream-after-clocksource
