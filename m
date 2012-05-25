From: Tony Lindgren <tony@atomide.com>
Subject: Re: usage of sparse or other trick for improved type safety
Date: Fri, 25 May 2012 00:53:29 -0700
Message-ID: <20120525075328.GM17852@atomide.com>
References: <EF62F09C0797D947AD4180A1043C0DF73C423E7B@DLEE10.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:24555 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab2EYHxd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 May 2012 03:53:33 -0400
Content-Disposition: inline
In-Reply-To: <EF62F09C0797D947AD4180A1043C0DF73C423E7B@DLEE10.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: "Hilman, Kevin" <khilman@ti.com>, "Menon, Nishanth" <nm@ti.com>, "jean.pihet@newoldbits.com" <jean.pihet@newoldbits.com>, "Sripathy, Vishwanath" <vishwanath.bs@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Pasam, Vijay" <vpasam@ti.com>

Hi,

* Woodruff, Richard <r-woodruff2@ti.com> [120524 11:16]:
> Hi Tony,
> 
> I am hoping to solicit an opinion from you for OMAP frameworks in general.
> 
> In some recent review there was some debate about how it was good practice to form parameters in a way which didn't get misused. Nishanth was having some experience where end users doing custom ports made some hard to find mistakes.
> 
> I was wondering if it is useful to create a standard or it's a waste of time.  The knee-jerk reaction to comment is to consider annotations for driver users of api's, then inside the framework trust internals to do the right thing.  Complexity divide between a driver and some frameworks might be similar to user-vs-kernel.
> 
> I think example in this case was IVA and other external subsystems commonly got away using stale definitions when managing their own power domains.  Example seemed a little pedantic but it is true that this has broken several times through migrations. At customer fan out it causes a lot of effort which could have been avoided.
> 
> Just last week someone was trying to caste away an iomem annotation from external driver based on warning. For me warning was a good thing and forced discussion.
> 
> I do recall you pushing what ARM and Linux tress did in this area back into OMAP years back.  Question is if it's worth internalizing more for our ever growing frameworks.

I think we should have frameworks in place to manage clocks and powerdomains
for pretty much all drivers using runtime PM by now. That has helped making the
device drivers more generic and easier to maintain. And it's also less likely
for device drivers to accidentally mess up things for other drivers.

Before we had these frameworks in place it was often hard to debug when something
did not work for some omaps. Things would just not work or would stop working
for some drivers with no ideas what was going on. So yeah, having these kind of
frameworks in place has helped a lot to avoid breakage like you're describing
above.

For some external subsystems it might be possible to let the omap kernel manage
powerdomains and other resource via remote proc interface, assuming these
registers are ioremapped in the omap kernel side and not owned by the external
subsystem. The messaging to do this would add some undesired latencies though,
but maybe those would not be so critical for the external subsystems as they
tend to be full on or completely off type accelerators.

The other alternative of course is to implement similar frameworks for the
external subsystems. Some of this might be possible to implement as simple
macros with some type checks if it's subsystem specific. For doing it for
all omap devices, macros were soon found not to be enough as the various
bits all over need to be linked together for managing various resources.

Regards,

Tony
