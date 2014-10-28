From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: Warn about deprecated legacy booting mode
Date: Tue, 28 Oct 2014 15:12:44 -0700
Message-ID: <20141028221243.GU2542@atomide.com>
References: <20141027200008.GR2560@atomide.com>
 <20141027230138.GB7805@drone.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:40256 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756038AbaJ1WOI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 28 Oct 2014 18:14:08 -0400
Content-Disposition: inline
In-Reply-To: <20141027230138.GB7805@drone.musicnaut.iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [141027 16:03]:
> Hi,
> 
> On Mon, Oct 27, 2014 at 01:00:09PM -0700, Tony Lindgren wrote:
> > +
> > +	if (!of_have_populated_dt())
> > +		pr_warn("WARNING: legacy booting deprecated, please update to boot with .dts\n");
> > +
> 
> Maybe use WARN so that the warning is more verbose and kernel gets tainted?

Well I was hoping to avoid annoying people with the trace.
But can do that if people prefer that, what do others think?

Regards,

Tony
