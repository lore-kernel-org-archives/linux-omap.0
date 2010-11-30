From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: 4430sdp: enable the ehci port on 4430SDP
Date: Tue, 30 Nov 2010 10:25:25 -0800
Message-ID: <20101130182524.GR17222@atomide.com>
References: <1290364999-4783-1-git-send-email-gadiyar@ti.com>
 <20101122101737.GN2446@legolas.emea.dhcp.ti.com>
 <4CEA59E0.8080705@ti.com>
 <20101122120608.GG2446@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:32104 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755943Ab0K3SZ3 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Nov 2010 13:25:29 -0500
Content-Disposition: inline
In-Reply-To: <20101122120608.GG2446@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>

* Felipe Balbi <balbi@ti.com> [101122 03:56]:
> On Mon, Nov 22, 2010 at 05:24:08PM +0530, Anand Gadiyar wrote:
> >On 11/22/2010 3:47 PM, Felipe Balbi wrote:
> >>On Mon, Nov 22, 2010 at 12:13:19AM +0530, Anand Gadiyar wrote:
> >>>From: Keshava Munegowda <keshava_mgowda@ti.com>
> >>>
> >>>Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
> >>>Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
> >>>Cc: Tony Lindgren <tony@atomide.com>
> >>
> >>Tony, if you give me your Ack I can take this with Greg since it depends
> >>on the series I'm checking now.
> >>
> >
> >This one can go through Tony - I deliberately left it out of the EHCI series.
> >
> >The dependency is needed for the EHCI port to actually be usable, however we
> >can register the device in the board file independently of the driver.
> >
> >I forgot to update the patch description - I'll wait some more for any
> >more comments and then repost with a proper description.
> 
> Ok, so it's Tony's call now. Tony, if you want to take this together
> with OMAP changes, just let me know and I'll drop this patch from my
> branch, if you want me to take it through Greg, then give me an Acked-by
> :-)

No please keep it along with the other USB patches:

Acked-by: Tony Lindgren <tony@atomide.com>
