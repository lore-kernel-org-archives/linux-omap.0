From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 0/6] OMAP: board file changes for DSS2 porting
Date: Tue, 10 May 2011 16:35:43 +0300
Message-ID: <20110510133543.GJ30958@atomide.com>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
 <1304960499.2215.49.camel@deskari>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:62363 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754707Ab1EJNfr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 May 2011 09:35:47 -0400
Content-Disposition: inline
In-Reply-To: <1304960499.2215.49.camel@deskari>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-omap@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ti.com> [110509 19:58]:
> On Mon, 2011-05-09 at 10:36 +0300, Tomi Valkeinen wrote:
> > Hi Tony,
> > 
> > I posted last week a patch set porting most of the old omapfb OMAP2/3 drivers
> > to DSS2 (http://marc.info/?l=linux-fbdev&m=130451207802788&w=2). That patch set
> > contains changes to both the drivers and the board files, and it seems there is
> > already a minor conflict in them.
> > 
> > So I think it's simpler to divide the set into two parts, this one, which
> > contains the board file changes, and another containing the driver changes.
> > Merging will probably go easier if you can take this patch set via linux-omap,
> > and I'll take the driver changes via dss2 tree.
> > 
> > Applying this set without the driver changes will obviously disable the
> > displays of the affected boards until the drivers are also merged.
> 
> Tony, I updated the patches, adding one Ack and cleaning up the 2430sdp
> a bit. The patches can be found from
> 
> git://gitorious.org/linux-omap-dss2/linux.git board-changes-for-tony
> 
> should you decide to pull them.

Do the dss platform data code coalescing patches affect these?

We just hate positive diffstats for arch/arm/*omap*/ for the upcoming
merge window :)

Also, these patches should also be posted to linux-arm-kernel list for
review before I can apply.

Regards,

Tony
