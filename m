From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Tue, 9 Apr 2013 09:40:04 -0700
Message-ID: <20130409164003.GK10155@atomide.com>
References: <1363214006-10662-1-git-send-email-achew@nvidia.com>
 <1363214006-10662-2-git-send-email-achew@nvidia.com>
 <20130408214624.GZ10155@atomide.com>
 <20130408215616.GA25124@avionic-0098.mockup.avionic-design.de>
 <20130408221657.GC10155@atomide.com>
 <20130409075602.GA27255@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:19745 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759419Ab3DIQkJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 12:40:09 -0400
Content-Disposition: inline
In-Reply-To: <20130409075602.GA27255@avionic-0098.mockup.avionic-design.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Andrew Chew <achew@nvidia.com>, peter.ujfalusi@ti.com, acourbot@nvidia.com, linux-omap@vger.kernel.org

* Thierry Reding <thierry.reding@avionic-design.de> [130409 01:00]:
> On Mon, Apr 08, 2013 at 03:16:57PM -0700, Tony Lindgren wrote:
> > * Thierry Reding <thierry.reding@avionic-design.de> [130408 15:01]:
> > > On Mon, Apr 08, 2013 at 02:46:24PM -0700, Tony Lindgren wrote:
> > > > * Andrew Chew <achew@nvidia.com> [130313 15:37]:
> > > > > The pwm-backlight driver now takes a mandatory regulator that is gotten
> > > > > during driver probe.  Initialize a dummy regulator to satisfy this
> > > > > requirement.
> > > > > 
> > > > > Signed-off-by: Andrew Chew <achew@nvidia.com>
> > > > > ---
> > > > > Changed the device name of the backlight regulator supply to "pwm-backlight",
> > > > > per Peter's comment.
> > > > > 
> > > > > Changed the name of the regulator to "backlight-enable", per Thierry's
> > > > > suggestion.
> > > > 
> > > > Thanks applying into omap-for-v3.10/board. Note that I'm not taking the
> > > > second one, that should be resent to the related driver maintainers.
> > > > You can get that list by running scripts/get_maintainer.pl against it.
> > > 
> > > The plan was to take these all through one tree, preferably the PWM tree
> > > because it's all PWM related and the pwm-backlight change will go
> > > through that tree as well. Technically these individual patches can be
> > > applied as is and aren't harmful, but keeping track of the dependencies
> > > might be difficult if they go in via separate trees.
> > 
> > Registering the regulator alone should not do anything. Also the driver
> > should do the right thing if the regulator is not yet registered.
> > 
> > Can you please check your driver patch so the driver won't do anything
> > if the regulator is not (yet) registered and repost it alone as I've
> > already applied the board-*.c change.
> 
> That's not the way that the regulator subsystem works, unfortunately.
> There's no way you can distinguish between the case where a regulator
> just hasn't been registered yet, or whether it's missing. That's the
> whole reason why we need to add the dummy regulators in the first
> place.

But then the regulator is not found and the driver should just exit,
or do nothing. If this is an optional regulator, then that should be
indicated in some platform data flags?
 
> > The reason why we want to do queue these patches separately is to cut
> > away the dependency between drivers and the core arch/arm changes. 
> > Otherwise we'll end up with pointless merge conflicts as we've seen
> > earlier several times with the USB patches for example.
> 
> We could possibly postpone merging the pwm-backlight changes until all
> other patches have been merged. If you have this in you for-3.10 branch
> I guess it will go into linux-next when the 3.9 merge window closes? If
> so I could possibly base my for-3.10 branch on your branch if you can
> provide a stable one that you can guarantee not to rebase. There are
> other alternatives too, but certainly the easiest would've been to take
> all patches through the PWM tree. The potential for merge conflicts
> should be rather minimal.

The driver parts really must be done in independently from any platform
data or .dts changes. The only common part needed should be changes
to include/linux/platform_data/*.h files.

Regards,

Tony
