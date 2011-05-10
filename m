From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 0/6] OMAP: board file changes for DSS2 porting
Date: Tue, 10 May 2011 17:03:43 +0300
Message-ID: <1305036223.2045.74.camel@deskari>
References: <1304926567-26814-1-git-send-email-tomi.valkeinen@ti.com>
	 <1304960499.2215.49.camel@deskari>  <20110510133543.GJ30958@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog104.obsmtp.com ([74.125.149.73]:60155 "EHLO
	na3sys009aog104.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755738Ab1EJODs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 10 May 2011 10:03:48 -0400
Received: by mail-ew0-f49.google.com with SMTP id 3so2065009ewy.36
        for <linux-omap@vger.kernel.org>; Tue, 10 May 2011 07:03:46 -0700 (PDT)
In-Reply-To: <20110510133543.GJ30958@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Tue, 2011-05-10 at 16:35 +0300, Tony Lindgren wrote:
> * Tomi Valkeinen <tomi.valkeinen@ti.com> [110509 19:58]:
> > On Mon, 2011-05-09 at 10:36 +0300, Tomi Valkeinen wrote:
> > > Hi Tony,
> > > 
> > > I posted last week a patch set porting most of the old omapfb OMAP2/3 drivers
> > > to DSS2 (http://marc.info/?l=linux-fbdev&m=130451207802788&w=2). That patch set
> > > contains changes to both the drivers and the board files, and it seems there is
> > > already a minor conflict in them.
> > > 
> > > So I think it's simpler to divide the set into two parts, this one, which
> > > contains the board file changes, and another containing the driver changes.
> > > Merging will probably go easier if you can take this patch set via linux-omap,
> > > and I'll take the driver changes via dss2 tree.
> > > 
> > > Applying this set without the driver changes will obviously disable the
> > > displays of the affected boards until the drivers are also merged.
> > 
> > Tony, I updated the patches, adding one Ack and cleaning up the 2430sdp
> > a bit. The patches can be found from
> > 
> > git://gitorious.org/linux-omap-dss2/linux.git board-changes-for-tony
> > 
> > should you decide to pull them.
> 
> Do the dss platform data code coalescing patches affect these?

Do you mean the recent discussions about DSS regulator stuff? If so, no.
These patches do not introduce any regulator uses.

> We just hate positive diffstats for arch/arm/*omap*/ for the upcoming
> merge window :)

Well... I know, but if we want to port the old drivers to DSS2 it really
can't be helped. The display device definitions in the board files are
probably a bit more verbose with DSS2 than with old omapfb, due to more
features and better configurability.

That said, if you want to calm down the arch/arm/*omap* changes for this
merge window I can just postpone these (and some other display related
board changes in dss2 tree) to the next one. They are not critical in
any way regarding DSS2 development, they just would help us to clean up
the old omapfb code (which probably won't affect arch/arm/*omap* much).

Speaking of which, the include file for DSS2 currently resides in
arch/arm/plat-omap/include/plat/display.h. I guess this is not right
place for it, as the driver itself is in drivers/, even if the driver is
OMAP-only driver?

> Also, these patches should also be posted to linux-arm-kernel list for
> review before I can apply.

Ok. Should all arch/arm/*omap* code be posted to linux-arm-kernel also?
I feel like spamming if I mail the patches to three different mailing
lists =).

 Tomi


