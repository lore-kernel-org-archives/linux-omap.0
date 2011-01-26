From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Latest regressions
Date: Wed, 26 Jan 2011 09:01:57 +0000
Message-ID: <20110126090157.GA2997@n2100.arm.linux.org.uk>
References: <20110107115744.GL1198@n2100.arm.linux.org.uk> <20110107165626.GD880@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:51179 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485Ab1AZJCD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 26 Jan 2011 04:02:03 -0500
Content-Disposition: inline
In-Reply-To: <20110107165626.GD880@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Fri, Jan 07, 2011 at 08:56:26AM -0800, Tony Lindgren wrote:
> > diff --git a/arch/arm/mach-omap2/mux.c b/arch/arm/mach-omap2/mux.c
> > index 17bd639..9eaa28c 100644
> > --- a/arch/arm/mach-omap2/mux.c
> > +++ b/arch/arm/mach-omap2/mux.c
> > @@ -160,7 +160,7 @@ static int __init _omap_mux_get_by_name(struct omap_mux_partition *partition,
> >  	struct omap_mux *mux = NULL;
> >  	struct omap_mux_entry *e;
> >  	const char *mode_name;
> > -	int found = 0, found_mode, mode0_len = 0;
> > +	int found = 0, found_mode = 0, mode0_len = 0;
> >  	struct list_head *muxmodes = &partition->muxmodes;
> >  
> >  	mode_name = strchr(muxname, '.');
> 
> Ack.

This one is also still there.
