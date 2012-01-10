From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv8 4/5] twl4030: add support for external voltage get/set
Date: Tue, 10 Jan 2012 19:10:12 +0000
Message-ID: <20120110191012.GI7164@opensource.wolfsonmicro.com>
References: <1323444589-19940-1-git-send-email-t-kristo@ti.com> <1323444589-19940-5-git-send-email-t-kristo@ti.com> <871ur8weds.fsf@ti.com> <20120110033012.GM30766@opensource.wolfsonmicro.com> <87pqertwjt.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:48459 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756699Ab2AJTKO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 Jan 2012 14:10:14 -0500
Content-Disposition: inline
In-Reply-To: <87pqertwjt.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, Jan 10, 2012 at 07:19:18AM -0800, Kevin Hilman wrote:

> Yes, some of the control still goes via the normal path (although I
> forget which, maybe Benoit can remind us), so I think it's best to add
> the HW control part to each regulator that might uses it.

> Ideally this could be facilitated by adding the extentions to the
> regulator core so the amount of code needed for each regulator driver
> would be minimal.

I think the original version of the patch was something along those
lines but it was just a general facility which ignored the regulator
driver entirely which didn't feel well integrated.  The discussion
suggested that this wasn't something that'd work with other regulators
so a per-driver solution seemed OK.
