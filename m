From: Tony Lindgren <tony@atomide.com>
Subject: Re: Latest regressions
Date: Thu, 27 Jan 2011 16:22:14 -0800
Message-ID: <20110128002214.GP23412@atomide.com>
References: <20110107115744.GL1198@n2100.arm.linux.org.uk>
 <20110107165626.GD880@atomide.com>
 <20110126090157.GA2997@n2100.arm.linux.org.uk>
 <20110126181536.GD23412@atomide.com>
 <20110127122211.GA26418@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:56043 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674Ab1A1AWQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Jan 2011 19:22:16 -0500
Content-Disposition: inline
In-Reply-To: <20110127122211.GA26418@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110127 04:21]:
> On Wed, Jan 26, 2011 at 10:15:37AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110126 01:00]:
> > > On Fri, Jan 07, 2011 at 08:56:26AM -0800, Tony Lindgren wrote:
> > > > > diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> > > > > index 17bd639..9eaa28c 100644
> > > > > --- a/arch/arm/mach-omap2/mux.c
> > > > > +++ b/arch/arm/mach-omap2/mux.c
> > > > > @@ -160,7 +160,7 @@ static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
> > > > >  	struct omap_mux *mux = NULL;
> > > > >  	struct omap_mux_entry *e;
> > > > >  	const char *mode_name;
> > > > > -	int found = 0, found_mode, mode0_len = 0;
> > > > > +	int found = 0, found_mode = 0, mode0_len = 0;
> > > > >  	struct list_head *muxmodes = &partition->muxmodes;
> > > > >  
> > > > >  	mode_name = strchr(muxname, '.');
> > > > 
> > > > Ack.
> > > 
> > > This one is also still there.
> > 
> > I have a similar patch in devel-cleanup branch queued up from Felipe Balbi.
> > However, this fixes regression for patch 8419fdbaf2118a0a169441be82f09f7be93a5ca1
> > (omap2+: Add omap_mux_get_by_name) so this too should be done for the
> > -rc cycle:
> > 
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > 
> > Again, let me know if you want me to take it.
> 
> I'm happy if you want to queue it for -rc.

OK, will use Felipe's patch as that does not require patch editing for me.

Tony
