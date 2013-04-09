From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3 1/2] ARM: OMAP: board-4430sdp: Provide regulator to
 pwm-backlight
Date: Tue, 9 Apr 2013 13:17:46 -0700
Message-ID: <20130409201745.GQ10155@atomide.com>
References: <1363214006-10662-1-git-send-email-achew@nvidia.com>
 <1363214006-10662-2-git-send-email-achew@nvidia.com>
 <20130408214624.GZ10155@atomide.com>
 <20130408215616.GA25124@avionic-0098.mockup.avionic-design.de>
 <20130408221657.GC10155@atomide.com>
 <20130409075602.GA27255@avionic-0098.mockup.avionic-design.de>
 <20130409164003.GK10155@atomide.com>
 <20130409194049.GA16847@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:18013 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935910Ab3DIURv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 9 Apr 2013 16:17:51 -0400
Content-Disposition: inline
In-Reply-To: <20130409194049.GA16847@avionic-0098.mockup.avionic-design.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Andrew Chew <achew@nvidia.com>, peter.ujfalusi@ti.com, acourbot@nvidia.com, linux-omap@vger.kernel.org

* Thierry Reding <thierry.reding@avionic-design.de> [130409 12:45]:
> On Tue, Apr 09, 2013 at 09:40:04AM -0700, Tony Lindgren wrote:
> [...]
> > But then the regulator is not found and the driver should just exit,
> > or do nothing. If this is an optional regulator, then that should be
> > indicated in some platform data flags?
> 
> Yes, if the regulator isn't found then the driver fails. However the
> goal was to maintain bisectability. If we apply them in the wrong order
> we can't guarantee that because pwm-backlight will fail to work between
> both patches.

But it's fixing something that's not working anyways for board-4430sdp.c,
It seems so as these patches just add new features?
 
> > The driver parts really must be done in independently from any platform
> > data or .dts changes. The only common part needed should be changes
> > to include/linux/platform_data/*.h files.
> 
> We don't even need to touch platform data because the regulators are
> looked up via a global table. And the changes are all done independently
> but as I mentioned above, bisectability isn't maintained, so the
> preferred patch order is the one in which pwm-backlight keeps working at
> each point in the commit history.

Bisectability is a good point. But in the 4430sdp case I'm sure it's enough
that it builds and boots no matter how the patches get merged :)

Regards,

Tony

