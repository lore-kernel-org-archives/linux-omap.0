From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [linux-pm] [PATCH 02/11] PM: extend PM QoS with per-device
 wake-up constraints
Date: Sun, 7 Aug 2011 11:47:14 +0900
Message-ID: <20110807024712.GA5887@opensource.wolfsonmicro.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
 <201108052137.37011.rjw@sisk.pl>
 <20110806033711.GA18987@opensource.wolfsonmicro.com>
 <201108062146.20423.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34362 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756571Ab1HGCr1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 6 Aug 2011 22:47:27 -0400
Content-Disposition: inline
In-Reply-To: <201108062146.20423.rjw@sisk.pl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>

On Sat, Aug 06, 2011 at 09:46:20PM +0200, Rafael J. Wysocki wrote:
> On Saturday, August 06, 2011, Mark Brown wrote:

> > I wouldn't say we've got to rely on userspace here - it seems like we
> > ought to be able to use DMI or other system data to identify the
> > affected systems and activate the workarounds.

> That's only practical on systems where the kernel can be rebuilt.
> Moreover, if that affects individual devices, using DMI-based blacklists
> is not really practical at all.

OK, so this does sound like there's probably a genuine issue on PCs due
to limitations in the environment.  Is it possible to expose these
things to userspace in a way that's limited to the affected platforms?

> > You're right that it doesn't stop the kernel doing anything, the concern
> > is that people just won't bother making the kernel work properly and
> > will just do their power management in userspace and not bother fixing
> > the kernel.

> I wouldn't call it "fixing the kernel".  I'd rather say "putting workarounds
> into the kernel", which I'm not sure is the right thing to at least in some
> cases.

That does sound like a fair characterization for PCs.  For embedded
systems where we have a *much* better knowledge of the hardware we're
running on you're just working with the basics of what the hardware
needs to run - the hardware needs whatever it needs and no matter what
you think of the quality of the hardware there's an expectation that the
kernel is ging to be able to work.

> > Punting to userspace seems like it is creating the
> > expectation that we can't make the kernel work and isn't great from a
> > usability perspective since users shouldn't really be worrying about bus
> > performance or so on, it's not something that's visible at the level
> > applications work at.

> However, platform builders may want to fine tuned things and I'm not sure
> we should require them to patch the kernel for this purpose.

As I've said it's not the fine tuning that I'm worried about, it's the
specific mechanism that's being suggested.  Being able to tune things in
a way that's relevant to the device being tuned seems entirely sensible.

> > I'm not sure I can see a lot of cases where you'd have root access and
> > not be able to do kernel updates if required?  Having stuff in debugfs
> > for diagnostics doesn't strike me as a problem if that's the issue.

> Root access doesn't necessarily mean you have all of the requisite
> tools (like compilers etc.) and installing them isn't always trivial
> (think of systems like phones etc.), let alone building the kernel from
> sources (where you don't necessarily know the original .config used for
> building your device's kernel).

Phones are exactly the sort of case I'm primarily concerned with here.

Realistically if you're in a position where you need to work at this
very low level on an embedded device you can replace the entire firmware
on the device.  We don't want to end up in the situation where we've got
kernel support for a device and the only way to get it to actually run
sensibly is to install the silicon vendor's proprietary userspace, and
we especially don't want to end up in the situation where that userspace
is using standard and supported kernel interfaces to do its thing.

> IOW, I don't buy the "you can always rebuild the kernel if necessary"
> argument.  It simply is not true in general.

You can push that argument to extremes, of course.
