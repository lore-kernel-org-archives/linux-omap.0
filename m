From: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Pull request for OMAP PM, clock, SDRC 2.6.32 patches
Date: Tue, 18 Aug 2009 06:35:38 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0908180621270.7224@utopia.booyaka.com>
References: <alpine.DEB.2.00.0908160737380.31720@utopia.booyaka.com> <20090817170921.GT10764@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20090817170921.GT10764-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-arm-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org, linux-arm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hiroshi.doyu-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Hello Russell,

On Mon, 17 Aug 2009, Russell King - ARM Linux wrote:

> On Sun, Aug 16, 2009 at 07:45:59AM -0600, Paul Walmsley wrote:
> > 
> > Hello Russell,
> > 
> > Here's the pull request for the thirteen patches posted earlier, plus 
> > Hiroshi's clock debugfs error path fix.
> 
> I'm afraid to say that I think you've left it far too late to send this.
> I did set a date of the 16th as being the final date to sort out stuff
> (which was flexible to a degree) but since these patches were only posted
> on Saturday, and they're still being discussed, I don't think it would
> make sense for me to pull it today.

I've dropped the two patches that are being discussed and reposted the 
remainder.  The updated series is here (et seq.):

    http://marc.info/?l=linux-arm-kernel&m=125059872200340&w=2

and the pull request is here:

    http://marc.info/?l=linux-arm-kernel&m=125059845132331&w=2


- Paul

>
> And this is likely to be the final day that I merge anything into my
> kernel tree for the next two weeks.
> > 
> > regards,
> > 
> > - Paul
> > 
> > The following changes since commit 3b3119fc549c93df60316d28bdd77c2de3986588:
> >   Russell King (1):
> >         Merge branch 'ixp4xx-fixes' of git://git.kernel.org/.../chris/linux-2.6
> 
> That's stupid.  Someone publishing _my_ tree, which I make no guarantees
> about the life of the commits, for other people to base their work on...
> That's definitely a big FAIL.
> 
> Luckily for you though, that commit still exists in my tree, and I've
> asked Linus to pull that set; so essentially it became immutable only
> last night.
> 
> Don't base patches on the contents of my tree without talking to me first
> please.


--
To unsubscribe from this list: send the line "unsubscribe linux-arm" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
