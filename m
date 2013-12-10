From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] make mach-omap2 boot with device tree only for v3.14
Date: Tue, 10 Dec 2013 08:59:58 -0800
Message-ID: <20131210165958.GH13171@atomide.com>
References: <pull-1386643347-596413>
 <20131210143547.GA32243@n2100.arm.linux.org.uk>
 <20131210160144.GG13171@atomide.com>
 <20131210160703.GB32243@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40972 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751929Ab3LJRAH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 12:00:07 -0500
Content-Disposition: inline
In-Reply-To: <20131210160703.GB32243@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [131210 08:08]:
> On Tue, Dec 10, 2013 at 08:01:44AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [131210 06:37]:
> > > On Mon, Dec 09, 2013 at 06:42:27PM -0800, Tony Lindgren wrote:
> > > > We can now finally make mach-omap2 to boot with device tree only and get
> > > > rid of over 20k lines of platform init code that way.
> > > > 
> > > > Most basic devices already work using device tree based initialization
> > > > and the remaining devices can be initialized using platform data
> > > > with pdata-quirks.c.
> > > > 
> > > > So for most missing boards it's just a question of adding a .dts file
> > > > that should be fairly similar to one of the existing .dts files as
> > > > we've tried to cover all basic omap3 board types.
> > > > 
> > > > For people getting started updating their board files to for device
> > > > tree, there are some basic instructions in commit 8dc8b3ddf5d7
> > > > (ARM: OMAP2+: Remove legacy omap3 board-*.c files and make mach-omap2
> > > > DT only for booting).
> > > > 
> > > > Please also note that there are also some related fixes making their way
> > > > into the mainline kernel that are needed for some use cases:
> > > > 
> > > > PM off-idle for omap3 and wake-up events need the following two patches:
> > > 
> > > While this is good, what seems to be happening is a complete switch
> > > from one method of booting to a different method of booting with no
> > > compatibility inbetween.  We're going from only supporting the ATAG
> > > booting protocol for these platforms in v3.12 to only supporting the
> > > DT booting protocol in v3.13.  There's no forward or backwards
> > > compatibility - it's one or the other.
> > 
> > Hmm hey this is for v3.14, not for v3.13.
> 
> Yes, I meant 3.14.
> 
> > > This is bad: this is the kind of "flag day" change which Linus hates -
> > > and I hate it because it means I need to update my build test system
> > > at the same time that arm-soc merges this stuff.
> > 
> > Unfortunately there's no way around that unless we carry the legacy
> > booting setup for longer. We can certainly postpone the flip over if
> > if there's a real neeed to do it.
> > 
> > But if the issue is just building an appended DTB image, I'd rather just
> > get done with it as that problem we're always going to have no matter
> > how much we delay the flip over.
> 
> Right, so I should just turn off building OMAP3 for the remainder of this
> cycle.
> 
> What's the fscking point me running a build system, because if I switch
> it now, OMAP3 breaks.  If I don't switch it now and your pull request is
> merged, it breaks at that point.

Fair enough, I hear you.
 
> This is utterly insane.

Well let's do this. Let's merge the parts that add stuff now, then wait
a week (or longer as needed) so you have both ways working with linux
next for a while. Does that sounds reasonable to you?

Regards,

Tony
