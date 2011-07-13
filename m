From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2 2/5] regulator: omap smps regulator driver
Date: Thu, 14 Jul 2011 07:55:26 +0900
Message-ID: <20110713225524.GA9770@opensource.wolfsonmicro.com>
References: <1310565638-13140-1-git-send-email-t-kristo@ti.com>
 <1310565638-13140-3-git-send-email-t-kristo@ti.com>
 <20110713144019.GA7861@opensource.wolfsonmicro.com>
 <1310572425.4331.96.camel@sokoban>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58568 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752741Ab1GMWze (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 13 Jul 2011 18:55:34 -0400
Content-Disposition: inline
In-Reply-To: <1310572425.4331.96.camel@sokoban>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, "Girdwood, Liam" <lrg@ti.com>, "Hilman, Kevin" <khilman@ti.com>

On Wed, Jul 13, 2011 at 06:53:45PM +0300, Tero Kristo wrote:
> On Wed, 2011-07-13 at 16:40 +0200, Mark Brown wrote:

> > I do strongly prefer the idiom of just registering all the regulators
> > even if they're read only.

> Number of available SMPS regulators is kind of board specific issue.
> OMAP3 has 2 available, OMAP4 has 3. If we are using some custom powering
> solution, we might have even different amounts for these.

Right, but the interface to them is always there?

> > No, this is bad.  We *always* pay attention to the constraints the user
> > set even if they're nuts or won't work, the machine driver has the final
> > say on what is or isn't allowed on a given board.  The mode setting is
> > especially suspect as there's no mode support in the driver.

> Just a clarification on this one that I have understood your comment
> right... Do you mean that I should be checking the constraints user sets
> more thoroughly to see if there is something bogus? I was looking at
> some of the other regulator drivers and they seem to be fiddling with
> the constraints in similar manner.

No!  You should *always* use the constraints the user has set, don't
randomly add new permissions without them doing so.
