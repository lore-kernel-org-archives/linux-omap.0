From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] Kernel debugging: omap: print warning if CONFIG_DEBUG_LL
 is enabled
Date: Thu, 9 Nov 2017 16:58:40 +0000
Message-ID: <20171109165840.GI28231@n2100.armlinux.org.uk>
References: <b80b85cd6f26d02d698463b3dd5e9783081aa780.1510176592.git.hns@goldelico.com>
 <20171108222755.GW28152@atomide.com>
 <20171108223604.GG28231@n2100.armlinux.org.uk>
 <20171108223810.GH28231@n2100.armlinux.org.uk>
 <E542DC13-D6C4-4C84-8521-8CE468BD0AFE@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E542DC13-D6C4-4C84-8521-8CE468BD0AFE@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Tony Lindgren <tony@atomide.com>, letux-kernel@openphoenux.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 09, 2017 at 06:44:49AM +0100, H. Nikolaus Schaller wrote:
> Hi Russel,

Nikolus,

> > Am 08.11.2017 um 23:38 schrieb Russell King - ARM Linux <linux@armlinux.org.uk>:
> > 
> > On Wed, Nov 08, 2017 at 10:36:04PM +0000, Russell King - ARM Linux wrote:
> >> We don't need a compiler warning there, we probably need better help
> >> text against DEBUG_LL and against EARLY_PRINTK.
> > 
> > Actually, this is already clearly stated against DEBUG_LL:
> > 
> >          Note that selecting this option will limit the kernel to a single
> >          UART definition, as specified below. Attempting to boot the kernel
> >          image on a different platform *will not work*, so this option should
> >          not be enabled for kernels that are intended to be portable.
> > 
> > and since EARLY_PRINTK depends on DEBUG_LL... I guess people don't
> > read help texts anymore.
> 
> Yes, we read, but we face a situation where it doesn't help that it is a
> well known problem *for you* or anyone else and that it is described in
> the help.

Personally, I'd like early_printk not to be re-using this, but others
disagree.  It's all about knowledge and compromise.

What we don't want is more warnings in the kernel - it's already
hard enough for people to spot the "bad" warnings that they need to
fix to have a working system (such as wrong printf specifiers) that
(a) they're not going to spot this #warning and (b) it's just going
to be more noise for those who do try to spot the warnings.

> Do you expect anybody to remember after 3 years of *not* changing DEBUG_LL
> what was written in a help message? Or to understand that DEBUG_LL has
> anything to do with the mysteriously appearing boot problem? Which can't
> easily be debugged since there are no messages despite playing with
> EARLY_PRINTK/EARLYCON?

Do you expect people to read the build log of their kernel and spot
the additional warning?  You might be on the ball enough to do that,
but not everyone does, or is.  Not everyone logs the output of the
kernel build so they can review it later.  I suspect that many just
set the build going in a terminal, walk away and come back sometime
later when they think it's done.  (This view is based upon the number
of warnings that I've seen crop up that are for things that are real
bugs that others have introduced - had the warnings been spotted, it
would've triggered a "oh, that's not right" moment.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
