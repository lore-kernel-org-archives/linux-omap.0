From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 00/19] OMAP: DSS2 v5 intro
Date: Wed, 11 Nov 2009 10:42:09 -0800
Message-ID: <20091111184208.GC24837@atomide.com>
References: <1257767126-12059-1-git-send-email-tomi.valkeinen@nokia.com>
 <1257856848.21596.753.camel@localhost>
 <1257929140.20378.51.camel@tubuntu.research.nokia.com>
 <1257932641.20378.77.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758448AbZKKSmM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1257932641.20378.77.camel@tubuntu.research.nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>
List-Id: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@nokia.com> [091111 01:43]:
> On Wed, 2009-11-11 at 09:45 +0100, Valkeinen Tomi (Nokia-D/Helsinki)
> wrote:
> > On Tue, 2009-11-10 at 13:40 +0100, Artem Bityutskiy wrote:
> > > Tomi,
> > > 
> > > could you please kindly ask Stephen (CCed) to include the DSS2 tree into
> > > linux-next, because you are going to merge it the next merge window, and
> > > there does not seem to be any blocker for this.
> > > 
> > > Being in linux-next for a while is really important.
> > 
> > Stephen, would this be possible? DSS2 driver is rather big piece of
> > code, even if it's quite isolated, so it would be nice to have it in
> > linux-next.
> > 
> > What does it require from me? A git tree, obviously, but what should it
> > be based on?
> 
> Ah, I just realized that DSS2 patches depend on patches from Tony's
> tree. I guess I should base my tree on top of some Tony's tree that is
> going to linux-next?

Or I can merge them into my for-next if that's OK with everybody. This
merge cycle is a pain for omap as we've moved all the common headers from
include/mach to include/plat.

Tomi should still send a separate pull request for Linus for the
DSS2 patches.

Regards,

Tony
