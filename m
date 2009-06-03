From: Tony Lindgren <tony@atomide.com>
Subject: Re: LDP support
Date: Wed, 3 Jun 2009 16:41:26 -0700
Message-ID: <20090603234125.GI5026@atomide.com>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090531212449.GD25140@n2100.arm.linux.org.uk> <20090601160032.GA4825@atomide.com> <20090603213955.GA24318@localhost> <20090603223333.GD17411@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:53446 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbZFCXlg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2009 19:41:36 -0400
Content-Disposition: inline
In-Reply-To: <20090603223333.GD17411@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Imre Deak <imre.deak@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Valkeinen Tomi (Nokia-D/Helsinki)" <Tomi.Valkeinen@nokia.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090603 15:34]:
> On Thu, Jun 04, 2009 at 12:39:55AM +0300, Imre Deak wrote:
> > I updated the omapfb-upstream branch on git://koowaldah.org/people/imre/linux-2.6-fb,
> > if these are ok with you I'll post them on the fb list.
> 
> Just be aware that Linus released -rc8 on Tuesday, and said that will
> be the final rc before the merge window opens.  So I reckon there's less
> than a week to the merge window opening.

Imre, few comments after browsing through your patches:

"omapfb: Add support for MIPI-DCS compatible LCDs" seems to depend on
drivers/cbus which is not yet merged. Please leave out those parts so
it compiles. Then we can add the missing functions once drivers/cbus
is merged in the future.

"omapfb: dispc: Add OMAP3 support" should no longer be needed, this
got already fixed with clkdev patch 005187eecaa400b4b43d9f640fbde9fcc50f37c1
in mainline.

"omapfb: Fix coding style / remove dead line" has a typo in Russell's
name.
 
> That's not a suggestion that people should panic and sent their half
> complete patches out for merging.  [for the wider audience] Looking
> at the amount of unread email from the last two days, I think I have
> sufficient quantity to keep me occupied until the merge window does
> open.

Just FYI, I don't think we have much anything more heading your way
this merge window from the omap land. Just the second clock fixes
series from Paul, and the omap4 SMP patches are still pending.

Regards,

Tony
