From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 7/7] ARM: OMAP2+: Mark omap_hsmmc_init and omap_mux
 related functions as __init
Date: Tue, 20 Mar 2012 15:17:02 -0700
Message-ID: <20120320221701.GI9859@atomide.com>
References: <1329997247-27342-1-git-send-email-rnayak@ti.com>
 <1329997247-27342-8-git-send-email-rnayak@ti.com>
 <1332148116.2144.1.camel@deskari>
 <1332152442.2144.27.camel@deskari>
 <20120319180928.GA9859@atomide.com>
 <1332228651.2409.5.camel@lappy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:21403 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755969Ab2CTWRH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Mar 2012 18:17:07 -0400
Content-Disposition: inline
In-Reply-To: <1332228651.2409.5.camel@lappy>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <rmk+kernel@arm.linux.org.uk>

* Tomi Valkeinen <tomi.valkeinen@ti.com> [120320 00:41]:
> On Mon, 2012-03-19 at 11:09 -0700, Tony Lindgren wrote:
> 
> > I've updated your patch a bit for the comments a bit and marked
> > omap4_hdmi_mux_pads as __init, will apply to fixes. Updated patch
> > below.
> 
> Hmm, is there something funny with these init changes now...
> 
> Initially the situation was that there were no __inits in display.c's
> mux functions. Then "Mark omap_hsmmc_init..." patch added __inits to all
> of them. My patch removed the __inits from dsi functions, but left them
> to hdmi functions.
> 
> But now you modified my patch to add the __inits to hdmi functions.
> Which should already have them from the "Mark omap_hsmmc_init..." patch.

Looks like the original patch missed making omap4_hdmi_mux_pads __init
though. I'm just changing omap4_hdmi_mux_pads to make it __init like
it should be.

Regards,

Tony
