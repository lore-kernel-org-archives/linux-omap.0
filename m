From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2+: fix dpll round_rate() to actually round
Date: Thu, 24 Apr 2014 11:44:58 -0700
Message-ID: <20140424184457.GH22987@atomide.com>
References: <1389944699-27962-1-git-send-email-tomi.valkeinen@ti.com>
 <1389944699-27962-3-git-send-email-tomi.valkeinen@ti.com>
 <20140424182914.GD4659@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:31310 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbaDXSpE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 24 Apr 2014 14:45:04 -0400
Content-Disposition: inline
In-Reply-To: <20140424182914.GD4659@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Mike Turquette <mturquette@linaro.org>, Paul Walmsley <paul@pwsan.com>

* Felipe Balbi <balbi@ti.com> [140424 11:29]:
> Hi,
> 
> On Fri, Jan 17, 2014 at 09:44:59AM +0200, Tomi Valkeinen wrote:
> > omap2_dpll_round_rate() doesn't actually round the given rate, even if
> > the name and the description so hints. Instead it only tries to find an
> > exact rate match, or if that fails, return ~0 as an error.
> > 
> > What this basically means is that the user of the clock needs to know
> > what rates the dpll can support, which obviously isn't right.
> > 
> > This patch adds a simple method of rounding: during the iteration, the
> > code keeps track of the closest rate match. If no exact match is found,
> > the closest is returned.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> 
> Tony, looks like this patch was lost. Are you taking it during the -rc ?

Would like to hear what Paul thinks of the updated patch suggested
by Tomi first.

Tony
