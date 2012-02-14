From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv8 4/5] twl4030: add support for external voltage get/set
Date: Tue, 14 Feb 2012 14:47:46 +0200
Message-ID: <1329223666.4102.319.camel@sokoban>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com>
	 <1323444589-19940-5-git-send-email-t-kristo@ti.com> <871ur8weds.fsf@ti.com>
	 <20120110033012.GM30766@opensource.wolfsonmicro.com>
	 <87pqertwjt.fsf@ti.com> <20120110191012.GI7164@opensource.wolfsonmicro.com>
Reply-To: <t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59812 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760260Ab2BNMrw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 14 Feb 2012 07:47:52 -0500
In-Reply-To: <20120110191012.GI7164@opensource.wolfsonmicro.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Kevin Hilman <khilman@ti.com>, Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, 2012-01-10 at 19:10 +0000, Mark Brown wrote:
> On Tue, Jan 10, 2012 at 07:19:18AM -0800, Kevin Hilman wrote:
> 
> > Yes, some of the control still goes via the normal path (although I
> > forget which, maybe Benoit can remind us), so I think it's best to add
> > the HW control part to each regulator that might uses it.
> 
> > Ideally this could be facilitated by adding the extentions to the
> > regulator core so the amount of code needed for each regulator driver
> > would be minimal.
> 
> I think the original version of the patch was something along those
> lines but it was just a general facility which ignored the regulator
> driver entirely which didn't feel well integrated.  The discussion
> suggested that this wasn't something that'd work with other regulators
> so a per-driver solution seemed OK.

Coming back to this patch now as I have time to look at it, what is the
general opinion, is it acceptable to patch the regulator core to add
support for the external controller or should I just resend the latest
version with changes Mark suggested? This will probably mean that once
we add new regulator drivers (e.g. pmics) we may need to duplicate the
external controller support here.

-Tero


