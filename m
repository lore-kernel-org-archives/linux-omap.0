From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: Re: [PATCH 00/19] OMAP: DSS2 v5 intro
Date: Wed, 11 Nov 2009 11:44:01 +0200
Message-ID: <1257932641.20378.77.camel@tubuntu.research.nokia.com>
References: <1257767126-12059-1-git-send-email-tomi.valkeinen@nokia.com>
	 <1257856848.21596.753.camel@localhost>
	 <1257929140.20378.51.camel@tubuntu.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756244AbZKKJoY@vger.kernel.org>
In-Reply-To: <1257929140.20378.51.camel@tubuntu.research.nokia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, ext Tony Lindgren <tony@atomide.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev-devel@lists.sourceforge.net" <linux-fbdev-devel@lists.sourceforge.net>, "dedekind1@gmail.com" <dedekind1@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wed, 2009-11-11 at 09:45 +0100, Valkeinen Tomi (Nokia-D/Helsinki)
wrote:
> On Tue, 2009-11-10 at 13:40 +0100, Artem Bityutskiy wrote:
> > Tomi,
> > 
> > could you please kindly ask Stephen (CCed) to include the DSS2 tree into
> > linux-next, because you are going to merge it the next merge window, and
> > there does not seem to be any blocker for this.
> > 
> > Being in linux-next for a while is really important.
> 
> Stephen, would this be possible? DSS2 driver is rather big piece of
> code, even if it's quite isolated, so it would be nice to have it in
> linux-next.
> 
> What does it require from me? A git tree, obviously, but what should it
> be based on?

Ah, I just realized that DSS2 patches depend on patches from Tony's
tree. I guess I should base my tree on top of some Tony's tree that is
going to linux-next?

 Tomi
