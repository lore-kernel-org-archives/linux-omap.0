From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv8 4/5] twl4030: add support for external voltage get/set
Date: Wed, 15 Feb 2012 10:38:21 +0200
Message-ID: <1329295101.4102.345.camel@sokoban>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
	 <1323444589-19940-5-git-send-email-t-kristo@ti.com> <871ur8weds.fsf@ti.com>
	 <20120110033012.GM30766@opensource.wolfsonmicro.com>
	 <87pqertwjt.fsf@ti.com> <20120110191012.GI7164@opensource.wolfsonmicro.com>
	 <1329223666.4102.319.camel@sokoban>  <87fwed6xa0.fsf@ti.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:60250 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751402Ab2BOIi1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 03:38:27 -0500
In-Reply-To: <87fwed6xa0.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, 2012-02-14 at 11:16 -0800, Kevin Hilman wrote:
> Tero Kristo <t-kristo@ti.com> writes:
> 
> > On Tue, 2012-01-10 at 19:10 +0000, Mark Brown wrote:
> >> On Tue, Jan 10, 2012 at 07:19:18AM -0800, Kevin Hilman wrote:
> >> 
> >> > Yes, some of the control still goes via the normal path (although I
> >> > forget which, maybe Benoit can remind us), so I think it's best to add
> >> > the HW control part to each regulator that might uses it.
> >> 
> >> > Ideally this could be facilitated by adding the extentions to the
> >> > regulator core so the amount of code needed for each regulator driver
> >> > would be minimal.
> >> 
> >> I think the original version of the patch was something along those
> >> lines but it was just a general facility which ignored the regulator
> >> driver entirely which didn't feel well integrated.  The discussion
> >> suggested that this wasn't something that'd work with other regulators
> >> so a per-driver solution seemed OK.
> >
> > Coming back to this patch now as I have time to look at it, what is the
> > general opinion, is it acceptable to patch the regulator core to add
> > support for the external controller or should I just resend the latest
> > version with changes Mark suggested? This will probably mean that once
> > we add new regulator drivers (e.g. pmics) we may need to duplicate the
> > external controller support here.
> 
> How about you keep it in the regulator driver for now, and when we need
> to abstract it out, we make the case for it then.

Okay, sounds good to me, once we have a second driver that actually
requires this, we have more backing for the request. Currently the
regulator core change is difficult to justify. I'll rework the set based
on last comments and send it out.

-Tero


