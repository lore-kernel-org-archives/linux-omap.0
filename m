From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/9] ehci: increase timeout to fix ehci failure
Date: Tue, 22 Sep 2009 10:10:27 -0700
Message-ID: <20090922171027.GD14890@atomide.com>
References: <1249560460-16306-1-git-send-email-ajay.gupta@ti.com> <1249560460-16306-2-git-send-email-ajay.gupta@ti.com> <1249560460-16306-3-git-send-email-ajay.gupta@ti.com> <1249560460-16306-4-git-send-email-ajay.gupta@ti.com> <1249560460-16306-5-git-send-email-ajay.gupta@ti.com> <20090922011009.GJ27699@atomide.com> <19F8576C6E063C45BE387C64729E73940436C43D6F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:49820 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbZIVRK0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Sep 2009 13:10:26 -0400
Content-Disposition: inline
In-Reply-To: <19F8576C6E063C45BE387C64729E73940436C43D6F@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>

* Gupta, Ajay Kumar <ajay.gupta@ti.com> [090922 06:10]:
> Tony,
> > * Ajay Kumar Gupta <ajay.gupta@ti.com> [090806 05:13]:
> > > Sometime during TLL reset and waiting loop for TLL reset timeouts and
> > thus
> > > ehci init fails. Fixing this by increasing timeout value.
> > 
> > Applying patches 6 - 9 to ehci branch also.
> 
> One patch is missing which causes compilation error.
> [0002-omap3-Add-CHIP_GE_OMAP3430ES3-for-HSUSB.patch]

OK, after looking at the "ehci: Support for ES3.x" patch more,
how about just testing the revision with:

if (omap_rev() == OMAP3430_REV_ES3_1) {
	/* Set something */
}

That means the 0002-omap3-Add-CHIP_GE_OMAP3430ES3-for-HSUSB.patch
is not needed.

So I'm dropping the "ehci: Support for ES3.x" patch for now.
 
> Apart from this I have two more EHCI fixes and one patch to fix compilation warning on OMAP3EVM.
> 
> I am submitting all four patches , Please review them.

Pushing the others to the ehci branch.

Tony

