From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4-alt 0/6] GPMC driver migrate one
Date: Fri, 11 May 2012 13:00:49 -0700
Message-ID: <20120511200049.GY21851@atomide.com>
References: <cover.1335941443.git.afzal@ti.com>
 <20120508213625.GG5088@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E98A339@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:35082 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759382Ab2EKUAv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 May 2012 16:00:51 -0400
Content-Disposition: inline
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E98A339@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Mohammed, Afzal" <afzal@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Mohammed, Afzal <afzal@ti.com> [120509 23:39]:
> Hi Tony,
> 
> On Wed, May 09, 2012 at 03:06:26, Tony Lindgren wrote:
> 
> > > To resolve this and as per your earlier question on whether old along
> > > with new interface can be made to work parallely, here is suggestion
> > > from my end to deal with it.
> > 
> > I think this is the only way to keep this all building and booting
> > for each patch in the series, no? If so, then we should select this
> > option. The first patch should be broken up into more readable patches,
> > it seems that you can do that without breaking things.
> 
> Bisectability has been maintained in the patches.
> 
> Ok, I will proceed by keeping old & new interface together, will
> try to achieve it in smaller patches and without hacks.
> 
> > > Please let me know whether you are fine in taking patch series
> > > as in v4 (that converts all boards at once, with further revisions
> > > based on review comments).
> > 
> > It seems that there are still some pending comments and we need to
> > have the hwmod entries merged first by Paul.
> 
> Ok, first I will try to get hwmod in.

Let's try to get merged these into l-o master around -rc2 so we can
have them tested properly for a few weeks before v3.6 merge window.

Regards,

Tony
