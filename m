From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Mon, 8 Apr 2013 15:16:57 -0700
Message-ID: <20130408221657.GC10155@atomide.com>
References: <1363214006-10662-1-git-send-email-achew@nvidia.com>
 <1363214006-10662-2-git-send-email-achew@nvidia.com>
 <20130408214624.GZ10155@atomide.com>
 <20130408215616.GA25124@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32778 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934888Ab3DHWRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Apr 2013 18:17:03 -0400
Content-Disposition: inline
In-Reply-To: <20130408215616.GA25124@avionic-0098.mockup.avionic-design.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Andrew Chew <achew@nvidia.com>, peter.ujfalusi@ti.com, acourbot@nvidia.com, linux-omap@vger.kernel.org

* Thierry Reding <thierry.reding@avionic-design.de> [130408 15:01]:
> On Mon, Apr 08, 2013 at 02:46:24PM -0700, Tony Lindgren wrote:
> > * Andrew Chew <achew@nvidia.com> [130313 15:37]:
> > > The pwm-backlight driver now takes a mandatory regulator that is gotten
> > > during driver probe.  Initialize a dummy regulator to satisfy this
> > > requirement.
> > > 
> > > Signed-off-by: Andrew Chew <achew@nvidia.com>
> > > ---
> > > Changed the device name of the backlight regulator supply to "pwm-backlight",
> > > per Peter's comment.
> > > 
> > > Changed the name of the regulator to "backlight-enable", per Thierry's
> > > suggestion.
> > 
> > Thanks applying into omap-for-v3.10/board. Note that I'm not taking the
> > second one, that should be resent to the related driver maintainers.
> > You can get that list by running scripts/get_maintainer.pl against it.
> 
> The plan was to take these all through one tree, preferably the PWM tree
> because it's all PWM related and the pwm-backlight change will go
> through that tree as well. Technically these individual patches can be
> applied as is and aren't harmful, but keeping track of the dependencies
> might be difficult if they go in via separate trees.

Registering the regulator alone should not do anything. Also the driver
should do the right thing if the regulator is not yet registered.

Can you please check your driver patch so the driver won't do anything
if the regulator is not (yet) registered and repost it alone as I've
already applied the board-*.c change.

The reason why we want to do queue these patches separately is to cut
away the dependency between drivers and the core arch/arm changes. 
Otherwise we'll end up with pointless merge conflicts as we've seen
earlier several times with the USB patches for example.

Regards,

Tony
